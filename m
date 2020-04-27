From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 06/16] irqchip: add sl28cpld interrupt controller
 support
Date: Mon, 27 Apr 2020 19:05:39 +0100
Message-ID: <20200427180539.GF4383@sirena.org.uk>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-7-michael@walle.cc>
 <87pnbtqhr1.fsf@nanos.tec.linutronix.de>
 <87f141bce0a4fda04b550647306be296@walle.cc>
 <20200427174427.GE4383@sirena.org.uk>
 <5d63026fc7c8700c2c7fb15267a9e441@walle.cc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qftxBdZWiueWNAVY"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5d63026fc7c8700c2c7fb15267a9e441@walle.cc>
Sender: linux-gpio-owner@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Jason
List-Id: linux-pwm@vger.kernel.org


--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 27, 2020 at 08:01:14PM +0200, Michael Walle wrote:
> Am 2020-04-27 19:44, schrieb Mark Brown:

> > Looking at the changelog there the "we can't be sure" bit is that
> > coccinelle couldn't follow the flags through from the caller to make
> > sure that IRQF_ONESHOT is set so we're just oring it in unconditionally.

> So it is correct that IRQF_ONESHOT is also set in the driver which is
> using regmap_add_irq_chip(), right?

It shouldn't break anything and my instinct is that it's better form.

--qftxBdZWiueWNAVY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6nHvMACgkQJNaLcl1U
h9ApOQf/S6MhJTO+bFChRr3cqXq9pRPnjvTfkt1e+TT+fIXOh2uMY8mRxXizy7En
nNcSqd3id4MgeW/kEGX7lvy7/oekEZsIqZATQy0THN93fw1n/0t9u22LwLFW00/w
MHfKqmnBMOv+o5aYUrJtsdspfhyS76FcRnaoe5gr6PPYtEbQnWRy4UV3HAPpp5mO
3d+MFa4olzoLwjD7HKkcIbbuWy3QcYgSn7HWfkqRPl+g06FIivX0SqC7kKLvTMzw
++5Oj+jFw8W3sfX0mcnF1U/PieOR5WYuy6PXUKcN4j2zy1XrEbfF3e9k/H6B710c
UOuaJn2BH7J1F4zSNSNQlc4ihuaoPw==
=Y8Z/
-----END PGP SIGNATURE-----

--qftxBdZWiueWNAVY--
