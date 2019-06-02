From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH -next] pwm: pca9685: Remove set but not used variable 'pwm'
Date: Sun, 2 Jun 2019 10:18:15 -0400
Message-ID: <CAGngYiUfGGF+PwaT4SE2ZJkrCidc7-QWeuRsPTDwrLL1onm88w@mail.gmail.com>
References: <20190601035709.85379-1-yuehaibing@huawei.com> <CAGngYiXZM0QUdKE_zDK763J9iDuiKSbmFeTVA1PJ_4WvjntjQQ@mail.gmail.com>
 <20190601160459.baedo5pp5hsrltzs@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190601160459.baedo5pp5hsrltzs@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: YueHaibing <yuehaibing@huawei.com>, Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Sat, Jun 1, 2019 at 12:05 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> I didn't look into the driver to try to understand that, but the
> definitely needs a comment to explain for the next person to think they
> can do a cleanup here.

Certainly.

But if we do restore the old behaviour, there may still be problems.
I'm unsure if the old synchronization was working correctly.
See the example at the end of this email.

An intuitive way forward would be to use a simple bitfield in
struct pca9685 to track if a specific pwm is in use by either
pwm or gpio. Protected by a mutex.

But it could be that the old behaviour is 'good enough' for
the driver's users (I am no longer one of them).

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Let's take the example of two threads, racing to grab a pwm and gpio,
respectively. Assume the gpio is backed by the pwm, so they conflict.

[Thread 1]
drivers/pwm/core.c:

    if (pwm->chip->ops->request) {
        err =3D pwm->chip->ops->request(pwm->chip, pwm);
            [this calls pca9685_pwm_request()]
            [which calls pca9685_pwm_is_gpio()]
            [checks pwm chip_data, is NULL, pwm is free]
            [returns 0 - pwm request ok]
        if (err) {
            module_put(pwm->chip->ops->owner);
            return err;
        }
    }

        [CONTEXT SWITCH to Thread 2]
        static int pca9685_pwm_gpio_request(struct gpio_chip *gpio,
unsigned int offset)
        {
            struct pca9685 *pca =3D gpiochip_get_data(gpio);
            struct pwm_device *pwm;

            mutex_lock(&pca->lock);

            pwm =3D &pca->chip.pwms[offset];

            [pwm->flags do not (yet) have PWMF_REQUESTED]
            if (pwm->flags & (PWMF_REQUESTED | PWMF_EXPORTED)) {
                mutex_unlock(&pca->lock);
                return -EBUSY;
            }

            pwm_set_chip_data(pwm, (void *)1);

            mutex_unlock(&pca->lock);
            pm_runtime_get_sync(pca->chip.dev);
            return 0;
        }

[CONTEXT SWITCH back to Thread 1, still in pwm/core.c]

    set_bit(PWMF_REQUESTED, &pwm->flags);
    pwm->label =3D label;
