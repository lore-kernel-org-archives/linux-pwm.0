From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: Re: [PATCH 4/6] pwm: sun4i: Add support for H6 PWM
Date: Wed, 31 Jul 2019 08:52:30 +0200
Message-ID: <20190731065230.mqbtn5sfoxrkevw5@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <173825848.1FZsmuHfpq@jernej-laptop>
 <20190729185108.tpilwoooxvi2z72e@pengutronix.de>
 <2452836.v7ux4bnEjb@jernej-laptop>
 <20190730080900.hhxrqun7vk4nsj2h@pengutronix.de>
 <20190730170601.a7ei43wku6jsjanu@flea>
Reply-To: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCX3TTWUQMPRBM7VQTVAKGQEBS5EHSI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20190730170601.a7ei43wku6jsjanu@flea>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Tue, Jul 30, 2019 at 07:06:01PM +0200, Maxime Ripard wrote:
> On Tue, Jul 30, 2019 at 10:09:00AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Rob and Frank,
> >
> > Maxime and Jernej on one side and me on the other cannot agree about a
> > detail in the change to the bindings here. I'm trying to objectively
> > summarize the situation for you to help deciding what is the right thin=
g
> > to do here.
> >
> > TLDR: The sun4i pwm driver is extended to support a new variant of that
> > device on the H6 SoC. Compared to the earlier supported variants
> > allwinner,sun50i-h6-pwm on H6 needs to handle a reset controller and an
> > additional clock.
> >
> > The two positions are:
> >
> >  - We need a new compatible because only then the driver and/or the dt
> >    schema checker can check that each "allwinner,sun50i-h6-pwm" device
> >    has a reset property and a "bus" clock; and the earlier variants
> >    don't.
>=20
> There is two topics here, really. The binding itself really must have
> those properties as required.
>=20
> You had an analogy before that we shouldn't really do that, since it
> would be verification and that it would be similar to checking whether
> the register range was right. This analogy isn't correct, a better one
> would be checking that the register range exists in the first place.

The relevant difference is that *all* devices supported by the driver
have to have a register range. Compared to that only a subset of the
devices have to have a bus clock.

> Indeed, if you don't have a register range, you have no register to
> write to, and that's a showstopper for any driver. I'm pretty sure we
> all agree on that. But on those SoCs, like Chen-Yu said, having no
> resets or clocks properties result in an equally bad result: either
> any write to that device is completely ignored (missing reset), or the
> system completely (and silently) locks up (missing bus clock).
>=20
> We *have* to catch that somehow and not let anything like that happen.

IIUC both the clock and the reset stuff is SoC specific, so it's the
same for all machines with the H6, right? So assuming this is correctly
contained in the h6.dtsi, in which cases can this go wrong? I only see
the cases that the dts author includes the wrong dtsi or overrides
stuff. In the first case a non-working PWM is probably one of the
smaller problems and the second is something we're not really able to
catch.

But even if each machine's dts author has to get this right, I don't
think the dts schema is the right place to assert this.

> That being said, we can't really validate that the clock pointed is
> the right one, just like we can't really check that the register range
> is the proper one. Or rather, we could, but it's completely
> impractical and we do agree on that as well.
>=20
> Having the bus clock and reset line being required however is only a
> few lines in the binding though, and is very practical.
>=20
> >  - The driver can be simpler and the device specific knowledge is only
> >    in a single place (the dt) if the device tree is considered valid an=
d
> >    a reset property and "bus" clock is used iff it's provided in the
> >    device tree without additional comparison for the compatible.
>=20
> And now we have the discussion on how it's implemented in a
> driver. Since it's pretty cheap to implement (only a couple of lines:
> two for the if block, one for the additional field in the structure,
> one for each SoC using that) and have huge benefits (not silently
> locking up the system at boot), then I'd say we should go for it.

Right, it's only a few lines. Still it (IMHO needlessly) complicates the
driver. From the driver's POV the device tree defines the
characteristics of the device and if the dts defines an h6-pwm without a
bus clock then maybe this is the PWM on the next generation SoC that
doesn't need it. And maybe you're happy in a few year's time when you
don't have to touch the driver again for this next generation SoC
because the driver is not only simpler but also flexible enough to
handle the new PWM without adaptions.

All in all I don't care much about the dt schema stuff, I want to keep
the driver simple. So if we agree that the schema ensures that the h6
pwms have a reset and a bus clock and we just use reset_get_optional and
clk_get_optional that's a compromise I can agree to.

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
/linux-sunxi/20190731065230.mqbtn5sfoxrkevw5%40pengutronix.de.
