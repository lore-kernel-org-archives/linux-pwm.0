From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH -next] pwm: pca9685: Remove set but not used variable
 'pwm'
Date: Mon, 3 Jun 2019 14:40:29 +0300
Message-ID: <20190603114029.GC2781@lahna.fi.intel.com>
References: <20190601035709.85379-1-yuehaibing@huawei.com>
 <CAGngYiXZM0QUdKE_zDK763J9iDuiKSbmFeTVA1PJ_4WvjntjQQ@mail.gmail.com>
 <20190601160459.baedo5pp5hsrltzs@pengutronix.de>
 <CAGngYiUfGGF+PwaT4SE2ZJkrCidc7-QWeuRsPTDwrLL1onm88w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGngYiUfGGF+PwaT4SE2ZJkrCidc7-QWeuRsPTDwrLL1onm88w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, YueHaibing <yuehaibing@huawei.com>, Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Sun, Jun 02, 2019 at 10:18:15AM -0400, Sven Van Asbroeck wrote:
> On Sat, Jun 1, 2019 at 12:05 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > I didn't look into the driver to try to understand that, but the
> > definitely needs a comment to explain for the next person to think they
> > can do a cleanup here.
> 
> Certainly.

I agree.

> But if we do restore the old behaviour, there may still be problems.
> I'm unsure if the old synchronization was working correctly.
> See the example at the end of this email.

I think you are right. pca9685_pwm_request() should take the mutex as
long as it is requesting PWM.

> An intuitive way forward would be to use a simple bitfield in
> struct pca9685 to track if a specific pwm is in use by either
> pwm or gpio. Protected by a mutex.

A flag would probably be easier to understand than the magic we have
now. Or then wrap it inside function with an explanation comment:

static inline void pca9685_pwm_set_as_gpio(struct pwm_device *pwm)
{
	/*
	 * We use ->chip_data to convoy the fact that the PWM channel is
	 * being used as GPIO instead of PWM.
	 */
	pwm_set_chip_data(pwm, (void *)1)
}

static inline void pca9685_pwm_set_as_pwm(struct pwm_device *pwm)
{
	pwm_set_chip_data(pwm, NULL);
}
