From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
Subject: Re: [PATCH 3/6] pwm: sun4i: Add a quirk for bus clock
Date: Mon, 29 Jul 2019 17:48:36 +0200
Message-ID: <4022372.WfP88Fa4Lu@jernej-laptop>
References: <20190726184045.14669-1-jernej.skrabec@siol.net> <20190726184045.14669-4-jernej.skrabec@siol.net> <20190729063825.wxfky6nswcru26g7@pengutronix.de>
Reply-To: jernej.skrabec-gGgVlfcn5nU@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDQNBWPU7YERBWFK7TUQKGQE7CEEPHQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190729063825.wxfky6nswcru26g7-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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

Dne ponedeljek, 29. julij 2019 ob 08:38:25 CEST je Uwe Kleine-K=C3=B6nig=20
napisal(a):
> Hello,
>=20
> On Fri, Jul 26, 2019 at 08:40:42PM +0200, Jernej Skrabec wrote:
> > H6 PWM core needs bus clock to be enabled in order to work.
> >=20
> > Add a quirk for it.
> >=20
> > Signed-off-by: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
> > ---
> >=20
> >  drivers/pwm/pwm-sun4i.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >=20
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 1b7be8fbde86..7d3ac3f2dc3f 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -72,6 +72,7 @@ static const u32 prescaler_table[] =3D {
> >=20
> >  };
> > =20
> >  struct sun4i_pwm_data {
> >=20
> > +	bool has_bus_clock;
> >=20
> >  	bool has_prescaler_bypass;
> >  	bool has_reset;
> >  	unsigned int npwm;
> >=20
> > @@ -79,6 +80,7 @@ struct sun4i_pwm_data {
> >=20
> >  struct sun4i_pwm_chip {
> > =20
> >  	struct pwm_chip chip;
> >=20
> > +	struct clk *bus_clk;
> >=20
> >  	struct clk *clk;
> >  	struct reset_control *rst;
> >  	void __iomem *base;
> >=20
> > @@ -382,6 +384,16 @@ static int sun4i_pwm_probe(struct platform_device
> > *pdev)>=20
> >  		reset_control_deassert(pwm->rst);
> >  =09
> >  	}
> >=20
> > +	if (pwm->data->has_bus_clock) {
> > +		pwm->bus_clk =3D devm_clk_get(&pdev->dev, "bus");
>=20
> Similar to my suggestion in patch 2: I'd use devm_clk_get_optional() and
> drop struct sun4i_pwm_data::has_bus_clock.

This one is not so simple. This patch has incorrect logic. Correct logic wo=
uld=20
be to use "devm_clk_get(&pdev->dev, NULL)" for variants without bus clock a=
s=20
it is done already and "devm_clk_get(&pdev->dev, "bus")" and=20
"devm_clk_get(&pdev->dev, "mod")" for variants with bus clock.

You see, DT nodes for other variants don't have clock-names property at all=
.=20
If it would be specified, it would be "mod". So, DT nodes for other variant=
s=20
have "mod" clock specified on first place (the only one), while H6 DT node =
will=20
have "mod" clock specified on second place (see one of e-mails from Maxime)=
, so=20
"NULL" can't be used instead of "mod" in both cases.

So I would say quirk is beneficial to know if you have to look up clocks by=
=20
name or you just take first clock specified.

Best regards,
Jernej

>=20
> Best regards
> Uwe




--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web, visit https://groups.google.com/d/msgid=
/linux-sunxi/4022372.WfP88Fa4Lu%40jernej-laptop.
