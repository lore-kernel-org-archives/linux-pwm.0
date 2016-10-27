From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2 03/10] pwm: imx: Rewrite imx_pwm_*_v1 code to
 facilitate switch to atomic pwm operation
Date: Thu, 27 Oct 2016 09:40:05 +0200
Message-ID: <20161027094005.2da3b7d4@bbrezillon>
References: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
        <1477549785-4972-4-git-send-email-l.majewski@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477549785-4972-4-git-send-email-l.majewski@majess.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On Thu, 27 Oct 2016 08:29:39 +0200
Lukasz Majewski <l.majewski@majess.pl> wrote:

> The code has been rewritten to remove "generic" calls to
> imx_pwm_{enable|disable|config}.
> 
> Such approach would facilitate switch to atomic PWM (a.k.a ->apply())
> implementation.
> 
> Suggested-by: Stefan Agner <stefan@agner.ch>
> Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> ---
> Changes for v2:
> - Add missing clock unprepare for clk_ipg
> - Enable peripheral PWM clock (clk_per)
> ---
>  drivers/pwm/pwm-imx.c | 50 ++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 38 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index ea3ce79..822eb5a 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -65,8 +65,6 @@ struct imx_chip {
>  static int imx_pwm_config_v1(struct pwm_chip *chip,
>  		struct pwm_device *pwm, int duty_ns, int period_ns)
>  {
> -	struct imx_chip *imx = to_imx_chip(chip);
> -
>  	/*
>  	 * The PWM subsystem allows for exact frequencies. However,
>  	 * I cannot connect a scope on my device to the PWM line and
> @@ -84,26 +82,56 @@ static int imx_pwm_config_v1(struct pwm_chip *chip,
>  	 * both the prescaler (/1 .. /128) and then by CLKSEL
>  	 * (/2 .. /16).
>  	 */
> +	struct imx_chip *imx = to_imx_chip(chip);
>  	u32 max = readl(imx->mmio_base + MX1_PWMP);
>  	u32 p = max * duty_ns / period_ns;
> +	int ret;
> +
> +	ret = clk_prepare_enable(imx->clk_ipg);
> +	if (ret)
> +		return ret;
> +
>  	writel(max - p, imx->mmio_base + MX1_PWMS);
>  
> +	clk_disable_unprepare(imx->clk_ipg);
> +
>  	return 0;
>  }
>  
> -static void imx_pwm_set_enable_v1(struct pwm_chip *chip, bool enable)
> +static int imx_pwm_enable_v1(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>  	struct imx_chip *imx = to_imx_chip(chip);
> +	int ret;
>  	u32 val;
>  
> +	ret = clk_prepare_enable(imx->clk_ipg);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(imx->clk_per);
> +	if (ret)
> +		return ret;
> +
>  	val = readl(imx->mmio_base + MX1_PWMC);
> +	val |= MX1_PWMC_EN;
> +	writel(val, imx->mmio_base + MX1_PWMC);
>  
> -	if (enable)
> -		val |= MX1_PWMC_EN;
> -	else
> -		val &= ~MX1_PWMC_EN;
> +	clk_disable_unprepare(imx->clk_ipg);
> +
> +	return 0;
> +}
> +
> +static void imx_pwm_disable_v1(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct imx_chip *imx = to_imx_chip(chip);
> +	u32 val;
> +
> +	val = readl(imx->mmio_base + MX1_PWMC);
> +	val &= ~MX1_PWMC_EN;
>  
>  	writel(val, imx->mmio_base + MX1_PWMC);

Are you sure you don't need to enable the ipg clk when manipulating the
PWMC register?
If it's not needed here, then it's probably not needed in
imx_pwm_enable_v1() either.

> +
> +	clk_disable_unprepare(imx->clk_per);
>  }
>  
>  static int imx_pwm_config_v2(struct pwm_chip *chip,
> @@ -241,9 +269,9 @@ static void imx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  }
>  
>  static struct pwm_ops imx_pwm_ops_v1 = {
> -	.enable = imx_pwm_enable,
> -	.disable = imx_pwm_disable,
> -	.config = imx_pwm_config,
> +	.enable = imx_pwm_enable_v1,
> +	.disable = imx_pwm_disable_v1,
> +	.config = imx_pwm_config_v1,
>  	.owner = THIS_MODULE,
>  };
>  
> @@ -262,8 +290,6 @@ struct imx_pwm_data {
>  };
>  
>  static struct imx_pwm_data imx_pwm_data_v1 = {
> -	.config = imx_pwm_config_v1,
> -	.set_enable = imx_pwm_set_enable_v1,
>  	.pwm_ops = &imx_pwm_ops_v1,
>  };
>  
