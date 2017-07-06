From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 3/3] pwm: meson: improve pwm calculation precision.
Date: Thu, 6 Jul 2017 23:21:57 +0200
Message-ID: <20170706212154.GA28918@mithrandir>
References: <20170608122416.1993-1-jbrunet@baylibre.com>
 <20170608122416.1993-4-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170608122416.1993-4-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Carlo Caione <carlo@caione.org>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 02:24:16PM +0200, Jerome Brunet wrote:
> When using input clocks with high rates, such as clk81 (166MHz), the
> fin_ns =3D NSEC_PER_SEC / fin_freq can introduce a significant error.
>=20
> Ex: fin_freq =3D 166666667, NSEC_PER_SEC =3D 1000000000
>     fin_ns =3D 5,9999999
>=20
> which is, of course, rounded down to 5. This introduce an error of ~20%
> on the period requested from the pwm.
>=20
> This patch use ps instead of ns (and 64bits integer) to perform the
> calculation. This should give a good enough precision.
>=20
> Fixes: 211ed630753d ("pwm: Add support for Meson PWM Controller")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/pwm/pwm-meson.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index b911a944744a..4cdc66f7f718 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -163,7 +163,8 @@ static int meson_pwm_calc(struct meson_pwm *meson,
>  			  unsigned int duty, unsigned int period)
>  {
>  	unsigned int pre_div, cnt, duty_cnt;
> -	unsigned long fin_freq =3D -1, fin_ns;
> +	unsigned long fin_freq =3D -1;
> +	u64 fin_ps;
> =20
>  	if (~(meson->inverter_mask >> id) & 0x1)
>  		duty =3D period - duty;
> @@ -179,13 +180,14 @@ static int meson_pwm_calc(struct meson_pwm *meson,
>  	}
> =20
>  	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
> -	fin_ns =3D NSEC_PER_SEC / fin_freq;
> +	fin_ps =3D ((u64)NSEC_PER_SEC * 1000) / fin_freq;

This failed to build, so I had to change this division to a do_div().

Thierry

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlleqe8ACgkQ3SOs138+
s6Gq/BAAji7O2nZvTWjzUWFMZ6B/bC3cfYHj0GFoDD+oHpwfKWmGdYJX+n8zJSng
Xbj4Xb21ryHsgUK4IiLAz1yUqAaJTx4Y8fbdpJymWdSkI5nhlQRvK83kxOh9bp92
za6rbEOk04OKZetDGjP4tszhAS6VvKdESkpTVcIXSChIA2cJf2OTQMhOkcDf9soK
3S3gfqkdfYHpURYLhImkdV+lJpDr4Wf9TtB4UPh8M2AqC5VPWhhmUAy8ymHzRUdK
5FbYDwP3z5Jla/k7Db17IkH6ZtWxNkDggJ0IxDW64wxhAcWuCS/gm0P1NLbSGFpD
wXm5I2DXusrtzUe+LZOmcY3LzN439xUj89YjKQcdUFMnFK/SUmcKZ54ez6PfZWYl
RfzWuLBmmanjdLWUpG4Zn5aFdAUYS6/OfV5hZtaiPepIwa0HnPquQQUILYvm8PHq
c4wvuq2HM+qEkzvwd8kR+ex8gHJ/WdJjobi8Ca0kP32TDSzlX/q7sE0ROgPIebqV
0iPFcJO0BxRRzJIXzagclUOPWTiEOaDxbtzT5IRB4q9bW2jjDubP1Homgz/y42nD
JZoSGEviDCPFTSVE9WtY3hHHMNrKQr8FZbLA08lxh8VqB4M9BrfA58kwNu1BmOyN
mW7LyJauN9rjUW+KmF/TZbjszwNn2agljYit02qJfdYtgoX4k8A=
=k7wT
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
