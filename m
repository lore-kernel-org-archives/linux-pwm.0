From: Shenwei Wang <shenwei.wang@nxp.com>
Subject: RE: [PATCH 1/1] pwm: fsl-ftm: Support the new version of FTM block on
 i.MX8x
Date: Wed, 6 Jun 2018 15:57:57 +0000
Message-ID: <HE1PR04MB3289F832BAC9F430241E394E89650@HE1PR04MB3289.eurprd04.prod.outlook.com>
References: <20180524180848.61844-1-shenwei.wang@nxp.com>
 <20180606083423.GE11810@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606083423.GE11810@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

Thank you for the detailed review. I was intending to avoid adding a new co=
mpatible string, and to limit the changes. But your comments make sense, an=
d I will split the commit and use the compatible string to identify the IP =
differences.

Thanks,
Shenwei

-----Original Message-----
From: Thierry Reding [mailto:thierry.reding@gmail.com]=20
Sent: Wednesday, June 6, 2018 3:34 AM
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: linux-pwm@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; linux-kern=
el@vger.kernel.org
Subject: Re: [PATCH 1/1] pwm: fsl-ftm: Support the new version of FTM block=
 on i.MX8x

On Thu, May 24, 2018 at 01:08:48PM -0500, shenwei.wang@nxp.com wrote:
> On the new i.MX8x SoC family, the following changes were made on the=20
> FTM
> block:
>=20
> 1. Need to enable the IPG clock before accessing any FTM registers.=20
> Because the IPG clock is not an option for FTM counter clock source,=20
> it can't be used as the ftm_sys clock.
>=20
> 2. An additional PWM enable bit was added for each PWM channel in=20
> register FTM_SC[16:23]. It supports 8 channels. Bit16 is for channel=20
> 0, and bit23 for channel 7.

Generally if you need to itemize changes in your commit message it is a goo=
d indication that you should be splitting up the patch into multiple logica=
l changes. In this case, one possibility would be to turn this into three p=
atches:

	1. Introduce the concept on an "interface" clock which is by
	   default the same as the ftm_sys clock.

	2. Add support for enable bits, based on some per-compatible
	   data structure (see for example pwm-tegra.c for an example of
	   how to do this).

	3. Enable support for the new SoC family by adding an instance
	   of the per-compatible structure for that compatible string.

> As the IP version information can not be obtained in any of the FTM=20
> registers, a property of "fsl,has-pwmen-bits" is added in the ftm pwm=20
> device node. If it has the property, the driver set the PWM enable bit=20
> when a PWM channel is requested.

I don't see a corresponding device tree bindings update for this change.
Also, I don't think doing this via a separate property is the right way, yo=
u can just derive this from the new compatible string which you need to add=
 anyway.

So to the above patches, add:

	0. Add DT bindings for new SoC family with a mention that they
	   need to provide the new IPG clock.

>=20
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  drivers/pwm/pwm-fsl-ftm.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c=20
> index 557b4ea..0426458f 100644
> --- a/drivers/pwm/pwm-fsl-ftm.c
> +++ b/drivers/pwm/pwm-fsl-ftm.c
> @@ -86,7 +86,9 @@ struct fsl_pwm_chip {
>  	struct regmap *regmap;
> =20
>  	int period_ns;
> +	bool has_pwmen;
> =20
> +	struct clk *ipg_clk;
>  	struct clk *clk[FSL_PWM_CLK_MAX];
>  };
> =20
> @@ -97,16 +99,31 @@ static inline struct fsl_pwm_chip=20
> *to_fsl_chip(struct pwm_chip *chip)
> =20
>  static int fsl_pwm_request(struct pwm_chip *chip, struct pwm_device=20
> *pwm)  {
> +	int ret;
>  	struct fsl_pwm_chip *fpc =3D to_fsl_chip(chip);
> =20
> -	return clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
> +	ret =3D clk_prepare_enable(fpc->ipg_clk);

This is confusing because it looks as if you're breaking existing drivers, =
until you realize that...

> +
> +	if ((!ret) && (fpc->has_pwmen)) {
> +		mutex_lock(&fpc->lock);
> +		regmap_update_bits(fpc->regmap, FTM_SC,
> +				BIT(pwm->hwpwm + 16), BIT(pwm->hwpwm + 16));
> +		mutex_unlock(&fpc->lock);
> +	}
> +
> +	return ret;
>  }
> =20
>  static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device=20
> *pwm)  {
>  	struct fsl_pwm_chip *fpc =3D to_fsl_chip(chip);
> =20
> -	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
> +	if (fpc->has_pwmen) {
> +		mutex_lock(&fpc->lock);
> +		regmap_update_bits(fpc->regmap, FTM_SC, BIT(pwm->hwpwm + 16), 0);
> +		mutex_unlock(&fpc->lock);
> +	}
> +	clk_disable_unprepare(fpc->ipg_clk);
>  }
> =20
>  static int fsl_pwm_calculate_default_ps(struct fsl_pwm_chip *fpc, @@=20
> -363,7 +380,7 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)  {
>  	int ret;
> =20
> -	ret =3D clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
> +	ret =3D clk_prepare_enable(fpc->ipg_clk);
>  	if (ret)
>  		return ret;
> =20
> @@ -371,7 +388,7 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)
>  	regmap_write(fpc->regmap, FTM_OUTINIT, 0x00);
>  	regmap_write(fpc->regmap, FTM_OUTMASK, 0xFF);
> =20
> -	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
> +	clk_disable_unprepare(fpc->ipg_clk);
> =20
>  	return 0;
>  }
> @@ -428,6 +445,10 @@ static int fsl_pwm_probe(struct platform_device *pde=
v)
>  		return PTR_ERR(fpc->clk[FSL_PWM_CLK_SYS]);
>  	}
> =20
> +	fpc->ipg_clk =3D devm_clk_get(&pdev->dev, "ipg");
> +	if (IS_ERR(fpc->ipg_clk))
> +		fpc->ipg_clk =3D fpc->clk[FSL_PWM_CLK_SYS];

... fpc->ipg_clk is actually the same as fpc->clk[FSL_PWM_CLK_SYS] for olde=
r chips. I think this could be made more obvious by splitting this patch in=
to several smaller ones as suggested above.

> +
>  	fpc->clk[FSL_PWM_CLK_FIX] =3D devm_clk_get(fpc->chip.dev, "ftm_fix");
>  	if (IS_ERR(fpc->clk[FSL_PWM_CLK_FIX]))
>  		return PTR_ERR(fpc->clk[FSL_PWM_CLK_FIX]);
> @@ -446,6 +467,8 @@ static int fsl_pwm_probe(struct platform_device *pdev=
)
>  	fpc->chip.of_pwm_n_cells =3D 3;
>  	fpc->chip.base =3D -1;
>  	fpc->chip.npwm =3D 8;
> +	fpc->has_pwmen =3D of_property_read_bool(pdev->dev.of_node,
> +						"fsl,ftm-has-pwmen-bits");

As I said earlier, I think this should be derived from the compatible strin=
g. That is, you could have a data structure such as:

	struct fsl_pwm_soc {
		bool has_enable_bits;
	};

	static const struct fsl_pwm_soc vf610_ftm_pwm =3D {
		.has_enable_bits =3D false,
	};

	/* up to here would be part of patch 2 */

	/* and this is part of patch 3, along with an entry in the OF
	 * match table */
	static const struct fsl_pwm_soc imx8x_ftm_pwm =3D {
		.has_enable_bits =3D true,
	};

Thierry
