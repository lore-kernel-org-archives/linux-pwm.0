From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 1/6] Documentation: ARM: sunxi: pwm: add
 Allwinner sun8i.
Date: Tue, 27 Nov 2018 11:32:53 +0100
Message-ID: <20181127103253.ubbjjy2ji6sxc7xs@flea>
References: <20181125161859.GA5277@arx-s1>
 <20181127075226.qo3mv3o6etqdjaop@flea>
 <20181127083523.pciie2gyaplrwiey@pengutronix.de>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t4dgavpmjejg77mf"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBYF26TPQKGQEUDJIMVQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20181127083523.pciie2gyaplrwiey-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Hao Zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--t4dgavpmjejg77mf
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 09:35:23AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Tue, Nov 27, 2018 at 08:52:26AM +0100, Maxime Ripard wrote:
> > On Mon, Nov 26, 2018 at 12:18:59AM +0800, Hao Zhang wrote:
> > > +  - clocks: From common clock binding, handle to the parent clock.
> > > +  - clock-names: Must contain the clock names described just above.
> >=20
> > [...]
> >=20
> > You seem to have used mux-0 and mux-1 for the clock names. I guess we
> > don't have to use a name there, we can simply use the position to find
> > out (as long as it's documented in the binding)
>=20
> I also wondered if the driver relies on the fact that the second clock
> is the faster running one. Is this sensible?

Not really, I'm not sure we can make those expectations in the DT
binding, especially since clock rate can change at runtime.

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

--t4dgavpmjejg77mf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/0dVQAKCRDj7w1vZxhR
xWJdAQDW/2ZVKI8YZGRXlYR6/0v3Jouh2V9QpPDIL6Ae0KaXkQD+LAAS+KtX4+7x
hJtiDCvE2+4leY4Ff+MyXhA8Q6itugY=
=hYrT
-----END PGP SIGNATURE-----

--t4dgavpmjejg77mf--
