From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 10/16] gpio: add a reusable generic gpio_chip using
 regmap
Date: Tue, 14 Apr 2020 18:21:29 +0100
Message-ID: <20200414172129.GJ5412@sirena.org.uk>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-11-michael@walle.cc>
 <CAMpxmJVE3PgVCxkQ-ryc5=KSrKcpdmk1cnJUxJBz9QFCx-e_+A@mail.gmail.com>
 <80bd8661ec8a1f5eda3f09a267846eaa@walle.cc>
 <CAMpxmJVC7e9JnHzBo-h8M1+KmcA32=Rvxo7+znH=-kAbcCr_LQ@mail.gmail.com>
 <e0388a2137e23d76b2415a7549c01dd1@walle.cc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQAwcd5tHl0Qlnzi"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407622AbgDNRVd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 14 Apr 2020 13:21:33 -0400
Content-Disposition: inline
In-Reply-To: <e0388a2137e23d76b2415a7549c01dd1@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-gpio <linux-gpio@vger.kernel.org>, linux-devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.d>


--LQAwcd5tHl0Qlnzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 14, 2020 at 12:07:01PM +0200, Michael Walle wrote:
> Am 2020-04-14 11:50, schrieb Bartosz Golaszewski:

> > Maybe setting the pointer to ERR_PTR(-ENOENT) which will result in
> > IS_ERR() returning true?

> Unfortunatly, its not a pointer, but only a regular unsigned int (ie
> the type the regmap API has for its "reg" property). It could be a
> pointer of course but then the user would have to allocate additional
> memory.

You could define REGMAP_INVALID_ADDR to be (unsigned int)(-1) or some
other suitably implausible address and use that as a value.  It's
possible that there might be a collision with a real address on some
device but it should be sufficiently unlikely to be useful, especially
if it's not something regmap in general goes and evaluates.  For extra
safety we could have an API for allowing users to query the register
validity information regmap has (or can be given) and gpiolib could then
use that to figure out if the value was actually a dummy value but
that's probably overdoing it.

--LQAwcd5tHl0Qlnzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6V8RkACgkQJNaLcl1U
h9AnZwf8CXCh0WrZ2WtwfdTJ1yX5W12AkMOk5xoWSFXC9PzRicdAquQGHN0U0Qan
v2iy9fXKFP9/vjkpNOP0q8hzXFoFbxcDvTTPUcPJV9Xd/bJ/X2OTXn7qKKLxIA0q
8i5t5KXA1+3upDL3nzJvH/dZULUUz7vP7m1SrwkowgS4asnOJVMfa8vGJLbnxhT5
m9MjUO206PwDS/sUpsK36S+4ccbV5Nzdq50Ce9sWr4szpQnKtAFb0Z8Q9eriTl15
hJxwRBCZJLqzXLYIGVC0eJPv9YrbG3YLM+x+Hb6oxzOuHRWU5B/Kv8n01YeHW5A1
Zk21Hdv+mJcVD0qTQ1dNFzb4QzAp5Q==
=mDDb
-----END PGP SIGNATURE-----

--LQAwcd5tHl0Qlnzi--
