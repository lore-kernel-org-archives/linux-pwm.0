From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: [PATCH 2/5] pwm: sun4i: Add support for PWM
 controller on sun6i SoCs
Date: Wed, 12 Oct 2016 16:10:03 +0800
Message-ID: <1476259803.2317.2.camel@Nokia-N900>
References: <20161012042059.40015-1-icenowy@aosc.xyz>
	 <20161012042059.40015-2-icenowy@aosc.xyz>
	  <CAGb2v65P7SQyEv+b0mU_FA=CQxy7qX9h7HE4NivqjZ-ZBh94ww@mail.gmail.com>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBSHA667QKGQEZRVWUYI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v65P7SQyEv+b0mU_FA=CQxy7qX9h7HE4NivqjZ-ZBh94ww-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-ID: <1476259802.2317.1.camel@Nokia-N900>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: wens-jdAy2FN1RRM@public.gmane.org
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi,

----- =E5=8E=9F=E4=BB=B6 -----
> Hi,
>=20
> On Wed, Oct 12, 2016 at 12:20 PM, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org> wrote:
> > The PWM controller in A31 is different with other Allwinner SoCs, with
> > a control register per channel (in other SoCs the control register is
> > shared), and each channel are allocated 16 bytes of address (but only 8
> > bytes are used.). The register map in one channel is just like a
> > single-channel A10 PWM controller, however, A31 have a different
> > prescaler table than other SoCs.
> >=20
> > In order to use the driver for all 4 channels, device nodes should be
> > created per channel.
>=20
> I think Maxime wants you to support the different register offsets
> in this driver, and have all 4 channels in the same device (node).

I think that will make the code much more complex...
And in hardware there may also be 4 controllers... as the register is align=
ed at 0x10.

The error I made in my previous patch set is making
a dedicatded pwm-sun6i driver. So I reworked this.
(This also why I do not call the current patchset PATCH v2 -- it's a new pa=
tchset)

Icenowy Zheng

>=20
> ChenYu
>=20
>=20
> > Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
> > ---
> > drivers/pwm/pwm-sun4i.c | 37 ++++++++++++++++++++++++++++++++++++-
> > 1 file changed, 36 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 03a99a5..3e93bdf 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -46,7 +46,7 @@
> >=20
> > #define BIT_CH(bit, chan)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  ((bit) << =
((chan) * PWMCH_OFFSET))
> >=20
> > -static const u32 prescaler_table[] =3D {
> > +static const u32 prescaler_table_a10[] =3D {
> > 120,
> > 180,
> > 240,
> > @@ -65,10 +65,30 @@ static const u32 prescaler_table[] =3D {
> > 0, /* Actually 1 but tested separately */
> > };
> >=20
> > +static const u32 prescaler_table_a31[] =3D {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  1,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  2,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  4,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  8,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  16,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  32,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  64,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  0,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  0,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  0,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  0,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  0,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  0,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  0,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  0,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  0,
> > +};
> > +
> > struct sun4i_pwm_data {
> > bool has_prescaler_bypass;
> > bool has_rdy;
> > unsigned int npwm;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  const u32 *prescaler_table;
> > };
> >=20
> > struct sun4i_pwm_chip {
> > @@ -100,6 +120,7 @@ static int sun4i_pwm_config(struct pwm_chip *chip,
> > struct pwm_device *pwm, int duty_ns, int period_ns)
> > {
> > struct sun4i_pwm_chip *sun4i_pwm =3D to_sun4i_pwm_chip(chip);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  const u32 *prescaler_table =
=3D sun4i_pwm->data->prescaler_table;
> > u32 prd, dty, val, clk_gate;
> > u64 clk_rate, div =3D 0;
> > unsigned int prescaler =3D 0;
> > @@ -264,24 +285,35 @@ static const struct sun4i_pwm_data
> > sun4i_pwm_data_a10 =3D { .has_prescaler_bypass =3D false,
> > .has_rdy =3D false,
> > .npwm =3D 2,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  .prescaler_table =3D presca=
ler_table_a10,
> > };
> >=20
> > static const struct sun4i_pwm_data sun4i_pwm_data_a10s =3D {
> > .has_prescaler_bypass =3D true,
> > .has_rdy =3D true,
> > .npwm =3D 2,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  .prescaler_table =3D presca=
ler_table_a10,
> > };
> >=20
> > static const struct sun4i_pwm_data sun4i_pwm_data_a13 =3D {
> > .has_prescaler_bypass =3D true,
> > .has_rdy =3D true,
> > .npwm =3D 1,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  .prescaler_table =3D presca=
ler_table_a10,
> > };
> >=20
> > static const struct sun4i_pwm_data sun4i_pwm_data_a20 =3D {
> > .has_prescaler_bypass =3D true,
> > .has_rdy =3D true,
> > .npwm =3D 2,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  .prescaler_table =3D presca=
ler_table_a10,
> > +};
> > +
> > +static const struct sun4i_pwm_data sun4i_pwm_data_a31 =3D {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  .has_prescaler_bypass =3D f=
alse,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  .has_rdy =3D true,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  .npwm =3D 1,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  .prescaler_table =3D presca=
ler_table_a31,
> > };
> >=20
> > static const struct of_device_id sun4i_pwm_dt_ids[] =3D {
> > @@ -298,6 +330,9 @@ static const struct of_device_id
> > sun4i_pwm_dt_ids[] =3D { .compatible =3D "allwinner,sun7i-a20-pwm",
> > .data =3D &sun4i_pwm_data_a20,
> > }, {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0  .compatible =3D "allwinner,sun6i-a31-pwm",
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0  .data =3D &sun4i_pwm_data_a31
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  }, {
> > /* sentinel */
> > },
> > };
> > --
> > 2.10.1
> >=20
> > --
> > You received this message because you are subscribed to the Google
> > Groups "linux-sunxi" group. To unsubscribe from this group and stop
> > receiving emails from it, send an email to
> > linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org For more options, visit
> > https://groups.google.com/d/optout.
>=20
> --=20
> You received this message because you are subscribed to the Google
> Groups "linux-sunxi" group. To unsubscribe from this group and stop
> receiving emails from it, send an email to
> linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org For more options, visit
> https://groups.google.com/d/optout.

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
