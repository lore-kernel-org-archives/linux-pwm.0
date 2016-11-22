From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v3 05/11] pwm: imx: Move PWMv2 software reset code to a
 separate function
Date: Tue, 22 Nov 2016 13:56:29 -0800
Message-ID: <c2122b6d4a18d4112578b7039f912f21@agner.ch>
References: <1477984230-18071-1-git-send-email-l.majewski@majess.pl>
 <1477984230-18071-6-git-send-email-l.majewski@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477984230-18071-6-git-send-email-l.majewski@majess.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On 2016-11-01 00:10, Lukasz Majewski wrote:
> The software reset code has been extracted from imx_pwm_config_v2 function
> and moved to new one - imx_pwm_sw_reset().
> 
> This change reduces the overall size of imx_pwm_config_v2() and prepares
> it for atomic PWM operation.
> 
> Suggested-by: Stefan Agner <stefan@agner.ch>
> Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> 

Looks good to me:

Reviewed-by: Stefan Agner <stefan@agner.ch>

> ---
> Changes for v3:
> - None
> 
> Changes for v2:
> - Add missing parenthesis
> ---
>  drivers/pwm/pwm-imx.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index 8497902..b4e5803 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -119,6 +119,25 @@ static void imx_pwm_disable_v1(struct pwm_chip
> *chip, struct pwm_device *pwm)
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
> +
> +	if (cr & MX3_PWMCR_SWR)
> +		dev_warn(dev, "software reset timeout\n");
> +}
> +
> +
>  static int imx_pwm_config_v2(struct pwm_chip *chip,
>  		struct pwm_device *pwm, int duty_ns, int period_ns)
>  {
> @@ -128,7 +147,7 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
>  	unsigned long period_cycles, duty_cycles, prescale;
>  	unsigned int period_ms;
>  	bool enable = pwm_is_enabled(pwm);
> -	int wait_count = 0, fifoav;
> +	int fifoav;
>  	u32 cr, sr;
>  
>  	/*
> @@ -151,15 +170,7 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
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
