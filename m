From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/3] pwm: jz4740: Make PWM start with the active part
Date: Sun, 24 May 2020 19:35:27 +0200
Message-ID: <20200524173527.xlie3iycszvtugam@pengutronix.de>
References: <20200413121445.72996-1-paul@crapouillou.net>
 <20200413121445.72996-2-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200413121445.72996-2-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Mon, Apr 13, 2020 at 02:14:44PM +0200, Paul Cercueil wrote:
> The PWM would previously always start with the inactive part.
> To counter that, the common trick is to use an inverted duty as the
> real duty (as in, 'period - duty'), and invert the polarity when the
> PWM is enabled.
> 
> However, for some reason the driver was already configuring the hardware
> for an inverted duty, so inverting it again means we do configure the
> hardware with the actual duty value.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/pwm/pwm-jz4740.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index 3cd5c054ad9a..f566f9d248d6 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -6,7 +6,6 @@
>   * Limitations:
>   * - The .apply callback doesn't complete the currently running period before
>   *   reconfiguring the hardware.
> - * - Each period starts with the inactive part.
>   */
>  
>  #include <linux/clk.h>
> @@ -163,7 +162,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,

Side note: in the calculation above the driver is loosing precision as
the calculation for the duty counter uses the (already rounded) stuff
for the period counter.

The currently used calculation is (somewhat simplified syntax):

	period = (rate * requested_period) // NSEC_PER_SEC;
	duty = (period * requested_duty) // requested_period

The output then is an actual period of

	period * NSEC_PER_SEC / rate

and the duty cycle is

	duty * NSEC_PER_SEC / rate

.

Consider the following:

	rate = 23856100
	requested_period = 20959
	requested_duty = 16000

With the currently implemented algorithm we get:

	period = 499
	duty = 380

yielding a real period of 20917.08 ns (ok) and a duty cycle of 15928.84
ns. With duty = 381 we'd get 15970.758 ns which is better.

To reach that we'd need:

	/* Calculate duty value */
	tmp = (unsigned long long)rate * state->duty_cycle;
	do_div(tmp, NSEC_PER_SEC);
	duty = tmp

>  	/* Calculate duty value */
>  	tmp = (unsigned long long)period * state->duty_cycle;
>  	do_div(tmp, state->period);
> -	duty = period - tmp;
> +	duty = (unsigned long)tmp;

That cast is unnecessary.

>  
>  	if (duty >= period)
>  		duty = period - 1;
> @@ -190,17 +189,13 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
>  
>  	/* Set polarity */
> -	switch (state->polarity) {
> -	case PWM_POLARITY_NORMAL:
> +	if ((state->polarity != PWM_POLARITY_INVERSED) ^ state->enabled)

This needs to be more complicated than before as a disabled PWM needs
the other setting to yield its inactive level?

Maybe worth a comment?

>  		regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
>  				   TCU_TCSR_PWM_INITL_HIGH, 0);
> -		break;
> -	case PWM_POLARITY_INVERSED:
> +	else
>  		regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
>  				   TCU_TCSR_PWM_INITL_HIGH,
>  				   TCU_TCSR_PWM_INITL_HIGH);
> -		break;
> -	}

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
