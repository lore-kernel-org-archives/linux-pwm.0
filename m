Return-path: <kernel-bounces@pengutronix.de>
Date: Mon, 4 Mar 2019 12:23:18 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20190304112318.GA7617@ulmo>
References: <20190110193353.20767-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20190110193353.20767-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: imx27: only enable the clocks once in .get_state
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 08:33:53PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Currently the function pwm_imx27_get_state() of enables the clocks once
> unconditionally at the start, a second time if the PWM is enabled and
> disables unconditionally at the end.
>=20
> Simplify that to enable once at the start and disable conditionally at
> the end.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-imx27.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Applied, thanks.

Thierry

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9CqYACgkQ3SOs138+
s6HYGBAAhROWTjWBcZio//SmXFcD0EZ3Yjuj+mZxo6/l0Lqq0EIVr8T8lk0J/ZI8
7cdQqwih1l3HYnCoX3bsNj9C24llTPnvUb3qPkXbSUUtEL16RZN43vLB9ufeprMp
6PNuput72dAOk4DZrLFrpw+IC8hw6jb7UHAe1pBgujleCSxg93vHGkSwLYtmhSzz
M4CynkJWwupYqlIl1KPKJk+FoHqbEnn4aUKvUde4EuSlVfDe3eoIteepkV2ZbDzz
2g2tRlmV5pibmFLBw9Hu4rotqdQDM0jJXLyOkXC//IhBkqWDWSA79BakEsjOtqCe
p7iqT0mEZ8pQCMMORDYfNjcKVFOw727/MJz/PRbPdUJb9MnM0sCDEerdMtD99onx
uaTg15xlEWNHLF6hnE1vq9HbCFTdUAJaCc5S32CGa1CQ9q7szTKsOxvAoiLO5rMt
Xj+lo8Zqusb6zEMuBTxZ5LHOVgfKGR4TpmROWo5Kx16k7q0lAZjTQVJAtmZyeoG6
BBf24+nOIIKpT5IUXbyEeTChuSkYO+u53voYKbI4akxL80H3J4pYZN6PqHHOYg6a
GJGVheOUBppB0RRON6501MMIZUJsJHpbqil9G7uQzWnGduIBA7riYPm/mcCt3CkY
p0elzhO7DXYVbcAaoaaRoVRiWc1Fe3MGdsYbW6LjAoHWfQtK8vc=
=WEOo
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
