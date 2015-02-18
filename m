From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/1] fixing pwm-mxs period divider computation
Date: Wed, 18 Feb 2015 13:11:24 +0100
Message-ID: <20150218121123.GB18576@ulmo>
References: <1424247536-16476-1-git-send-email-ghug@induct.be>
 <1424247536-16476-2-git-send-email-ghug@induct.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424247536-16476-2-git-send-email-ghug@induct.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Gaetan Hug <ghug@induct.be>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>
List-Id: linux-pwm@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2015 at 09:18:56AM +0100, Gaetan Hug wrote:
> ---
>  drivers/pwm/pwm-mxs.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Adding Shawn and Fabio, hence quoting the full patch.

> diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
> index f75ecb0..bbb2f8a 100644
> --- a/drivers/pwm/pwm-mxs.c
> +++ b/drivers/pwm/pwm-mxs.c
> @@ -52,15 +52,18 @@ static int mxs_pwm_config(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>  	unsigned long rate;
>  	unsigned long long c;
> =20
> +    unsigned const int cdiv[PERIOD_CDIV_MAX] =3D {1, 2, 4, 8, 16, 64, 25=
6, 1024};

This could prbably be static const and could be in file scope rather
than in this function.

Thierry

> +
>  	rate =3D clk_get_rate(mxs->clk);
> +
>  	while (1) {
> -		c =3D rate / (1 << div);
> +		c =3D rate / cdiv[div];
>  		c =3D c * period_ns;
>  		do_div(c, 1000000000);
>  		if (c < PERIOD_PERIOD_MAX)
>  			break;
>  		div++;
> -		if (div > PERIOD_CDIV_MAX)
> +		if (div >=3D PERIOD_CDIV_MAX)
>  			return -EINVAL;
>  	}
> =20
> --=20
> 1.7.10.4
>=20

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU5IFrAAoJEN0jrNd/PrOhnNUP/RPWkbvUX7zNnCpp8LiCdZ1l
r0u2plMOwxt1edvm/vWoCXZpOftQ3y968dpe2/pZur7gIpTutnyzWkxmXPk+MIwz
O4gviB+kYgkWE4y5tBN+xKOvd9qpwqVxtmsrQmZkc+/8r1H00l9B8Uy+U+yulRpS
+L6JRv5QFvLqcbD8ae33Oivl+EUnuz6frvviXIXbzUuO3iqVjqsGUSR8ZVzdsryn
aPteLv6dYlHf1ty5wlNvUpDArdMZPRjUopMTlewqQhAvgD/FaZSQ9RWormABa4v3
iSNmgNtSDTI4LseeVj/BtrQ/5jNDCs2vLiuXCsGMS77+JcztoUdbOyDjPPqtI2zo
DphD9jOw97lISGJf9VHg1u7r8iZgohvqpZbLXwybCCzVfevspP5ocdtJSKt2mJCl
I1u7e/sl4zmO5TX0H44+fam+gEQ5XWdE4ZtkzMXx0v5+aCXUVxiAOUyj94b3qdPV
KhH7Dcj0tA4evG6e0sKNB6cD0GyPJQyloYRjUQ0hhqgNk9UoBrPPp5VCmK0kmoaP
lFWlOoWk5nTz3L8qIrhaE8BrM5qSEHf289x8S5EVcl1lPrYlsrJMbHnYFVxwMGAW
2DV9qLFTjo2B6ToB1izbLDOYwiYhoQXvHtrMmYPDWgPlpI+RFqVYgGEnGlxdPwk7
4qSd1pMWemvSXA7Abehs
=yS8S
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
