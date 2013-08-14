Date: Wed, 14 Aug 2013 11:46:39 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: pwm-tiehrpwm: add missing __iomem annotation
Message-ID: <20130814094639.GF2084@ulmo>
References: <000f01ce8f48$9a60de60$cf229b20$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xkXJwpr35CY/Lc3I"
Content-Disposition: inline
In-Reply-To: <000f01ce8f48$9a60de60$cf229b20$@samsung.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Thierry Reding' <thierry.reding@avionic-design.de>, linux-pwm@vger.kernel.org


--xkXJwpr35CY/Lc3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2013 at 03:22:03PM +0900, Jingoo Han wrote:
> Fix the following sparse warnings:
>=20
> drivers/pwm/pwm-tiehrpwm.c:144:16: warning: incorrect type in argument 1 =
(different address spaces)
> drivers/pwm/pwm-tiehrpwm.c:144:16:    expected void const volatile [noder=
ef] <asn:2>*addr
> drivers/pwm/pwm-tiehrpwm.c:144:16:    got void *
> drivers/pwm/pwm-tiehrpwm.c:149:9: warning: incorrect type in argument 2 (=
different address spaces)
> drivers/pwm/pwm-tiehrpwm.c:149:9:    expected void volatile [noderef] <as=
n:2>*addr
> drivers/pwm/pwm-tiehrpwm.c:149:9:    got void *
> drivers/pwm/pwm-tiehrpwm.c:157:18: warning: incorrect type in argument 1 =
(different address spaces)
> drivers/pwm/pwm-tiehrpwm.c:157:18:    expected void const volatile [noder=
ef] <asn:2>*addr
> drivers/pwm/pwm-tiehrpwm.c:157:18:    got void *
> drivers/pwm/pwm-tiehrpwm.c:160:9: warning: incorrect type in argument 2 (=
different address spaces)
> drivers/pwm/pwm-tiehrpwm.c:160:9:    expected void volatile [noderef] <as=
n:2>*addr
> drivers/pwm/pwm-tiehrpwm.c:160:9:    got void *
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/pwm/pwm-tiehrpwm.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--xkXJwpr35CY/Lc3I
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSC1H/AAoJEN0jrNd/PrOhriIQALZapgU2OUiKPtlMhu1ZgEmq
u7jAyxNo6IcKXVJtYSjrCumBo0opFg0Swg9XyBp7lZxA31TvGUnS8yXdHZPXvBju
hYAtDpsgGroP0FC077murcazcpkloO1zVm0fjHnpSm1GpJCX39Y7rqSDC4VWQ3nr
Zgi3PrPDJctVnCZDepJrCkk285TuvcO+JE9rYKvzT3uTpkux7oVYQMd5tIBHvrjp
mMfmrVe36SYGh0MIVl7zsQkKVuwGW9dJDE46g4vhWaT4kSXE6KlS2A+p7vaqlMkw
amvLqApbHl94+M6QDqNzeKeqztwjjNLii/L6S1R/U20ss1L6J+a6ufTvhDc4bTsb
Wh2J3QjLmoG/1DlXU4g5WdELOg+JD9JJB03K8cIFHYktyw1gnL7pMUXZm67FDNA9
0i7zNz0BVFDpu1loRyeiQZTTQRBobs1x4D93v9u+UWUsHDElGXZLoXQZEhcptvX6
XXlEv5i5UPh+8vUcE9hz8e3U8D5ABDCGgODby9LFCApjdhXnUj2Ir9zzv8q+Gfhd
Mx5YvSg9mYbTNnUrmogdYQS4m4avHmLXNP84DBK47adbxFGlZ0uVnmRrKHE0qS24
PFcRtrp4WDi5hfLbBs2T44m+ruaI2e3e3hOGdE5LhSVvaDVwXsLFqxh/Mhx/7DH2
i2XBVXMDPk3qBdJMLC0v
=nkik
-----END PGP SIGNATURE-----

--xkXJwpr35CY/Lc3I--
