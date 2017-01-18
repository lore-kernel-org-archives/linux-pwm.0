From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH 2/2] pwm: pca9685: fix prescaler initialization
Date: Wed, 18 Jan 2017 14:53:25 +0100
Message-ID: <20170118135325.GA2498@archie.localdomain>
References: <20161213155251.28684-1-clemens.gruber@pqgruber.com>
 <20161213155251.28684-2-clemens.gruber@pqgruber.com>
 <20170118105735.GM18989@ulmo.ba.sec>
 <1484737764.2133.193.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484737764.2133.193.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stable@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pwm@vger.kernel.org

On Wed, Jan 18, 2017 at 01:09:24PM +0200, Andy Shevchenko wrote:
> On Wed, 2017-01-18 at 11:57 +0100, Thierry Reding wrote:
> > On Tue, Dec 13, 2016 at 04:52:51PM +0100, Clemens Gruber wrote:
> > > Until now, we assumed that the period is the hardware default of
> > > 1/200Hz
> > > at probe time, but if the period was changed and the user reboots,
> > > this
> > > assumption is wrong.
> > > 
> > > Solution: Check if the prescaler is set to the hardware default. If
> > > not,
> > > reprogram the prescaler at first configuration.
> 
> AFAIU the PWM is off until user space or kernel user enables it
> explicitly after reboot. Is it correct?

Yes, but the period could be different, maybe modified in the bootloader
or at a previous boot without hardware reset in between. (We do not send
a SWRST to the chip, so the period register could be different)

Until now, we assumed it is always 1/200 Hz and skipped the lengthy
prescale configuration (put chip into sleep mode, set prescaler, go out
of sleep mode, udelay for 0.5ms until the oscillator is back up) if the
user wants a period of 1/200 Hz.

With this patch, we check if it is in fact set to the hardware default.
If not, we set pca->period_ns to 0 which leads to changing the prescaler
in the next call to pca9685_pwm_config.

Thanks,
Clemens
