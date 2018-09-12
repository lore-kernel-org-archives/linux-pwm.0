From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 1/1] gpio: mvebu: Add support for multiple PWM lines
 per GPIO chip
Date: Wed, 12 Sep 2018 15:01:02 +0200
Message-ID: <20180912130102.GB24595@lunn.ch>
References: <1536727915-113932-1-git-send-email-aditya@kobol.io>
 <1536727915-113932-2-git-send-email-aditya@kobol.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1536727915-113932-2-git-send-email-aditya@kobol.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Aditya Prayoga <aditya@kobol.io>
Cc: linux-gpio@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Genoud <richard.genoud@gmail.com>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Gauthier Provost <gauthier@kobol.io>, Dennis Gilmore <dennis@ausil.us>
List-Id: linux-pwm@vger.kernel.org

>  static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>  	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
>  	struct mvebu_gpio_chip *mvchip = mvpwm->mvchip;
>  	struct gpio_desc *desc;
> +	struct mvebu_pwm *counter;
>  	unsigned long flags;
>  	int ret = 0;
>  
>  	spin_lock_irqsave(&mvpwm->lock, flags);
>  
> -	if (mvpwm->gpiod) {
> -		ret = -EBUSY;
> -	} else {
> -		desc = gpiochip_request_own_desc(&mvchip->chip,
> -						 pwm->hwpwm, "mvebu-pwm");
> -		if (IS_ERR(desc)) {
> -			ret = PTR_ERR(desc);
> +	counter = mvpwm;
> +	if (counter->gpiod) {
> +		counter = mvebu_pwm_get_avail_counter();
> +		if (!counter) {
> +			ret = -EBUSY;

I don't understand this bit of code. Please could you explain what is
going on.

>  			goto out;
>  		}
>  
> -		ret = gpiod_direction_output(desc, 0);
> -		if (ret) {
> -			gpiochip_free_own_desc(desc);
> -			goto out;
> -		}
> +		pwm->chip_data = counter;
> +	}
>  
> -		mvpwm->gpiod = desc;
> +	desc = gpiochip_request_own_desc(&mvchip->chip,
> +					 pwm->hwpwm, "mvebu-pwm");
> +	if (IS_ERR(desc)) {
> +		ret = PTR_ERR(desc);
> +		goto out;
>  	}
> +
> +	ret = gpiod_direction_output(desc, 0);
> +	if (ret) {
> +		gpiochip_free_own_desc(desc);
> +		goto out;
> +	}
> +
> +	regmap_update_bits(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF +
> +			   mvchip->offset, BIT(pwm->hwpwm),
> +			   counter->id ? BIT(pwm->hwpwm) : 0);
> +	regmap_read(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF +
> +		    mvchip->offset, &counter->blink_select);
> +
> +	counter->gpiod = desc;
>  out:
>  	spin_unlock_irqrestore(&mvpwm->lock, flags);
>  	return ret;
> @@ -632,6 +666,11 @@ static void mvebu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
>  	unsigned long flags;
>  
> +	if (pwm->chip_data) {
> +		mvpwm = (struct mvebu_pwm *) pwm->chip_data;
> +		pwm->chip_data = NULL;
> +	}
> +
>  	spin_lock_irqsave(&mvpwm->lock, flags);
>  	gpiochip_free_own_desc(mvpwm->gpiod);
>  	mvpwm->gpiod = NULL;
> @@ -648,6 +687,9 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
>  	unsigned long flags;
>  	u32 u;
>  
> +	if (pwm->chip_data)
> +		mvpwm = (struct mvebu_pwm *) pwm->chip_data;
> +

You should not need a cast here, if chip_data is a void *.

What is pwm->chip_data is a NULL? Don't you then use an uninitialized
mvpwm?

	Andrew
