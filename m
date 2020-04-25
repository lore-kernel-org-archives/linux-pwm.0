Return-path: <sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0efec2ac3e9d9d8d7d71e29c9ab7cdcbb02d137d.1587523702.git.gurus@codeaurora.org>
References: <cover.1587523702.git.gurus@codeaurora.org> <0efec2ac3e9d9d8d7d71e29c9ab7cdcbb02d137d.1587523702.git.gurus@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
Date: Sat, 25 Apr 2020 12:06:29 -0700
Message-ID: <158784158978.117437.14418056763457603677@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH v13 10/11] clk: pwm: Use 64-bit division function
To: Guru Das Srinagesh <gurus@codeaurora.org>, linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, u.kleine-koenig@pengutronix.de, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, David Collins <collinsd@codeaurora.org>, linux-kernel@vger.kernel.org, Guru Das Srinagesh <gurus@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>

Quoting Guru Das Srinagesh (2020-04-21 19:57:22)
> Since the PWM framework is switching struct pwm_args.period's datatype
> to u64, prepare for this transition by using div64_u64 to handle a

Write div64_u64() please

> 64-bit divisor.
>=20
> Also ensure that divide-by-zero (with fixed_rate as denominator) does
> not happen with an explicit check with probe failure as a consequence.
>=20
> To: David Laight <David.Laight@ACULAB.COM>
> To: Arnd Bergmann <arnd@arndb.de>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
>=20

Nitpick: Remove the extra newline.

> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
