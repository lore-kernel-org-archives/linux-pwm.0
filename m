From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/4] pwm: bcm-kona: Remove impossible comparison when
 validating duty cycle
Date: Mon, 29 Jun 2020 21:41:13 +0200
Message-ID: <20200629194113.5ppu6fbolvk2ibkj@pengutronix.de>
References: <20200629124752.1018358-1-lee.jones@linaro.org>
 <20200629124752.1018358-3-lee.jones@linaro.org>
 <0db8ebc7-b75b-a74c-8852-b235daedaf82@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iom6ccgswov23aih"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0db8ebc7-b75b-a74c-8852-b235daedaf82@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-pwm@vger.kernel.org


--iom6ccgswov23aih
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2020 at 09:45:31AM -0700, Florian Fainelli wrote:
>=20
>=20
> On 6/29/2020 5:47 AM, Lee Jones wrote:
> > 'dc' here is an unsigned long, thus checking for <0 will always
> > evaluate to false.
> >=20
> > Fixes the following W=3D1 warning:
> >=20
> >  drivers/pwm/pwm-bcm-kona.c:141:35: warning: comparison of unsigned exp=
ression < 0 is always false [-Wtype-limits]
> >=20
> > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > Cc: Ray Jui <rjui@broadcom.com>
> > Cc: Scott Branden <sbranden@broadcom.com>
> > Cc: bcm-kernel-feedback-list@broadcom.com
> > Cc: linux-pwm@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>=20
> And similar to patch #1, DUTY_CYCLE_HIGH_MIN now gets unused, so if you
> remove it as well, you can add:
>=20
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Even without removing DUTY_CYCLE_HIGH_MIN (which might still serve as
documentation):

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--iom6ccgswov23aih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl76Q9UACgkQwfwUeK3K
7Al0CAf/Y4ZPaVHfhUvfydRJdCxxev03qoTCFtAzDTPaVB5uB2EoQY52OdKsixQ2
ael/uUR1eKJKfQZ3YTgJisVG135iRhv4e9QAaPUAjNJ5c6NBsHd5vevPzMm5vjq9
Pso3NLmhEcZk1qzn/SQJcjRCbUALSN9fXe7cORKeoJKH92ApyYxAz4T0ynURzwju
cjW2fPgfBC1T0r15e0+AbUwuy/8cgg+RjVM1/DXrZC0YD/QIMVCfQ4mk4UHIlAWA
WTNN/1J05XFWK5EmpsGgTnjYtGQYH//wLR0/jHG4TlhfbW9SdF4PYUkb4k93fNdr
3iUPx7ZRd+DqvR9cFPX0W0jhYjGiig==
=4PU7
-----END PGP SIGNATURE-----

--iom6ccgswov23aih--
