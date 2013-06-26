Return-Path: <thierry.reding@gmail.com>
Date: Wed, 26 Jun 2013 11:51:07 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: pca9685: Fix wrong argument to set MODE1_SLEEP bit
Message-ID: <20130626095106.GB27083@manwe>
References: <1371662847.5355.2.camel@phoenix>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <1371662847.5355.2.camel@phoenix>
List-ID: <linux-pwm.vger.kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Axel Lin <axel.lin@ingics.com>, linux-pwm@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2013 at 01:27:27AM +0800, Axel Lin wrote:
> Current code actually does not set MODE1_SLEEP bit because the new value =
for
> bitmask (0x1) is wrong. To set MODE1_SLEEP bit, we should pass MODE1_SLEEP
> as the new value for bitmask.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi Steffen,
> I don't have this hardware, can you test if this patch works?
> Thanks,
> Axel
>=20
>  drivers/pwm/pwm-pca9685.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Steffen,

are you able to test or review this? The patch seems good but I'm not
familiar with the hardware nor do I have a board to test it on.

Thierry

>=20
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index c9f9e65..3fb775d 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -190,7 +190,7 @@ static void pca9685_pwm_free(struct pwm_chip *chip, s=
truct pwm_device *pwm)
> =20
>  	if (--pca->active_cnt =3D=3D 0)
>  		regmap_update_bits(pca->regmap, PCA9685_MODE1, MODE1_SLEEP,
> -				   0x1);
> +				   MODE1_SLEEP);
>  }
> =20
>  static const struct pwm_ops pca9685_pwm_ops =3D {
> @@ -264,7 +264,8 @@ static int pca9685_pwm_remove(struct i2c_client *clie=
nt)
>  {
>  	struct pca9685 *pca =3D i2c_get_clientdata(client);
> =20
> -	regmap_update_bits(pca->regmap, PCA9685_MODE1, MODE1_SLEEP, 0x1);
> +	regmap_update_bits(pca->regmap, PCA9685_MODE1, MODE1_SLEEP,
> +			   MODE1_SLEEP);
> =20
>  	return pwmchip_remove(&pca->chip);
>  }
> --=20
> 1.8.1.2
>=20
>=20
>=20

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyrmKAAoJEN0jrNd/PrOh6PYP/0eoFaUP9hWddmA5ghkab8L7
7wGtPcaJSshotAgRc6FjqdUQSUgvi/Flu5i0wai5LZzLQ/XAQ87ZjYCf0x5vMKBs
zmuJkRznDeMOa2hbHBpGspWev5DYk0hSdk/poxei2Vos7p8LOtypfVnWkLArPZ85
KxZ1lfk+EiY/GnuGSE78NkTCCUIxjYTNEEu3H+p+EO8/1psiAWddR3Sbmr8HRbcH
byLcheLTnbsVS2EOHhxFCWTSaD1ldKiql8vQnPXaNX0n0s3vQdEym8Vm6dfN8Do6
RzegVlDob3P3d5zw2msQ5KPchhFStmkhHBlKaE9Gtb788a0n0Jw14t9RYJUZkuyt
7OpVewKwF2Os8Jm1KWSBRtnUnmelRzLKiQ5nDnvW48eKODSkabHZDZeQU+AqHK4a
IVO4dMhlDL4eVOqdIxTMsS5Zhh0Wqhmqpt9fXrETzpRA37vxsAYwvS+DnncE5xv1
CQ7jswp/9+KSbL1Gjj7Ffd3IGdVVOo0YBPkXkC1aofowLhkhhPPFNkQlJh7MGB2h
6QAbf/iX/qqGZ+Q4+2KIgL0FFXEhFlOLfpj8nJKk3GWVfVbkrfMTCWsnKr5S3644
SCqwNuAsQ8jR9m68bx8yfuSIugXX5ibEOimqE/SCgGsrNCRZJk67nIuvECiLGNGJ
BcUoLP+9fRI+TQszW8io
=7/Vp
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
