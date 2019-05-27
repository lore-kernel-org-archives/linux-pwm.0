From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 06/14] pwm: meson: pass struct pwm_device to
 meson_pwm_calc()
Date: Mon, 27 May 2019 14:27:02 +0200
Message-ID: <9d0d7be1-af52-a7db-79ec-3b17b3190897@baylibre.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-7-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190525181133.4875-7-martin.blumenstingl@googlemail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 25/05/2019 20:11, Martin Blumenstingl wrote:
> meson_pwm_calc() is the last function that accepts a struct
> meson_pwm_channel. meson_pwm_enable(), meson_pwm_disable() and
> meson_pwm_apply() for example are all taking a struct pwm_device as
> parameter. When they need the struct meson_pwm_channel these functions
> simply call pwm_get_chip_data() internally.
> 
> Make meson_pwm_calc() consistent with the other functions in the
> meson-pwm driver by passing struct pwm_device to it as well. The value
> of the "id" parameter is actually pwm->hwpwm, but the driver never read
> the "id" parameter, which is why there's no replacement for it in the
> new code.
> 
> No functional changes.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/pwm/pwm-meson.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 39ea119add7b..d6eb4d04d5c9 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -114,10 +114,10 @@ static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  		clk_disable_unprepare(channel->clk);
>  }
>  
> -static int meson_pwm_calc(struct meson_pwm *meson,
> -			  struct meson_pwm_channel *channel,
> +static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>  			  struct pwm_state *state)
>  {
> +	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
>  	unsigned int duty, period, pre_div, cnt, duty_cnt;
>  	unsigned long fin_freq = -1;
>  	u64 fin_ps;
> @@ -280,7 +280,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	if (state->period != channel->state.period ||
>  	    state->duty_cycle != channel->state.duty_cycle ||
>  	    state->polarity != channel->state.polarity) {
> -		err = meson_pwm_calc(meson, channel, state);
> +		err = meson_pwm_calc(meson, pwm, state);
>  		if (err < 0)
>  			return err;
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
