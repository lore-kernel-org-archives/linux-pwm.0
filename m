From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: Re: [PATCH 4/6] pwm: sun4i: Add support for H6 PWM
Date: Tue, 30 Jul 2019 10:09:00 +0200
Message-ID: <20190730080900.hhxrqun7vk4nsj2h@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <173825848.1FZsmuHfpq@jernej-laptop>
 <20190729185108.tpilwoooxvi2z72e@pengutronix.de>
 <2452836.v7ux4bnEjb@jernej-laptop>
Reply-To: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCX3TTWUQMPRBH7W77UQKGQEIM7CRZY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <2452836.v7ux4bnEjb@jernej-laptop>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hello Rob and Frank,

Maxime and Jernej on one side and me on the other cannot agree about a
detail in the change to the bindings here. I'm trying to objectively
summarize the situation for you to help deciding what is the right thing
to do here.

TLDR: The sun4i pwm driver is extended to support a new variant of that
device on the H6 SoC. Compared to the earlier supported variants
allwinner,sun50i-h6-pwm on H6 needs to handle a reset controller and an
additional clock.=20

The two positions are:

 - We need a new compatible because only then the driver and/or the dt
   schema checker can check that each "allwinner,sun50i-h6-pwm" device
   has a reset property and a "bus" clock; and the earlier variants
   don't.

 - The driver can be simpler and the device specific knowledge is only
   in a single place (the dt) if the device tree is considered valid and
   a reset property and "bus" clock is used iff it's provided in the
   device tree without additional comparison for the compatible.

Now our arguments seem to go in circles and Jernej was interested in
your position. That's something I agree with ;-) Can you please share
your view?

Find below some context about the arguments.

Best regards
Uwe

On Tue, Jul 30, 2019 at 12:04:47AM +0200, Jernej =C5=A0krabec wrote:
> Dne ponedeljek, 29. julij 2019 ob 20:51:08 CEST je Uwe Kleine-K=C3=B6nig=
=20
> napisal(a):
> > On Mon, Jul 29, 2019 at 08:46:25PM +0200, Jernej =C5=A0krabec wrote:
> > > Dne ponedeljek, 29. julij 2019 ob 20:40:41 CEST je Uwe Kleine-K=C3=B6=
nig
> > > napisal(a):
> > > > On Mon, Jul 29, 2019 at 06:40:15PM +0200, Jernej =C5=A0krabec wrote=
:
> > > > > Dne ponedeljek, 29. julij 2019 ob 18:24:28 CEST je Uwe Kleine-K=
=C3=B6nig
> > > > > napisal(a):
> > > > > > On Tue, Jul 30, 2019 at 12:09:40AM +0800, Chen-Yu Tsai wrote:
> > > > > > > On Tue, Jul 30, 2019 at 12:07 AM Uwe Kleine-K=C3=B6nig
> > > > > > > <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > > > > > > > On Mon, Jul 29, 2019 at 05:55:52PM +0200, Jernej =C5=A0krab=
ec wrote:
> > > > > > > > > Dne ponedeljek, 29. julij 2019 ob 08:40:30 CEST je Uwe Kl=
eine-K=C3=B6nig
> > > > > > > > > napisal(a):
> > > > > > > > > > On Fri, Jul 26, 2019 at 08:40:43PM +0200, Jernej Skrabe=
c wrote:
> > > > > > > > > > > --- a/drivers/pwm/pwm-sun4i.c
> > > > > > > > > > > +++ b/drivers/pwm/pwm-sun4i.c
> > > > > > > > > > > @@ -331,6 +331,13 @@ static const struct sun4i_pwm_da=
ta
> > > > > > > > > > > sun4i_pwm_single_bypass =3D {>
> > > > > > > > > > >=20
> > > > > > > > > > >   .npwm =3D 1,
> > > > > > > > > > > =20
> > > > > > > > > > >  };
> > > > > > > > > > >=20
> > > > > > > > > > > +static const struct sun4i_pwm_data
> > > > > > > > > > > sun50i_pwm_dual_bypass_clk_rst
> > > > > > > > > > > =3D {
> > > > > > > > > > > + .has_bus_clock =3D true,
> > > > > > > > > > > + .has_prescaler_bypass =3D true,
> > > > > > > > > > > + .has_reset =3D true,
> > > > > > > > > > > + .npwm =3D 2,
> > > > > > > > > > > +};
> > > > > > > > > > > +
> > > > > > > > > > >=20
> > > > > > > > > > >  static const struct of_device_id sun4i_pwm_dt_ids[] =
=3D {
> > > > > > > > > > > =20
> > > > > > > > > > >   {
> > > > > > > > > > >  =20
> > > > > > > > > > >           .compatible =3D "allwinner,sun4i-a10-pwm",
> > > > > > > > > > >=20
> > > > > > > > > > > @@ -347,6 +354,9 @@ static const struct of_device_id
> > > > > > > > > > > sun4i_pwm_dt_ids[] =3D
> > > > > > > > > > > {
> > > > > > > > > > >=20
> > > > > > > > > > >   }, {
> > > > > > > > > > >  =20
> > > > > > > > > > >           .compatible =3D "allwinner,sun8i-h3-pwm",
> > > > > > > > > > >           .data =3D &sun4i_pwm_single_bypass,
> > > > > > > > > > >=20
> > > > > > > > > > > + }, {
> > > > > > > > > > > +         .compatible =3D "allwinner,sun50i-h6-pwm",
> > > > > > > > > > > +         .data =3D &sun50i_pwm_dual_bypass_clk_rst,
> > > > > > > > > >=20
> > > > > > > > > > If you follow my suggestion for the two previous patche=
s,

(i.e. use devm_clk_get_optional instead of using devm_clk_get iff the
compatible is allwinner,sun50i-h6-pwm; analogous for the reset
controller.)

> > > > > > > > > > you can just use:
> > > > > > > > > >
> > > > > > > > > >     compatible =3D "allwinner,sun50i-h6-pwm", "allwinne=
r,sun5i-a10s-pwm";
> > > > > > > > > >=20
> > > > > > > > > > and drop this patch.
> > > > > > > > >=20
> > > > > > > > > Maxime found out that it's not compatible with A10s due t=
o difference
> > > > > > > > > in bypass bit, but yes, I know what you mean.
> > > > > > > > >=20
> > > > > > > > > Since H6 requires reset line and bus clock to be specifie=
d, it's not
> > > > > > > > > compatible from DT binding side. New yaml based binding m=
ust somehow
> > > > > > > > > know that in order to be able to validate DT node, so it =
needs
> > > > > > > > > standalone compatible. However, depending on conclusions =
of other
> > > > > > > > > discussions, this new compatible can be associated with a=
lready
> > > > > > > > > available quirks structure or have it's own.
> > > > > > > >=20
> > > > > > > > I cannot follow. You should be able to specify in the bindi=
ng that the
> > > > > > > > reset line and bus clock is optional. Then allwinner,sun50i=
-h6-pwm
> > > > > > > > without a reset line and bus clock also verifies, but this =
doesn't
> > > > > > > > really hurt (and who knows, maybe the next allwinner chip n=
eeds exactly this).
> > > > > > >=20
> > > > > > > It is not optional. It will not work if either the clocks or =
reset controls
> > > > > > > are missing. How would these be optional anyway? Either it's =
connected and
> > > > > > > thus required, or it's not and therefore should be omitted fr=
om the description.
> > > > > >=20
> > > > > > [Just arguing about the clock here, the argumentation is analog=
ous for
> > > > > > the reset control.]
> > > > > >=20
> > > > > > From the driver's perspective it's optional: There are devices =
with and
> > > > > > without a bus clock. This doesn't mean that you can just ignore=
 this
> > > > > > clock if it's specified. It's optional in the sense "If dt does=
n't
> > > > > > specify it, then assume this is a device that doesn't have it a=
nd so you
> > > > > > don't need to handle it." but not in the sense "it doesn't matt=
er if
> > > > > > you handle it or not.".
> > > > > >=20
> > > > > > Other than that I'm on your side. So for example I think it's n=
ot
> > > > > > optimal that gpiod_get_optional returns NULL if GPIOLIB=3Dn or =
that
> > > > > > devm_reset_control_get_optional returns NULL if RESET_CONTROLLE=
R=3Dn
> > > > > > because this hides exactly the kind of problem you point out he=
re.
> > > > >=20
> > > > > I think there's misunderstanding. I only argued that we can't use
> > > > >=20
> > > > > compatible =3D "allwinner,sun50i-h6-pwm", "allwinner,sun5i-a10s-p=
wm";
> > > > >=20
> > > > > as you suggested and only
> > > > >=20
> > > > > compatible =3D "allwinner,sun50i-h6-pwm";
> > > > >=20
> > > > > will work. Not because of driver itself (it can still use _option=
al()
> > > > > variants), but because of DT binding, which should be able to val=
idate H6
> > > > > PWM node - reset and bus clock references are required in this ca=
se.
> > > >=20
> > > > I think I understood. In my eyes there is no need to let validation=
 of
> > > > the DT bindings catch a missing "optional" property that is needed =
on
> > > > H6.
> > > >=20
> > > > You have to draw the line somewhere which information the driver ha=
s
> > > > hard-coded and what is only provided by the device tree and just as=
sumed
> > > > to be correct by the driver. You argue the driver should know that
> > >=20
> > > No, in this thread I argue that DT validation tool, executed by
> > >=20
> > > make ARCH=3Darm64 dtbs_check
> > >=20
> > > should catch that. This is not a driver, but DT binding described in =
YAML.
> >=20
> > The argumentation is the same. dtbs_check doesn't notice if the base
> > address of your "allwinner,sun50i-h6-pwm" device is wrong. So why shoul=
d
> > it catch a missing reset controller phandle?
>=20
> Of course checking actual values of node properties doesn't make sense in=
=20
> dtbs_check, otherwise we would have million DT bindings. If you have 10 c=
opies=20
> of the same IP core, of course you would use same compatible, but actual=
=20
> register ranges, interrupts, etc. would be different in DT nodes.
>=20
> At this point I would make same argument as were made before, but there i=
s no=20
> point going in circles. I'm interested what have DT maintainers to say.

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
/linux-sunxi/20190730080900.hhxrqun7vk4nsj2h%40pengutronix.de.
