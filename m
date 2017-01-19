From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] pwm: pca9685: fix prescaler initialization
Date: Thu, 19 Jan 2017 18:10:08 +0200
Message-ID: <1484842208.2133.245.camel@linux.intel.com>
References: <20161213155251.28684-1-clemens.gruber@pqgruber.com>
         <20161213155251.28684-2-clemens.gruber@pqgruber.com>
         <20170118105735.GM18989@ulmo.ba.sec>
         <1484737764.2133.193.camel@linux.intel.com>
         <20170118135325.GA2498@archie.localdomain>
         <1484748118.2133.206.camel@linux.intel.com>
         <20170118142533.GA17640@archie.localdomain>
         <1484829279.2133.236.camel@linux.intel.com>
         <20170119144925.GA1660@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170119144925.GA1660@archie.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, 2017-01-19 at 15:49 +0100, Clemens Gruber wrote:
> On Thu, Jan 19, 2017 at 02:34:39PM +0200, Andy Shevchenko wrote:
> > On Wed, 2017-01-18 at 15:25 +0100, Clemens Gruber wrote:
> > > Yes, that's what this patch tries to solve by verifying that the
> > > external setting (the prescale register) is set to its hardware
> > > default
> > > value of 0x1E (corresponding to a period of 1/200 Hz).
> > > If it is not 0x1E, the driver will reconfigure the prescaler
> > > according
> > > to the desired period at the time of the next configuration.
> > 
> > Yes, and my question is what is possible go wrong if you just
> > enforce
> > prescaler to be 1/200Hz?
> 
> If we enforce a default of 1 / 200 Hz, we have to go through the SLEEP
> mode and udelay for 0.5ms once for our default and then again for the
> user, if he does not want a period of 1 / 200 Hz.
> -> Number of prescaler changes: 1 or 2
> 
> I think it is better as it is now + my patch applied: We verify if the
> prescaler is already set to 1 / 200 Hz.
> Then, as soon as the user configures his PWM channels, we either do
> not
> have to change the prescaler at all (if he wants 1 / 200 Hz) or do it
> once at the time of configuration.
> -> Number of prescaler changes: 0 or 1
> 
> What's the advantage of enforcing the prescaler to 1 / 200 Hz in the
> probe function when we do not know yet if 1 / 200 Hz is the period the
> user is going to configure?

Advantage of this proposal is to get to known state.
Combining with your proposal I would see the best approach is to set
pca->period_ns accordingly to current prescaler value if you want to.

In your patch I see no benefit, since it's quite unlikely user will want
to have 5ms period among all possibilities.

The 500us delay at the _first_ configuration is not a big deal.

So, summarize, I prefer (in order of preference from high to low):
- enforce default prescaler value based on default period (it's just one
line to write a register)
- calculate default period based on actual prescaler value
- your or similar solution

If you still disagree with that, I rest my case.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
