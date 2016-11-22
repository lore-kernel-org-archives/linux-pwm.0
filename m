From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v3 06/11] pwm: imx: Move PWMv2 wait for fifo slot code to
 a separate function
Date: Tue, 22 Nov 2016 13:56:46 -0800
Message-ID: <9a3ad088c9fb9e533508563ad633aea6@agner.ch>
References: <1477984230-18071-1-git-send-email-l.majewski@majess.pl>
 <1477984230-18071-7-git-send-email-l.majewski@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477984230-18071-7-git-send-email-l.majewski@majess.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On 2016-11-01 00:10, Lukasz Majewski wrote:
> The code, which waits for fifo slot, has been extracted from
> imx_pwm_config_v2 function and moved to new one - imx_pwm_wait_fifo_slot().
> 
> This change reduces the overall size of imx_pwm_config_v2() and prepares
> it for atomic PWM operation.
> 
> Suggested-by: Stefan Agner <stefan@agner.ch>
> Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>

Reviewed-by: Stefan Agner <stefan@agner.ch>

> ---
> Changes for v3:
> - None
> 
> Changes for v2:
> - None
> ---
>  drivers/pwm/pwm-imx.c | 43 +++++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index b4e5803..ebe9b0c 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -137,18 +137,36 @@ static void imx_pwm_sw_reset(struct pwm_chip *chip)
>  		dev_warn(dev, "software reset timeout\n");
>  }
>  
> +static void imx_pwm_wait_fifo_slot(struct pwm_chip *chip,
> +				   struct pwm_device *pwm)
> +{
> +	struct imx_chip *imx = to_imx_chip(chip);
> +	struct device *dev = chip->dev;
> +	unsigned int period_ms;
> +	int fifoav;
> +	u32 sr;
> +
> +	sr = readl(imx->mmio_base + MX3_PWMSR);
> +	fifoav = sr & MX3_PWMSR_FIFOAV_MASK;
> +	if (fifoav == MX3_PWMSR_FIFOAV_4WORDS) {
> +		period_ms = DIV_ROUND_UP(pwm_get_period(pwm),
> +					 NSEC_PER_MSEC);
> +		msleep(period_ms);
> +
> +		sr = readl(imx->mmio_base + MX3_PWMSR);
> +		if (fifoav == (sr & MX3_PWMSR_FIFOAV_MASK))
> +			dev_warn(dev, "there is no free FIFO slot\n");
> +	}
> +}
>  
>  static int imx_pwm_config_v2(struct pwm_chip *chip,
>  		struct pwm_device *pwm, int duty_ns, int period_ns)
>  {
>  	struct imx_chip *imx = to_imx_chip(chip);
> -	struct device *dev = chip->dev;
>  	unsigned long long c;
>  	unsigned long period_cycles, duty_cycles, prescale;
> -	unsigned int period_ms;
>  	bool enable = pwm_is_enabled(pwm);
> -	int fifoav;
> -	u32 cr, sr;
> +	u32 cr;
>  
>  	/*
>  	 * i.MX PWMv2 has a 4-word sample FIFO.
> @@ -157,21 +175,10 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
>  	 * wait for a full PWM cycle to get a relinquished FIFO slot
>  	 * when the controller is enabled and the FIFO is fully loaded.
>  	 */
> -	if (enable) {
> -		sr = readl(imx->mmio_base + MX3_PWMSR);
> -		fifoav = sr & MX3_PWMSR_FIFOAV_MASK;
> -		if (fifoav == MX3_PWMSR_FIFOAV_4WORDS) {
> -			period_ms = DIV_ROUND_UP(pwm_get_period(pwm),
> -						 NSEC_PER_MSEC);
> -			msleep(period_ms);
> -
> -			sr = readl(imx->mmio_base + MX3_PWMSR);
> -			if (fifoav == (sr & MX3_PWMSR_FIFOAV_MASK))
> -				dev_warn(dev, "there is no free FIFO slot\n");
> -		}
> -	} else {
> +	if (enable)
> +		imx_pwm_wait_fifo_slot(chip, pwm);
> +	else
>  		imx_pwm_sw_reset(chip);
> -	}
>  
>  	c = clk_get_rate(imx->clk_per);
>  	c = c * period_ns;
