From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v3 3/6] pwm: imx: support output polarity inversion
Date: Fri, 21 Oct 2016 23:49:39 +0200
Message-ID: <20161021234939.1a4f51f4@jawa>
References: <20161007151129.6043-1-bhuvanchandra.dv@toradex.com>
 <20161007151129.6043-4-bhuvanchandra.dv@toradex.com>
 <5325a332099473a2d8382530f79c5a8e@agner.ch>
 <20161013001540.7f759158@jawa>
 <ff9ba34df2729204c617685dd26ea625@agner.ch>
 <20161013065812.0da91859@jawa> <20161020103018.44fb94ea@jawa>
 <1b72dcbc9a021e6fa3aef62f63bbf93f@agner.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1144079698792593512=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1b72dcbc9a021e6fa3aef62f63bbf93f@agner.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Agner <stefan@agner.ch>, thierry.reding@gmail.com, boris.brezillon@free-electrons.com
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, robh+dt@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, Lothar Wassmann <LW@karo-electronics.de>
List-Id: linux-pwm@vger.kernel.org

--===============1144079698792593512==
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_//+HMipER08=_=o8NgV59_h0"; protocol="application/pgp-signature"

--Sig_//+HMipER08=_=o8NgV59_h0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

> On 2016-10-20 01:30, Lukasz Majewski wrote:
> > Hi Stefan,
> >=20
> >> Hi Stefan,
> >>
> >> > On 2016-10-12 15:15, Lukasz Majewski wrote:
> >> > > Hi Stefan,
> >> > >
> >> > >> On 2016-10-07 08:11, Bhuvanchandra DV wrote:
> >> > >> > From: Lothar Wassmann <LW@KARO-electronics.de>
> >> > >> >
> >> > >> > The i.MX pwm unit on i.MX27 and newer SoCs provides a
> >> > >> > configurable output polarity. This patch adds support to
> >> > >> > utilize this feature where available.
> >> > >> >
> >> > >> > Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> >> > >> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> >> > >> > Signed-off-by: Bhuvanchandra DV
> >> > >> > <bhuvanchandra.dv@toradex.com> Acked-by: Shawn Guo
> >> > >> > <shawn.guo@linaro.org> Reviewed-by: Sascha Hauer
> >> > >> > <s.hauer@pengutronix.de> ---
> >> > >> >  Documentation/devicetree/bindings/pwm/imx-pwm.txt |  6 +--
> >> > >> >  drivers/pwm/pwm-imx.c                             | 51
> >> > >> > +++++++++++++++++++++-- 2 files changed, 51 insertions(+), 6
> >> > >> > deletions(-)
> >> > >> >
> >> > >> > diff --git
> >> > >> > a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> >> > >> > b/Documentation/devicetree/bindings/pwm/imx-pwm.txt index
> >> > >> > e00c2e9..c61bdf8 100644 ---
> >> > >> > a/Documentation/devicetree/bindings/pwm/imx-pwm.txt +++
> >> > >> > b/Documentation/devicetree/bindings/pwm/imx-pwm.txt @@ -6,8
> >> > >> > +6,8 @@ Required properties:
> >> > >> >    - "fsl,imx1-pwm" for PWM compatible with the one
> >> > >> > integrated on i.MX1
> >> > >> >    - "fsl,imx27-pwm" for PWM compatible with the one
> >> > >> > integrated on i.MX27
> >> > >> >  - reg: physical base address and length of the controller's
> >> > >> > registers -- #pwm-cells: should be 2. See pwm.txt in this
> >> > >> > directory for a description of
> >> > >> > -  the cells format.
> >> > >> > +- #pwm-cells: 2 for i.MX1 and 3 for i.MX27 and newer SoCs.
> >> > >> > See pwm.txt
> >> > >> > +  in this directory for a description of the cells format.
> >> > >> >  - clocks : Clock specifiers for both ipg and per clocks.
> >> > >> >  - clock-names : Clock names should include both "ipg" and
> >> > >> > "per" See the clock consumer binding,
> >> > >> > @@ -17,7 +17,7 @@ See the clock consumer binding,
> >> > >> >  Example:
> >> > >> >
> >> > >> >  pwm1: pwm@53fb4000 {
> >> > >> > -	#pwm-cells =3D <2>;
> >> > >> > +	#pwm-cells =3D <3>;
> >> > >> >  	compatible =3D "fsl,imx53-pwm", "fsl,imx27-pwm";
> >> > >> >  	reg =3D <0x53fb4000 0x4000>;
> >> > >> >  	clocks =3D <&clks IMX5_CLK_PWM1_IPG_GATE>,
> >> > >> > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> >> > >> > index d600fd5..c37d223 100644
> >> > >> > --- a/drivers/pwm/pwm-imx.c
> >> > >> > +++ b/drivers/pwm/pwm-imx.c
> >> > >> > @@ -38,6 +38,7 @@
> >> > >> >  #define MX3_PWMCR_DOZEEN		(1 << 24)
> >> > >> >  #define MX3_PWMCR_WAITEN		(1 << 23)
> >> > >> >  #define MX3_PWMCR_DBGEN			(1 << 22)
> >> > >> > +#define MX3_PWMCR_POUTC			(1 << 18)
> >> > >> >  #define MX3_PWMCR_CLKSRC_IPG_HIGH	(2 << 16)
> >> > >> >  #define MX3_PWMCR_CLKSRC_IPG		(1 << 16)
> >> > >> >  #define MX3_PWMCR_SWR			(1 << 3)
> >> > >> > @@ -180,6 +181,9 @@ static int imx_pwm_config_v2(struct
> >> > >> > pwm_chip *chip, if (enable)
> >> > >> >  		cr |=3D MX3_PWMCR_EN;
> >> > >> >
> >> > >> > +	if (pwm->args.polarity =3D=3D PWM_POLARITY_INVERSED)
> >> > >> > +		cr |=3D MX3_PWMCR_POUTC;
> >> > >> > +
> >> > >>
> >> > >> This seems wrong to me, the config callback is meant for
> >> > >> period/duty cycle only.
> >=20
> > Unfortunately, it also resets the PWM IP block and setups it again
> > (by writing to PWMCR register). In that function we setup for
> > example MX3_PWMCR_DOZEEN
> > and MX3_PWMCR_DBGEN. Why cannot we setup polarity as well?
> >=20
> >=20
> > I've double checked the backlight and pwm code flow.
> >=20
> > Please find following snippet:
> >=20
> > [    0.135545] ######### imx_pwm_probe
> > [    0.135581] PWM supports output inversion
> > [    0.136864] ######### pwm_backlight_probe
> > [    0.136913] backlight supply power not found, using dummy
> > regulator [    0.136984] ######### imx_pwm_set_polarity 1
> > [    0.136995] imx_pwm_set_polarity: polarity set to inverted cr:
> > 0x40000 0xf08f8000
> > [    0.137005] #########0 imx_pwm_config_v2 cr: 0x40000=20
> > [    0.137683] #########1 imx_pwm_config_v2 cr: 0x0 0xf08f8000
> > [    0.137693] #########2 imx_pwm_config_v2 cr: 0x1c20050
> > [    0.137702] #########3 imx_pwm_config_v2 cr: 0x1c20050 0xf08f8000
> > [    0.137711] @@@@@@@@@@ pwm_apply_state

Maybe a bit more logs:

[    0.135451] ######### imx_pwm_probe
[    0.135488] PWM supports output inversion
[    0.136777] ######### pwm_backlight_probe
[    0.136826] backlight supply power not found, using dummy regulator
[    0.136893] ********* pwm_apply_state state->enabled: 0
[    0.136902] ######### imx_pwm_set_polarity 1
[    0.136913] imx_pwm_set_polarity: polarity set to inverted cr: 0x40000 0=
xf08f8000
[    0.136923] #########0 imx_pwm_config_v2 cr: 0x40000
[    0.137692] #########1 imx_pwm_config_v2 cr: 0x0 0xf08f8000
[    0.137701] #########2 imx_pwm_config_v2 cr: 0x1c20050
[    0.137710] #########3 imx_pwm_config_v2 cr: 0x1c20050 0xf08f8000
[    0.137720] @@@@@@@@@@ pwm_apply_state
[    0.137856] ********* pwm_apply_state state->enabled: 0
[    0.137869] #########0 imx_pwm_config_v2 cr: 0x1c20050
[    0.138904] #########1 imx_pwm_config_v2 cr: 0x0 0xf08f8000
[    0.138913] #########2 imx_pwm_config_v2 cr: 0x1c20050
[    0.138921] #########3 imx_pwm_config_v2 cr: 0x1c20050 0xf08f8000
[    0.138928] @@@@@@@@@@ pwm_apply_state
[    0.138940] ********* pwm_apply_state state->enabled: 1
					 ^^^^^^^^^^^^^^^^^^ this is called from
			pwm_backlight_power_on() from pwm_bl probe function

The problem here is not the lack of ->apply() callback, but the requirement=
 to
perform software reset on the pwm_v2 fifo when the pwm_v2 is NOT enabled (s=
tate->enabled: 0).

As fair as I can see the pwm_state has following members: period, duty cycl=
e, polarity and enabled.
I'm fine to implement ->apply() callback, which would change above values.

However, there is a problem with ->config() (imx_pwm_config_v2 @ pwm-imx.c)=
 and imx pwm_v2 software
FIFO reset.
We can set polarity in any other kernel subsystem, which uses PWM (backligh=
t in this example) and=20
then this setting would disappear when we call pwm_apply_state with state->=
enabled =3D 0 (as presented
in the log). This imposes setting polarity at ->config when we enable the P=
WM (as this patch does).



> >=20
> > Here the pwm_backlight_probe calls set_polarity callback available
> > in pwm - the polarity is set (the 0x40000 value).
> >=20
> > The above operation is performed in pwm_apply_state (@
> > drivers/pwm/core.c). In the same function, latter we call the
> > pwm->chip->ops->config(), which is the pointer to config_v2.
> > Since the PWM is not yet enabled, this function performs SW reset
> > and PWM inversion setting is cleared.
>=20
> That function should not do that.=20

I do agree that it shouldn't. Correct me if I'm wrong, but it seems like an=
=20
PWM HW requirement to perform the reset.

>It was probably already problematic
> in the old times, it is definitely now with the atomic PWM stuff.

The "atomic"[*] code (with ->apply() provided) will not solve this issue.

>=20
> >=20
> > Possible solutions:
> >=20
> > 1. Leave the original patch from Bhuvanchandra as it was (I'm for
> > this option)
>=20
> That really seems like a hack to me, and makes transition to the
> atomic PWM API more complex.

Could you be more specific here?=20

As I mentioned before, the problem is not with the lack of
"atomic" API.

For me the problem is with other subsystems (like pwm backlight)
which do require polarity inversion to work properly.

>=20
> If we can't make it happen properly in the current state of affairs,

We can set polarity properly with this patch. The only thing which needs fi=
xing
and another revision of the patch) is the removal of condition:

-       if (polarity =3D=3D pwm->args.polarity)
-               return 0;

at imx_pwm_set_polarity() function.

> we probably should first move to the atomic API.
>=20
> It really should not be that hard, since we already do almost
> everything in one function (imx_pwm_config_v2). We probably can
> almost just assign that function to the new apply function pointer
> and read information from the new state struct.

We do need to configure polarity according to DT value during the pwm
config_v2 configuration after PWM IP software reset.

>=20
> There are examples for instance here:
> https://patchwork.kernel.org/patch/7228221/

The atomicity[*]:

- It seems to me that this "atomicity" is just embracing all the ->enable, =
->disable
and ->set_polarity in one -> apply callback. Is this just conceptual clean =
up or is
there any other reason for it (I'm just curious) ?

Best regards,

=C5=81ukasz Majewski

>=20
> --
> Stefan
>=20
> >=20
> > 2. Enable early PWM (in core, or in bl driver) so the config_v2 is
> > not calling SW reset on the PWM. (but this solutions seems _really_
> > bad to me)
> >=20
> > 3. Perform defer probe of pwm backlight driver (pwm_bl.c) until the
> > pwm is fully configured (it might be a bit tricky).
> >=20
> >=20
> > Best regards,
> > =C5=81ukasz Majewski
> >=20
> >> > >
> >> > > If it is meant only for that, then the polarity should be
> >> > > removed from it.
> >> > >
> >> > > However after very quick testing, at least on my setup, it
> >> > > turns out that removing this lines causes polarity to _not_
> >> > > being set (and the polarity is not inverted).
> >> > >
> >> > > I will investigate this further on my setup and hopefully sent
> >> > > proper patch.
> >> > >
> >> > >> The set_polarity callback should get called in case a
> >> > >> different polarity is requested.
> >> > >
> >> > > On my setup the pwm2 is set from DT and pwm_backlight_probe()
> >> > > calls pwm_apply_args(), so everything should work. However, as
> >> > > I mentioned above there still is some problem with inversion
> >> > > setting.
> >> > >
> >> > >>
> >> > >>
> >> > >> >  	writel(cr, imx->mmio_base + MX3_PWMCR);
> >> > >> >
> >> > >> >  	return 0;
> >> > >> > @@ -240,27 +244,62 @@ static void imx_pwm_disable(struct
> >> > >> > pwm_chip *chip, struct pwm_device *pwm)
> >> > >> >  	clk_disable_unprepare(imx->clk_per);
> >> > >> >  }
> >> > >> >
> >> > >> > -static struct pwm_ops imx_pwm_ops =3D {
> >> > >> > +static int imx_pwm_set_polarity(struct pwm_chip *chip,
> >> > >> > struct pwm_device *pwm,
> >> > >> > +				enum pwm_polarity polarity)
> >> > >> > +{
> >> > >> > +	struct imx_chip *imx =3D to_imx_chip(chip);
> >> > >> > +	u32 val;
> >> > >> > +
> >> > >> > +	if (polarity =3D=3D pwm->args.polarity)
> >> > >> > +		return 0;
> >> > >>
> >> > >> I don't think that this is right. Today, pwm_apply_args (in
> >> > >> include/linux/pwm.h) copies the polarity from args to
> >> > >> state.polarity, which is then passed as polarity argument to
> >> > >> this function. So this will always return 0 afaict.
> >> > >
> >> > > Yes, I've overlooked it (that the state is copied).
> >> > >
> >> > > It can be dropped.
> >> >
> >> > Did you do the above test with that line dropped?
> >>
> >> Yes. The above code has been also removed.
> >>
> >> Best regards,
> >> =C5=81ukasz Majewski
> >>
> >> >
> >> > >
> >> > >>
> >> > >> I would just drop that.
> >> > >>
> >> > >> There is probably one little problem in the current state of
> >> > >> affairs: If the bootloader makes use of a PWM channel with
> >> > >> inverted state, then the kernel would not know about that and
> >> > >> currently assume a wrong initial state... I guess at one
> >> > >> point in time we should implement the state retrieval
> >> > >> callback and move to the new atomic PWM API, which would mean
> >> > >> to implement apply callback.
> >> > >
> >> > > Are there any patches on the horizon?
> >> > >
> >> >
> >> > Not that I know of...
> >> >
> >> > --
> >> > Stefan
> >> >
> >> > >>
> >> > >> --
> >> > >> Stefan
> >> > >>
> >> > >>
> >> > >> > +
> >> > >> > +	val =3D readl(imx->mmio_base + MX3_PWMCR);
> >> > >> > +
> >> > >> > +	if (polarity =3D=3D PWM_POLARITY_INVERSED)
> >> > >> > +		val |=3D MX3_PWMCR_POUTC;
> >> > >> > +	else
> >> > >> > +		val &=3D ~MX3_PWMCR_POUTC;
> >> > >> > +
> >> > >> > +	writel(val, imx->mmio_base + MX3_PWMCR);
> >> > >> > +
> >> > >> > +	dev_dbg(imx->chip.dev, "%s: polarity set to %s\n",
> >> > >> > __func__,
> >> > >> > +		polarity =3D=3D PWM_POLARITY_INVERSED ?
> >> > >> > "inverted" : "normal"); +
> >> > >> > +	return 0;
> >> > >> > +}
> >> > >> > +
> >> > >> > +static struct pwm_ops imx_pwm_ops_v1 =3D {
> >> > >> >  	.enable =3D imx_pwm_enable,
> >> > >> >  	.disable =3D imx_pwm_disable,
> >> > >> >  	.config =3D imx_pwm_config,
> >> > >> >  	.owner =3D THIS_MODULE,
> >> > >> >  };
> >> > >> >
> >> > >> > +static struct pwm_ops imx_pwm_ops_v2 =3D {
> >> > >> > +	.enable =3D imx_pwm_enable,
> >> > >> > +	.disable =3D imx_pwm_disable,
> >> > >> > +	.set_polarity =3D imx_pwm_set_polarity,
> >> > >> > +	.config =3D imx_pwm_config,
> >> > >> > +	.owner =3D THIS_MODULE,
> >> > >> > +};
> >> > >> > +
> >> > >> >  struct imx_pwm_data {
> >> > >> >  	int (*config)(struct pwm_chip *chip,
> >> > >> >  		struct pwm_device *pwm, int duty_ns, int
> >> > >> > period_ns); void (*set_enable)(struct pwm_chip *chip, bool
> >> > >> > enable);
> >> > >> > +	struct pwm_ops *pwm_ops;
> >> > >> >  };
> >> > >> >
> >> > >> >  static struct imx_pwm_data imx_pwm_data_v1 =3D {
> >> > >> >  	.config =3D imx_pwm_config_v1,
> >> > >> >  	.set_enable =3D imx_pwm_set_enable_v1,
> >> > >> > +	.pwm_ops =3D &imx_pwm_ops_v1,
> >> > >> >  };
> >> > >> >
> >> > >> >  static struct imx_pwm_data imx_pwm_data_v2 =3D {
> >> > >> >  	.config =3D imx_pwm_config_v2,
> >> > >> >  	.set_enable =3D imx_pwm_set_enable_v2,
> >> > >> > +	.pwm_ops =3D &imx_pwm_ops_v2,
> >> > >> >  };
> >> > >> >
> >> > >> >  static const struct of_device_id imx_pwm_dt_ids[] =3D {
> >> > >> > @@ -282,6 +321,8 @@ static int imx_pwm_probe(struct
> >> > >> > platform_device *pdev) if (!of_id)
> >> > >> >  		return -ENODEV;
> >> > >> >
> >> > >> > +	data =3D of_id->data;
> >> > >> > +
> >> > >> >  	imx =3D devm_kzalloc(&pdev->dev, sizeof(*imx),
> >> > >> > GFP_KERNEL); if (imx =3D=3D NULL)
> >> > >> >  		return -ENOMEM;
> >> > >> > @@ -300,18 +341,22 @@ static int imx_pwm_probe(struct
> >> > >> > platform_device *pdev) return PTR_ERR(imx->clk_ipg);
> >> > >> >  	}
> >> > >> >
> >> > >> > -	imx->chip.ops =3D &imx_pwm_ops;
> >> > >> > +	imx->chip.ops =3D data->pwm_ops;
> >> > >> >  	imx->chip.dev =3D &pdev->dev;
> >> > >> >  	imx->chip.base =3D -1;
> >> > >> >  	imx->chip.npwm =3D 1;
> >> > >> >  	imx->chip.can_sleep =3D true;
> >> > >> > +	if (data->pwm_ops->set_polarity) {
> >> > >> > +		dev_dbg(&pdev->dev, "PWM supports output
> >> > >> > inversion\n");
> >> > >> > +		imx->chip.of_xlate =3D
> >> > >> > of_pwm_xlate_with_flags;
> >> > >> > +		imx->chip.of_pwm_n_cells =3D 3;
> >> > >> > +	}
> >> > >> >
> >> > >> >  	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> > >> >  	imx->mmio_base =3D devm_ioremap_resource(&pdev->dev,
> >> > >> > r); if (IS_ERR(imx->mmio_base))
> >> > >> >  		return PTR_ERR(imx->mmio_base);
> >> > >> >
> >> > >> > -	data =3D of_id->data;
> >> > >> >  	imx->config =3D data->config;
> >> > >> >  	imx->set_enable =3D data->set_enable;
> >> > >>
> >> > >
> >> > > Best regards,
> >> > >
> >> > > =C5=81ukasz Majewski
> >>


--Sig_//+HMipER08=_=o8NgV59_h0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlgKjXsACgkQf9/hG2YwgjHp/wCfWkZ/f613cLBYEJTmBfQ95G39
uW8An2oZ7YUszO5Qo9PjF9wPXJcuoQ0Y
=N95V
-----END PGP SIGNATURE-----

--Sig_//+HMipER08=_=o8NgV59_h0--


--===============1144079698792593512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1144079698792593512==--
