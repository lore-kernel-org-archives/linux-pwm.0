From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 09/14] pwm: meson: move pwm_set_chip_data() to
 meson_pwm_request()
Date: Mon, 27 May 2019 14:30:37 +0200
Message-ID: <aa6e6832-6bbc-87d7-9937-b18aec83a2ff@baylibre.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-10-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190525181133.4875-10-martin.blumenstingl@googlemail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 25/05/2019 20:11, Martin Blumenstingl wrote:
> All existing PWM drivers (except pwm-meson and two other ones) call
> pwm_set_chip_data() from their pwm_ops.request() callback. Now that we
> can access the struct meson_pwm_channel from struct meson_pwm we can do
> the same.
> 
> Move the call to pwm_set_chip_data() to meson_pwm_request() and drop the
> custom meson_pwm_add_channels(). This makes the implementation
> consistent with other drivers and makes it slightly more obvious
> thatpwm_get_chip_data() cannot be used from pwm_ops.get_state() (because
> that's called by the PWM core before pwm_ops.request()).
> 
> No functional changes intended.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/pwm/pwm-meson.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index ac7e188155fd..27915d6475e3 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -98,12 +98,16 @@ static inline struct meson_pwm *to_meson_pwm(struct pwm_chip *chip)
>  
>  static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
> -	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
> +	struct meson_pwm *meson = to_meson_pwm(chip);
> +	struct meson_pwm_channel *channel;
>  	struct device *dev = chip->dev;
>  	int err;
>  
> -	if (!channel)
> -		return -ENODEV;
> +	channel = pwm_get_chip_data(pwm);
> +	if (channel)
> +		return 0;
> +
> +	channel = &meson->channels[pwm->hwpwm];
>  
>  	if (channel->clk_parent) {
>  		err = clk_set_parent(channel->clk, channel->clk_parent);
> @@ -124,7 +128,7 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  
>  	chip->ops->get_state(chip, pwm, &channel->state);
>  
> -	return 0;
> +	return pwm_set_chip_data(pwm, channel);
>  }
>  
>  static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> @@ -460,14 +464,6 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
>  	return 0;
>  }
>  
> -static void meson_pwm_add_channels(struct meson_pwm *meson)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < meson->chip.npwm; i++)
> -		pwm_set_chip_data(&meson->chip.pwms[i], &meson->channels[i]);
> -}
> -
>  static int meson_pwm_probe(struct platform_device *pdev)
>  {
>  	struct meson_pwm *meson;
> @@ -503,8 +499,6 @@ static int meson_pwm_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	meson_pwm_add_channels(meson);
> -
>  	platform_set_drvdata(pdev, meson);
>  
>  	return 0;
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
