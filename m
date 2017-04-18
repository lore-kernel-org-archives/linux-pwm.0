From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 1/1] pwm: pca9685: fix gpio-only operation.
Date: Tue, 18 Apr 2017 12:14:12 +0300
Message-ID: <1492506852.24567.54.camel@linux.intel.com>
References: <1492088291-5215-1-git-send-email-svenv@arcx.com>
         <1492088291-5215-2-git-send-email-svenv@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1492088291-5215-2-git-send-email-svenv@arcx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>, thierry.reding@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, clemens.gruber@pqgruber.com, mika.westerberg@linux.intel.com, Sven Van Asbroeck <TheSven73@googlemail.com>
List-Id: linux-pwm@vger.kernel.org


+Cc: Rafael (one question to you below)

On Thu, 2017-04-13 at 08:58 -0400, Sven Van Asbroeck wrote:
> gpio-only driver operation never clears the SLEEP bit, which can
> cause the gpios to become unusable.
> 
> Example:
> 1. user requests first pwm  ->      driver clears SLEEP bit
> 2. user frees last pwm      ->      driver sets SLEEP bit
> 3. user requests gpio
> 4. user switches gpio on    ->      output does not turn on
>                                     because SLEEP bit is set
> 
> Prevent this behaviour by letting the runtime_pm framework
> control the SLEEP bit. This will put the chip to SLEEP if
> no pwms/gpios are exported/in use.
> 

I know the patch is applied already, though please consider below to be
addressed as usual (w/o Fixes tag).

> +static void pca9685_set_sleep_mode(struct pca9685 *pca, int sleep)
> +{
> +	regmap_update_bits(pca->regmap, PCA9685_MODE1,
> +			   MODE1_SLEEP, sleep ? MODE1_SLEEP : 0);

> +	if (!sleep) {
> +		/* Wait 500us for the oscillator to be back up */
> +		udelay(500);
> +	}

I would go with

/* Wait for @sleep microseconds for the oscillator to be back up */
if (sleep)
 udelay(sleep);

Otherwise int sleep is oddly here.

Or

bool sleep

/* Wait 500us ... */
if (sleep)
 udelay(500);

> +}


> +#ifdef CONFIG_PM
> +static int pca9685_pwm_runtime_suspend(struct device *dev)

__maybe_unused and remove ugly #ifdef:ery.

> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct pca9685 *pca = i2c_get_clientdata(client);
> +
> +	pca9685_set_sleep_mode(pca, 1);
> +	return 0;
>  }
>  
> +static int pca9685_pwm_runtime_resume(struct device *dev)

Ditto.

> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct pca9685 *pca = i2c_get_clientdata(client);
> +
> +	pca9685_set_sleep_mode(pca, 0);
> +	return 0;
> +}
> +#endif

> +static const struct dev_pm_ops pca9685_pwm_pm = {
> +	SET_RUNTIME_PM_OPS(pca9685_pwm_runtime_suspend,
> +			   pca9685_pwm_runtime_resume, NULL)
> +};
> +

Perhaps we may introduce RUNTIME_DEV_PM_OPS() macro and re-use it here.
Rafael?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
