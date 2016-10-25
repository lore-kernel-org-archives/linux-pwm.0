From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/6] pwm: imx: Rewrite imx_pwm_*_v1 code to facilitate
 switch to atomic pwm operation
Date: Tue, 25 Oct 2016 07:54:54 +0200
Message-ID: <20161025055454.emytytmcg6d23jdd@pengutronix.de>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
 <1477259146-19167-2-git-send-email-l.majewski@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57691 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753977AbcJYFz1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Oct 2016 01:55:27 -0400
Content-Disposition: inline
In-Reply-To: <1477259146-19167-2-git-send-email-l.majewski@majess.pl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>

On Sun, Oct 23, 2016 at 11:45:41PM +0200, Lukasz Majewski wrote:
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

This looks wrong. You start by enabling clk_ipg which is needed for
register access, but then end with disabling clk_per which is needed for
driving the actual PWM output. This function should probably enable
clk_per on entry and enable clk_ipg while accessing registers.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
