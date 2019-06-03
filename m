From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH -next] pwm: pca9685: Remove set but not used variable
 'pwm'
Date: Mon, 3 Jun 2019 18:58:58 +0300
Message-ID: <20190603155858.GF2781@lahna.fi.intel.com>
References: <20190601035709.85379-1-yuehaibing@huawei.com>
 <CAGngYiXZM0QUdKE_zDK763J9iDuiKSbmFeTVA1PJ_4WvjntjQQ@mail.gmail.com>
 <20190601160459.baedo5pp5hsrltzs@pengutronix.de>
 <CAGngYiUfGGF+PwaT4SE2ZJkrCidc7-QWeuRsPTDwrLL1onm88w@mail.gmail.com>
 <20190603114029.GC2781@lahna.fi.intel.com>
 <CAGngYiVDCCjo6VKt660Uz5mbEGOBOZpcUWeRHWx_L=TapZgv_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGngYiVDCCjo6VKt660Uz5mbEGOBOZpcUWeRHWx_L=TapZgv_w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, YueHaibing <yuehaibing@huawei.com>, Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, Jun 03, 2019 at 11:08:06AM -0400, Sven Van Asbroeck wrote:
> On Mon, Jun 3, 2019 at 7:40 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > I think you are right. pca9685_pwm_request() should take the mutex as
> > long as it is requesting PWM.
> 
> Yes, but things get hairy because pca9685_pwm_request() will have to
> give up the mutex when it returns. I cannot see a way to keep holding
> this mutex while the in-use flag is set by the pwm core ?

Right, I did not notice it's the PWM core that sets the flag.

> Alternatively, we could set (void *)1 pwm_data inside the pwm_request,
> wrapped inside the mutex.
> But then things get 'messy'.
> 
> > A flag would probably be easier to understand than the magic we have
> > now.
> 
> I have the feeling that a flag (plus a mutex) would be the clearest and
> safest way forward. I'll post a patch soon, you guys tell me what you
> think.

Sounds good thanks!
