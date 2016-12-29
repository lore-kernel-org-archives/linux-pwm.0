From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3 RESEND 07/11] pwm: imx: Provide atomic PWM support
 for i.MX PWMv2
Date: Thu, 29 Dec 2016 17:21:17 +0100
Message-ID: <20161229172117.523a42a4@bbrezillon>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
        <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
        <1482792961-12702-8-git-send-email-l.majewski@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482792961-12702-8-git-send-email-l.majewski@majess.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

Hi Lukasz,

On Mon, 26 Dec 2016 23:55:57 +0100
Lukasz Majewski <l.majewski@majess.pl> wrote:

> This commit provides apply() callback implementation for i.MX's PWMv2.
> 
> Suggested-by: Stefan Agner <stefan@agner.ch>
> Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> Changes for v3:
> - Remove ipg clock enable/disable functions
> 
> Changes for v2:
> - None
> ---
>  drivers/pwm/pwm-imx.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index ebe9b0c..cd53c05 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -159,6 +159,75 @@ static void imx_pwm_wait_fifo_slot(struct pwm_chip *chip,
>  	}
>  }
>  
> +static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    struct pwm_state *state)
> +{
> +	unsigned long period_cycles, duty_cycles, prescale;
> +	struct imx_chip *imx = to_imx_chip(chip);
> +	struct pwm_state cstate;
> +	unsigned long long c;
> +	u32 cr = 0;
> +	int ret;
> +
> +	pwm_get_state(pwm, &cstate);
> +
> +	c = clk_get_rate(imx->clk_per);
> +	c *= state->period;
> +
> +	do_div(c, 1000000000);
> +	period_cycles = c;
> +
> +	prescale = period_cycles / 0x10000 + 1;
> +
> +	period_cycles /= prescale;
> +	c = (unsigned long long)period_cycles * state->duty_cycle;
> +	do_div(c, state->period);
> +	duty_cycles = c;
> +
> +	/*
> +	 * according to imx pwm RM, the real period value should be
> +	 * PERIOD value in PWMPR plus 2.
> +	 */
> +	if (period_cycles > 2)
> +		period_cycles -= 2;
> +	else
> +		period_cycles = 0;
> +
> +	/* Enable the clock if the PWM is being enabled. */
> +	if (state->enabled && !cstate.enabled) {
> +		ret = clk_prepare_enable(imx->clk_per);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * Wait for a free FIFO slot if the PWM is already enabled, and flush
> +	 * the FIFO if the PWM was disabled and is about to be enabled.
> +	 */
> +	if (cstate.enabled)
> +		imx_pwm_wait_fifo_slot(chip, pwm);
> +	else if (state->enabled)
> +		imx_pwm_sw_reset(chip);
> +
> +	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> +	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> +
> +	cr |= MX3_PWMCR_PRESCALER(prescale) |
> +	      MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
> +	      MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH;
> +
> +	if (state->enabled)
> +		cr |= MX3_PWMCR_EN;
> +
> +	writel(cr, imx->mmio_base + MX3_PWMCR);
> +
> +	/* Disable the clock if the PWM is being disabled. */
> +	if (!state->enabled && cstate.enabled)
> +		clk_disable_unprepare(imx->clk_per);
> +
> +	return 0;
> +}
> +

Stefan suggested to rework this function to avoid unneeded
duty/period calculation and reg write when disabling the PWM. Why
didn't you send a v4 addressing that instead of resending the exact
same v3?

Same goes for the regression introduced in patch 2: I think it's better
to keep things bisectable on all platforms (even if it appeared to work
by chance on imx7, it did work before this change).

That's just my opinion, but when you get reviews on a patch series, it's
better to address them directly (especially when issues can be easily
fixed) than provide follow-up patches.

Regards,

Boris
