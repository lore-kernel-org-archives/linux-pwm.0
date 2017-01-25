From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH 2/2] pwm: pca9685: fix prescaler initialization
Date: Wed, 25 Jan 2017 19:05:10 +0100
Message-ID: <20170125180510.GA9566@archie.localdomain>
References: <20170118105735.GM18989@ulmo.ba.sec>
 <1484737764.2133.193.camel@linux.intel.com>
 <20170118135325.GA2498@archie.localdomain>
 <1484748118.2133.206.camel@linux.intel.com>
 <20170118142533.GA17640@archie.localdomain>
 <1484829279.2133.236.camel@linux.intel.com>
 <20170119144925.GA1660@archie.localdomain>
 <1484842208.2133.245.camel@linux.intel.com>
 <20170119165210.GA2139@archie.localdomain>
 <20170120063907.GA4894@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170120063907.GA4894@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pwm@vger.kernel.org

On Fri, Jan 20, 2017 at 07:39:07AM +0100, Thierry Reding wrote:
> On Thu, Jan 19, 2017 at 05:52:10PM +0100, Clemens Gruber wrote:
> > Let's go with this one. I'll spin up a v2 where I calculate the
> > period_ns value from the current prescaler value in the probe function.
> 
> This effectively ends up duplicating much of what the atomic API is
> supposed to be doing.
> 
> So generally before the atomic API there is no way for the PWM driver
> (and consequently the PWM users) to know what the current setting is.
> That implies that we either can't care about the settings that were
> programmed by some bootloader or that we force the PWM to a setting
> on ->probe().
> 
> The result is inconsistent behaviour across drivers, and that's just
> fine for many cases. But for some cases it is really not something that
> we can work with.
> 
> So perhaps another possibility would be for this driver to implement the
> atomic API. This should give you the necessary infrastructure to do
> exactly what you want.

Sounds good. I'll work on that.

One oddity remains though:
The chip has one prescaler, so changing the period of one channel
changes the period of all other channels as well.
If somebody configures different periods for each channel, the last one
wins, but the PWM core still stores the period values the user set
initially. Should we update the period in pwm_state of all pwms in the
chip if the period of one pwm is changed?
Then, when the user calls pwm_get_state, the pwm_state would contain the
correct period?

Thanks,
Clemens
