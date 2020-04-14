From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: Add missing '\n' in log messages
Date: Tue, 14 Apr 2020 15:58:27 +0200
Message-ID: <20200414135827.GB3593749@ulmo>
References: <20200411153528.30130-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200411153528.30130-1-christophe.jaillet@wanadoo.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2020 at 05:35:28PM +0200, Christophe JAILLET wrote:
> Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.
>=20
> Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/pwm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 9973c442b455..bca04965bfe6 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -537,7 +537,7 @@ static void pwm_apply_state_debug(struct pwm_device *=
pwm,
> =20
>  	if (!state->enabled && s2.enabled && s2.duty_cycle > 0)
>  		dev_warn(chip->dev,
> -			 "requested disabled, but yielded enabled with duty > 0");
> +			 "requested disabled, but yielded enabled with duty > 0\n");
> =20
>  	/* reapply the state that the driver reported being configured. */
>  	err =3D chip->ops->apply(chip, pwm, &s1);

I don't think this is strictly necessary any longer since the logging
functions are supposed to add these themselves nowadays. But I like the
consistency of this, so I'll apply this anyway.

Thanks,
Thierry

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6VwYMACgkQ3SOs138+
s6Fzlg//b9ON8vAP4sRTnLHsUC0mCmY2XcrY0P5eCKvrjAivAAswf7qGNpzKcBN1
FUzY74P+qLClXRXFcciVxdGCaPzb+dynFkizSZC5wqBathkkFK3WMAjfFkjH2fe5
2pLX7gpMvlrlneBVM52ZrR2KK4fAonlQe7Xq07vKQ6K8stWmQblhGZNKXlCaK4fi
gkzWQKzHvWML6Bzu5Zrk21Z/BxPeT4gHl0jxo3ZnsHhv1ZveNkDHDLB1ybDjTaEj
p+faT8bCf4bSPp8OlpnJpP6d0yzAxcDO6gDRCEH/jaBUaZDkHEgjsSDxkL5H+lkp
s8N/kJ9q+0qSivxQyFLPTGyUoUm5C/xkT81UrwWEQMbouN7FVBelXVs9SLKfUSbA
noAYtOMxz8V4AxtUNniYyzo1ir8gqB4kZTUmr+cn0mP68WJHvmTHe/ElmC/bn8uK
N92cuJnV0s4A+5SrPi4mDpLA4FP8m2MBAsEDKd5j1tPfBY7HrHgdgZkNxSIiehNQ
+5rzl2LyBfx8rnz/Ljw02TpgJX/pNELNrM/Oa4jy3QoDiIlaUpoL5/d9QrIbt71d
UlGep4cyvSvRlsY0CZDJhABtsjb6zLix/Rc6x0jCL45rwGVLilLbKgoHedCEllvu
ueo5JO9bxbeHxPi+II1uGQ07LNd3TJyRZMVjSggpscDcfmfJCTc=
=cwju
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
