From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/2] pwm: meson: don't disable pwm when setting duty
 repeatedly
Date: Wed, 3 Apr 2019 13:19:11 +0200
Message-ID: <7545ce1e-1e27-ca16-d762-5bf4b833defa@baylibre.com>
References: <20190401181817.11999-1-martin.blumenstingl@googlemail.com>
 <20190401181817.11999-3-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401181817.11999-3-martin.blumenstingl@googlemail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc: jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de, bichao.zheng@amlogic.com
List-Id: linux-pwm@vger.kernel.org

On 01/04/2019 20:18, Martin Blumenstingl wrote:
> From: Bichao Zheng <bichao.zheng@amlogic.com>
> 
> There is an abnormally low about 20ms,when setting duty repeatedly.
> Because setting the duty will disable pwm and then enable. Delete
> this operation now.
> 
> Fixes: 211ed630753d2f ("pwm: Add support for Meson PWM Controller")
> Signed-off-by: Bichao Zheng <bichao.zheng@amlogic.com>
> [ Dropped code instead of hiding it behind a comment ]
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/pwm/pwm-meson.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 4b708c1fcb1d..e247ab632530 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -325,11 +325,6 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	if (state->period != channel->state.period ||
>  	    state->duty_cycle != channel->state.duty_cycle ||
>  	    state->polarity != channel->state.polarity) {
> -		if (channel->state.enabled) {
> -			meson_pwm_disable(meson, pwm->hwpwm);
> -			channel->state.enabled = false;
> -		}
> -
>  		if (state->polarity != channel->state.polarity) {
>  			if (state->polarity == PWM_POLARITY_NORMAL)
>  				meson->inverter_mask |= BIT(pwm->hwpwm);
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
