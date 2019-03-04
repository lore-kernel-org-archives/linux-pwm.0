From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v10 11/27] pwm: jz4740: Apply configuration atomically
Date: Mon, 4 Mar 2019 12:59:07 +0100
Message-ID: <20190304115907.GB9040@ulmo>
References: <20190302233413.14813-1-paul@crapouillou.net>
 <20190302233413.14813-12-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190302233413.14813-12-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Mathieu Malaterre <malat@debian.org>, od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2019 at 08:33:57PM -0300, Paul Cercueil wrote:
> This is cleaner, more future-proof, and incidentally it also fixes the
> PWM resetting its config when stopped/started several times.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>=20
> Notes:
>          v9: New patch
>    =20
>          v10: No change
>=20
>  drivers/pwm/pwm-jz4740.c | 37 ++++++++++++-------------------------
>  1 file changed, 12 insertions(+), 25 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9EwsACgkQ3SOs138+
s6Fifw//f2H2kWj6n++VBIr3qcpgyLlpnGP7IdO8SjFN1SopHRC1vHqhKao7IdRf
7HfK6sbCuisohUtSedMVcj5aD8fDlf2eUoaLwmErr/RKtQZiOmS7oSsYCFXaWvCf
YpXCycCtRX00UT0dVAw3uVIftDnYJ1sYJbXBM4SPZC9VmYSBz4UVOy7XoY+HhOBv
f+4LKs61FYgZmKDY10FWW2Wpq8Tw36Pdh8Szl9f8H8pFc+tgGCue7EaO7JN+TR3d
ZTSJmxlF0hwzzGbouA7Y1UcLDnZrCZqgkf/SCSpyOqn4JkbaxWUdYwtIUTD9N22Q
STfBGCCLlfXVEHQkEBvbgk84PwWBlEmPCcs/6ujnJCtD9mBKUJleOnF3aiqOpfCA
KplgKB+tR+YN866fG+A9JhbbX0JkAwdiCF/DRdJAajqW4gY2pyxkiEC1FwmIe/YM
vqLqaU7KqqeDso4HHjMbpBiJkznvUszfRJDrkboMygZ9WoMkUCseRJSLKXlyoRLX
buG5vHVkjJkhhuEL5Af7CguZzNUvTIMrvKd5Zn4/fRdMolj7m5vksQ1V1Wb7qWTI
G6CvNQO8S8cYwBkKYpXuMYWmsB8agHFnmzr98op8R6toc9/3i8EGOo0kV9V8NxmX
21KrsQr738C981dGRLoBVJRVlfnSHZgv67Dni+uj2+y2MBElhxk=
=DBKx
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
