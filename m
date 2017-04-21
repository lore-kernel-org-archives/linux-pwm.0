From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1] pwm: pca9685: clarify pca9685_set_sleep_mode() interface.
Date: Fri, 21 Apr 2017 17:48:38 +0300
Message-ID: <CAHp75Ver25fUpgkFQZMiy_cU12Fm=-_XZ_VNu-bJ8U3AvgiCuQ@mail.gmail.com>
References: <1492780742-11251-1-git-send-email-thesven73@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1492780742-11251-1-git-send-email-thesven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pwm@vger.kernel.org

On Fri, Apr 21, 2017 at 4:19 PM, Sven Van Asbroeck <thesven73@gmail.com> wrote:
> The function
> static void pca9685_set_sleep_mode(struct pca9685 *pca, int sleep)
> takes the chip in and out of sleep mode, depending on the value of
> sleep, which is interpreted as a boolean.
>
> To clarify that 'int sleep' is a boolean and not a sleep delay,
> change the function interface to:
> static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
>

Yes, that's indeed more understandable, thanks.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 5f55cfa..a7eaf962 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -241,11 +241,11 @@ static inline int pca9685_pwm_gpio_probe(struct pca9685 *pca)
>  }
>  #endif
>
> -static void pca9685_set_sleep_mode(struct pca9685 *pca, int sleep)
> +static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
>  {
>         regmap_update_bits(pca->regmap, PCA9685_MODE1,
> -                          MODE1_SLEEP, sleep ? MODE1_SLEEP : 0);
> -       if (!sleep) {
> +                          MODE1_SLEEP, enable ? MODE1_SLEEP : 0);
> +       if (!enable) {
>                 /* Wait 500us for the oscillator to be back up */
>                 udelay(500);
>         }
> @@ -272,13 +272,13 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>                          * state is guaranteed active here.
>                          */
>                         /* Put chip into sleep mode */
> -                       pca9685_set_sleep_mode(pca, 1);
> +                       pca9685_set_sleep_mode(pca, true);
>
>                         /* Change the chip-wide output frequency */
>                         regmap_write(pca->regmap, PCA9685_PRESCALE, prescale);
>
>                         /* Wake the chip up */
> -                       pca9685_set_sleep_mode(pca, 0);
> +                       pca9685_set_sleep_mode(pca, false);
>
>                         pca->period_ns = period_ns;
>                 } else {
> @@ -534,7 +534,7 @@ static int pca9685_pwm_runtime_suspend(struct device *dev)
>         struct i2c_client *client = to_i2c_client(dev);
>         struct pca9685 *pca = i2c_get_clientdata(client);
>
> -       pca9685_set_sleep_mode(pca, 1);
> +       pca9685_set_sleep_mode(pca, true);
>         return 0;
>  }
>
> @@ -543,7 +543,7 @@ static int pca9685_pwm_runtime_resume(struct device *dev)
>         struct i2c_client *client = to_i2c_client(dev);
>         struct pca9685 *pca = i2c_get_clientdata(client);
>
> -       pca9685_set_sleep_mode(pca, 0);
> +       pca9685_set_sleep_mode(pca, false);
>         return 0;
>  }
>  #endif
> --
> 1.9.1
>



-- 
With Best Regards,
Andy Shevchenko
