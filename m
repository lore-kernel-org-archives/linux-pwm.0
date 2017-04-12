From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 0/4] pwm: tegra: Pin configuration in suspend/resume
 and cleanups
Date: Wed, 12 Apr 2017 19:18:09 +0200
Message-ID: <20170412171809.GD11964@ulmo.ba.sec>
References: <1491557642-15940-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1491557642-15940-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2017 at 03:03:58PM +0530, Laxman Dewangan wrote:
> This patch series have following fixes:
> - Add more precession in PWM period register value calculation
>   for lower pwm frequency.
> - Add support to configure PWM pins in different state in the
>   suspend/resume.
>=20
> Changes from v1:
> - Use standard pinctrl names for sleep and active state.
> - Use API pinctrl_pm_select_*()
>=20
> Changes from V2:
> - Type fixes, rephrases commit message and use pinctrl_pm_state* return
>   value.
>=20
> Laxman Dewangan (4):
>   pwm: tegra: Use DIV_ROUND_CLOSEST_ULL() instead of local
>     implementation
>   pwm: tegra: Increase precision in pwm rate calculation
>   pwm: tegra: Add DT binding details to configure pin in suspends/resume
>   pwm: tegra: Add support to configure pin state in suspends/resume
>=20
>  .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 43 ++++++++++++
>  drivers/pwm/pwm-tegra.c                            | 77 ++++++++++++++++=
++++--
>  2 files changed, 116 insertions(+), 4 deletions(-)

All four patches applied to for-4.12/drivers, thanks.

I've slightly modified the commit messages of some patches for "pwm" ->
"PWM".

Thierry

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljuYVEACgkQ3SOs138+
s6F8MBAAl3Zxu6de9n5t/fSnwQe7lTmHLAskvAnvVA3AY6aPBfO9Yz+g4wOFxQ/6
MW+PEiKReT7xKFsb+y8XILtmfXiOJ7ZfpvioZ3iM8AMQ3Oh0WBY5hN1kwt2QS4uY
61NSwJ8IkyZCstWRY/nmwx45al6Ub3p1GTwc/5WW/Cztydz3M4LG9efZfydyczez
cL2G1bTxauB6duvrEqaYullUF2ucaFxiq0nO3RKQwtovF0inM/bfno6M/LFrEXpp
Vj6eb+DE+t2a4j3VpV1iqvy4BKvzvUWyESNFk3ENVk4NqOprOJHxTvk5nj2nWBXu
BSf3IrFJRYUT7KyB42LZyJoWhSCICLej+B+Jm9yuMzt7JM7d/2Ob/WDNbkZp+POO
gmAAps/1mxoFdTi2Y+J6L6LUOrDq/KG2joboBzL2beBxWZFvVrcWy2DkiNp51V4x
GrBcdr1LGONhAWk6doDaHs3gl3W4xLqjyTQS8XA87x714l94D4XP/Sh07LCnUObT
h2/F+4ZDDGFC0WpliTdtLY/bffV1OUFUlW3jf9V79avkj6sl5NlMkJ6QltiVztuu
OasyAdfjzKyJ609wL3QDq5LAC8u1MQQ8vWz+PtPphvnDek1cmG7nwaxKEDJvoGmc
3HR4dycNsLIOvj9Goww5t5fRqEix3S1ssDa2DBq3Xg5ZqnoZJX4=
=g9Fr
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
