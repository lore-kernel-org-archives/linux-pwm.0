From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v2 2/6] pwm: core: make the PWM_POLARITY flag in DTB
 optional
Date: Thu, 6 Oct 2016 08:36:42 +0200
Message-ID: <20161006083642.6a28a629@jawa>
References: <20161001101235.24598-1-bhuvanchandra.dv@toradex.com>
 <20161001101235.24598-3-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7845937317426682492=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161001101235.24598-3-bhuvanchandra.dv@toradex.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, l.majewski@samsung.com, linux-kernel@vger.kernel.org, stefan@agner.ch, robh+dt@kernel.org, thierry.reding@gmail.com, kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, Lothar Wassmann <LW@KARO-electronics.de>
List-Id: linux-pwm@vger.kernel.org

--===============7845937317426682492==
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/z_4clVB2B5/iEe7gTi+HZl1"; protocol="application/pgp-signature"

--Sig_/z_4clVB2B5/iEe7gTi+HZl1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Bhuvanchandra,

> From: Lothar Wassmann <LW@KARO-electronics.de>
>=20
> Change the pwm chip driver registration, so that a chip driver that
> supports polarity inversion can still be used with DTBs that don't
> provide the 'PWM_POLARITY' flag.
>=20
> This is done to provide polarity inversion support for the pwm-imx
> driver without having to modify all existing DTS files.
>=20
> Signed-off-by: Lothar Wassmann <LW@KARO-electronics.de>
> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/core.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 195373e..aae8db3 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -137,9 +137,14 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc,
> const struct of_phandle_args *args) {
>  	struct pwm_device *pwm;
> =20
> +	/* check, whether the driver supports a third cell for flags
> */ if (pc->of_pwm_n_cells < 3)
>  		return ERR_PTR(-EINVAL);
> =20
> +	/* flags in the third cell are optional */
> +	if (args->args_count < 2)
> +		return ERR_PTR(-EINVAL);
> +
>  	if (args->args[0] >=3D pc->npwm)
>  		return ERR_PTR(-EINVAL);
> =20
> @@ -149,10 +154,12 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc,
> const struct of_phandle_args *args)=20
>  	pwm->args.period =3D args->args[1];
> =20
> -	if (args->args[2] & PWM_POLARITY_INVERTED)
> -		pwm->args.polarity =3D PWM_POLARITY_INVERSED;
> -	else
> -		pwm->args.polarity =3D PWM_POLARITY_NORMAL;
> +	if (args->args_count > 2) {
> +		if (args->args[2] & PWM_POLARITY_INVERTED)
> +			pwm_set_polarity(pwm, PWM_POLARITY_INVERSED);
			^^^^^^^^^^^^^^^^=20
			here we should set pwm->args.polarity, since
			the pwm_set_polarity() calls pwm_apply_state()
			which requires duty_cycle and period to be set.

			In this particular moment it is not yet set and
			polarity is not properly configured.

Patch fixing this will be sent as a reply to this e-mail. Please just
squash it and test on your platform.

Best regards,
=C5=81ukasz Majewski

> +		else
> +			pwm_set_polarity(pwm, PWM_POLARITY_NORMAL);
> +	}
> =20
>  	return pwm;
>  }
> @@ -163,9 +170,14 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const
> struct of_phandle_args *args) {
>  	struct pwm_device *pwm;
> =20
> +	/* sanity check driver support */
>  	if (pc->of_pwm_n_cells < 2)
>  		return ERR_PTR(-EINVAL);
> =20
> +	/* all cells are required */
> +	if (args->args_count !=3D pc->of_pwm_n_cells)
> +		return ERR_PTR(-EINVAL);
> +
>  	if (args->args[0] >=3D pc->npwm)
>  		return ERR_PTR(-EINVAL);
> =20
> @@ -672,13 +684,6 @@ struct pwm_device *of_pwm_get(struct device_node
> *np, const char *con_id) goto put;
>  	}
> =20
> -	if (args.args_count !=3D pc->of_pwm_n_cells) {
> -		pr_debug("%s: wrong #pwm-cells for %s\n",
> np->full_name,
> -			 args.np->full_name);
> -		pwm =3D ERR_PTR(-EINVAL);
> -		goto put;
> -	}
> -
>  	pwm =3D pc->of_xlate(pc, &args);
>  	if (IS_ERR(pwm))
>  		goto put;


--Sig_/z_4clVB2B5/iEe7gTi+HZl1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlf18QIACgkQf9/hG2YwgjFIAwCgxWv1Jdu5lVt+sf4bUtWKyZKw
Y6MAnik59cgW9r3m4kBg2g2eIFBqphNu
=0bQK
-----END PGP SIGNATURE-----

--Sig_/z_4clVB2B5/iEe7gTi+HZl1--


--===============7845937317426682492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7845937317426682492==--
