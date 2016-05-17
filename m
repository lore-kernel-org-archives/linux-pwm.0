From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: Fill pwm->args before calling
 pwm_request_from_chip()
Date: Tue, 17 May 2016 13:04:38 +0200
Message-ID: <20160517110438.GB26166@ulmo.ba.sec>
References: <1463481333-23438-1-git-send-email-boris.brezillon@free-electrons.com>
 <1463481333-23438-2-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33693 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbcEQLEl (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2016 07:04:41 -0400
Content-Disposition: inline
In-Reply-To: <1463481333-23438-2-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Mika =?utf-8?B?UGVudHRpbMOk?= <mika.penttila@nextfour.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 17, 2016 at 12:35:33PM +0200, Boris Brezillon wrote:
[...]
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 427142d..3d2eeaa 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -143,10 +143,6 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const s=
truct of_phandle_args *args)
>  	if (args->args[0] >=3D pc->npwm)
>  		return ERR_PTR(-EINVAL);
> =20
> -	pwm =3D pwm_request_from_chip(pc, args->args[0], NULL);
> -	if (IS_ERR(pwm))
> -		return pwm;
> -
>  	pwm->args.period =3D args->args[1];
> =20
>  	if (args->args[2] & PWM_POLARITY_INVERTED)
> @@ -154,6 +150,10 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const s=
truct of_phandle_args *args)
>  	else
>  		pwm->args.polarity =3D PWM_POLARITY_NORMAL;
> =20
> +	pwm =3D pwm_request_from_chip(pc, args->args[0], NULL);
> +	if (IS_ERR(pwm))
> +		return pwm;
> +

Can't do that, because now you're dereferencing an uninitialized
pointer.

>  	return pwm;
>  }
>  EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
> @@ -169,12 +169,12 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const stru=
ct of_phandle_args *args)
>  	if (args->args[0] >=3D pc->npwm)
>  		return ERR_PTR(-EINVAL);
> =20
> +	pwm->args.period =3D args->args[1];

Same here.

> diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
> index 58b709f..c33bd42 100644
> --- a/drivers/pwm/pwm-pxa.c
> +++ b/drivers/pwm/pwm-pxa.c
> @@ -156,12 +156,12 @@ pxa_pwm_of_xlate(struct pwm_chip *pc, const struct =
of_phandle_args *args)
>  {
>  	struct pwm_device *pwm;
> =20
> +	pwm->args.period =3D args->args[0];

And here.

Thierry

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXOvrGAAoJEN0jrNd/PrOh9DgQAIHtY11nMdOC7RsDDItufkun
lPe/ybCfxGipO3U5FI1nT3aCjuw1Le/qvB75na4aDwtgtbwB68Azf4nXHuJ1vZPo
fOLQykhtgcDR/0qCbmav4Jr+El4uQYsR5xHHwV1cjcTg4ntUNCnV+GJRhFOnIPKG
2TTIyvrZli4CDLd2smu+keDTNh0Exq0q7O8SrTpSFNyYVU9i3T5NSkl+x31CITjN
jj72549CmkMW4LMeZKEMjoIRB+TNo1A3RuQHFvv6QJPQHbVNW8XWjL9bpBhy/Jie
Hdd6AvHCF+kU8OrlzO+sJlioye/gKefkimzs3Lj9zn667UWkTeSMLWLtUSvWse5t
km2hMu71LgGWNe/wHqqzg6Ga4kqkhbuNF0yh56AEfotRr4Akv8FBQzT3L2ar6B0j
7fP0R0f5VQcSNUj5svIZ6Sx+J6OcAqDLPmB76Q7r1hxlgXKILN8QxNVVVZfD4gZR
S7RGN0xhJYs5CDUsMr8paNTbA7CtpkKr6PRPVWoP4nVKHZAOs8hiczLgCtTNosYL
vcIKJ0QepA77qtlV6c6ld/Q2jckz5WhN28pWyWoXdr0Y0EtGe4uuGX5PeT+7D9zJ
HYMeRk9iiM8zcXimqcClzOAlo0o9I9cpb2ACIPSJRkgjXut+urJR5aWhKN9O4sSE
hczGVfFL40JpaK8Ruzbc
=FzS3
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
