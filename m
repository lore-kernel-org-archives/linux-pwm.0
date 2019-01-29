Return-path: <sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20181227181319.31095-1-paul@crapouillou.net> <20181227181319.31095-15-paul@crapouillou.net> <20190105195725.cuxfge6zkpbt3cyk@pengutronix.de> <1546722339.30174.0@crapouillou.net> <20190105212711.s765knwwerceytvk@pengutronix.de> <1547129096.16183.0@crapouillou.net>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1547129096.16183.0@crapouillou.net>
Message-ID: <154879972841.136743.8067109506420222877@swboyd.mtv.corp.google.com>
Date: Tue, 29 Jan 2019 14:08:48 -0800
Subject: Re: [PATCH v9 14/27] pwm: jz4740: Improve algorithm of clock calculation
To: u.kleine-koenig@pengutronix.de, Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, Russell King <linux@armlinux.org.uk>
List-ID: <linux-pwm.vger.kernel.org>

Quoting Paul Cercueil (2019-01-10 06:04:56)
> Adding Stephen to the discussion.
> Adding Stephen to the discussion.
>=20
> On Sat, Jan 5, 2019 at 6:27 PM, Uwe Kleine-K=C3=B6nig=20
> <u.kleine-koenig@pengutronix.de> wrote:
> > Hello Paul,
> >=20
> > On Sat, Jan 05, 2019 at 06:05:38PM -0300, Paul Cercueil wrote:
> >>  On Sat, Jan 5, 2019 at 4:57 PM, Uwe Kleine-K=C3=B6nig
> >>  <u.kleine-koenig@pengutronix.de> wrote:
> >>  > You are assuming stuff here about the parent clk which isn't=20
> >> guaranteed
> >>  > (AFAICT) by the clk framework: If you call clk_round_rate(clk,=20
> >> rate - 1)
> >>  > this might well return rate even if the clock could run slower=20
> >> than
> >>  > rate.
> >>=20
> >>  It may not be guaranteed by the clock framework itself, but it is=20
> >> guaranteed
> >>  to behave like that on this family of SoCs.
> >=20
> > You shouldn't rely on that. Experience shows that people will start
> > copying code to machines where this is not guaranteed. Even if they
> > don't copy and only learn from reading this is bad. Also how do you
> > guarantee that this won't change in the future making the pwm code=20
> > break
> > without noticing?
> >=20
> > If you use an API better don't assume more things given than are
> > guaranteed by the API.
> >=20
> > Having said that I would consider it sensible to introduce something
> > like clk_roundup_rate() and clk_rounddown_rate() which would allow
> > calculations like that.
>=20
> @Stephen:
> Some context: my algorithm makes use of clk_round_rate(clk, rate - 1)=20
> to get the
> next (smaller) clock rate that a clock support.
>=20
> Is it something safe to assume? If not is there a better way?

It isn't super efficient but it should work if you keep subtracting from
rate until it reaches 0. The rounding of clk_round_rate() is
implementation defined. All the API does is tell you what clk_set_rate()
will set the rate to if you call it with the same arguments passed to
clk_round_rate(). Having something like clk_roundup_rate() or
clk_rounddown_rate() could be implemented with a wrapper around
clk_round_rate(), and I believe Uwe has proposed such an API before, but
I'm not sure we want to encourage that sort of API or behavior in
general. The mailing list archives probably have discussions around this
proposed API, I can't remember the whole discussion.

Why do you need to find the "next" supported frequency anyway? It may be
a sign that something is sort of off with the approach if you need to do
this.
