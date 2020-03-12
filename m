From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Date: Thu, 12 Mar 2020 09:47:39 +0100
Message-ID: <20200312084739.isixgdo3txr6rjzg@pengutronix.de>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <f250549f-1e7c-06d6-b2a4-7ae01c06725b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f250549f-1e7c-06d6-b2a4-7ae01c06725b@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On Thu, Mar 12, 2020 at 01:35:32PM +0530, Lokesh Vutla wrote:
> On 12/03/20 12:10 PM, Uwe Kleine-König wrote:
> > On Thu, Mar 12, 2020 at 09:52:09AM +0530, Lokesh Vutla wrote:
> >> Only the Timer control register(TCLR) cannot be updated when the timer
> >> is running. Registers like Counter register(TCRR), loader register(TLDR),
> >> match register(TMAR) can be updated when the counter is running. Since
> >> TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
> >> timer for period/duty_cycle update.
> > 
> > I'm not sure what is sensible here. Stopping the PWM for a short period
> > is bad, but maybe emitting a wrong period isn't better. You can however
> > optimise it if only one of period or duty_cycle changes.
> > 
> > @Thierry, what is your position here? I tend to say a short stop is
> > preferable.
> 
> Short stop has side effects especially in the case where 1PPS is generated using
> this PWM. In this case where PWM period is continuously synced with PTP clock,
> cannot expect any breaks in PWM. This doesn't fall in the above limitations as
> well. as duty_cycle is not a worry and only the rising edge is all that matters.
> 
> Also any specific reason why you wanted to stop rather than having the mentioned
> limitation? it is just a corner anyway and doesn't happen all the time.

I'm a bit torn here. Which of the two steps out of line is worse depends
on what is driven by the PWM in question. And also I think ignoring
"just corner cases" is a reliable way into trouble.

The usual PWM contributer (understandably) cares mostly about their own
problem they have to solve. If however you take a step back and care
about the PWM framework as a whole to be capable to solve problems in
general, such that any consumer just has to know that there is a PWM and
start requesting specific settings for their work to get done, it gets
obvious that you want some kind of uniform behaviour of each hardware
driver. And then a short inactive break between two periods is more
common and better understandable than a mixed period.

Also being a corner case that only happens (say) once in 100000 cases
isn't a clear upside. This just results in a machine leaving the development
department, passing the production test and then behave unexpected once
per year in the field.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
