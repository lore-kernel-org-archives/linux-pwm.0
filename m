From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 01/14] pwm: meson: unify the parameter list of
 meson_pwm_{enable, disable}
Date: Mon, 27 May 2019 14:25:08 +0200
Message-ID: <bb920cb5-0e0b-ef1b-0ed9-35e865d54add@baylibre.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-2-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190525181133.4875-2-martin.blumenstingl@googlemail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 25/05/2019 20:11, Martin Blumenstingl wrote:
> This is a preparation for a future cleanup. Pass struct pwm_device
> instead of passing the individual values required by each function as
> these can be obtained for each struct pwm_device instance.
> 
> As a nice side-effect the driver now uses "switch (pwm->hwpwm)"
> everywhere. Before some functions used "switch (id)" while others used
> "switch (pwm->hwpwm)".
> 
> No functional changes.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/pwm/pwm-meson.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 5fef7e925282..3fbbc4128ce8 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -183,15 +183,14 @@ static int meson_pwm_calc(struct meson_pwm *meson,
>  	return 0;
>  }
>  
> -static void meson_pwm_enable(struct meson_pwm *meson,
> -			     struct meson_pwm_channel *channel,
> -			     unsigned int id)
> +static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
>  {
> +	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
>  	u32 value, clk_shift, clk_enable, enable;
>  	unsigned int offset;
>  	unsigned long flags;
>  
> -	switch (id) {
> +	switch (pwm->hwpwm) {
>  	case 0:
>  		clk_shift = MISC_A_CLK_DIV_SHIFT;
>  		clk_enable = MISC_A_CLK_EN;
> @@ -228,12 +227,12 @@ static void meson_pwm_enable(struct meson_pwm *meson,
>  	spin_unlock_irqrestore(&meson->lock, flags);
>  }
>  
> -static void meson_pwm_disable(struct meson_pwm *meson, unsigned int id)
> +static void meson_pwm_disable(struct meson_pwm *meson, struct pwm_device *pwm)
>  {
>  	u32 value, enable;
>  	unsigned long flags;
>  
> -	switch (id) {
> +	switch (pwm->hwpwm) {
>  	case 0:
>  		enable = MISC_A_EN;
>  		break;
> @@ -266,7 +265,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		return -EINVAL;
>  
>  	if (!state->enabled) {
> -		meson_pwm_disable(meson, pwm->hwpwm);
> +		meson_pwm_disable(meson, pwm);
>  		channel->state.enabled = false;
>  
>  		return 0;
> @@ -293,7 +292,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	}
>  
>  	if (state->enabled && !channel->state.enabled) {
> -		meson_pwm_enable(meson, channel, pwm->hwpwm);
> +		meson_pwm_enable(meson, pwm);
>  		channel->state.enabled = true;
>  	}
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
