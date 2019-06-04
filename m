From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] pwm: pca9685: fix pwm/gpio inter-operation
Date: Tue, 4 Jun 2019 12:14:25 +0300
Message-ID: <20190604091425.GL2781@lahna.fi.intel.com>
References: <20190603151223.5311-1-TheSven73@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190603151223.5311-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

On Mon, Jun 03, 2019 at 11:12:23AM -0400, Sven Van Asbroeck wrote:
> This driver allows pwms to be requested as gpios via gpiolib.
> Obviously, it should not be allowed to request a gpio when its
> corresponding pwm is already requested (and vice versa).
> So it requires some exclusion code.
> 
> Given that the pwm and gpio cores are not synchronized with
> respect to each other, this exclusion code will also require
> proper synchronization.
> 
> Such a mechanism was in place, but was inadvertently removed
> by Uwe's clean-up patch.
> 
> Upon revisiting the synchronization mechanism, we found that
> theoretically, it could allow two threads to successfully
> request conflicting pwms / gpios.
> 
> Replace with a bitmap which tracks pwm in-use, plus a mutex.
> As long as pwm and gpio's respective request/free functions
> modify the in-use bitmap while holding the mutex, proper
> synchronization will be guaranteed.
> 
> Reported-by: YueHaibing <yuehaibing@huawei.com>
> Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()")
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Link: https://lkml.org/lkml/2019/5/31/963
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
> 
> This approach will also prevent the request of the "all" pwm channel, if any
> other pwm channel is already in use. Is this correct behaviour?

Sounds correct to me.

>  drivers/pwm/pwm-pca9685.c | 64 +++++++++++++++++++++------------------
>  1 file changed, 35 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 567f5e2771c4..f9927cd106d0 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -31,6 +31,7 @@
>  #include <linux/slab.h>
>  #include <linux/delay.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/bitmap.h>
>  
>  /*
>   * Because the PCA9685 has only one prescaler per chip, changing the period of
> @@ -85,6 +86,7 @@ struct pca9685 {
>  #if IS_ENABLED(CONFIG_GPIOLIB)
>  	struct mutex lock;
>  	struct gpio_chip gpio;
> +	DECLARE_BITMAP(pwms_inuse, PCA9685_MAXCHAN);
>  #endif
>  };
>  
> @@ -97,48 +99,45 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
>  static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
>  {
>  	struct pca9685 *pca = gpiochip_get_data(gpio);
> -	struct pwm_device *pwm;
>  
>  	mutex_lock(&pca->lock);
>  
> -	pwm = &pca->chip.pwms[offset];
> -
> -	if (pwm->flags & (PWMF_REQUESTED | PWMF_EXPORTED)) {
> +	if (test_and_set_bit(offset, pca->pwms_inuse)) {
>  		mutex_unlock(&pca->lock);
>  		return -EBUSY;
>  	}
>  
> -	pwm_set_chip_data(pwm, (void *)1);
> -
>  	mutex_unlock(&pca->lock);
>  	pm_runtime_get_sync(pca->chip.dev);
>  	return 0;
>  }
>  
> -static bool pca9685_pwm_is_gpio(struct pca9685 *pca, struct pwm_device *pwm)
> +static bool
> +pca9685_pwm_test_set_inuse(struct pca9685 *pca, struct pwm_device *pwm)

Can we call it pca9685_pwm_test_and_set_inuse() following naming of
test_and_set_bit()?

>  {
> -	bool is_gpio = false;
> +	bool is_inuse;
>  
>  	mutex_lock(&pca->lock);
> +	/*
> +	 * Check if any of the PWMs are requested and in that case
> +	 * prevent using the "all LEDs" channel.
> +	 */
> +	if (pwm->hwpwm >= PCA9685_MAXCHAN &&
> +			!bitmap_empty(pca->pwms_inuse, PCA9685_MAXCHAN))
> +		is_inuse = true;
> +	else
> +		is_inuse = test_and_set_bit(pwm->hwpwm, pca->pwms_inuse);
> +	mutex_unlock(&pca->lock);
>  
> -	if (pwm->hwpwm >= PCA9685_MAXCHAN) {
> -		unsigned int i;
> -
> -		/*
> -		 * Check if any of the GPIOs are requested and in that case
> -		 * prevent using the "all LEDs" channel.
> -		 */
> -		for (i = 0; i < pca->gpio.ngpio; i++)
> -			if (gpiochip_is_requested(&pca->gpio, i)) {
> -				is_gpio = true;
> -				break;
> -			}
> -	} else if (pwm_get_chip_data(pwm)) {
> -		is_gpio = true;
> -	}
> +	return is_inuse;
> +}
>  
> +static void pca9685_pwm_clear_inuse(struct pca9685 *pca, struct pwm_device *pwm)

I think it might be better if you provide __pca9685_pwm_clear_inuse()
that does not take the lock and then pca9685_pwm_clear_inuse() that just
calls the former. Then ->

> +{
> +	mutex_lock(&pca->lock);
> +	if (pwm->hwpwm < PCA9685_MAXCHAN)
> +		clear_bit(pwm->hwpwm, pca->pwms_inuse);
>  	mutex_unlock(&pca->lock);
> -	return is_gpio;
>  }
>  
>  static int pca9685_pwm_gpio_get(struct gpio_chip *gpio, unsigned int offset)
> @@ -170,12 +169,11 @@ static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
>  static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
>  {
>  	struct pca9685 *pca = gpiochip_get_data(gpio);
> -	struct pwm_device *pwm;
>  
> +	mutex_lock(&pca->lock);
>  	pca9685_pwm_gpio_set(gpio, offset, 0);
>  	pm_runtime_put(pca->chip.dev);
> -	mutex_lock(&pca->lock);
> -	pwm = &pca->chip.pwms[offset];
> +	clear_bit(offset, pca->pwms_inuse);

-> you can call

	__pca9685_pwm_clear_inuse()

It feels more "consistent" wrt setting the bit.

>  	mutex_unlock(&pca->lock);
>  }
>  
> @@ -228,12 +226,17 @@ static int pca9685_pwm_gpio_probe(struct pca9685 *pca)
>  	return devm_gpiochip_add_data(dev, &pca->gpio, pca);
>  }
>  #else
> -static inline bool pca9685_pwm_is_gpio(struct pca9685 *pca,
> +static inline bool pca9685_pwm_test_set_inuse(struct pca9685 *pca,
>  				       struct pwm_device *pwm)
>  {
>  	return false;
>  }
>  
> +static inline void
> +pca9685_pwm_clear_inuse(struct pca9685 *pca, struct pwm_device *pwm)
> +{
> +}
> +
>  static inline int pca9685_pwm_gpio_probe(struct pca9685 *pca)
>  {
>  	return 0;
> @@ -417,7 +420,7 @@ static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>  	struct pca9685 *pca = to_pca(chip);
>  
> -	if (pca9685_pwm_is_gpio(pca, pwm))
> +	if (pca9685_pwm_test_set_inuse(pca, pwm))
>  		return -EBUSY;
>  	pm_runtime_get_sync(chip->dev);
>  
> @@ -426,8 +429,11 @@ static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  
>  static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
> +	struct pca9685 *pca = to_pca(chip);
> +
>  	pca9685_pwm_disable(chip, pwm);
>  	pm_runtime_put(chip->dev);
> +	pca9685_pwm_clear_inuse(pca, pwm);
>  }
>  
>  static const struct pwm_ops pca9685_pwm_ops = {
> -- 
> 2.17.1
