From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: Re: [PATCH 4/6] pwm: sun4i: Add support for H6 PWM
Date: Mon, 29 Jul 2019 20:40:41 +0200
Message-ID: <20190729184041.vlvfz3vz3ykhufdk@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <CAGb2v66C=ghjck6rxTg6Vt4xN2DcXntzVOa=KJWh98KRjkhnHQ@mail.gmail.com>
 <20190729162428.bxuzgxg5sjqptlbp@pengutronix.de>
 <2346193.MplWYqIveT@jernej-laptop>
Reply-To: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCX3TTWUQMPRBLP37TUQKGQECIS6THY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <2346193.MplWYqIveT@jernej-laptop>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, Jul 29, 2019 at 06:40:15PM +0200, Jernej =C5=A0krabec wrote:
> Dne ponedeljek, 29. julij 2019 ob 18:24:28 CEST je Uwe Kleine-K=C3=B6nig=
=20
> napisal(a):
> > Hello,
> >=20
> > On Tue, Jul 30, 2019 at 12:09:40AM +0800, Chen-Yu Tsai wrote:
> > > On Tue, Jul 30, 2019 at 12:07 AM Uwe Kleine-K=C3=B6nig
> > >=20
> > > <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > > > On Mon, Jul 29, 2019 at 05:55:52PM +0200, Jernej =C5=A0krabec wrote=
:
> > > > > Dne ponedeljek, 29. julij 2019 ob 08:40:30 CEST je Uwe Kleine-K=
=C3=B6nig
> > > > >=20
> > > > > napisal(a):
> > > > > > On Fri, Jul 26, 2019 at 08:40:43PM +0200, Jernej Skrabec wrote:
> > > > > > > --- a/drivers/pwm/pwm-sun4i.c
> > > > > > > +++ b/drivers/pwm/pwm-sun4i.c
> > > > > > > @@ -331,6 +331,13 @@ static const struct sun4i_pwm_data
> > > > > > > sun4i_pwm_single_bypass =3D {>
> > > > > > >=20
> > > > > > >   .npwm =3D 1,
> > > > > > > =20
> > > > > > >  };
> > > > > > >=20
> > > > > > > +static const struct sun4i_pwm_data sun50i_pwm_dual_bypass_cl=
k_rst
> > > > > > > =3D {
> > > > > > > + .has_bus_clock =3D true,
> > > > > > > + .has_prescaler_bypass =3D true,
> > > > > > > + .has_reset =3D true,
> > > > > > > + .npwm =3D 2,
> > > > > > > +};
> > > > > > > +
> > > > > > >=20
> > > > > > >  static const struct of_device_id sun4i_pwm_dt_ids[] =3D {
> > > > > > > =20
> > > > > > >   {
> > > > > > >  =20
> > > > > > >           .compatible =3D "allwinner,sun4i-a10-pwm",
> > > > > > >=20
> > > > > > > @@ -347,6 +354,9 @@ static const struct of_device_id
> > > > > > > sun4i_pwm_dt_ids[] =3D
> > > > > > > {
> > > > > > >=20
> > > > > > >   }, {
> > > > > > >  =20
> > > > > > >           .compatible =3D "allwinner,sun8i-h3-pwm",
> > > > > > >           .data =3D &sun4i_pwm_single_bypass,
> > > > > > >=20
> > > > > > > + }, {
> > > > > > > +         .compatible =3D "allwinner,sun50i-h6-pwm",
> > > > > > > +         .data =3D &sun50i_pwm_dual_bypass_clk_rst,
> > > > > >=20
> > > > > > If you follow my suggestion for the two previous patches, you c=
an
> > > > > > just
> > > > > >=20
> > > > > > use:
> > > > > >     compatible =3D "allwinner,sun50i-h6-pwm",
> > > > > >     "allwinner,sun5i-a10s-pwm";
> > > > > >=20
> > > > > > and drop this patch.
> > > > >=20
> > > > > Maxime found out that it's not compatible with A10s due to differ=
ence
> > > > > in bypass bit, but yes, I know what you mean.
> > > > >=20
> > > > > Since H6 requires reset line and bus clock to be specified, it's =
not
> > > > > compatible from DT binding side. New yaml based binding must some=
how
> > > > > know that in order to be able to validate DT node, so it needs
> > > > > standalone compatible. However, depending on conclusions of other
> > > > > discussions, this new compatible can be associated with already
> > > > > available quirks structure or have it's own.> >=20
> > > > I cannot follow. You should be able to specify in the binding that =
the
> > > > reset line and bus clock is optional. Then allwinner,sun50i-h6-pwm
> > > > without a reset line and bus clock also verifies, but this doesn't
> > > > really hurt (and who knows, maybe the next allwinner chip needs exa=
ctly
> > > > this).
> > >=20
> > > It is not optional. It will not work if either the clocks or reset
> > > controls
> > > are missing. How would these be optional anyway? Either it's connecte=
d and
> > > thus required, or it's not and therefore should be omitted from the
> > > description.
> >=20
> > [Just arguing about the clock here, the argumentation is analogous for
> > the reset control.]
> >=20
> > From the driver's perspective it's optional: There are devices with and
> > without a bus clock. This doesn't mean that you can just ignore this
> > clock if it's specified. It's optional in the sense "If dt doesn't
> > specify it, then assume this is a device that doesn't have it and so yo=
u
> > don't need to handle it." but not in the sense "it doesn't matter if
> > you handle it or not.".
> >=20
> > Other than that I'm on your side. So for example I think it's not
> > optimal that gpiod_get_optional returns NULL if GPIOLIB=3Dn or that
> > devm_reset_control_get_optional returns NULL if RESET_CONTROLLER=3Dn
> > because this hides exactly the kind of problem you point out here.
> >
>=20
> I think there's misunderstanding. I only argued that we can't use
>=20
> compatible =3D "allwinner,sun50i-h6-pwm",
> 	 "allwinner,sun5i-a10s-pwm";
>=20
> as you suggested and only=20
>=20
> compatible =3D "allwinner,sun50i-h6-pwm";=20
>=20
> will work. Not because of driver itself (it can still use _optional()=20
> variants), but because of DT binding, which should be able to validate H6=
 PWM=20
> node - reset and bus clock references are required in this case.

I think I understood. In my eyes there is no need to let validation of
the DT bindings catch a missing "optional" property that is needed on
H6.

You have to draw the line somewhere which information the driver has
hard-coded and what is only provided by the device tree and just assumed
to be correct by the driver. You argue the driver should know that if it
cares for a "allwinner,sun50i-h6-pwm" device it should know (and check)
that there is a clock named "bus" and a resets property that links to a
reset controller. How is that different from checking that the base
address is 0x0300a000 or that the "pwm" clock is the osc24M clock
running at 24 MHz? This isn't checked in the driver or the dt schema.
Still if the device tree got one of them wrong this yields an
non-working pwm device that isn't catched in the driver.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web, visit https://groups.google.com/d/msgid=
/linux-sunxi/20190729184041.vlvfz3vz3ykhufdk%40pengutronix.de.
