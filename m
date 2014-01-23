From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCHv2 2/2] pwm: imx: support polarity inversion
Date: Thu, 23 Jan 2014 08:37:14 +0100
Message-ID: <20140123083714.3c6e86ae@ipc1.ka-ro>
References: <1389859585-14006-1-git-send-email-LW@KARO-electronics.de>
	<1389859585-14006-3-git-send-email-LW@KARO-electronics.de>
	<20140116160356.GY16215@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140116160356.GY16215@pengutronix.de>
Sender: linux-doc-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi,

Sascha Hauer wrote:
> On Thu, Jan 16, 2014 at 09:06:25AM +0100, Lothar Wa=C3=9Fmann wrote:
> > The i.MX PWM controller supports inverting the polarity of the PWM
> > output. Make this feature available in the pxm-imx driver.
> >=20
> > Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> > ---
> >  Documentation/devicetree/bindings/pwm/imx-pwm.txt |    5 +-
> >  drivers/pwm/pwm-imx.c                             |   42 +++++++++=
++++++++++++
> >  2 files changed, 45 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Do=
cumentation/devicetree/bindings/pwm/imx-pwm.txt
> > index b50d7a6d..d0b04b5 100644
> > --- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> > +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> > @@ -3,8 +3,9 @@ Freescale i.MX PWM controller
> >  Required properties:
> >  - compatible: should be "fsl,<soc>-pwm"
> >  - reg: physical base address and length of the controller's regist=
ers
> > -- #pwm-cells: should be 2. See pwm.txt in this directory for a des=
cription of
> > -  the cells format.
> > +- #pwm-cells: may be 2 for backwards compatibility or 3 to support
> > +  switching the output polarity. See pwm.txt in this directory for=
 a
> > +  description of the cells format.
> >  - interrupts: The interrupt for the pwm controller
> > =20
> >  Example:
> > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > index 3b00a82..05461bb 100644
> > --- a/drivers/pwm/pwm-imx.c
> > +++ b/drivers/pwm/pwm-imx.c
> > @@ -36,6 +36,7 @@
> >  #define MX3_PWMCR_DOZEEN		(1 << 24)
> >  #define MX3_PWMCR_WAITEN		(1 << 23)
> >  #define MX3_PWMCR_DBGEN			(1 << 22)
> > +#define MX3_PWMCR_POUTC			(1 << 18)
> >  #define MX3_PWMCR_CLKSRC_IPG_HIGH	(2 << 16)
> >  #define MX3_PWMCR_CLKSRC_IPG		(1 << 16)
> >  #define MX3_PWMCR_EN			(1 << 0)
> > @@ -138,6 +139,9 @@ static int imx_pwm_config_v2(struct pwm_chip *c=
hip,
> >  	if (test_bit(PWMF_ENABLED, &pwm->flags))
> >  		cr |=3D MX3_PWMCR_EN;
> > =20
> > +	if (pwm->polarity =3D=3D PWM_POLARITY_INVERSED)
> > +		cr |=3D MX3_PWMCR_POUTC;
> > +
> >  	writel(cr, imx->mmio_base + MX3_PWMCR);
> > =20
> >  	return 0;
> > @@ -155,6 +159,11 @@ static void imx_pwm_set_enable_v2(struct pwm_c=
hip *chip, bool enable)
> >  	else
> >  		val &=3D ~MX3_PWMCR_EN;
> > =20
> > +	if (chip->pwms[0].polarity =3D=3D PWM_POLARITY_INVERSED)
> > +		val |=3D MX3_PWMCR_POUTC;
> > +	else
> > +		val &=3D ~MX3_PWMCR_POUTC;
> > +
> >  	writel(val, imx->mmio_base + MX3_PWMCR);
> >  }
> > =20
> > @@ -198,6 +207,17 @@ static void imx_pwm_disable(struct pwm_chip *c=
hip, struct pwm_device *pwm)
> >  	clk_disable_unprepare(imx->clk_per);
> >  }
> > =20
> > +static int imx_pwm_set_polarity(struct pwm_chip *chip, struct pwm_=
device *pwm,
> > +				enum pwm_polarity polarity)
> > +{
> > +	struct imx_chip *imx =3D to_imx_chip(chip);
> > +
> > +	dev_dbg(imx->chip.dev, "%s: polarity set to %s\n", __func__,
> > +		polarity =3D=3D PWM_POLARITY_INVERSED ? "inverted" : "normal");
> > +
> > +	return 0;
> > +}
> > +
> >  static struct pwm_ops imx_pwm_ops =3D {
> >  	.enable =3D imx_pwm_enable,
> >  	.disable =3D imx_pwm_disable,
> > @@ -209,6 +229,7 @@ struct imx_pwm_data {
> >  	int (*config)(struct pwm_chip *chip,
> >  		struct pwm_device *pwm, int duty_ns, int period_ns);
> >  	void (*set_enable)(struct pwm_chip *chip, bool enable);
> > +	unsigned output_polarity:1;
> >  };
> > =20
> >  static struct imx_pwm_data imx_pwm_data_v1 =3D {
> > @@ -219,6 +240,7 @@ static struct imx_pwm_data imx_pwm_data_v1 =3D =
{
> >  static struct imx_pwm_data imx_pwm_data_v2 =3D {
> >  	.config =3D imx_pwm_config_v2,
> >  	.set_enable =3D imx_pwm_set_enable_v2,
> > +	.output_polarity =3D 1,
> >  };
> > =20
> >  static const struct of_device_id imx_pwm_dt_ids[] =3D {
> > @@ -271,6 +293,26 @@ static int imx_pwm_probe(struct platform_devic=
e *pdev)
> >  		return PTR_ERR(imx->mmio_base);
> > =20
> >  	data =3D of_id->data;
> > +	if (data->output_polarity) {
> > +		const struct device_node *np =3D pdev->dev.of_node;
> > +		u32 num_cells;
> > +
> > +		dev_dbg(&pdev->dev, "PWM supports output inversion\n");
> > +		ret =3D of_property_read_u32(np, "#pwm-cells", &num_cells);
> > +		if (ret < 0) {
> > +			dev_err(&pdev->dev, "missing property '#pwm-cells'\n");
> > +			return ret;
> > +		}
> > +		if (num_cells =3D=3D 3) {
> > +			imx_pwm_ops.set_polarity =3D imx_pwm_set_polarity;
> > +			imx->chip.of_xlate =3D of_pwm_xlate_with_flags;
> > +		} else if (num_cells !=3D 2) {
> > +			dev_err(&pdev->dev, "'#pwm-cells' must be <2> or <3>\n");
> > +			return -EINVAL;
> > +		}
> > +		imx->chip.of_pwm_n_cells =3D num_cells;
> > +	}
>=20
> Can't this be done in the PWM core? Right now the PWM core checks for
> of_pwm_n_cells before calling ->of_xlate. IMO this check should be do=
ne
> in the of_xlate hook. Then of_pwm_simple_xlate and
> of_pwm_xlate_with_flags can be merged into something like:
>=20
This wouldn't buy much without a material change to of_pwm_get().
The function of_parse_phandle_with_args() called by of_pwm_get()
requires the number of args in the pwms property be greater or equal to
the #pwm-cells property in the pwm node. Thus, the interesting case of
having #pwm-cells =3D <3> without changing the existing users is
prohibited by of_parse_phandle_with_args().

of_pwm_get() would have to be changed to something like below to allow
this:
struct pwm_device *of_pwm_get(struct device_node *np, const char *con_i=
d)
{
	struct pwm_device *pwm =3D NULL;
	struct of_phandle_args args;
	struct pwm_chip *pc;
	int index =3D 0;
	int err;
	struct property *prop;
	u32 num_cells;
	int i;
	const __be32 *list;

	if (con_id) {
		index =3D of_property_match_string(np, "pwm-names", con_id);
		if (index < 0)
			return ERR_PTR(index);
	}

	args.np =3D of_parse_phandle(np, "pwms", index);
	if (!args.np) {
		pr_err("%s(): property 'pwms' not found in '%s'\n",
			__func__, np->full_name);
		return ERR_PTR(-ENOENT);
	}

	err =3D of_property_read_u32(args.np, "#pwm-cells", &num_cells);
	if (err) {
		pr_err("%s(): could not read property '#pwm-cells' in '%s': %d\n",
			__func__, args.np->full_name, err);
		return ERR_PTR(err);
	}

	prop =3D of_find_property(np, "pwms", NULL);
	if (WARN_ON(!prop))
		return ERR_PTR(-EINVAL);

	args.args_count =3D prop->length / sizeof(u32) - 1;
	list =3D prop->value;
	for (i =3D 0; i < args.args_count; i++)
		args.args[i] =3D be32_to_cpup(++list);

	pc =3D of_node_to_pwmchip(args.np);
	if (IS_ERR(pc)) {
		pr_err("%s(): PWM chip not found\n", __func__);
		pwm =3D ERR_CAST(pc);
		goto put;
	}
[...]

=20

Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
