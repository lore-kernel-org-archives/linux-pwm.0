From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v3 RESEND 02/11] pwm: imx: remove ipg clock
Date: Tue, 27 Dec 2016 08:26:09 +0100
Message-ID: <46d2d434303d416645f27bb20358d46e@agner.ch>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
 <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
 <1482792961-12702-3-git-send-email-l.majewski@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:46447 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbcL0Hc7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 27 Dec 2016 02:32:59 -0500
In-Reply-To: <1482792961-12702-3-git-send-email-l.majewski@majess.pl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>

On 2016-12-26 23:55, Lukasz Majewski wrote:
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

Hi Lukasz,

Has my concern addressed in any way with this resend?
https://lkml.org/lkml/2016/11/22/729

Breaking hardware is usually not an option :-)

I checked the i.MX 7 reference manual again, and in this case the
peripheral access clock is a clock line named "ipg_clk_s" (Table 12-20),
with a clock root "PWM1_CLK_ROOT" (Table 5-12). In i.MX 7 all clocks are
behind a single gate, so in fact it does not matter which clock we take.
Given that others have peripheral access behind the "pwm" gate, I guess
we should take the "pwm" gate...

--
Stefan

> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
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
