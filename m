From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/7] pwm: jz4740: Improve algorithm of clock calculation
Date: Mon, 12 Aug 2019 23:48:38 +0200
Message-ID: <20190812214838.e5hyhnlcyykjfvsb@pengutronix.de>
References: <20190809123031.24219-1-paul@crapouillou.net>
 <20190809123031.24219-5-paul@crapouillou.net>
 <20190809170551.u4ybilf5ay2rsvnn@pengutronix.de>
 <1565370885.2091.2@crapouillou.net>
 <20190812061520.lwzk3us4ginwwxov@pengutronix.de>
 <1565642590.2007.1@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565642590.2007.1@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Mathieu Malaterre <malat@debian.org>, Artur Rojek <contact@artur-rojek.eu>
List-Id: linux-pwm@vger.kernel.org

Hello Paul,

On Mon, Aug 12, 2019 at 10:43:10PM +0200, Paul Cercueil wrote:
> Le lun. 12 août 2019 à 8:15, Uwe =?iso-8859-1?q?Kleine-K=F6nig?=
> <u.kleine-koenig@pengutronix.de> a écrit :
> > On Fri, Aug 09, 2019 at 07:14:45PM +0200, Paul Cercueil wrote:
> > >  Le ven. 9 août 2019 à 19:05, Uwe =?iso-8859-1?q?Kleine-K=F6nig?=
> > >  <u.kleine-koenig@pengutronix.de> a écrit :
> > >  > On Fri, Aug 09, 2019 at 02:30:28PM +0200, Paul Cercueil wrote:
> > >  > > [...]
> > >  > >  +	/* Reset the clock to the maximum rate, and we'll reduce it if needed */
> > >  > >  +	ret = clk_set_max_rate(clk, parent_rate);
> > >  >
> > >  > What is the purpose of this call? IIUC this limits the allowed range of
> > >  > rates for clk. I assume the idea is to prevent other consumers to change
> > >  > the rate in a way that makes it unsuitable for this pwm. But this only
> > >  > makes sense if you had a notifier for clk changes, doesn't it? I'm
> > >  > confused.
> > > 
> > >  Nothing like that. The second call to clk_set_max_rate() might have set
> > >  a maximum clock rate that's lower than the parent's rate, and we want to
> > >  undo that.
> > 
> > I still don't get the purpose of this call. Why do you limit the clock
> > rate at all?
> 
> As it says below, we "limit the clock to a maximum rate that still gives
> us a period value which fits in 16 bits". So that the computed hardware
> values won't overflow.

But why not just using clk_set_rate? You want to have the clock running
at a certain rate, not any rate below that certain rate, don't you?
 
> E.g. if at a rate of 12 MHz your computed hardware value for the period
> is 0xf000, then at a rate of 24 MHz it won't fit in 16 bits. So the clock
> rate must be reduced to the highest possible that will still give you a
> < 16-bit value.
> 
> We always want the highest possible clock rate that works, for the sake of
> precision.

This is dubious; but ok to keep the driver simple. (Consider a PWM that
can run at i MHz for i in [1, .. 30]. If a period of 120 ns and a duty
cycle of 40 ns is requested you can get an exact match with 25 MHz, but
not with 30 MHz.)

> > >  Basically, we start from the maximum clock rate we can get for that PWM
> > >  - which is the rate of the parent clk - and from that compute the maximum
> > >  clock rate that we can support that still gives us < 16-bits hardware
> > >  values for the period and duty.
> > > 
> > >  We then pass that computed maximum clock rate to clk_set_max_rate(), which
> > >  may or may not update the current PWM clock's rate to match the new limits.
> > >  Finally we read back the PWM clock's rate and compute the period and duty
> > >  from that.
> > 
> > If you change the clk rate, is this externally visible on the PWM
> > output? Does this affect other PWM instances?
> 
> The clock rate doesn't change the PWM output because the hardware values for
> the period and duty are adapted accordingly to reflect the change.

It doesn't change it in the end. But in the (short) time frame between
the call to change the clock and the update of the PWM registers there
is a glitch, right?

You didn't answer to the question about other PWM instances. Does that
mean others are not affected?

Best regards
Uwe

PS: It would be great if you could fix your mailer to not damage the
quoted mail. Also it doesn't seem to understand how my name is encoded
in the From line. I fixed up the quotes in my reply.

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
