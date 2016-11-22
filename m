From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v3 04/11] pwm: imx: Rewrite imx_pwm_*_v1 code to
 facilitate switch to atomic pwm operation
Date: Tue, 22 Nov 2016 13:31:23 -0800
Message-ID: <ef885c1a133fa106646c192672ac4ffe@agner.ch>
References: <1477984230-18071-1-git-send-email-l.majewski@majess.pl>
 <1477984230-18071-5-git-send-email-l.majewski@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477984230-18071-5-git-send-email-l.majewski@majess.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On 2016-11-01 00:10, Lukasz Majewski wrote:
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
> Changes for v3:
> - Remove ipg clock
> 
> Changes for v2:
> - Add missing clock unprepare for clk_ipg
> - Enable peripheral PWM clock (clk_per)
> ---
>  drivers/pwm/pwm-imx.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index d594501..8497902 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -64,8 +64,6 @@ struct imx_chip {
>  static int imx_pwm_config_v1(struct pwm_chip *chip,
>  		struct pwm_device *pwm, int duty_ns, int period_ns)
>  {
> -	struct imx_chip *imx = to_imx_chip(chip);
> -
>  	/*
>  	 * The PWM subsystem allows for exact frequencies. However,
>  	 * I cannot connect a scope on my device to the PWM line and
> @@ -83,6 +81,7 @@ static int imx_pwm_config_v1(struct pwm_chip *chip,
>  	 * both the prescaler (/1 .. /128) and then by CLKSEL
>  	 * (/2 .. /16).
>  	 */
> +	struct imx_chip *imx = to_imx_chip(chip);

This change is unnecessary.

It is also common to have declarations at the beginning of the function
and separated with a newline from code.

But otherwise looks good to me:

Reviewed-by: Stefan Agner <stefan@agner.ch>

--
Stefan

>  	u32 max = readl(imx->mmio_base + MX1_PWMP);
>  	u32 p = max * duty_ns / period_ns;
>  	writel(max - p, imx->mmio_base + MX1_PWMS);
> @@ -90,19 +89,34 @@ static int imx_pwm_config_v1(struct pwm_chip *chip,
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
> +
> +	clk_disable_unprepare(imx->clk_per);
>  }
>  
>  static int imx_pwm_config_v2(struct pwm_chip *chip,
> @@ -231,9 +245,9 @@ static void imx_pwm_disable(struct pwm_chip *chip,
> struct pwm_device *pwm)
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
> @@ -252,8 +266,6 @@ struct imx_pwm_data {
>  };
>  
>  static struct imx_pwm_data imx_pwm_data_v1 = {
> -	.config = imx_pwm_config_v1,
> -	.set_enable = imx_pwm_set_enable_v1,
>  	.pwm_ops = &imx_pwm_ops_v1,
>  };
