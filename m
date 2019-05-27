From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 13/14] pwm: meson: add support PWM_POLARITY_INVERSED when
 disabling
Date: Mon, 27 May 2019 14:33:42 +0200
Message-ID: <4de7d436-32b7-e4ed-39b2-e85f75a17c16@baylibre.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-14-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190525181133.4875-14-martin.blumenstingl@googlemail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 25/05/2019 20:11, Martin Blumenstingl wrote:
> meson_pwm_apply() has to consider the PWM polarity when disabling the
> output.
> With enabled=false and polarity=PWM_POLARITY_NORMAL the output needs to
> be LOW. The driver already supports this.
> With enabled=false and polarity=PWM_POLARITY_INVERSED the output needs
> to be HIGH. Implement this in the driver by internally enabling the
> output with the same settings that we already use for "period == duty".
> 
> This fixes a PWM API violation which expects that the driver honors the
> polarity also for enabled=false. Due to the IP block not supporting this
> natively we only get "an as close as possible" to 100% HIGH signal (in
> my test setup with input clock of 24MHz and measuring the output with a
> logic analyzer at 24MHz sampling rate I got a duty cycle of 99.998475%
> on a Khadas VIM).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/pwm/pwm-meson.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 900d362ec3c9..bb48ba85f756 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -245,6 +245,7 @@ static void meson_pwm_disable(struct meson_pwm *meson, struct pwm_device *pwm)
>  static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			   struct pwm_state *state)
>  {
> +	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
>  	struct meson_pwm *meson = to_meson_pwm(chip);
>  	int err = 0;
>  
> @@ -252,7 +253,27 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		return -EINVAL;
>  
>  	if (!state->enabled) {
> -		meson_pwm_disable(meson, pwm);
> +		if (state->polarity == PWM_POLARITY_INVERSED) {
> +			/*
> +			 * This IP block revision doesn't have an "always high"
> +			 * setting which we can use for "inverted disabled".
> +			 * Instead we achieve this using the same settings
> +			 * that we use a pre_div of 0 (to get the shortest
> +			 * possible duration for one "count") and
> +			 * "period == duty_cycle". This results in a signal
> +			 * which is LOW for one "count", while being HIGH for
> +			 * the rest of the (so the signal is HIGH for slightly
> +			 * less than 100% of the period, but this is the best
> +			 * we can achieve).
> +			 */
> +			channel->pre_div = 0;
> +			channel->hi = ~0;
> +			channel->lo = 0;
> +
> +			meson_pwm_enable(meson, pwm);
> +		} else {
> +			meson_pwm_disable(meson, pwm);
> +		}
>  	} else {
>  		err = meson_pwm_calc(meson, pwm, state);
>  		if (err < 0)
> 

While not perfect, it almost fills the gap.
Another way would be to use a specific pinctrl state setting the pin
in GPIO output in high level, but this implementation could stay
if the pinctrl state isn't available.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
