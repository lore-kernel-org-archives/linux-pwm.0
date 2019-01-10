From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v9 14/27] pwm: jz4740: Improve algorithm of clock
 calculation
Date: Thu, 10 Jan 2019 11:04:56 -0300
Message-ID: <1547129096.16183.0@crapouillou.net>
References: <20181227181319.31095-1-paul@crapouillou.net>
        <20181227181319.31095-15-paul@crapouillou.net>
        <20190105195725.cuxfge6zkpbt3cyk@pengutronix.de>
        <1546722339.30174.0@crapouillou.net>
        <20190105212711.s765knwwerceytvk@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105212711.s765knwwerceytvk@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, Russell King <linux@armlinux.org.uk>
List-Id: linux-pwm@vger.kernel.org

Adding Stephen to the discussion.
Adding Stephen to the discussion.

On Sat, Jan 5, 2019 at 6:27 PM, Uwe Kleine-K=F6nig=20
<u.kleine-koenig@pengutronix.de> wrote:
> Hello Paul,
>=20
> On Sat, Jan 05, 2019 at 06:05:38PM -0300, Paul Cercueil wrote:
>>  On Sat, Jan 5, 2019 at 4:57 PM, Uwe Kleine-K=F6nig
>>  <u.kleine-koenig@pengutronix.de> wrote:
>>  > You are assuming stuff here about the parent clk which isn't=20
>> guaranteed
>>  > (AFAICT) by the clk framework: If you call clk_round_rate(clk,=20
>> rate - 1)
>>  > this might well return rate even if the clock could run slower=20
>> than
>>  > rate.
>>=20
>>  It may not be guaranteed by the clock framework itself, but it is=20
>> guaranteed
>>  to behave like that on this family of SoCs.
>=20
> You shouldn't rely on that. Experience shows that people will start
> copying code to machines where this is not guaranteed. Even if they
> don't copy and only learn from reading this is bad. Also how do you
> guarantee that this won't change in the future making the pwm code=20
> break
> without noticing?
>=20
> If you use an API better don't assume more things given than are
> guaranteed by the API.
>=20
> Having said that I would consider it sensible to introduce something
> like clk_roundup_rate() and clk_rounddown_rate() which would allow
> calculations like that.

@Stephen:
Some context: my algorithm makes use of clk_round_rate(clk, rate - 1)=20
to get the
next (smaller) clock rate that a clock support.

Is it something safe to assume? If not is there a better way?

>>  > Wouldn't it make sense to start iterating with rate =3D 0xffff *=20
>> 1e9 /
>>  > period? Otherwise you get bad configurations if rate is=20
>> considerable
>>  > slower than necessary.
>>=20
>>  The algorithm will start with 'rate' being the parent clock's rate,=20
>> which
>>  will always be the highest rate that the child clock will support.
>=20
> Ah right, I missed that bit.

Thanks,
-Paul
=
