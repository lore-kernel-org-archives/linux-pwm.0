From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v10 14/27] pwm: jz4740: Improve algorithm of clock
 calculation
Date: Mon, 4 Mar 2019 13:33:13 +0100
Message-ID: <20190304123313.GF9040@ulmo>
References: <20190302233413.14813-1-paul@crapouillou.net>
 <20190302233413.14813-15-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0rSojgWGcpz+ezC3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190302233413.14813-15-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Mathieu Malaterre <malat@debian.org>, od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2019 at 08:34:00PM -0300, Paul Cercueil wrote:
> The previous algorithm hardcoded details about how the TCU clocks work.
> The new algorithm will use clk_round_rate to find the perfect clock rate
> for the PWM channel.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>=20
> Notes:
>          v9: New patch
>    =20
>         v10: - New algorithm. Instead of starting with the maximum clock =
rate
>                and using clk_round_rate(rate - 1) to get the next (smalle=
r)
>     	   clock, we compute the maximum rate we can use before the
>     	   register overflows, and apply it with clk_set_max_rate.
>     	   Then we read the new clock rate and compute the register values
>     	   of the period and duty from that.
>     	 - Use NSEC_PER_SEC instead of magic 1000000000 value
>=20
>  drivers/pwm/pwm-jz4740.c | 49 ++++++++++++++++++++++++++++++++----------=
------
>  1 file changed, 33 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index c6136bd4434b..f497388fc818 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -110,24 +110,45 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  	struct jz4740_pwm_chip *jz4740 =3D to_jz4740(pwm->chip);
>  	struct clk *clk =3D jz4740->clks[pwm->hwpwm],
>  		   *parent_clk =3D clk_get_parent(clk);
> -	unsigned long rate, period, duty;
> +	unsigned long rate, parent_rate, period, duty;
>  	unsigned long long tmp;
> -	unsigned int prescaler =3D 0;
> +	int ret;
> =20
> -	rate =3D clk_get_rate(parent_clk);
> -	tmp =3D (unsigned long long)rate * state->period;
> -	do_div(tmp, 1000000000);
> -	period =3D tmp;
> +	parent_rate =3D clk_get_rate(parent_clk);
> +
> +	jz4740_pwm_disable(chip, pwm);
> +
> +	/* Reset the clock to the maximum rate, and we'll reduce it if needed */
> +	ret =3D clk_set_rate(clk, parent_rate);
> +	if (ret)
> +		return ret;
> =20
> -	while (period > 0xffff && prescaler < 6) {
> -		period >>=3D 2;
> -		rate >>=3D 2;
> -		++prescaler;
> +	/* Limit the clock to a maximum rate that still gives us a period value
> +	 * which fits in 16 bits.
> +	 */

Please use proper block-comment style.

> +	tmp =3D 0xffffull * NSEC_PER_SEC;
> +	do_div(tmp, state->period);
> +
> +	ret =3D clk_set_max_rate(clk, tmp);
> +	if (ret) {
> +		dev_err(chip->dev, "Unable to set max rate: %i\n", ret);
> +		return ret;
>  	}
> =20
> -	if (prescaler =3D=3D 6)
> -		return -EINVAL;
> +	/* Read back the clock rate, as it may have been modified by
> +	 * clk_set_max_rate()
> +	 */
> +	rate =3D clk_get_rate(clk);

That's a pretty neat trick. But also, please use proper block-comment
style.

Thierry

--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9GwkACgkQ3SOs138+
s6GJgBAAnQvMOMCV6VZpxm0xDRxvZpCOPycq+4tWt69b30Ja/bcSGRxP0XHqZWWP
ndv7LtD9hTbBgHQNtMM1xV3dPhZ190ule9TsEmvWX8CNnU5fHAPLO0OvzNmUC/XZ
eftV62b3mHRvbZxB/CtFXHz7V+0TLGTG8k9Ft2mgH4Av2FVCjSQxLLL8kLcZs23o
hAGwFhen0QCnz70R72Biuz0Qr6DbEo1XCDCt5JPLrSuETC7t4VuGc/aLW08helen
Jc9/rMV93vnhw41TDlEaAeusDPNqLDBM96Nxs2xkuLx3o8AJFOHXx9b7dNzb7HMp
ywIbbW7e2o61nLkzNQvPPeSFljpxv+Np/x4UJZclyTLwbrcmRICfow1DaR6T1xSY
XckA95jtqrf1W57GrcxcpkhBRMC2EefFnr/Z6WV2+HYL24lG/rGkqE6GWN1ZFsay
77rnhZ4xx+z08OcSh4GG+7MPQcrs5iBVm5pXFS42XEfWCZfUkOm7XnqbVsztWiD0
e20FAbcRj0SG8ul1OZgVPNU2xb9W3iie0Wj9SqxCyH+U2wqnEC2KtgwCmVxGH54M
5SRabTKLq7leXkoekwZwiQkJrW2g8AJR0rqjwwG/LEPQpHaD4vZGf0+o0Oo0Z7KF
+X8XaQvWgZDtqmfc/B3Qum+FIPzFZNdVV3IwNwqZjSvsc3j+DIc=
=zQDM
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--
