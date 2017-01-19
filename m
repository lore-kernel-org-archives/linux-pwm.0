From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH 2/2] pwm: pca9685: fix prescaler initialization
Date: Thu, 19 Jan 2017 17:52:10 +0100
Message-ID: <20170119165210.GA2139@archie.localdomain>
References: <20161213155251.28684-1-clemens.gruber@pqgruber.com>
 <20161213155251.28684-2-clemens.gruber@pqgruber.com>
 <20170118105735.GM18989@ulmo.ba.sec>
 <1484737764.2133.193.camel@linux.intel.com>
 <20170118135325.GA2498@archie.localdomain>
 <1484748118.2133.206.camel@linux.intel.com>
 <20170118142533.GA17640@archie.localdomain>
 <1484829279.2133.236.camel@linux.intel.com>
 <20170119144925.GA1660@archie.localdomain>
 <1484842208.2133.245.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484842208.2133.245.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, Jan 19, 2017 at 06:10:08PM +0200, Andy Shevchenko wrote:
> Combining with your proposal I would see the best approach is to set
> pca->period_ns accordingly to current prescaler value if you want to.

Yes, I agree.

> In your patch I see no benefit, since it's quite unlikely user will want
> to have 5ms period among all possibilities.

It is the hardware default, but you are right, the user probably does
not care about that.

> So, summarize, I prefer (in order of preference from high to low):
> - enforce default prescaler value based on default period (it's just one
> line to write a register)
> - calculate default period based on actual prescaler value

Let's go with this one. I'll spin up a v2 where I calculate the
period_ns value from the current prescaler value in the probe function.

--

Thierry: I think you could merge v1 of patch 1/2 from my series
independently.

I'll send v2 of patch 2/2 with aforementioned changes in the next days.

Thanks,
Clemens
