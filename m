From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] pwm: pca9685: fix prescaler initialization
Date: Fri, 20 Jan 2017 11:58:18 +0200
Message-ID: <1484906298.2133.264.camel@linux.intel.com>
References: <20161213155251.28684-2-clemens.gruber@pqgruber.com>
         <20170118105735.GM18989@ulmo.ba.sec>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170120063907.GA4894@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pwm@vger.kernel.org

On Fri, 2017-01-20 at 07:39 +0100, Thierry Reding wrote:
> On Thu, Jan 19, 2017 at 05:52:10PM +0100, Clemens Gruber wrote:
> > On Thu, Jan 19, 2017 at 06:10:08PM +0200, Andy Shevchenko wrote:
> > > Combining with your proposal I would see the best approach is to
> > > set
> > > pca->period_ns accordingly to current prescaler value if you want
> > > to.

> > I'll send v2 of patch 2/2 with aforementioned changes in the next
> > days.
> 
> Like I said above, I think atomic API conversion wouldn't be very
> difficult for this driver and it has the added advantage of giving you
> the proper infrastructure to do this rather than having to duplicate
> it in the driver.
> 
> That would be my preference, but I'm willing to take v2 of 2/2 as well
> if it ends up being really nice and compact. =)

I think we may split to this fix and separate change to move to atomic
API. Does it sound reasonable?

P.S. <offtopic>Can you comment further pwm-lpss changes Mika and I
did?</offtopic>

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
