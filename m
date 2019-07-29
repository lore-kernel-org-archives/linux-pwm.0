From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
Subject: Re: [PATCH 4/6] pwm: sun4i: Add support for H6 PWM
Date: Mon, 29 Jul 2019 17:55:52 +0200
Message-ID: <223488703.0I5IR7NXoI@jernej-laptop>
References: <20190726184045.14669-1-jernej.skrabec@siol.net> <20190726184045.14669-5-jernej.skrabec@siol.net> <20190729064030.7uenld2kbof45zti@pengutronix.de>
Reply-To: jernej.skrabec-gGgVlfcn5nU@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDQNBWPU7YERBC5O7TUQKGQEVTJFZCI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190729064030.7uenld2kbof45zti-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

Dne ponedeljek, 29. julij 2019 ob 08:40:30 CEST je Uwe Kleine-K=C3=B6nig=20
napisal(a):
> On Fri, Jul 26, 2019 at 08:40:43PM +0200, Jernej Skrabec wrote:
> > Now that sun4i PWM driver supports deasserting reset line and enabling
> > bus clock, support for H6 PWM can be added.
> >=20
> > Note that while H6 PWM has two channels, only first one is wired to
> > output pin. Second channel is used as a clock source to companion AC200
> > chip which is bundled into same package.
> >=20
> > Signed-off-by: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
> > ---
> >=20
> >  drivers/pwm/pwm-sun4i.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >=20
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 7d3ac3f2dc3f..9e0eca79ff88 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -331,6 +331,13 @@ static const struct sun4i_pwm_data
> > sun4i_pwm_single_bypass =3D {>=20
> >  	.npwm =3D 1,
> > =20
> >  };
> >=20
> > +static const struct sun4i_pwm_data sun50i_pwm_dual_bypass_clk_rst =3D =
{
> > +	.has_bus_clock =3D true,
> > +	.has_prescaler_bypass =3D true,
> > +	.has_reset =3D true,
> > +	.npwm =3D 2,
> > +};
> > +
> >=20
> >  static const struct of_device_id sun4i_pwm_dt_ids[] =3D {
> > =20
> >  	{
> >  =09
> >  		.compatible =3D "allwinner,sun4i-a10-pwm",
> >=20
> > @@ -347,6 +354,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[]=
 =3D
> > {
> >=20
> >  	}, {
> >  =09
> >  		.compatible =3D "allwinner,sun8i-h3-pwm",
> >  		.data =3D &sun4i_pwm_single_bypass,
> >=20
> > +	}, {
> > +		.compatible =3D "allwinner,sun50i-h6-pwm",
> > +		.data =3D &sun50i_pwm_dual_bypass_clk_rst,
>=20
> If you follow my suggestion for the two previous patches, you can just
> use:
>=20
> 	compatible =3D "allwinner,sun50i-h6-pwm", "allwinner,sun5i-a10s-pwm";
>=20
> and drop this patch.

Maxime found out that it's not compatible with A10s due to difference in by=
pass=20
bit, but yes, I know what you mean.

Since H6 requires reset line and bus clock to be specified, it's not compat=
ible=20
from DT binding side. New yaml based binding must somehow know that in orde=
r=20
to be able to validate DT node, so it needs standalone compatible. However,=
=20
depending on conclusions of other discussions, this new compatible can be=
=20
associated with already available quirks structure or have it's own.

Best regards,
Jernej

>=20
> Best regards
> Uwe
>=20
> >  	}, {
> >  =09
> >  		/* sentinel */
> >  =09
> >  	},




--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web, visit https://groups.google.com/d/msgid=
/linux-sunxi/223488703.0I5IR7NXoI%40jernej-laptop.
