From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 04/10] pwm: imx: Move PWMv2 software reset code to a
 separate function
Date: Thu, 03 Nov 2016 10:34:32 +0100
Message-ID: <1478165672.3650.3.camel@pengutronix.de>
References: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
         <1477549785-4972-5-git-send-email-l.majewski@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57852 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752194AbcKCJej (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Nov 2016 05:34:39 -0400
In-Reply-To: <1477549785-4972-5-git-send-email-l.majewski@majess.pl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>

Hi Lukasz,

Am Donnerstag, den 27.10.2016, 08:29 +0200 schrieb Lukasz Majewski:
> The software reset code has been extracted from imx_pwm_config_v2 function
> and moved to new one - imx_pwm_sw_reset().
> 
> This change reduces the overall size of imx_pwm_config_v2() and prepares
> it for atomic PWM operation.
> 
> Suggested-by: Stefan Agner <stefan@agner.ch>
> Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

> ---
> Changes for v2:
> - Add missing parenthesis
> ---
>  drivers/pwm/pwm-imx.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index 822eb5a..8174ae6 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -134,6 +134,25 @@ static void imx_pwm_disable_v1(struct pwm_chip *chip, struct pwm_device *pwm)
>  	clk_disable_unprepare(imx->clk_per);
>  }
>  
> +static void imx_pwm_sw_reset(struct pwm_chip *chip)
> +{
> +	struct imx_chip *imx = to_imx_chip(chip);
> +	struct device *dev = chip->dev;
> +	int wait_count = 0;
> +	u32 cr;
> +
> +	writel(MX3_PWMCR_SWR, imx->mmio_base + MX3_PWMCR);
> +	do {
> +		usleep_range(200, 1000);
> +		cr = readl(imx->mmio_base + MX3_PWMCR);
> +	} while ((cr & MX3_PWMCR_SWR) &&
> +		 (wait_count++ < MX3_PWM_SWR_LOOP));

Not an issue for this patch, but this could be converted to use
readl_poll_timeout.

> +
> +	if (cr & MX3_PWMCR_SWR)
> +		dev_warn(dev, "software reset timeout\n");
> +}
> +
> +
>  static int imx_pwm_config_v2(struct pwm_chip *chip,
>  		struct pwm_device *pwm, int duty_ns, int period_ns)
>  {
> @@ -143,7 +162,7 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
>  	unsigned long period_cycles, duty_cycles, prescale;
>  	unsigned int period_ms;
>  	bool enable = pwm_is_enabled(pwm);
> -	int wait_count = 0, fifoav;
> +	int fifoav;
>  	u32 cr, sr;
>  
>  	/*
> @@ -166,15 +185,7 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
>  				dev_warn(dev, "there is no free FIFO slot\n");
>  		}
>  	} else {
> -		writel(MX3_PWMCR_SWR, imx->mmio_base + MX3_PWMCR);
> -		do {
> -			usleep_range(200, 1000);
> -			cr = readl(imx->mmio_base + MX3_PWMCR);
> -		} while ((cr & MX3_PWMCR_SWR) &&
> -			 (wait_count++ < MX3_PWM_SWR_LOOP));
> -
> -		if (cr & MX3_PWMCR_SWR)
> -			dev_warn(dev, "software reset timeout\n");
> +		imx_pwm_sw_reset(chip);
>  	}
>  
>  	c = clk_get_rate(imx->clk_per);

regards
Philipp
