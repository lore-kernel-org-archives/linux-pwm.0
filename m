From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/7] pwm: jz4740: Improve algorithm of clock calculation
Date: Wed, 14 Aug 2019 19:32:18 +0200
Message-ID: <20190814173218.zhg4se3pppano5m3@pengutronix.de>
References: <20190812061520.lwzk3us4ginwwxov@pengutronix.de>
 <1565642590.2007.1@crapouillou.net>
 <20190812214838.e5hyhnlcyykjfvsb@pengutronix.de>
 <1565648183.2007.3@crapouillou.net>
 <20190813052726.g37upws5rlvrszc4@pengutronix.de>
 <1565694066.1856.1@crapouillou.net>
 <20190813123331.m4ttfhcgt6wyrcfi@pengutronix.de>
 <1565700448.1856.2@crapouillou.net>
 <20190813140903.rdwy7p3mhwetmlnt@pengutronix.de>
 <1565799035.1984.0@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565799035.1984.0@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Stephen Boyd <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Mathieu Malaterre <malat@debian.org>, Artur Rojek <contact@artur-rojek.eu>
List-Id: linux-pwm@vger.kernel.org

Hello Paul,

On Wed, Aug 14, 2019 at 06:10:35PM +0200, Paul Cercueil wrote:
> Le mar. 13 août 2019 à 16:09, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= a écrit :
> > On Tue, Aug 13, 2019 at 02:47:28PM +0200, Paul Cercueil wrote:
> > > Le mar. 13 août 2019 à 14:33, Uwe Kleine-König a écrit :
> > > > On Tue, Aug 13, 2019 at 01:01:06PM +0200, Paul Cercueil wrote:
> > > > > Well, you said that I shouln't rely on the fact that clk_round_rate() will
> > > > > round down. That completely defeats the previous algorithm. So please tell
> > > > > me how to use it correctly, because I don't see it.
> > > >
> > > > Using clk_round_rate correctly without additional knowledge is hard. If
> > > > you assume at least some sane behaviour you'd still have to call it
> > > > multiple times. Assuming maxrate is the maximal rate you can handle
> > > > without overflowing your PWM registers you have to do:
> > > >
> > > > 	rate = maxrate;
> > > > 	rounded_rate = clk_round_rate(clk, rate);
> > > > 	while (rounded_rate > rate) {
> > > > 		if (rate < rounded_rate - rate) {
> > > > 			/*
> > > > 			 * clk doesn't support a rate smaller than
> > > > 			 * maxrate (or the round_rate callback doesn't
> > > > 			 * round consistently).
> > > > 			 */
> > > > 			 return -ESOMETHING;
> > > > 		}
> > > > 		rate = rate - (rounded_rate - rate)
> > > > 		rounded_rate = clk_round_rate(clk, rate);
> > > > 	}
> > > >
> > > > 	return rate;
> > > >
> > > > Probably it would be sensible to put that in a function provided by the
> > > > clk framework (maybe call it clk_round_rate_down and maybe with
> > > > additional checks).
> > > 
> > >  clk_round_rate_down() has been refused multiple times in the past for
> > >  reasons that Stephen can explain.
> > 
> > I'd be really interested in these reasons as I think the clk framework
> > should make it easy to solve common tasks related to clocks. And finding
> > out the biggest supported rate not bigger than a given maxrate is
> > something I consider such a common task.
> > 
> > The first hit I found when searching was
> > https://lkml.org/lkml/2010/7/14/260 . In there Stephen suggested that
> > clk_round_rate with the current semantic is hardly useful and suggested
> > clk_round_rate_up() and clk_round_rate_down() himself.
> 
> That's from 2010, though.

If you have a better link please tell me.

> I agree that clk_round_rate_up() and clk_round_rate_down() should exist.
> Even if they return -ENOSYS if it's not implemented for a given clock
> controller.

ack.

> > > > > I came up with a much smarter alternative, that doesn't rely on the rounding
> > > > > method of clk_round_rate, and which is better overall (no loop needed). It
> > > > > sounds to me like you're bashing the code without making the effort to
> > > > > understand what it does.
> > > > >
> > > > > Thierry called it a "neat trick"
> > > > > (https://patchwork.kernel.org/patch/10836879/) so it cannot be as bad as you
> > > > > say.
> > > >
> > > > Either that or Thierry failed to see the downside. The obvious downside
> > > > is that once you set the period to something long (and so the clk was
> > > > limited to a small frequency) you never make the clock any faster
> > > > afterwards.
> > >
> > >  Read the algorithm again.
> > 
> > I indeed missed a call to clk_set_rate(clk, parent_rate). I thought I
> > grepped for clk_set_rate before claiming the code was broken. Sorry.
> > 
> > So I think the code works indeed, but it feels like abusing
> > clk_set_max_rate. So I'd like to see some words from Stephen about this
> > procedure.
> > 
> > Also I think this is kind of inelegant to set the maximal rate twice. At
> > least call clk_set_max_rate only once please.
> 
> Ok. I can do that.

I would still prefer to hear from Stephen about this approach. It seems
wrong to have two different ways to achieve the same goal and my
impression is that clk_round_rate is the function designed for this use
case.
 
> > > > > > > > > E.g. if at a rate of 12 MHz your computed hardware value for the period
> > > > > > > > > is 0xf000, then at a rate of 24 MHz it won't fit in 16 bits. So the clock
> > > > > > > > > rate must be reduced to the highest possible that will still give you a
> > > > > > > > > < 16-bit value.
> > > > > > > > >
> > > > > > > > > We always want the highest possible clock rate that works, for the sake of
> > > > > > > > > precision.
> > > > > > > >
> > > > > > > > This is dubious; but ok to keep the driver simple.> (Consider a PWM that
> > > > > > > > can run at i MHz for i in [1, .. 30]. If a period of 120 ns and a duty
> > > > > > > > cycle of 40 ns is requested you can get an exact match with 25 MHz, but
> > > > > > > > not with 30 MHz.)
> > > > > > >
> > > > > > > The clock rate is actually (parent_rate >> (2 * x) )
> > > > > > > for x = 0, 1, 2, ...
> > > > > > >
> > > > > > > So if your parent_rate is 30 MHz the next valid one is 7.5 MHz, and the
> > > > > > > next one is 1.875 MHz. It'd be very unlikely that you get a better match at
> > > > > > > a lower clock.
> > > > > >
> > > > > > If the smaller freqs are all dividers of the fastest that's fine. Please
> > > > > > note in a code comment that you're assuming this.
> > > > >
> > > > >  No, I am not assuming this. The current driver just picks the highest clock
> > > > >  rate that works. We're not changing the behaviour here.
> > > >
> > > > But you hide it behind clk API functions that don't guarantee this
> > > > behaviour. And even if it works for you it might not for the next person
> > > > who copies your code to support another hardware.
> > > 
> > >  Again, I'm not *trying* to guarantee this behaviour.
> > 
> > I didn't request you should guarantee this behaviour. I want you to make
> > it obvious for readers of your code that you rely on something that
> > isn't guaranteed. That your code works today isn't a good enough excuse.
> > There are various examples like these. If you want a few:
> > 
> >  - printf("string: %s\n", NULL); works fine with glibc, but segfaults on
> >    other libcs.
> >  - setenv("MYVAR", NULL) used to work (and was equivalent to
> >    setenv("MYVAR", "")) but that was never guaranteed. Then at some
> >    point of time it started to segfault.
> >  - Look into commits like a4435febd4c0f14b25159dca249ecf91301c7c76. This
> >    used to work fine until compilers were changed to optimize more
> >    aggressively.
> > 
> > Now if you use a clk and know that all rates smaller than the requested
> > one are divisors of the fast one and your code only works (here: is
> > optimal) when this condition is given, you're walking on thin ice just
> > because this fact it's not guaranteed.
> > The least you can do is to add a code comment to make people aware who
> > debug the breakage or copy your code.
> 
> If I was assuming something, it's not that the requested clock rates are
> always integer dividers of the parent rate - but rather that the difference
> in precision between two possible clock rates (even non-integer-dividers) is
> so tiny that we just don't care.

I'm more exacting here. If you are asked for X and can provide X - 2 you
shouldn't provide X - 12. Depending on the use case the consumer is happy
about every bit of accuracy they can get. So if you deliberately provide
X - 12 because it is easier to do and good enough for you, at least
document this laziness to not waste other people's time more than
necessary.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
