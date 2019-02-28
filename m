From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v9 14/27] pwm: jz4740: Improve algorithm of clock calculation
Date: Thu, 28 Feb 2019 10:42:32 -0800
Message-ID: <155137935225.16805.10412318501940648799@swboyd.mtv.corp.google.com>
References: <20181227181319.31095-1-paul@crapouillou.net> <20181227181319.31095-15-paul@crapouillou.net> <20190105195725.cuxfge6zkpbt3cyk@pengutronix.de> <1546722339.30174.0@crapouillou.net> <20190105212711.s765knwwerceytvk@pengutronix.de> <1547129096.16183.0@crapouillou.net> <1550884678.20534.0@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550884678.20534.0@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>, u.kleine-koenig@pengutronix.de
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, Russell King <linux@armlinux.org.uk>
List-Id: linux-pwm@vger.kernel.org

Quoting Paul Cercueil (2019-02-22 17:17:58)
> Bump.
>=20
> What should I do here?
>=20

I thought I replied to the list but maybe it got rejected because my MUA
is currently failing hard at sending 8-bit mails without
using quoted printable. Let me remove all non-ascii characters from this
mail!

If someone has the mail please rebounce it to the list. Otherwise, I
think I basically said this is OK because clk_round_rate() semantics are
specifically vague here to allow the implementation to decide how rates
are rounded (up, down, closest, etc). As long as the whole rate space is
searched with a +1 or a -1 style of search it should be work. We're not
going to add round_up() or round_down() APIs as far as I'm concerned,
and you can look on the list to see previous proposals on that topic to
get some background on why they aren't liked.
