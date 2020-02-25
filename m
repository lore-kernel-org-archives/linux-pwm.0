From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/4] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Date: Tue, 25 Feb 2020 09:38:46 +0100
Message-ID: <20200225083846.4l4tnbjcpm6uggtl@pengutronix.de>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
 <20200224052135.17278-4-lokeshvutla@ti.com>
 <20200224085531.zab5ewr2nfi2shem@pengutronix.de>
 <4aedb6d4-1823-ab46-b7e6-cc0b30f7747d@ti.com>
 <20200225064833.kmvaplfqqf53s3iy@pengutronix.de>
 <8e22912c-a65f-9efe-27e7-555cd144776f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8e22912c-a65f-9efe-27e7-555cd144776f@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

Hello Lokesh,

On Tue, Feb 25, 2020 at 01:29:57PM +0530, Lokesh Vutla wrote:
> On 25/02/20 12:18 PM, Uwe Kleine-König wrote:
> > On Tue, Feb 25, 2020 at 10:32:42AM +0530, Lokesh Vutla wrote:
> >> On 24/02/20 2:25 PM, Uwe Kleine-König wrote:
> >>> On Mon, Feb 24, 2020 at 10:51:34AM +0530, Lokesh Vutla wrote:
> >>>>  	omap->pdata->set_load(omap->dm_timer, true, load_value);
> >>>>  	omap->pdata->set_match(omap->dm_timer, true, match_value);
> >>>
> >>> (Without having looked into the depths of the driver I assume
> >>> .set_load() sets the period of the PWM and .set_match() the duty cycle.)
> >>
> >> Right.
> >>
> >>>
> >>> What happens on a running PWM if you change the period? Consider you
> >>> change from duty_cycle = 1000, period = 5000 to duty_cycle = 4000,
> >>> period = 10000. As you set the period first, can it happen the hardware
> >>> produces a cycle with duty_cycle = 1000, period = 10000?
> >>
> >> No. So, the current cycle is un affected with duty_cycle = 1000 and period =
> >> 5000. Starting from next cycle new settings gets reflected with duty_cycle =
> >> 4000 and period = 10000.
> > 
> > Is the reference manual for this hardware publically available?
> 
> AM335x TRM [0] Section 20.1.3.5 Pulse-Width Modulation (Page 4445).
> 
> [0] http://www.ti.com/lit/ug/spruh73q/spruh73q.pdf

Great. This is BTW an opportunity to increase your patch count: Create a
patch that adds a reference to this document at the top of the driver.

> > So the .set_load callback just writes a shadow register and .set_match
> > latches it into hardware atomically with its own register changes? A
> > comment in the source code about this would be good. Also if .set_load
> > doesn't work without .set_match I wonder if it is sane to put their
> > logic in two different functions.
> 
> Just to give a little bit of background:

Thanks, very appreciated.

> - The omap timer is an upward counter that can be started and stopped at any time.
> - Once the timer counter overflows, it gets loaded with a predefined load
> value.(Or can be configured to not re load at all).
> - Timer has a configurable output pin which can be toggled in the following two
> cases:
> 	- When the counter overflows
> 	- When the counter matches with a predefined register(match register).
> 
> Using this o/p pin the driver tries to generate a PWM with period = (OVERFLOW -
> LOAD_VALUE) and duty_cycle = (MATCH_VALUE - LOAD_VALUE).
> 
> .set_load will configure the load value .set_match will configure the match
> value. The configured values gets effected only in the next cycle of PWM.

Ah, so back to my original question: If you change from
duty_cycle/period = 1000/5000 to duty_cycle/period = 4000/10000 and
after you set the period but before you set the duty_cycle a period
happens to end, you get indeed a cycle with mixed settings, right?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
