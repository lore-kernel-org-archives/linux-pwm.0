From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 1/6] Documentation: ARM: sunxi: pwm: add
 Allwinner sun8i.
Date: Mon, 3 Dec 2018 10:28:09 +0100
Message-ID: <20181203092809.mgeaxpwg6u4s23vq@flea>
References: <20181125161859.GA5277@arx-s1>
 <20181127075226.qo3mv3o6etqdjaop@flea>
 <20181127083523.pciie2gyaplrwiey@pengutronix.de>
 <20181127103253.ubbjjy2ji6sxc7xs@flea>
 <CAJeuY79RRzTqLpaXSe5d8TuNKGeQeYLbXraRVrZk9HBMYBf1+A@mail.gmail.com>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zznxkq7h2qi3betk"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBNPOSPQAKGQE24WXNHQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <CAJeuY79RRzTqLpaXSe5d8TuNKGeQeYLbXraRVrZk9HBMYBf1+A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Hao Zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, wens-jdAy2FN1RRM@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--zznxkq7h2qi3betk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

(Please keep all the recipiens in Cc)

On Sun, Dec 02, 2018 at 12:13:21AM +0800, Hao Zhang wrote:
> Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> =E4=BA=8E2018=E5=B9=B411=E6=9C=
=8827=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:33=E5=86=99=E9=81=93=
=EF=BC=9A
> >
> > On Tue, Nov 27, 2018 at 09:35:23AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > Hello,
> > >
> > > On Tue, Nov 27, 2018 at 08:52:26AM +0100, Maxime Ripard wrote:
> > > > On Mon, Nov 26, 2018 at 12:18:59AM +0800, Hao Zhang wrote:
> > > > > +  - clocks: From common clock binding, handle to the parent cloc=
k.
> > > > > +  - clock-names: Must contain the clock names described just abo=
ve.
> > > >
> > > > [...]
> > > >
> > > > You seem to have used mux-0 and mux-1 for the clock names. I guess =
we
> > > > don't have to use a name there, we can simply use the position to f=
ind
> > > > out (as long as it's documented in the binding)
> > >
> > > I also wondered if the driver relies on the fact that the second cloc=
k
> > > is the faster running one. Is this sensible?
> >
> > Not really, I'm not sure we can make those expectations in the DT
> > binding, especially since clock rate can change at runtime.
>
> How about just add one clock on DT, most of the time, 24MHZ is enough
> (apb1 is 100MHZ)
> other one just use as a optional.
> clock rate change at runtime would make the same pair pwm channel
> uncontrollable,
> because previous one would be change by the new one different setting.

The DT is a hardware representation. If the hardware block can use
both clocks, it should be described.

Now, you can totally use only one clock of these 2 in your driver if that's
easier / more reasonable.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--zznxkq7h2qi3betk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAT3KQAKCRDj7w1vZxhR
xQeYAQDbnRAmYhwUqiaSbkwrmQzprsqASJeNCuc1rI/hF22HsAD6A/smAChtdem8
w8QGGZGN16H/E9vHXpmuF6xCPL7VDgw=
=gmHJ
-----END PGP SIGNATURE-----

--zznxkq7h2qi3betk--
