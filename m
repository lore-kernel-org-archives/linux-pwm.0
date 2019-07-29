From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/6] pwm: sun4i: Add a quirk for reset line
Date: Mon, 29 Jul 2019 20:20:46 +0200
Message-ID: <20190729182046.6bwrterbxoceulrx@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-3-jernej.skrabec@siol.net>
 <20190729063630.rn325whatfnc3m7n@pengutronix.de>
 <CAGb2v65KOpivHQNkg+R2=D=ejCJYnPdVcyHJZW-GJCR8j0Yk0g@mail.gmail.com>
 <20190729071218.bukw7vxilqy523k3@pengutronix.de>
 <20190729163715.vtv7lkrywewomxga@flea.home>
Reply-To: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCX3TTWUQMPRBDXS7TUQKGQEVRVROOY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20190729163715.vtv7lkrywewomxga-YififvaboMKzQB+pC5nmwQ@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, Jul 29, 2019 at 06:37:15PM +0200, Maxime Ripard wrote:
> On Mon, Jul 29, 2019 at 09:12:18AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Hello,
> >
> > On Mon, Jul 29, 2019 at 02:43:23PM +0800, Chen-Yu Tsai wrote:
> > > On Mon, Jul 29, 2019 at 2:36 PM Uwe Kleine-K=C3=B6nig
> > > <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > > > On Fri, Jul 26, 2019 at 08:40:41PM +0200, Jernej Skrabec wrote:
> > > > > @@ -371,6 +374,14 @@ static int sun4i_pwm_probe(struct platform_d=
evice *pdev)
> > > > >       if (IS_ERR(pwm->clk))
> > > > >               return PTR_ERR(pwm->clk);
> > > > >
> > > > > +     if (pwm->data->has_reset) {
> > > > > +             pwm->rst =3D devm_reset_control_get(&pdev->dev, NUL=
L);
> > > > > +             if (IS_ERR(pwm->rst))
> > > > > +                     return PTR_ERR(pwm->rst);
> > > > > +
> > > > > +             reset_control_deassert(pwm->rst);
> > > > > +     }
> > > > > +
> > > >
> > > > I wonder why there is a need to track if a given chip needs a reset
> > > > line. I'd just use devm_reset_control_get_optional() and drop the
> > > > .has_reset member in struct sun4i_pwm_data.
> > >
> > > Because it's not optional for this platform, i.e. it won't work if
> > > the reset control (or clk, in the next patch) is somehow missing from
> > > the device tree.
> >
> > If the device tree is wrong it is considered ok that the driver doesn't
> > behave correctly. So this is not a problem you need (or should) care
> > about.
>=20
> To some extent that's true, but if we can make the life easier for
> everyone by reporting an error and bailing out instead of silently
> ignoring that, continuing to probe and just ending up with a
> completely broken system for no apparent reason, then why not just do
> that?
>=20
> I mean, all it takes is three lines of code.

<pedantic>Actually it's more because you need to track for each variant
if it needs the clock (or reset stuff) or not.</pedantic>

It's a weighing between "simpler driver" and "catch unlikely errors".
(If the SoC's .dtsi includes the needed stuff, an error here is really
unlikely, isn't it?)

So to some degree it's subjective which one is better. I tend to prefer
"simpler driver". Also when catching this type of error you have to do
it right twice (in the .dtsi and the driver) while with my approach
there is only a single place that defines what is right, which is a good
design according to what I learned during my studies.

> It's no different than just calling clk_get, and testing the return
> code to see if it's there or not. I wouldn't call that check when you
> depend on a clock "validating the DT". It's just making sure that all
> the resources needed for you to operate properly are there, which is a
> pretty common thing to do.

This is different. As a driver author you are allowed (or even supposed)
to assume that the device tree (or ACPI or platform data ...) is right
and completely defines the stuff for the driven hardware to work
correctly. You must not assume that clk_get() succeeds unconditionally.

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
/linux-sunxi/20190729182046.6bwrterbxoceulrx%40pengutronix.de.
