From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] pwm: pca9685: fix period change with same duty cycle
Date: Wed, 18 Jan 2017 13:09:48 +0200
Message-ID: <20170118110948.GN2023@lahna.fi.intel.com>
References: <20161213155251.28684-1-clemens.gruber@pqgruber.com>
 <20170118105650.GL18989@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170118105650.GL18989@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Clemens Gruber <clemens.gruber@pqgruber.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stable@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pwm@vger.kernel.org

On Wed, Jan 18, 2017 at 11:56:50AM +0100, Thierry Reding wrote:
> On Tue, Dec 13, 2016 at 04:52:50PM +0100, Clemens Gruber wrote:
> > When first implementing support for changing the output frequency, an
> > optimization was added to continue the PWM after changing the prescaler
> > without having to reprogram the ON and OFF registers for the duty cycle,
> > in case the duty cycle stayed the same.
> > This was flawed, because we compared the absolute value of the duty
> > cycle in nanoseconds instead of the ratio to the period.
> > 
> > Fix the problem by removing the shortcut.
> > 
> > Fixes: 01ec8472009c9 ("pwm-pca9685: Support changing the output frequency")
> > Cc: <stable@vger.kernel.org> # v4.3+
> > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 11 -----------
> >  1 file changed, 11 deletions(-)
> 
> Mika, Andy, can you guys help review this and 2/2?

Looks good to me.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
