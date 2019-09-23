From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/4] pwm: mxs: implement ->apply
Date: Mon, 23 Sep 2019 10:24:59 +0200
Message-ID: <20190923082459.huqpbz5eseonkscv@pengutronix.de>
References: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
 <20190923081348.6843-2-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190923081348.6843-2-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello Rasmus,

On Mon, Sep 23, 2019 at 10:13:45AM +0200, Rasmus Villemoes wrote:
> In preparation for supporting setting the polarity, switch the driver
> to support the ->apply method.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/pwm/pwm-mxs.c | 62 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
> index 04c0f6b95c1a..c70c26a9ff68 100644
> --- a/drivers/pwm/pwm-mxs.c
> +++ b/drivers/pwm/pwm-mxs.c
> @@ -26,6 +26,7 @@
>  #define  PERIOD_PERIOD_MAX	0x10000
>  #define  PERIOD_ACTIVE_HIGH	(3 << 16)
>  #define  PERIOD_INACTIVE_LOW	(2 << 18)
> +#define  PERIOD_POLARITY_NORMAL	(PERIOD_ACTIVE_HIGH | PERIOD_INACTIVE_LOW)
>  #define  PERIOD_CDIV(div)	(((div) & 0x7) << 20)
>  #define  PERIOD_CDIV_MAX	8
>  
> @@ -41,6 +42,66 @@ struct mxs_pwm_chip {
>  
>  #define to_mxs_pwm_chip(_chip) container_of(_chip, struct mxs_pwm_chip, chip)
>  
> +static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 struct pwm_state *state)
> +{
> +	struct mxs_pwm_chip *mxs = to_mxs_pwm_chip(chip);
> +	int ret, div = 0;
> +	unsigned int period_cycles, duty_cycles;
> +	unsigned long rate;
> +	unsigned long long c;
> +
> +	if (state->polarity != PWM_POLARITY_NORMAL)
> +		return -ENOTSUPP;
> +
> +	rate = clk_get_rate(mxs->clk);
> +	while (1) {
> +		c = rate / cdiv[div];
> +		c = c * state->period;
> +		do_div(c, 1000000000);
> +		if (c < PERIOD_PERIOD_MAX)
> +			break;
> +		div++;
> +		if (div >= PERIOD_CDIV_MAX)
> +			return -EINVAL;
> +	}
> +
> +	period_cycles = c;
> +	c *= state->duty_cycle;
> +	do_div(c, state->period);
> +	duty_cycles = c;
> +
> +	/*
> +	 * If the PWM channel is disabled, make sure to turn on the clock
> +	 * before writing the register. Otherwise, keep it enabled.
> +	 */
> +	if (!pwm_is_enabled(pwm)) {
> +		ret = clk_prepare_enable(mxs->clk);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	writel(duty_cycles << 16,
> +	       mxs->base + PWM_ACTIVE0 + pwm->hwpwm * 0x20);
> +	writel(PERIOD_PERIOD(period_cycles) | PERIOD_POLARITY_NORMAL | PERIOD_CDIV(div),
> +	       mxs->base + PWM_PERIOD0 + pwm->hwpwm * 0x20);
> +
> +	if (state->enabled) {
> +		if (!pwm_is_enabled(pwm)) {
> +			/*
> +			 * The clock was enabled above. Just enable
> +			 * the channel in the control register.
> +			 */
> +			writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + SET);
> +		}
> +	} else {
> +		if (pwm_is_enabled(pwm))
> +			writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + CLR);
> +		clk_disable_unprepare(mxs->clk);
> +	}
> +	return 0;
> +}

Maybe it would be easier to review when converting from .config +
.enable + .disable to .apply in a single step. (Note this "maybe" is
honest, I'm not entirely sure.)

There is a bug: If the PWM is running at (say) period=100ms, duty=0ms
and we call
pwm_apply_state(pwm, { .enabled = false, duty=100000, period=1000000 });
the output might get high which it should not.

Also there is a bug already in .config: You are not supposed to call
clk_get_rate if the clk might be off.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
