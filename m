From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH -next] pwm: pca9685: Remove set but not used variable 'pwm'
Date: Sat, 1 Jun 2019 09:03:09 -0400
Message-ID: <CAGngYiXZM0QUdKE_zDK763J9iDuiKSbmFeTVA1PJ_4WvjntjQQ@mail.gmail.com>
References: <20190601035709.85379-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190601035709.85379-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, u.kleine-koenig@pengutronix.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi YueHaibing,

On Fri, May 31, 2019 at 11:49 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
>         mutex_lock(&pca->lock);
> -       pwm = &pca->chip.pwms[offset];
>         mutex_unlock(&pca->lock);

Thanks for noticing this issue. However it should be fixed differently.

This was introduced by Uwe's clean-up patch:
commit e926b12c611c2095c79 ("pwm: Clear chip_data in pwm_put()")

But Uwe did not realize that in this case, the pwm chip_data is used as a
synchronization mechanism between pwm and gpio. Moving the chip_data
clear out of the mutex breaks this mechanism.

I think the following would restore the mechanism:

>         mutex_lock(&pca->lock);
>        pwm = &pca->chip.pwms[offset];
> +     pwm_set_chip_data(pwm, NULL);
>         mutex_unlock(&pca->lock);

This would of course clear the pwm chip_data twice, once in the driver and
once in the core, but that's not a problem.

I'd like to hear Mika Westerberg's opinion, because he introduced this
synchronization mechanism back in 2016.

[Adding Mika]

Sven
