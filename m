From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v5 07/11] pwm: imx: Provide atomic PWM support for i.MX
 PWMv2
Date: Mon, 30 Jan 2017 08:49:14 +0100
Message-ID: <20170130084914.672dd16e@bbrezillon>
References: <1485726855-16236-1-git-send-email-lukma@denx.de>
        <1485726855-16236-8-git-send-email-lukma@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485726855-16236-8-git-send-email-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <l.majewski@majess.pl>
List-Id: linux-pwm@vger.kernel.org

On Sun, 29 Jan 2017 22:54:11 +0100
Lukasz Majewski <lukma@denx.de> wrote:

> This commit provides apply() callback implementation for i.MX's PWMv2.
> 
> Suggested-by: Stefan Agner <stefan@agner.ch>
> Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> Changes for v5:
> - Modify ->apply() function to avoid unbalanced clock enabling/disabling
> - Fix preventing iMX7 from hanging
> 
> Changes for v4:
> - Avoid recalculation of PWM parameters when disabling PWM signal
> - Unconditionally call clk_prepare_enable(imx->clk_per) and
>   clk_disable_unprepare(imx->clk_per)
> 
> Changes for v3:
> - Remove ipg clock enable/disable functions
> 
> Changes for v2:
> - None
> ---
>  drivers/pwm/pwm-imx.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index 60cdc5c..fdaa11b 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -249,6 +249,73 @@ static int imx_pwm_config(struct pwm_chip *chip,
>  	return ret;
>  }
>  
> +static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    struct pwm_state *state)
> +{
> +	unsigned long period_cycles, duty_cycles, prescale;
> +	struct imx_chip *imx = to_imx_chip(chip);
> +	struct pwm_state cstate;
> +	unsigned long long c;
> +	int ret;
> +
> +	pwm_get_state(pwm, &cstate);
> +
> +	if (state->enabled) {
> +		c = clk_get_rate(imx->clk_per);
> +		c *= state->period;
> +
> +		do_div(c, 1000000000);
> +		period_cycles = c;
> +
> +		prescale = period_cycles / 0x10000 + 1;
> +
> +		period_cycles /= prescale;
> +		c = (unsigned long long)period_cycles * state->duty_cycle;
> +		do_div(c, state->period);
> +		duty_cycles = c;
> +
> +		/*
> +		 * according to imx pwm RM, the real period value should be
> +		 * PERIOD value in PWMPR plus 2.
> +		 */
> +		if (period_cycles > 2)
> +			period_cycles -= 2;
> +		else
> +			period_cycles = 0;
> +
> +		/*
> +		 * Wait for a free FIFO slot if the PWM is already enabled, and
> +		 * flush the FIFO if the PWM was disabled and is about to be
> +		 * enabled.
> +		 */
> +		if (cstate.enabled) {
> +			imx_pwm_wait_fifo_slot(chip, pwm);
> +		} else if (state->enabled) {

Should just be

		} else {

since we're already in the 'if (state->enabled)' block (see above).

I see that Thierry already applied the series, so, just for the record,
with this fixed, the whole series is

Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Thanks,

Boris

> +			ret = clk_prepare_enable(imx->clk_per);
> +			if (ret)
> +				return ret;
> +
> +			imx_pwm_sw_reset(chip);
> +		}
> +
> +		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> +		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> +
> +		writel(MX3_PWMCR_PRESCALER(prescale) |
> +		       MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
> +		       MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH |
> +		       MX3_PWMCR_EN,
> +		       imx->mmio_base + MX3_PWMCR);
> +
> +	} else if (cstate.enabled) {
> +		writel(0, imx->mmio_base + MX3_PWMCR);
> +
> +		clk_disable_unprepare(imx->clk_per);
> +	}
> +
> +	return 0;
> +}
