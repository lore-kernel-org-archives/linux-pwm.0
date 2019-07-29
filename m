From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 3/6] pwm: sun4i: Add a quirk for bus clock
Date: Mon, 29 Jul 2019 21:04:04 +0200
Message-ID: <20190729190404.rnxw2aihmciafy6c@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-4-jernej.skrabec@siol.net>
 <20190729063825.wxfky6nswcru26g7@pengutronix.de>
 <4022372.WfP88Fa4Lu@jernej-laptop>
 <20190729161435.5bnj3ikocsyep4dd@pengutronix.de>
 <20190729164516.yxfgj2zd3d5ii4c4@flea.home>
Reply-To: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCX3TTWUQMPRBKEG7XUQKGQEISGHJWI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20190729164516.yxfgj2zd3d5ii4c4-YififvaboMKzQB+pC5nmwQ@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hello Maxime,

On Mon, Jul 29, 2019 at 06:45:16PM +0200, Maxime Ripard wrote:
> On Mon, Jul 29, 2019 at 06:14:35PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Then maybe something like the following?:
> >
> > 	busclk =3D devm_clk_get_optional(..., "bus");
> > 	modclk =3D devm_clk_get_optional(..., "mod");
> >
> > 	/*
> > 	 * old dtbs might have a single clock but no clock names. Fall
> > 	 * back to this for compatibility reasons.
> > 	 */
> > 	if (!modclk) {
> > 		modclk =3D devm_clk_get(..., NULL);
> > 	}
>=20
> Again, there's nothing optional about these clocks. You need a
> particular set of clocks for a given generation, and a separate set of
> them on another generation of SoCs.

It depends on the way how "optional" is understood. The semantic of
"optional" as it is used and implemented by devm_clk_get_optional (and
gpiod_get_optional and devm_reset_control_get_optional) is different
than yours when saying "on H6 the clock is not optional". If it was
about the "it doesn't matter if it's taken care of or not" semantic you
seem to mean the function would be useless and no driver would need to
actually use it. In the sense of the functions listed above "optional"
means: Some devices need it, others don't. Using this semantic the "bus"
clock is optional.

> It really isn't about DT validation. We're really making sure that the
> device can be operational. It's as much of a validation step than
> making sure we have mapped registers (reg), or an interrupt if we had
> any.

Do you agree with Jernej in the other end of this thread? If so I don't
think that repeating the same arguments here is sensible. Please read
what I wrote there.

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
/linux-sunxi/20190729190404.rnxw2aihmciafy6c%40pengutronix.de.
