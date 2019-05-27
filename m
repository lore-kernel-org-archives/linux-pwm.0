From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 12/14] pwm: meson: don't cache struct pwm_state internally
Date: Mon, 27 May 2019 14:31:49 +0200
Message-ID: <e0d88134-32f1-cbe2-5aa6-d1a31914c20e@baylibre.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-13-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190525181133.4875-13-martin.blumenstingl@googlemail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 25/05/2019 20:11, Martin Blumenstingl wrote:
> The PWM core already caches the "current struct pwm_state" as the
> "current state of the hardware registers" inside struct pwm_device.
> 
> Drop the struct pwm_state from struct meson_pwm_channel in favour of the
> struct pwm_state in struct pwm_device. While here also drop any checks
> based on the pwm_state because the PWM core already takes care of this.
> 
> No functional changes intended.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/pwm/pwm-meson.c | 25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 010212166d5d..900d362ec3c9 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -68,8 +68,6 @@ struct meson_pwm_channel {
>  	unsigned int lo;
>  	u8 pre_div;
>  
> -	struct pwm_state state;
> -
>  	struct clk *clk_parent;
>  	struct clk_mux mux;
>  	struct clk *clk;
> @@ -127,8 +125,6 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  		return err;
>  	}
>  
> -	chip->ops->get_state(chip, pwm, &channel->state);
> -
>  	return pwm_set_chip_data(pwm, channel);
>  }
>  
> @@ -153,10 +149,6 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>  	if (state->polarity == PWM_POLARITY_INVERSED)
>  		duty = period - duty;
>  
> -	if (period == channel->state.period &&
> -	    duty == channel->state.duty_cycle)
> -		return 0;
> -
>  	fin_freq = clk_get_rate(channel->clk);
>  	if (fin_freq == 0) {
>  		dev_err(meson->chip.dev, "invalid source clock frequency\n");
> @@ -253,7 +245,6 @@ static void meson_pwm_disable(struct meson_pwm *meson, struct pwm_device *pwm)
>  static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			   struct pwm_state *state)
>  {
> -	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
>  	struct meson_pwm *meson = to_meson_pwm(chip);
>  	int err = 0;
>  
> @@ -262,26 +253,12 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  
>  	if (!state->enabled) {
>  		meson_pwm_disable(meson, pwm);
> -		channel->state.enabled = false;
> -
> -		return 0;
> -	}
> -
> -	if (state->period != channel->state.period ||
> -	    state->duty_cycle != channel->state.duty_cycle ||
> -	    state->polarity != channel->state.polarity) {
> +	} else {
>  		err = meson_pwm_calc(meson, pwm, state);
>  		if (err < 0)
>  			return err;
>  
> -		channel->state.polarity = state->polarity;
> -		channel->state.period = state->period;
> -		channel->state.duty_cycle = state->duty_cycle;
> -	}
> -
> -	if (state->enabled && !channel->state.enabled) {
>  		meson_pwm_enable(meson, pwm);
> -		channel->state.enabled = true;
>  	}
>  
>  	return 0;
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
