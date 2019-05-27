From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 05/14] pwm: meson: don't duplicate the polarity internally
Date: Mon, 27 May 2019 14:26:48 +0200
Message-ID: <edb82eba-2576-f99a-5553-cec18ee292f1@baylibre.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-6-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190525181133.4875-6-martin.blumenstingl@googlemail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 25/05/2019 20:11, Martin Blumenstingl wrote:
> Let meson_pwm_calc() use the polarity from struct pwm_state directly.
> This removes a level of indirection where meson_pwm_apply() first had to
> set a driver-internal inverter mask which was then only used by
> meson_pwm_calc().
> 
> Instead of adding the polarity as parameter to meson_pwm_calc() switch
> to struct pwm_state directly to make it easier to see where the
> parameters are actually coming from.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/pwm/pwm-meson.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 84b28ba0f903..39ea119add7b 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -63,7 +63,6 @@ struct meson_pwm {
>  	struct pwm_chip chip;
>  	const struct meson_pwm_data *data;
>  	void __iomem *base;
> -	u8 inverter_mask;
>  	/*
>  	 * Protects register (write) access to the REG_MISC_AB register
>  	 * that is shared between the two PWMs.
> @@ -116,14 +115,17 @@ static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  }
>  
>  static int meson_pwm_calc(struct meson_pwm *meson,
> -			  struct meson_pwm_channel *channel, unsigned int id,
> -			  unsigned int duty, unsigned int period)
> +			  struct meson_pwm_channel *channel,
> +			  struct pwm_state *state)
>  {
> -	unsigned int pre_div, cnt, duty_cnt;
> +	unsigned int duty, period, pre_div, cnt, duty_cnt;
>  	unsigned long fin_freq = -1;
>  	u64 fin_ps;
>  
> -	if (~(meson->inverter_mask >> id) & 0x1)
> +	duty = state->duty_cycle;
> +	period = state->period;
> +
> +	if (state->polarity == PWM_POLARITY_INVERSED)
>  		duty = period - duty;
>  
>  	if (period == channel->state.period &&
> @@ -278,15 +280,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	if (state->period != channel->state.period ||
>  	    state->duty_cycle != channel->state.duty_cycle ||
>  	    state->polarity != channel->state.polarity) {
> -		if (state->polarity != channel->state.polarity) {
> -			if (state->polarity == PWM_POLARITY_NORMAL)
> -				meson->inverter_mask |= BIT(pwm->hwpwm);
> -			else
> -				meson->inverter_mask &= ~BIT(pwm->hwpwm);
> -		}
> -
> -		err = meson_pwm_calc(meson, channel, pwm->hwpwm,
> -				     state->duty_cycle, state->period);
> +		err = meson_pwm_calc(meson, channel, state);
>  		if (err < 0)
>  			return err;
>  
> @@ -520,7 +514,6 @@ static int meson_pwm_probe(struct platform_device *pdev)
>  	meson->chip.of_pwm_n_cells = 3;
>  
>  	meson->data = of_device_get_match_data(&pdev->dev);
> -	meson->inverter_mask = BIT(meson->chip.npwm) - 1;
>  
>  	channels = devm_kcalloc(&pdev->dev, meson->chip.npwm,
>  				sizeof(*channels), GFP_KERNEL);
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
