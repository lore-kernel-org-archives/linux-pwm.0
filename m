From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] pwm: pca9685: fix prescaler initialization
Date: Wed, 18 Jan 2017 11:57:35 +0100
Message-ID: <20170118105735.GM18989@ulmo.ba.sec>
References: <20161213155251.28684-1-clemens.gruber@pqgruber.com>
 <20161213155251.28684-2-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W4pDZ/VvazBYHhxQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161213155251.28684-2-clemens.gruber@pqgruber.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stable@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pwm@vger.kernel.org


--W4pDZ/VvazBYHhxQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2016 at 04:52:51PM +0100, Clemens Gruber wrote:
> Until now, we assumed that the period is the hardware default of 1/200Hz
> at probe time, but if the period was changed and the user reboots, this
> assumption is wrong.
>=20
> Solution: Check if the prescaler is set to the hardware default. If not,
> reprogram the prescaler at first configuration.
>=20
> Cc: <stable@vger.kernel.org> # v4.3+
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Cc'ing Mika and Andy and quoting verbatim for review.

Thierry

> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 01a6a83..efc657e 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -55,6 +55,7 @@
>  #define PCA9685_PRESCALE	0xFE
> =20
>  #define PCA9685_PRESCALE_MIN	0x03	/* =3D> max. frequency of 1526 Hz */
> +#define PCA9685_PRESCALE_DEF	0x1E	/* =3D> default frequency of 200 Hz */
>  #define PCA9685_PRESCALE_MAX	0xFF	/* =3D> min. frequency of 24 Hz */
> =20
>  #define PCA9685_COUNTER_RANGE	4096
> @@ -289,8 +290,8 @@ static int pca9685_pwm_probe(struct i2c_client *clien=
t,
>  				const struct i2c_device_id *id)
>  {
>  	struct pca9685 *pca;
> +	int prescale, mode2;
>  	int ret;
> -	int mode2;
> =20
>  	pca =3D devm_kzalloc(&client->dev, sizeof(*pca), GFP_KERNEL);
>  	if (!pca)
> @@ -304,10 +305,15 @@ static int pca9685_pwm_probe(struct i2c_client *cli=
ent,
>  		return ret;
>  	}
>  	pca->duty_ns =3D 0;
> -	pca->period_ns =3D PCA9685_DEFAULT_PERIOD;
> =20
>  	i2c_set_clientdata(client, pca);
> =20
> +	regmap_read(pca->regmap, PCA9685_PRESCALE, &prescale);
> +	if (prescale =3D=3D PCA9685_PRESCALE_DEF)
> +		pca->period_ns =3D PCA9685_DEFAULT_PERIOD;
> +	else
> +		pca->period_ns =3D 0;
> +
>  	regmap_read(pca->regmap, PCA9685_MODE2, &mode2);
> =20
>  	if (device_property_read_bool(&client->dev, "invert"))
> --=20
> 2.10.2
>=20

--W4pDZ/VvazBYHhxQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlh/Sh8ACgkQ3SOs138+
s6EvkQ/+LuiRipO6xTxZjZfSxd7WD6bb7BfH83j+bQWOsvlkS33wqrGw1mPfy0TB
cM+En4CLxhLZEOG+JtOFYvG2ZqB6AzMoNPT+UMqbPYtevikgP9EPC3yvillQb50m
L8e/YsvYDbch3Ibvvo6QOdwfcnx3Je5A5Uip/OioOf/x+QvVxu+RWDM3ErOX8yvl
wNBZv7YdLl1Ro9ke55m/SeIR8xJIuAjJO3dIUe5jpYi1qfAW2XWW6hE8kRNt9d0q
QtQxo2aoJ8I8a457zHdi7A0w5wU8lEMPun+PmUnK1mn8pwoo5x0mNfTRE+ymfto8
i5rdEkLqPaoh/AEEC/UCI3Wbk6V7R7cdHTMsJaLB2DBPkO3BrUTm6IFR4JToI6LY
HX8i7i2IaAVjR3LvwGURNH3NTBiTxwpzY5N2ho2g4DPZRo/PYJ40yPfGXHwNlD7o
senyYtVRxzQ+VhLFlMM9Z4FfuplKKu+pkxxMAxepVgBj0w1SzkUoP57hvZ1WHVrt
OKlZc0u0A73sE0vHe0Uel+DoRmOjJdqKRC/4vlHA9UAPpxuUqiAzXtIwkFx4ycqV
KDewTsdvvci+DyLJ8iVAf7wd2Bk3Xj96qnWrwu1uMmGJEfuSLCSuQpb40NQL7AoT
YlDv6SPfaTdRDl3l2Y+KHeHP/FT2tGF8G1B/5cBYkAoSpz8NebY=
=Sum1
-----END PGP SIGNATURE-----

--W4pDZ/VvazBYHhxQ--
