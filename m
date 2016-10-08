From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v3 3/6] pwm: imx: support output polarity inversion
Date: Sat, 8 Oct 2016 16:32:46 +0200
Message-ID: <20161008163246.4bee7896@jawa>
References: <20161007151129.6043-1-bhuvanchandra.dv@toradex.com>
 <20161007151129.6043-4-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9187616357314864168=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161007151129.6043-4-bhuvanchandra.dv@toradex.com>
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
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, l.majewski@samsung.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, stefan@agner.ch, robh+dt@kernel.org, thierry.reding@gmail.com, kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, Lothar Wassmann <LW@KARO-electronics.de>
List-Id: linux-pwm@vger.kernel.org

--===============9187616357314864168==
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/i27Q0vE5TeaTVHJ5lreCttG"; protocol="application/pgp-signature"

--Sig_/i27Q0vE5TeaTVHJ5lreCttG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Bhuvanchandra,

> From: Lothar Wassmann <LW@KARO-electronics.de>
>=20
> The i.MX pwm unit on i.MX27 and newer SoCs provides a configurable
> output polarity. This patch adds support to utilize this feature
> where available.
>=20
> Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

I've tested those patches on my iMX6q board on top of v4.7 linux kernel.

Tested-by: Lukasz Majewski <l.majewski@majess.pl>

Best regards,
=C5=81ukasz Majewski

> ---
>  Documentation/devicetree/bindings/pwm/imx-pwm.txt |  6 +--
>  drivers/pwm/pwm-imx.c                             | 51
> +++++++++++++++++++++-- 2 files changed, 51 insertions(+), 6
> deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> b/Documentation/devicetree/bindings/pwm/imx-pwm.txt index
> e00c2e9..c61bdf8 100644 ---
> a/Documentation/devicetree/bindings/pwm/imx-pwm.txt +++
> b/Documentation/devicetree/bindings/pwm/imx-pwm.txt @@ -6,8 +6,8 @@
> Required properties:
>    - "fsl,imx1-pwm" for PWM compatible with the one integrated on
> i.MX1
>    - "fsl,imx27-pwm" for PWM compatible with the one integrated on
> i.MX27
>  - reg: physical base address and length of the controller's registers
> -- #pwm-cells: should be 2. See pwm.txt in this directory for a
> description of
> -  the cells format.
> +- #pwm-cells: 2 for i.MX1 and 3 for i.MX27 and newer SoCs. See
> pwm.txt
> +  in this directory for a description of the cells format.
>  - clocks : Clock specifiers for both ipg and per clocks.
>  - clock-names : Clock names should include both "ipg" and "per"
>  See the clock consumer binding,
> @@ -17,7 +17,7 @@ See the clock consumer binding,
>  Example:
> =20
>  pwm1: pwm@53fb4000 {
> -	#pwm-cells =3D <2>;
> +	#pwm-cells =3D <3>;
>  	compatible =3D "fsl,imx53-pwm", "fsl,imx27-pwm";
>  	reg =3D <0x53fb4000 0x4000>;
>  	clocks =3D <&clks IMX5_CLK_PWM1_IPG_GATE>,
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index d600fd5..c37d223 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -38,6 +38,7 @@
>  #define MX3_PWMCR_DOZEEN		(1 << 24)
>  #define MX3_PWMCR_WAITEN		(1 << 23)
>  #define MX3_PWMCR_DBGEN			(1 << 22)
> +#define MX3_PWMCR_POUTC			(1 << 18)
>  #define MX3_PWMCR_CLKSRC_IPG_HIGH	(2 << 16)
>  #define MX3_PWMCR_CLKSRC_IPG		(1 << 16)
>  #define MX3_PWMCR_SWR			(1 << 3)
> @@ -180,6 +181,9 @@ static int imx_pwm_config_v2(struct pwm_chip
> *chip, if (enable)
>  		cr |=3D MX3_PWMCR_EN;
> =20
> +	if (pwm->args.polarity =3D=3D PWM_POLARITY_INVERSED)
> +		cr |=3D MX3_PWMCR_POUTC;
> +
>  	writel(cr, imx->mmio_base + MX3_PWMCR);
> =20
>  	return 0;
> @@ -240,27 +244,62 @@ static void imx_pwm_disable(struct pwm_chip
> *chip, struct pwm_device *pwm) clk_disable_unprepare(imx->clk_per);
>  }
> =20
> -static struct pwm_ops imx_pwm_ops =3D {
> +static int imx_pwm_set_polarity(struct pwm_chip *chip, struct
> pwm_device *pwm,
> +				enum pwm_polarity polarity)
> +{
> +	struct imx_chip *imx =3D to_imx_chip(chip);
> +	u32 val;
> +
> +	if (polarity =3D=3D pwm->args.polarity)
> +		return 0;
> +
> +	val =3D readl(imx->mmio_base + MX3_PWMCR);
> +
> +	if (polarity =3D=3D PWM_POLARITY_INVERSED)
> +		val |=3D MX3_PWMCR_POUTC;
> +	else
> +		val &=3D ~MX3_PWMCR_POUTC;
> +
> +	writel(val, imx->mmio_base + MX3_PWMCR);
> +
> +	dev_dbg(imx->chip.dev, "%s: polarity set to %s\n", __func__,
> +		polarity =3D=3D PWM_POLARITY_INVERSED ? "inverted" :
> "normal"); +
> +	return 0;
> +}
> +
> +static struct pwm_ops imx_pwm_ops_v1 =3D {
>  	.enable =3D imx_pwm_enable,
>  	.disable =3D imx_pwm_disable,
>  	.config =3D imx_pwm_config,
>  	.owner =3D THIS_MODULE,
>  };
> =20
> +static struct pwm_ops imx_pwm_ops_v2 =3D {
> +	.enable =3D imx_pwm_enable,
> +	.disable =3D imx_pwm_disable,
> +	.set_polarity =3D imx_pwm_set_polarity,
> +	.config =3D imx_pwm_config,
> +	.owner =3D THIS_MODULE,
> +};
> +
>  struct imx_pwm_data {
>  	int (*config)(struct pwm_chip *chip,
>  		struct pwm_device *pwm, int duty_ns, int period_ns);
>  	void (*set_enable)(struct pwm_chip *chip, bool enable);
> +	struct pwm_ops *pwm_ops;
>  };
> =20
>  static struct imx_pwm_data imx_pwm_data_v1 =3D {
>  	.config =3D imx_pwm_config_v1,
>  	.set_enable =3D imx_pwm_set_enable_v1,
> +	.pwm_ops =3D &imx_pwm_ops_v1,
>  };
> =20
>  static struct imx_pwm_data imx_pwm_data_v2 =3D {
>  	.config =3D imx_pwm_config_v2,
>  	.set_enable =3D imx_pwm_set_enable_v2,
> +	.pwm_ops =3D &imx_pwm_ops_v2,
>  };
> =20
>  static const struct of_device_id imx_pwm_dt_ids[] =3D {
> @@ -282,6 +321,8 @@ static int imx_pwm_probe(struct platform_device
> *pdev) if (!of_id)
>  		return -ENODEV;
> =20
> +	data =3D of_id->data;
> +
>  	imx =3D devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
>  	if (imx =3D=3D NULL)
>  		return -ENOMEM;
> @@ -300,18 +341,22 @@ static int imx_pwm_probe(struct platform_device
> *pdev) return PTR_ERR(imx->clk_ipg);
>  	}
> =20
> -	imx->chip.ops =3D &imx_pwm_ops;
> +	imx->chip.ops =3D data->pwm_ops;
>  	imx->chip.dev =3D &pdev->dev;
>  	imx->chip.base =3D -1;
>  	imx->chip.npwm =3D 1;
>  	imx->chip.can_sleep =3D true;
> +	if (data->pwm_ops->set_polarity) {
> +		dev_dbg(&pdev->dev, "PWM supports output
> inversion\n");
> +		imx->chip.of_xlate =3D of_pwm_xlate_with_flags;
> +		imx->chip.of_pwm_n_cells =3D 3;
> +	}
> =20
>  	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	imx->mmio_base =3D devm_ioremap_resource(&pdev->dev, r);
>  	if (IS_ERR(imx->mmio_base))
>  		return PTR_ERR(imx->mmio_base);
> =20
> -	data =3D of_id->data;
>  	imx->config =3D data->config;
>  	imx->set_enable =3D data->set_enable;
> =20


--Sig_/i27Q0vE5TeaTVHJ5lreCttG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlf5A5UACgkQf9/hG2YwgjHaxQCgxzf/zgR2N8VO6L33Tr0QgUt1
g7MAoLdHNCiSsJxvGBqHlodqwGNVzZf4
=mYA2
-----END PGP SIGNATURE-----

--Sig_/i27Q0vE5TeaTVHJ5lreCttG--


--===============9187616357314864168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9187616357314864168==--
