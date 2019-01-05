From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v9 14/27] pwm: jz4740: Improve algorithm of clock
 calculation
Date: Sat, 5 Jan 2019 22:27:11 +0100
Message-ID: <20190105212711.s765knwwerceytvk@pengutronix.de>
References: <20181227181319.31095-1-paul@crapouillou.net>
 <20181227181319.31095-15-paul@crapouillou.net>
 <20190105195725.cuxfge6zkpbt3cyk@pengutronix.de>
 <1546722339.30174.0@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1546722339.30174.0@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, Russell King <linux@armlinux.org.uk>
List-Id: linux-pwm@vger.kernel.org

Hello Paul,

On Sat, Jan 05, 2019 at 06:05:38PM -0300, Paul Cercueil wrote:
> On Sat, Jan 5, 2019 at 4:57 PM, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > You are assuming stuff here about the parent clk which isn't guaranteed
> > (AFAICT) by the clk framework: If you call clk_round_rate(clk, rate - 1)
> > this might well return rate even if the clock could run slower than
> > rate.
> 
> It may not be guaranteed by the clock framework itself, but it is guaranteed
> to behave like that on this family of SoCs.

You shouldn't rely on that. Experience shows that people will start
copying code to machines where this is not guaranteed. Even if they
don't copy and only learn from reading this is bad. Also how do you
guarantee that this won't change in the future making the pwm code break
without noticing?

If you use an API better don't assume more things given than are
guaranteed by the API.

Having said that I would consider it sensible to introduce something
like clk_roundup_rate() and clk_rounddown_rate() which would allow
calculations like that.

> > Wouldn't it make sense to start iterating with rate = 0xffff * 1e9 /
> > period? Otherwise you get bad configurations if rate is considerable
> > slower than necessary.
> 
> The algorithm will start with 'rate' being the parent clock's rate, which
> will always be the highest rate that the child clock will support.

Ah right, I missed that bit.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
