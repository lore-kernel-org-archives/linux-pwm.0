From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v3 3/6] pwm: imx: support output polarity inversion
Date: Thu, 20 Oct 2016 10:30:18 +0200
Message-ID: <20161020103018.44fb94ea@jawa>
References: <20161007151129.6043-1-bhuvanchandra.dv@toradex.com>
        <20161007151129.6043-4-bhuvanchandra.dv@toradex.com>
        <5325a332099473a2d8382530f79c5a8e@agner.ch>
        <20161013001540.7f759158@jawa>
        <ff9ba34df2729204c617685dd26ea625@agner.ch>
        <20161013065812.0da91859@jawa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/NpgSi_Yot0EsJ8.UQxyCxcn"; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 16.mo3.mail-out.ovh.net ([188.165.56.217]:35277 "EHLO
        16.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753341AbcJTIa6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Oct 2016 04:30:58 -0400
Received: from player730.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id ED4F133156
        for <linux-pwm@vger.kernel.org>; Thu, 20 Oct 2016 10:30:54 +0200 (CEST)
In-Reply-To: <20161013065812.0da91859@jawa>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, shawnguo@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, kernel@pengutronix.de, fabio.estevam@nxp.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lothar Wassmann <LW@karo-electronics.de>, boris.brezillon@free-electrons.com

--Sig_/NpgSi_Yot0EsJ8.UQxyCxcn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

> Hi Stefan,
>=20
> > On 2016-10-12 15:15, Lukasz Majewski wrote:
> > > Hi Stefan,
> > >=20
> > >> On 2016-10-07 08:11, Bhuvanchandra DV wrote:
> > >> > From: Lothar Wassmann <LW@KARO-electronics.de>
> > >> >
> > >> > The i.MX pwm unit on i.MX27 and newer SoCs provides a
> > >> > configurable output polarity. This patch adds support to
> > >> > utilize this feature where available.
> > >> >
> > >> > Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> > >> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > >> > Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> > >> > Acked-by: Shawn Guo <shawn.guo@linaro.org>
> > >> > Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> > >> > ---
> > >> >  Documentation/devicetree/bindings/pwm/imx-pwm.txt |  6 +--
> > >> >  drivers/pwm/pwm-imx.c                             | 51
> > >> > +++++++++++++++++++++-- 2 files changed, 51 insertions(+), 6
> > >> > deletions(-)
> > >> >
> > >> > diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> > >> > b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> > >> > index e00c2e9..c61bdf8 100644
> > >> > --- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> > >> > +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> > >> > @@ -6,8 +6,8 @@ Required properties:
> > >> >    - "fsl,imx1-pwm" for PWM compatible with the one integrated
> > >> > on i.MX1
> > >> >    - "fsl,imx27-pwm" for PWM compatible with the one integrated
> > >> > on i.MX27
> > >> >  - reg: physical base address and length of the controller's
> > >> > registers -- #pwm-cells: should be 2. See pwm.txt in this
> > >> > directory for a description of
> > >> > -  the cells format.
> > >> > +- #pwm-cells: 2 for i.MX1 and 3 for i.MX27 and newer SoCs. See
> > >> > pwm.txt
> > >> > +  in this directory for a description of the cells format.
> > >> >  - clocks : Clock specifiers for both ipg and per clocks.
> > >> >  - clock-names : Clock names should include both "ipg" and
> > >> > "per" See the clock consumer binding,
> > >> > @@ -17,7 +17,7 @@ See the clock consumer binding,
> > >> >  Example:
> > >> >
> > >> >  pwm1: pwm@53fb4000 {
> > >> > -	#pwm-cells =3D <2>;
> > >> > +	#pwm-cells =3D <3>;
> > >> >  	compatible =3D "fsl,imx53-pwm", "fsl,imx27-pwm";
> > >> >  	reg =3D <0x53fb4000 0x4000>;
> > >> >  	clocks =3D <&clks IMX5_CLK_PWM1_IPG_GATE>,
> > >> > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > >> > index d600fd5..c37d223 100644
> > >> > --- a/drivers/pwm/pwm-imx.c
> > >> > +++ b/drivers/pwm/pwm-imx.c
> > >> > @@ -38,6 +38,7 @@
> > >> >  #define MX3_PWMCR_DOZEEN		(1 << 24)
> > >> >  #define MX3_PWMCR_WAITEN		(1 << 23)
> > >> >  #define MX3_PWMCR_DBGEN			(1 << 22)
> > >> > +#define MX3_PWMCR_POUTC			(1 << 18)
> > >> >  #define MX3_PWMCR_CLKSRC_IPG_HIGH	(2 << 16)
> > >> >  #define MX3_PWMCR_CLKSRC_IPG		(1 << 16)
> > >> >  #define MX3_PWMCR_SWR			(1 << 3)
> > >> > @@ -180,6 +181,9 @@ static int imx_pwm_config_v2(struct
> > >> > pwm_chip *chip, if (enable)
> > >> >  		cr |=3D MX3_PWMCR_EN;
> > >> >
> > >> > +	if (pwm->args.polarity =3D=3D PWM_POLARITY_INVERSED)
> > >> > +		cr |=3D MX3_PWMCR_POUTC;
> > >> > +
> > >>
> > >> This seems wrong to me, the config callback is meant for
> > >> period/duty cycle only.

Unfortunately, it also resets the PWM IP block and setups it again (by
writing to PWMCR register). In that function we setup for example MX3_PWMCR=
_DOZEEN
and MX3_PWMCR_DBGEN. Why cannot we setup polarity as well?


I've double checked the backlight and pwm code flow.

Please find following snippet:

[    0.135545] ######### imx_pwm_probe
[    0.135581] PWM supports output inversion
[    0.136864] ######### pwm_backlight_probe
[    0.136913] backlight supply power not found, using dummy regulator
[    0.136984] ######### imx_pwm_set_polarity 1
[    0.136995] imx_pwm_set_polarity: polarity set to inverted cr: 0x40000 0=
xf08f8000=20
[    0.137005] #########0 imx_pwm_config_v2 cr: 0x40000=20
[    0.137683] #########1 imx_pwm_config_v2 cr: 0x0 0xf08f8000
[    0.137693] #########2 imx_pwm_config_v2 cr: 0x1c20050
[    0.137702] #########3 imx_pwm_config_v2 cr: 0x1c20050 0xf08f8000
[    0.137711] @@@@@@@@@@ pwm_apply_state

Here the pwm_backlight_probe calls set_polarity callback available in
pwm - the polarity is set (the 0x40000 value).

The above operation is performed in pwm_apply_state (@ drivers/pwm/core.c).=
=20
In the same function, latter we call the pwm->chip->ops->config(), which is=
 the
pointer to config_v2.
Since the PWM is not yet enabled, this function performs SW reset and
PWM inversion setting is cleared.

Possible solutions:

1. Leave the original patch from Bhuvanchandra as it was (I'm for this=20
option)

2. Enable early PWM (in core, or in bl driver) so the config_v2 is not
calling SW reset on the PWM. (but this solutions seems _really_ bad to me)

3. Perform defer probe of pwm backlight driver (pwm_bl.c) until the pwm
is fully configured (it might be a bit tricky).


Best regards,
=C5=81ukasz Majewski

> > >=20
> > > If it is meant only for that, then the polarity should be removed
> > > from it.
> > >=20
> > > However after very quick testing, at least on my setup, it turns
> > > out that removing this lines causes polarity to _not_ being set
> > > (and the polarity is not inverted).
> > >=20
> > > I will investigate this further on my setup and hopefully sent
> > > proper patch.
> > >=20
> > >> The set_polarity callback should get called in case a
> > >> different polarity is requested.
> > >=20
> > > On my setup the pwm2 is set from DT and pwm_backlight_probe()
> > > calls pwm_apply_args(), so everything should work. However, as I
> > > mentioned above there still is some problem with inversion
> > > setting.
> > >=20
> > >>
> > >>
> > >> >  	writel(cr, imx->mmio_base + MX3_PWMCR);
> > >> >
> > >> >  	return 0;
> > >> > @@ -240,27 +244,62 @@ static void imx_pwm_disable(struct
> > >> > pwm_chip *chip, struct pwm_device *pwm)
> > >> >  	clk_disable_unprepare(imx->clk_per);
> > >> >  }
> > >> >
> > >> > -static struct pwm_ops imx_pwm_ops =3D {
> > >> > +static int imx_pwm_set_polarity(struct pwm_chip *chip, struct
> > >> > pwm_device *pwm,
> > >> > +				enum pwm_polarity polarity)
> > >> > +{
> > >> > +	struct imx_chip *imx =3D to_imx_chip(chip);
> > >> > +	u32 val;
> > >> > +
> > >> > +	if (polarity =3D=3D pwm->args.polarity)
> > >> > +		return 0;
> > >>
> > >> I don't think that this is right. Today, pwm_apply_args (in
> > >> include/linux/pwm.h) copies the polarity from args to
> > >> state.polarity, which is then passed as polarity argument to this
> > >> function. So this will always return 0 afaict.
> > >=20
> > > Yes, I've overlooked it (that the state is copied).
> > >=20
> > > It can be dropped.
> >=20
> > Did you do the above test with that line dropped?
>=20
> Yes. The above code has been also removed.
>=20
> Best regards,
> =C5=81ukasz Majewski
>=20
> >=20
> > >=20
> > >>
> > >> I would just drop that.
> > >>
> > >> There is probably one little problem in the current state of
> > >> affairs: If the bootloader makes use of a PWM channel with
> > >> inverted state, then the kernel would not know about that and
> > >> currently assume a wrong initial state... I guess at one point in
> > >> time we should implement the state retrieval callback and move to
> > >> the new atomic PWM API, which would mean to implement apply
> > >> callback.
> > >=20
> > > Are there any patches on the horizon?
> > >=20
> >=20
> > Not that I know of...
> >=20
> > --
> > Stefan
> >=20
> > >>
> > >> --
> > >> Stefan
> > >>
> > >>
> > >> > +
> > >> > +	val =3D readl(imx->mmio_base + MX3_PWMCR);
> > >> > +
> > >> > +	if (polarity =3D=3D PWM_POLARITY_INVERSED)
> > >> > +		val |=3D MX3_PWMCR_POUTC;
> > >> > +	else
> > >> > +		val &=3D ~MX3_PWMCR_POUTC;
> > >> > +
> > >> > +	writel(val, imx->mmio_base + MX3_PWMCR);
> > >> > +
> > >> > +	dev_dbg(imx->chip.dev, "%s: polarity set to %s\n",
> > >> > __func__,
> > >> > +		polarity =3D=3D PWM_POLARITY_INVERSED ?
> > >> > "inverted" : "normal"); +
> > >> > +	return 0;
> > >> > +}
> > >> > +
> > >> > +static struct pwm_ops imx_pwm_ops_v1 =3D {
> > >> >  	.enable =3D imx_pwm_enable,
> > >> >  	.disable =3D imx_pwm_disable,
> > >> >  	.config =3D imx_pwm_config,
> > >> >  	.owner =3D THIS_MODULE,
> > >> >  };
> > >> >
> > >> > +static struct pwm_ops imx_pwm_ops_v2 =3D {
> > >> > +	.enable =3D imx_pwm_enable,
> > >> > +	.disable =3D imx_pwm_disable,
> > >> > +	.set_polarity =3D imx_pwm_set_polarity,
> > >> > +	.config =3D imx_pwm_config,
> > >> > +	.owner =3D THIS_MODULE,
> > >> > +};
> > >> > +
> > >> >  struct imx_pwm_data {
> > >> >  	int (*config)(struct pwm_chip *chip,
> > >> >  		struct pwm_device *pwm, int duty_ns, int
> > >> > period_ns); void (*set_enable)(struct pwm_chip *chip, bool
> > >> > enable);
> > >> > +	struct pwm_ops *pwm_ops;
> > >> >  };
> > >> >
> > >> >  static struct imx_pwm_data imx_pwm_data_v1 =3D {
> > >> >  	.config =3D imx_pwm_config_v1,
> > >> >  	.set_enable =3D imx_pwm_set_enable_v1,
> > >> > +	.pwm_ops =3D &imx_pwm_ops_v1,
> > >> >  };
> > >> >
> > >> >  static struct imx_pwm_data imx_pwm_data_v2 =3D {
> > >> >  	.config =3D imx_pwm_config_v2,
> > >> >  	.set_enable =3D imx_pwm_set_enable_v2,
> > >> > +	.pwm_ops =3D &imx_pwm_ops_v2,
> > >> >  };
> > >> >
> > >> >  static const struct of_device_id imx_pwm_dt_ids[] =3D {
> > >> > @@ -282,6 +321,8 @@ static int imx_pwm_probe(struct
> > >> > platform_device *pdev) if (!of_id)
> > >> >  		return -ENODEV;
> > >> >
> > >> > +	data =3D of_id->data;
> > >> > +
> > >> >  	imx =3D devm_kzalloc(&pdev->dev, sizeof(*imx),
> > >> > GFP_KERNEL); if (imx =3D=3D NULL)
> > >> >  		return -ENOMEM;
> > >> > @@ -300,18 +341,22 @@ static int imx_pwm_probe(struct
> > >> > platform_device *pdev) return PTR_ERR(imx->clk_ipg);
> > >> >  	}
> > >> >
> > >> > -	imx->chip.ops =3D &imx_pwm_ops;
> > >> > +	imx->chip.ops =3D data->pwm_ops;
> > >> >  	imx->chip.dev =3D &pdev->dev;
> > >> >  	imx->chip.base =3D -1;
> > >> >  	imx->chip.npwm =3D 1;
> > >> >  	imx->chip.can_sleep =3D true;
> > >> > +	if (data->pwm_ops->set_polarity) {
> > >> > +		dev_dbg(&pdev->dev, "PWM supports output
> > >> > inversion\n");
> > >> > +		imx->chip.of_xlate =3D of_pwm_xlate_with_flags;
> > >> > +		imx->chip.of_pwm_n_cells =3D 3;
> > >> > +	}
> > >> >
> > >> >  	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >> >  	imx->mmio_base =3D devm_ioremap_resource(&pdev->dev, r);
> > >> >  	if (IS_ERR(imx->mmio_base))
> > >> >  		return PTR_ERR(imx->mmio_base);
> > >> >
> > >> > -	data =3D of_id->data;
> > >> >  	imx->config =3D data->config;
> > >> >  	imx->set_enable =3D data->set_enable;
> > >>
> > >=20
> > > Best regards,
> > >=20
> > > =C5=81ukasz Majewski
>=20


--Sig_/NpgSi_Yot0EsJ8.UQxyCxcn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlgIgJ8ACgkQf9/hG2YwgjG3CwCfeqlBJLBbqV96/wAsXStkZ01F
NRsAn0WYY0BSNJdsnSXnDDOu4bM+9ZFg
=Jgtp
-----END PGP SIGNATURE-----

--Sig_/NpgSi_Yot0EsJ8.UQxyCxcn--
