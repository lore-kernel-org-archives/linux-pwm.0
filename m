From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 2/3] pwm: stm32: split breakinput apply routine to
 ease PM support
Date: Wed, 16 Oct 2019 09:03:22 +0200
Message-ID: <20191016070322.GB1296874@ulmo>
References: <1570193633-6600-1-git-send-email-fabrice.gasnier@st.com>
 <1570193633-6600-3-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1570193633-6600-3-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: robh+dt@kernel.org, u.kleine-koenig@pengutronix.de, alexandre.torgue@st.com, mark.rutland@arm.com, mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, benjamin.gaignard@st.com, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2019 at 02:53:52PM +0200, Fabrice Gasnier wrote:
> Split breakinput routine that configures STM32 timers 'break' safety
> feature upon probe, into two routines:
> - stm32_pwm_apply_breakinputs() sets all the break inputs into registers.
> - stm32_pwm_probe_breakinputs() probes the device tree break input settin=
gs
>   before calling stm32_pwm_apply_breakinputs()
>=20
> This is a precursor patch to ease PM support. Registers content may get
> lost during low power. So, break input settings applied upon probe need
> to be restored upon resume (e.g. by calling stm32_pwm_apply_breakinputs()=
).
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/pwm-stm32.c | 48 ++++++++++++++++++++++++++++---------------=
-----
>  1 file changed, 28 insertions(+), 20 deletions(-)

Applied, thanks. I've made some minor changes, mostly for consistency
with other drivers and the PWM core. See below.

> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 359b085..cf8658c 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -19,6 +19,12 @@
>  #define CCMR_CHANNEL_MASK  0xFF
>  #define MAX_BREAKINPUT 2
> =20
> +struct stm32_breakinput {
> +	u32 index;
> +	u32 level;
> +	u32 filter;
> +};
> +
>  struct stm32_pwm {
>  	struct pwm_chip chip;
>  	struct mutex lock; /* protect pwm config/enable */
> @@ -26,15 +32,11 @@ struct stm32_pwm {
>  	struct regmap *regmap;
>  	u32 max_arr;
>  	bool have_complementary_output;
> +	struct stm32_breakinput breakinput[MAX_BREAKINPUT];
> +	unsigned int nbreakinput;

I changed these to breakinputs and num_breakinputs since they are
slightly more consistent with the naming elsewhere in PWM.

>  	u32 capture[4] ____cacheline_aligned; /* DMA'able buffer */
>  };
> =20
> -struct stm32_breakinput {
> -	u32 index;
> -	u32 level;
> -	u32 filter;
> -};
> -
>  static inline struct stm32_pwm *to_stm32_pwm_dev(struct pwm_chip *chip)
>  {
>  	return container_of(chip, struct stm32_pwm, chip);
> @@ -512,15 +514,27 @@ static int stm32_pwm_set_breakinput(struct stm32_pw=
m *priv,
>  	return (bdtr & bke) ? 0 : -EINVAL;
>  }
> =20
> -static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv,
> +static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv)
> +{
> +	int i, ret =3D 0;

Made i unsigned int.

> +
> +	for (i =3D 0; i < priv->nbreakinput && !ret; i++) {
> +		ret =3D stm32_pwm_set_breakinput(priv,
> +					       priv->breakinput[i].index,
> +					       priv->breakinput[i].level,
> +					       priv->breakinput[i].filter);
> +	}

I thought this was a little odd, so I changed it to explicitly check the
value of ret and return on error.

> +
> +	return ret;

And then this became "return 0;"

> +}
> +
> +static int stm32_pwm_probe_breakinputs(struct stm32_pwm *priv,
>  				       struct device_node *np)
>  {
> -	struct stm32_breakinput breakinput[MAX_BREAKINPUT];
> -	int nb, ret, i, array_size;
> +	int nb, ret, array_size;
> =20
>  	nb =3D of_property_count_elems_of_size(np, "st,breakinput",
>  					     sizeof(struct stm32_breakinput));
> -

Dropped this since it made the code look cluttered.

Thierry

>  	/*
>  	 * Because "st,breakinput" parameter is optional do not make probe
>  	 * failed if it doesn't exist.
> @@ -531,20 +545,14 @@ static int stm32_pwm_apply_breakinputs(struct stm32=
_pwm *priv,
>  	if (nb > MAX_BREAKINPUT)
>  		return -EINVAL;
> =20
> +	priv->nbreakinput =3D nb;
>  	array_size =3D nb * sizeof(struct stm32_breakinput) / sizeof(u32);
>  	ret =3D of_property_read_u32_array(np, "st,breakinput",
> -					 (u32 *)breakinput, array_size);
> +					 (u32 *)priv->breakinput, array_size);
>  	if (ret)
>  		return ret;
> =20
> -	for (i =3D 0; i < nb && !ret; i++) {
> -		ret =3D stm32_pwm_set_breakinput(priv,
> -					       breakinput[i].index,
> -					       breakinput[i].level,
> -					       breakinput[i].filter);
> -	}
> -
> -	return ret;
> +	return stm32_pwm_apply_breakinputs(priv);
>  }
> =20
>  static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
> @@ -614,7 +622,7 @@ static int stm32_pwm_probe(struct platform_device *pd=
ev)
>  	if (!priv->regmap || !priv->clk)
>  		return -EINVAL;
> =20
> -	ret =3D stm32_pwm_apply_breakinputs(priv, np);
> +	ret =3D stm32_pwm_probe_breakinputs(priv, np);
>  	if (ret)
>  		return ret;
> =20
> --=20
> 2.7.4
>=20

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2mwLoACgkQ3SOs138+
s6GHWBAAwHNWDi4qqGce8HzLiOPsZ7PV4JSn64OsoS8PfEcGLWagSsNg3JN4vG8S
Hl49Do93zxuquA7pQlxxphQZNfbg4scYnEWZdGN9NPI+HVUiWXxKyKG++k9ZJMR4
KRVmugkh/Qo+sQOAi5qgafxtj42xMnyGj0jp9FNLJ/ZiYAyTabxPalVbLoEOliPX
X3QXW/o9RCcqam/n8vyEj+rsAJj9vdctQJl2q20n3AYH/G6Ku1xbr5htG3aWhWG0
YyvuHEYsTOqo/08TIdbajpkcPzMGh1AjvXwZ6EcNCuM2mGimxv1MH6oWbXyhMO9d
6u2PP3ttwkni+ogoLaYzN7+7/elSNtP10DfThPDvp2SfS4RTOQ/MwJ3DP8+lbNbD
p27zLHY5SE3cSZV8RqXlGQ+IlIPThwG66HJNuLzsfbXCon6OXdzd/sw0s3j8tDwq
V5JEstiS3EDg9mHX7CBH1GWtNm5gYhxMwcWJ5x56yLF/oiHGb+S0MBRjAVjLid9y
JcmXdks8bCk5BieAkfYmhX6Pa3DVHjMrn+DTWfCb/P+J29woIodOkxwVu7IZdWw/
katw5Q+2qtuJsXxmgNUsxVABsaZk7Q9KPo1LNbiz4TsCvttRmRNptxSfC2Je6otM
TSj7eq8zzUcx6GdYGkC6snh+GbHMHn/DyMj+FhmTPdECcsDmiYM=
=ibpm
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
