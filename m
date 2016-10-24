From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 1/6] pwm: imx: Rewrite imx_pwm_*_v1 code to facilitate
 switch to atomic pwm operation
Date: Mon, 24 Oct 2016 17:21:01 +0200
Message-ID: <20161024172101.2ea74462@bbrezillon>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
        <1477259146-19167-2-git-send-email-l.majewski@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from up.free-electrons.com ([163.172.77.33]:46670 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752360AbcJXPVK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Oct 2016 11:21:10 -0400
In-Reply-To: <1477259146-19167-2-git-send-email-l.majewski@majess.pl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de

On Sun, 23 Oct 2016 23:45:41 +0200
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

Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  drivers/pwm/pwm-imx.c | 46 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index c37d223..83e43d5 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -66,8 +66,6 @@ struct imx_chip {
>  static int imx_pwm_config_v1(struct pwm_chip *chip,
>  		struct pwm_device *pwm, int duty_ns, int period_ns)
>  {
> -	struct imx_chip *imx = to_imx_chip(chip);
> -
>  	/*
>  	 * The PWM subsystem allows for exact frequencies. However,
>  	 * I cannot connect a scope on my device to the PWM line and
> @@ -85,26 +83,52 @@ static int imx_pwm_config_v1(struct pwm_chip *chip,
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
>  	val = readl(imx->mmio_base + MX1_PWMC);
> +	val |= MX1_PWMC_EN;
> +	writel(val, imx->mmio_base + MX1_PWMC);
>  
> -	if (enable)
> -		val |= MX1_PWMC_EN;
> -	else
> -		val &= ~MX1_PWMC_EN;
> +	clk_disable_unprepare(imx->clk_per);
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
> +
> +	clk_disable_unprepare(imx->clk_per);
>  }
>  
>  static int imx_pwm_config_v2(struct pwm_chip *chip,
> @@ -269,9 +293,9 @@ static int imx_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
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
> @@ -291,8 +315,6 @@ struct imx_pwm_data {
>  };
>  
>  static struct imx_pwm_data imx_pwm_data_v1 = {
> -	.config = imx_pwm_config_v1,
> -	.set_enable = imx_pwm_set_enable_v1,
>  	.pwm_ops = &imx_pwm_ops_v1,
>  };
>  
