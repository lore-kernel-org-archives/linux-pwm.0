From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 07/14] pwm: meson: add the meson_pwm_channel data to
 struct meson_pwm
Date: Mon, 27 May 2019 14:27:25 +0200
Message-ID: <f218f396-9f07-c81c-62cc-bd363abfcbaa@baylibre.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-8-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190525181133.4875-8-martin.blumenstingl@googlemail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 25/05/2019 20:11, Martin Blumenstingl wrote:
> Make struct meson_pwm_channel accessible from struct meson_pwm.
> 
> PWM core has a limitation: per-channel data can only be set after
> pwmchip_add() is called. However, pwmchip_add() internally calls
> pwm_ops.get_state(). If pwm_ops.get_state() needs access to the
> per-channel data it has to obtain it from struct pwm_chip and struct
> pwm_device's hwpwm information.
> 
> Add a struct meson_pwm_channel for each PWM channel to struct meson_pwm
> so the pwm_ops.get_state() callback can be implemented as it needs
> access to the clock from struct meson_pwm_channel.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/pwm/pwm-meson.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index d6eb4d04d5c9..d1718f54ecec 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -37,6 +37,8 @@
>  #define MISC_B_EN		BIT(1)
>  #define MISC_A_EN		BIT(0)
>  
> +#define MESON_NUM_PWMS		2
> +
>  static const unsigned int mux_reg_shifts[] = {
>  	MISC_A_CLK_SEL_SHIFT,
>  	MISC_B_CLK_SEL_SHIFT
> @@ -62,6 +64,7 @@ struct meson_pwm_data {
>  struct meson_pwm {
>  	struct pwm_chip chip;
>  	const struct meson_pwm_data *data;
> +	struct meson_pwm_channel channels[MESON_NUM_PWMS];
>  	void __iomem *base;
>  	/*
>  	 * Protects register (write) access to the REG_MISC_AB register
> @@ -435,8 +438,7 @@ static const struct of_device_id meson_pwm_matches[] = {
>  };
>  MODULE_DEVICE_TABLE(of, meson_pwm_matches);
>  
> -static int meson_pwm_init_channels(struct meson_pwm *meson,
> -				   struct meson_pwm_channel *channels)
> +static int meson_pwm_init_channels(struct meson_pwm *meson)
>  {
>  	struct device *dev = meson->chip.dev;
>  	struct clk_init_data init;
> @@ -445,7 +447,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
>  	int err;
>  
>  	for (i = 0; i < meson->chip.npwm; i++) {
> -		struct meson_pwm_channel *channel = &channels[i];
> +		struct meson_pwm_channel *channel = &meson->channels[i];
>  
>  		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
>  
> @@ -480,18 +482,16 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
>  	return 0;
>  }
>  
> -static void meson_pwm_add_channels(struct meson_pwm *meson,
> -				   struct meson_pwm_channel *channels)
> +static void meson_pwm_add_channels(struct meson_pwm *meson)
>  {
>  	unsigned int i;
>  
>  	for (i = 0; i < meson->chip.npwm; i++)
> -		pwm_set_chip_data(&meson->chip.pwms[i], &channels[i]);
> +		pwm_set_chip_data(&meson->chip.pwms[i], &meson->channels[i]);
>  }
>  
>  static int meson_pwm_probe(struct platform_device *pdev)
>  {
> -	struct meson_pwm_channel *channels;
>  	struct meson_pwm *meson;
>  	struct resource *regs;
>  	int err;
> @@ -509,18 +509,13 @@ static int meson_pwm_probe(struct platform_device *pdev)
>  	meson->chip.dev = &pdev->dev;
>  	meson->chip.ops = &meson_pwm_ops;
>  	meson->chip.base = -1;
> -	meson->chip.npwm = 2;
> +	meson->chip.npwm = MESON_NUM_PWM;
>  	meson->chip.of_xlate = of_pwm_xlate_with_flags;
>  	meson->chip.of_pwm_n_cells = 3;
>  
>  	meson->data = of_device_get_match_data(&pdev->dev);
>  
> -	channels = devm_kcalloc(&pdev->dev, meson->chip.npwm,
> -				sizeof(*channels), GFP_KERNEL);
> -	if (!channels)
> -		return -ENOMEM;
> -
> -	err = meson_pwm_init_channels(meson, channels);
> +	err = meson_pwm_init_channels(meson);
>  	if (err < 0)
>  		return err;
>  
> @@ -530,7 +525,7 @@ static int meson_pwm_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	meson_pwm_add_channels(meson, channels);
> +	meson_pwm_add_channels(meson);
>  
>  	platform_set_drvdata(pdev, meson);
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
