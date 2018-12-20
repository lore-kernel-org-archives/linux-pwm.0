Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37960 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbeLTRZI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Dec 2018 12:25:08 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so2415299ede.5
        for <linux-pwm@vger.kernel.org>; Thu, 20 Dec 2018 09:25:06 -0800 (PST)
Date: Thu, 20 Dec 2018 18:25:04 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20181220172504.GB9408@ulmo>
References: <20181219103925.28360-1-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <20181219103925.28360-1-shc_work@mail.ru>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 1/2] pwm: clps711x: Fix period calculation
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-pwm@vger.kernel.org


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 19, 2018 at 01:39:24PM +0300, Alexander Shiyan wrote:
> Commit e39c0df1be5a ("pwm: Introduce the pwm_args concept") has
> changed the variable for the period for clps711x-pwm driver, so now
> pwm_get/set_period() works with pwm->state.period variable instead
> of pwm->args.period.
> This patch changes the period variable in other places where it is used.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/pwm/pwm-clps711x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> index 26ec24e457b1..7e16b7def0dc 100644
> --- a/drivers/pwm/pwm-clps711x.c
> +++ b/drivers/pwm/pwm-clps711x.c
> @@ -48,7 +48,7 @@ static void clps711x_pwm_update_val(struct clps711x_chi=
p *priv, u32 n, u32 v)
>  static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned i=
nt v)
>  {
>  	/* Duty cycle 0..15 max */
> -	return DIV_ROUND_CLOSEST(v * 0xf, pwm_get_period(pwm));
> +	return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
>  }
> =20
>  static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device=
 *pwm)
> @@ -71,7 +71,7 @@ static int clps711x_pwm_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  	struct clps711x_chip *priv =3D to_clps711x_chip(chip);
>  	unsigned int duty;
> =20
> -	if (period_ns !=3D pwm_get_period(pwm))
> +	if (period_ns !=3D pwm->args.period)
>  		return -EINVAL;
> =20
>  	duty =3D clps711x_get_duty(pwm, duty_ns);

Applied, thanks.

Thierry

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwb0HAACgkQ3SOs138+
s6HRQhAAiFCy2TGUtSoBTTNuJ2EGfxKdeOQpdlieqoJiysg/kbKQDtFUFT5zc3sZ
u5TKCGIGP8hVIjT3lOtTyezgaxggTnc1cArtqquTEcPEmeZLSFTjAPLywM9r4pVf
evrF2zc6Ym9bkRBQWlB8ukJM30B/G1ZZ8072bBnKXLVkPoU03+JuAF22XYVUoFP1
X++GDEX7M5FwzkHmJC3Ns4gzFAAYZdw0EDBEZjiKzuQ9gU5xOCGGU3c8zuK/lBVG
dQNMrpNjDkZc7UKpmkl/mASAFCmfHvUBbNRb1qwTbLbBDW0tC6QUpBZCvGh9Raip
a6f/q+PTc58BCdaahjcS8yN2+Nw+WS7MGzKY2yryIOFZq84Qo2jrw+db1UH+Y/Ik
74qdlTsjQWQe/4gJWHoqHLebwNq+d2nduH6n6qe7vMaOkxXGoYFaOErSmEjvVP1d
8wQxgUJE8IOFP6t3Iz5Km6jts1uj6YH7oZujCJX+jdrImMbQjA8ce6EVsHuIkM+v
qbd4DCjXB7Udd6Zc+8JGQwxz5RSESAgUEALboNu6hEAcuWjjUpMg0ctcg0mneGwW
U906ydqroPRrQz8Gqa83Qc0QnnUB0yFXNYeRlwK27TJ9+sOiCoYR3psYYHqYtqKP
9jF3Umm7PhtoUapLrlyYgtMm3erYQ2wZVtzSCG6ZnYKpC66tBI8=
=/4yg
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
