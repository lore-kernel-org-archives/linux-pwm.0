From: Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 2/6] pwm: sun4i: Add a quirk for reset line
Date: Mon, 29 Jul 2019 18:37:15 +0200
Message-ID: <20190729163715.vtv7lkrywewomxga@flea.home>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-3-jernej.skrabec@siol.net>
 <20190729063630.rn325whatfnc3m7n@pengutronix.de>
 <CAGb2v65KOpivHQNkg+R2=D=ejCJYnPdVcyHJZW-GJCR8j0Yk0g@mail.gmail.com>
 <20190729071218.bukw7vxilqy523k3@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c27mc7zieuu4am73"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190729071218.bukw7vxilqy523k3@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@siol.net>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org


--c27mc7zieuu4am73
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2019 at 09:12:18AM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>
> On Mon, Jul 29, 2019 at 02:43:23PM +0800, Chen-Yu Tsai wrote:
> > On Mon, Jul 29, 2019 at 2:36 PM Uwe Kleine-K=F6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Fri, Jul 26, 2019 at 08:40:41PM +0200, Jernej Skrabec wrote:
> > > > @@ -371,6 +374,14 @@ static int sun4i_pwm_probe(struct platform_dev=
ice *pdev)
> > > >       if (IS_ERR(pwm->clk))
> > > >               return PTR_ERR(pwm->clk);
> > > >
> > > > +     if (pwm->data->has_reset) {
> > > > +             pwm->rst =3D devm_reset_control_get(&pdev->dev, NULL);
> > > > +             if (IS_ERR(pwm->rst))
> > > > +                     return PTR_ERR(pwm->rst);
> > > > +
> > > > +             reset_control_deassert(pwm->rst);
> > > > +     }
> > > > +
> > >
> > > I wonder why there is a need to track if a given chip needs a reset
> > > line. I'd just use devm_reset_control_get_optional() and drop the
> > > .has_reset member in struct sun4i_pwm_data.
> >
> > Because it's not optional for this platform, i.e. it won't work if
> > the reset control (or clk, in the next patch) is somehow missing from
> > the device tree.
>
> If the device tree is wrong it is considered ok that the driver doesn't
> behave correctly. So this is not a problem you need (or should) care
> about.

To some extent that's true, but if we can make the life easier for
everyone by reporting an error and bailing out instead of silently
ignoring that, continuing to probe and just ending up with a
completely broken system for no apparent reason, then why not just do
that?

I mean, all it takes is three lines of code.

It's no different than just calling clk_get, and testing the return
code to see if it's there or not. I wouldn't call that check when you
depend on a clock "validating the DT". It's just making sure that all
the resources needed for you to operate properly are there, which is a
pretty common thing to do.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--c27mc7zieuu4am73
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXT8guwAKCRDj7w1vZxhR
xUcMAP48/d4gHWLB2ieD8luRNO7UdNKhBxkKVaYQSUwwNhdNhgEA6GotfwgqiOLI
FehMWvNcDSv607KLMFEsu5CWk9sxRwQ=
=W5NU
-----END PGP SIGNATURE-----

--c27mc7zieuu4am73--
