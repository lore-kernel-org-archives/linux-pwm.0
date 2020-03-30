From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Date: Mon, 30 Mar 2020 21:16:54 +0200
Message-ID: <20200330191654.waoocllctanh5nk5@pengutronix.de>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <20200330141436.GG2431644@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200330141436.GG2431644@ulmo>
Sender: linux-omap-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
List-Id: linux-pwm@vger.kernel.org

Hello Thierry,

On Mon, Mar 30, 2020 at 04:14:36PM +0200, Thierry Reding wrote:
> On Thu, Mar 12, 2020 at 07:40:42AM +0100, Uwe Kleine-König wrote:
> > On Thu, Mar 12, 2020 at 09:52:09AM +0530, Lokesh Vutla wrote:
> > > Only the Timer control register(TCLR) cannot be updated when the timer
> > > is running. Registers like Counter register(TCRR), loader register(TLDR),
> > > match register(TMAR) can be updated when the counter is running. Since
> > > TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
> > > timer for period/duty_cycle update.
> > 
> > I'm not sure what is sensible here. Stopping the PWM for a short period
> > is bad, but maybe emitting a wrong period isn't better. You can however
> > optimise it if only one of period or duty_cycle changes.
> > 
> > @Thierry, what is your position here? I tend to say a short stop is
> > preferable.
> 
> It's not clear to me from the above description how exactly the device
> behaves, but I suspect that it may latch the values in those registers
> and only update the actual signal output once a period has finished. I
> know of a couple of other devices that do that, so it wouldn't be
> surprising.
> 
> Even if that was not the case, I think this is just the kind of thing
> that we have to live with. Sometimes it just isn't possible to have all
> supported devices adhere strictly to an API. So I think the best we can
> do is have an API that loosely defines what's supposed to happen and
> make a best effort to implement those semantics. If a device deviates
> slightly from those expectations, we can always cross fingers and hope
> that things still work. And it looks like they are.
> 
> So I think if Lokesh and Tony agree that this is the right thing to do
> and have verified that things still work after this, that's about as
> good as it's going to get.

I'd say this isn't for the platform people to decide. My position here
is that the PWM drivers should behave as uniform as possible to minimize
surprises for consumers. And so it's a "PWM decision" that is to be made
here, not an "omap decision".

> I know this is perhaps cheating a little, or turning a blind eye, but I
> don't know what the alternative would be. Do we want to tell people that
> a given PWM controller can't be used if it doesn't work according to our
> expectations? That's hard to argue if that controller works just fine
> for all known use-cases.

I'd like have some official policy here which of the alternatives is the
preferred cheat.

The situation here is that period and duty_cycle cannot be updated
atomically. So the two options are:

 - stop shortly
 - update with hardware running and maybe emit a broken period

I tend to say "stop shortly" is the better alternative.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
