From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 00/10] pwm: add support for atomic update
Date: Mon, 20 Jul 2015 18:19:50 +0100
Message-ID: <20150720171950.GE11162@sirena.org.uk>
References: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OwxNnBplxDBmy6FV"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-leds-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Doug Anderson <dianders@google.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org


--OwxNnBplxDBmy6FV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 20, 2015 at 05:31:57PM +0200, Boris Brezillon wrote:

> - dropped pwm-regulator patches (should be submitted separately)

I think the second patch needs to go in with this series doesn't it?  It
was just the enable one that was good to go immediately IIRC.

--OwxNnBplxDBmy6FV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVrS22AAoJECTWi3JdVIfQ3u4H/1DaEVJrIoD2zH3HSOGhfiRF
bonfEXpacF+zm5pnN91kk06bGts2+xrKBPErT72C4awUlxb+wP4KilkJpBUKjdro
/BKsfcs/OnNuxB1Yv1XL0ZH49fFDIMdauDnNR4L/wCA047dYKlrKTCAghkPQLEbY
9VTLq6uIoCEMk5LRdGzX6rX31/638uqLH409BTAMUgsDKDk2Wg1HRgm3PHtvLDwS
BYxO/eiAhTAvz+UirukwM3SzJ7BCVS0eSi6t9ftNeMB+rP6tS8xdYXiHhfueEGJE
jfiI9A9hDfv405HOImy/uP9gnqQ1udwaZPU+/GBN6+wQweyvObDWEO3IkahJDcc=
=S7l4
-----END PGP SIGNATURE-----

--OwxNnBplxDBmy6FV--
