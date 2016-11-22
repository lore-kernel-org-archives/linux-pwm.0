From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v3 02/11] pwm: imx: remove ipg clock
Date: Tue, 22 Nov 2016 13:04:11 -0800
Message-ID: <369235b4acf1cc29991c18b05202ca49@agner.ch>
References: <1477984230-18071-1-git-send-email-l.majewski@majess.pl>
 <1477984230-18071-3-git-send-email-l.majewski@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477984230-18071-3-git-send-email-l.majewski@majess.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

On 2016-11-01 00:10, Lukasz Majewski wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The use of the ipg clock was introduced with commit 7b27c160c681
> ("pwm: i.MX: fix clock lookup").
> In the commit message it was claimed that the ipg clock is enabled for
> register accesses. This is true for the ->config() callback, but not
> for the ->set_enable() callback. Given that the ipg clock is not
> consistently enabled for all register accesses we can assume that either
> it is not required at all or that the current code does not work.
> Remove the ipg clock code for now so that it's no longer in the way of
> refactoring the driver.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>

I have to NACK here, sorry guys.

Just tested this on a i.MX 7, the kernel freezes in imx_pwm_config, I
guess that is where the code accesses a register first.

The i.MX 7 DT (imx7s.dtsi) specifies the same clock for ipg and per, but
it seems that this clock is crucial for register access on i.MX 7:

clocks = <&clks IMX7D_PWM1_ROOT_CLK>,
         <&clks IMX7D_PWM1_ROOT_CLK>;
clock-names = "ipg", "per";          

So since the "per" clock is the same in the i.MX 7 case, imx_pwm_enable
worked...

I agree that the old code is a bit weird, especially that we get the
clock in imx_pwm_enable. It seems that all device trees specify a "ipg"
clock, so I guess we can get the clock at probe time for all variants of
this IP and just enable it on peripheral access...

--
Stefan


> ---
> [commit message text refactored by Lukasz Majewski <l.majewski@majess.pl>]
> ---
> Changes for v3:
> - New patch
> ---
>  drivers/pwm/pwm-imx.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index d600fd5..70609ef2 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -49,7 +49,6 @@
>  
>  struct imx_chip {
>  	struct clk	*clk_per;
> -	struct clk	*clk_ipg;
>  
>  	void __iomem	*mmio_base;
>  
> @@ -204,17 +203,8 @@ static int imx_pwm_config(struct pwm_chip *chip,
>  		struct pwm_device *pwm, int duty_ns, int period_ns)
>  {
>  	struct imx_chip *imx = to_imx_chip(chip);
> -	int ret;
> -
> -	ret = clk_prepare_enable(imx->clk_ipg);
> -	if (ret)
> -		return ret;
>  
> -	ret = imx->config(chip, pwm, duty_ns, period_ns);
> -
> -	clk_disable_unprepare(imx->clk_ipg);
> -
> -	return ret;
> +	return imx->config(chip, pwm, duty_ns, period_ns);
>  }
>  
>  static int imx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> @@ -293,13 +283,6 @@ static int imx_pwm_probe(struct platform_device *pdev)
>  		return PTR_ERR(imx->clk_per);
>  	}
>  
> -	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> -	if (IS_ERR(imx->clk_ipg)) {
> -		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
> -				PTR_ERR(imx->clk_ipg));
> -		return PTR_ERR(imx->clk_ipg);
> -	}
> -
>  	imx->chip.ops = &imx_pwm_ops;
>  	imx->chip.dev = &pdev->dev;
>  	imx->chip.base = -1;
