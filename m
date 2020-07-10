From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] Revert "pwm: jz4740: Enhance precision in calculation of
 duty cycle"
Date: Fri, 10 Jul 2020 12:18:27 +0200
Message-ID: <20200710101827.rkaxju7msco4mez7@pengutronix.de>
References: <9335b924318fb36a882d5b46e8e9f2a10bb24daa.1594365885.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="65yw67g3d563xquq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9335b924318fb36a882d5b46e8e9f2a10bb24daa.1594365885.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Paul Cercueil <paul@crapouillou.net>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, linux-mips@vger.kernel.org, tsbogend@alpha.franken.de, stable@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--65yw67g3d563xquq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 09:24:45AM +0200, H. Nikolaus Schaller wrote:
> This reverts commit a6030d71e62d3e0e270bf3b7fb48d32a636732db.
>=20
> which was applied to v5.4.49. This ends in a compile issue:
>=20
>   CC      drivers/pwm/pwm-jz4740.o - due to target missing
> drivers/pwm/pwm-jz4740.c: In function 'jz4740_pwm_apply':
> drivers/pwm/pwm-jz4740.c:111:28: error: 'rate' undeclared (first use in t=
his function)
>   tmp =3D (unsigned long long)rate * state->duty_cycle;
>                             ^
> drivers/pwm/pwm-jz4740.c:111:28: note: each undeclared identifier is repo=
rted only once for each function it appears in
> make[4]: *** [drivers/pwm/pwm-jz4740.o] Error 1
>=20
> v5.5 and later include the required additional patches to define
> the rate variable.

So 9017dc4fbd59 ("pwm: jz4740: Enhance precision in calculation of duty
cycle") which is in v5.8-rc1 was backported to stable:

	v5.4.49 (as commit a6030d71e62d3e0e270bf3b7fb48d32a636732db)
	v5.7.5 (as commit e0e71bb7852142a18fb829da419013bb6da9ed3f)

However 9017dc4fbd59 depends on

	ce1f9cece057 ("pwm: jz4740: Use clocks from TCU driver")

(which in mainline comes before 9017dc4fbd59 as it's included in
v5.7-rc1).

As ce1f9cece057 was not backported to v5.4.x, this must either be done, or
we need to patch that. Will reply with a suggested change.

In v5.7.x there is no problem.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--65yw67g3d563xquq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8IQHAACgkQwfwUeK3K
7AlRlwf/Z1pKFJvwRVQyzLY8FCiUzLmHIEVQE6wSIUDz/od9UhdJK1PNIaN4KSvw
++xOPZLBfzBlkFldFFJSqxfUB5s6ZsdUo+hC/jjEiumJHlJ0wOb96rrx0KS6IuqZ
0Q0Xdk4ZY55ztqVAI1eESF006kfT+JL5uaAMXIvA2CTgiHg//j4es99/0aro8p/7
W3anw6UAZ4U3Zk7hDuck2C7OkJ83+uBQwAb/A+nk4dSLZcE/icbQvfI7uluhLbK2
hfcIc4PJUtu/xE8xKbVLdwN5kV0FNKy7H3cFrVQJ1JtO00FfTpJhrKZ1ux1W9tCX
PBUMkBeNQ5VR9HbCoGLo0koT7/Ctmg==
=UCTX
-----END PGP SIGNATURE-----

--65yw67g3d563xquq--
