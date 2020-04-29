From: Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v2] pwm: sun4i: direct clock output support for Allwinner
 A64
Date: Wed, 29 Apr 2020 14:03:06 +0200
Message-ID: <20200429120306.7bqg6d5z2qomt4bj@gilmour.lan>
References: <20200428164150.366966-1-peter.vasil@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vmsinkl72f7e2isg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428164150.366966-1-peter.vasil@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Vasil <peter.vasil@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nightwolf@relghuar.net
List-Id: linux-pwm@vger.kernel.org


--vmsinkl72f7e2isg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2020 at 06:41:50PM +0200, Peter Vasil wrote:
> Allwinner A64 is capable of a direct clock output on PWM (see A64
> User Manual chapter 3.10). Add support for this in the sun4i PWM
> driver.
>=20
> Signed-off-by: Peter Vasil <peter.vasil@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--vmsinkl72f7e2isg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqls+gAKCRDj7w1vZxhR
xXL4APwJ1frhThTxfINLI8+qwKzaB+xsWZPuoydUkyE2hxzV7wEA2Mq/A36nL3jr
dEXEVKmCa8o8lDHAr2fo9TOwjIuX+AU=
=w8vE
-----END PGP SIGNATURE-----

--vmsinkl72f7e2isg--
