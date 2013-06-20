Return-Path: <thierry.reding@gmail.com>
Date: Thu, 20 Jun 2013 13:02:50 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: pca9685: Add .owner to struct pwm_ops
Message-ID: <20130620110249.GB28718@manwe>
References: <1371662009.5355.0.camel@phoenix>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <1371662009.5355.0.camel@phoenix>
List-ID: <linux-pwm.vger.kernel.org>
To: Axel Lin <axel.lin@ingics.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-pwm@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2013 at 01:13:29AM +0800, Axel Lin wrote:
> Add missing .owner of struct pwm_ops. This prevents the module from being
> removed from underneath its users.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 2afc904..c9f9e65 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -199,6 +199,7 @@ static const struct pwm_ops pca9685_pwm_ops =3D {
>  	.config =3D pca9685_pwm_config,
>  	.request =3D pca9685_pwm_request,
>  	.free =3D pca9685_pwm_free,
> +	.owner =3D THIS_MODULE,
>  };
> =20
>  static struct regmap_config pca9685_regmap_i2c_config =3D {

Hi Axel,

I've already posted a patch for this (and a few other missing .owner
fields) a few days ago. I've now pushed it to my for-next branch.

Thierry

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRwuFZAAoJEN0jrNd/PrOhJWgP/jCq6rFuR5ew8JPQfTcl7lpH
IekacYIxNM1/4e/Y2ozTz4wXuf7K/UcYkCquSQEBN9U+EPy8SeF3ai7hAbITc2RI
Fx0QsTfFEXShHKmjmxWRQLoCKBfJe8v/c+eFeURHI7IJEYqwU3tiGVyeQiUjSEFJ
ypyoxMxncxdPwC2zFbPJ9f8ITCImULt8vIuorSlesC3BDiTc8AqsdKMWn/HKihIT
Og+JtD980aQbrRspsP+Z6fz09lvu4WFZgkl5KOIe39wlbRt3KhoE18co8Y6SogwY
BW4jvxBigZCEwsmfOFsPJ05IcAL3OVcdr6cVQqSCmPI5c3dTWq0os+GKYeYYsSVo
qoVJjs1QmhvaSVSLQhCSBYAK+JrdCjplfCo7fFaljipQwoXCUuXs4aKTADsWpjNl
5Lsua/lAMCZ+BZOTTGve8Xq/ZmyP/Ci68eYInZsEXp3mcXJAWTVRUMQW0ELtIxXM
rob/OVDkgvUS+vWlJ9lMMemJfyV/0yg535NLeCpHRzv1nmCCumEwrEevr+AfVTIN
u+TkfGUPY4hbdioiSGGpNUXm85dQpReL+oaxHSrnQcMtg5nRgJxggmewKAJe47X+
UcZeMdbfGf+lCyw/32AzAm2HmmHeSC4/J2cGcmB86E+pSk/iKrxtDivBGEpOuu0a
CLNa9h+xge/2EoONNEok
=TL9F
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
