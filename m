From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 0/2] pwm: meson: two small bug-fixes
Date: Thu, 9 May 2019 16:52:59 +0200
Message-ID: <20190509145259.GA8907@ulmo>
References: <20190401181817.11999-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdOeJE8sLwpQaOMV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190401181817.11999-1-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, narmstrong@baylibre.com, jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de, bichao.zheng@amlogic.com
List-Id: linux-pwm@vger.kernel.org


--sdOeJE8sLwpQaOMV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 08:18:15PM +0200, Martin Blumenstingl wrote:
> This series applies on top of my other fix "pwm: meson: fix scheduling
> while atomic issue" from [0]
>=20
> The first patch fixes an issue where the maximum possible pre-divider
> (128) could not be used because there was an off-by-one error in the
> code. I discovered this while testing with the longest supported period
> (349514407ns) when running from XTAL. This is verified to work on my
> Meson8b Odroid-C1 board using "pwm_b" on GPIOX_11.
>=20
> The second patch was suggested by Uwe Kleine-K=C3=B6nig but was actually
> implemented much earlier (back in mid 2018) by Bichao Zheng from
> Amlogic. This patch fixes changing the duty cycle by relying on the
> hardware to re-start the PWM output (instead of adding an artificial
> "constant LOW" of about 20ms - as measured by Bichao Zheng when
> stopping and re-starting the PWM output from within the driver). I
> tested this fix on my Meson8b Odroid-C1 board which uses a PWM driven
> CPU regulator (DVFS with all supported OPPs is still working fine for
> me, although I couldn't observe any issues before this patch).
>=20
> I also have some code-improvements queued which I'll send in the next
> days, see [1]
>=20
>=20
> [0] https://patchwork.kernel.org/cover/10880419/
> [1] https://github.com/xdarklight/linux/commits/meson-pwm-for-5.2-v1
>=20
>=20
> Bichao Zheng (1):
>   pwm: meson: don't disable pwm when setting duty repeatedly
>=20
> Martin Blumenstingl (1):
>   pwm: meson: consider 128 a valid pre-divider
>=20
>  drivers/pwm/pwm-meson.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Both patches applied, thanks.

Thierry

--sdOeJE8sLwpQaOMV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUPssACgkQ3SOs138+
s6HQ2w/5AYGbx7MbLUpSUjsimmVEVGLHZMNi+Ma8lE2mK2HKzvp1nHPQvai/Pob7
2dnkyZjxB5FhHBJSuh92Wpk7rdLUMEG0mY/BJRkZG5Ne2dt94Jxyz2clVbM950kE
7YtzMBuPmCWvn8noD9aSyiVqVAeBppUfQhBBWvWaC2byjmXW5YB0ND/yyZH6o33x
ZS9gH8v6COySx2zNxzWjk3Fx7q8PjqnY2JvKZqpLSoE4rt49YJnUdafeRPDdBOoa
odBOSmVE8u4NvjLL/lbHgfpX9ITApqBGsfIX9EQZiqsGsD3DFFJff7zuxjMJJLfZ
cVsvWaTRzQhPxB2CkWQJ/yn8OI0JOPdCXKyZM1sK/apBRj3lEhD6AoYdwlslk4MW
Qn4mqSf5yWE7i8XnSo9Bb3IvE0U0F9+WSRE9Cf/IeKryeE2SwbIGNbbHrtQNqD4I
95xa0Ck4ijkwX4N3j1fL+/6VfLG/gRUs7aXUtwfMPyf4ln49hwHvAkFJfWU7fOqm
zffAQhbmqEeuiGFO9BZGHtTF5l9WzOEhs+aqtupn226xLAAUA5AUUZeypRwswNIM
x8X91p+Iy/EJdck2vcsLmFgl2CHuSo45bUepmicGOaOc1611ZZMry5fgqSgEn4iI
pVmuiNeb8uZ//O5v+GG0vdt94+lLwZAwCARg/UHfmPf55T4AMuI=
=7AFQ
-----END PGP SIGNATURE-----

--sdOeJE8sLwpQaOMV--
