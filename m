From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 2/7] dt-bindings: pwm: document the PWM polarity flag
Date: Thu, 19 Mar 2020 00:19:10 +0100
Message-ID: <20200318231910.GA2885069@ulmo>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-3-oleksandr.suvorov@toradex.com>
 <20200317174344.GB1464607@ulmo>
 <20200317213056.futfiwn4qgr2njye@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200317213056.futfiwn4qgr2njye-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Barker <pbarker-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Marcel Ziswiler <marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Igor Opaniuk <igor.opaniuk-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Philippe Schenker <philippe.schenker-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 10:30:56PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Tue, Mar 17, 2020 at 06:43:44PM +0100, Thierry Reding wrote:
> > On Tue, Mar 17, 2020 at 02:32:26PM +0200, Oleksandr Suvorov wrote:
> > > Add the description of PWM_POLARITY_NORMAL flag.
> > >=20
> > > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
> > > ---
> > >=20
> > >  Documentation/devicetree/bindings/pwm/pwm.txt | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Document=
ation/devicetree/bindings/pwm/pwm.txt
> > > index 084886bd721e..440c6b9a6a4e 100644
> > > --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> > > +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> > > @@ -46,6 +46,7 @@ period in nanoseconds.
> > >  Optionally, the pwm-specifier can encode a number of flags (defined =
in
> > >  <dt-bindings/pwm/pwm.h>) in a third cell:
> > >  - PWM_POLARITY_INVERTED: invert the PWM signal polarity
> > > +- PWM_POLARITY_NORMAL: don't invert the PWM signal polarity
> >=20
> > This doesn't make sense. PWM_POLARITY_NORMAL is not part of the DT ABI.
>=20
> "is not part of the DT ABI" is hardly a good reason. If it's sensible to
> be used, it is sensible to define it.

That's exactly it. It's not sensible at all to use it. If you define it
here it means people are allowed to do stuff like this:

	pwms =3D <&pwm 1234 PWM_POLARITY_INVERTED | PWM_POLARITY_NORMAL>;

which doesn't make sense. What's more, it impossible for the code to
even notice that you're being silly because | PWM_POLARITY_NORMAL is
just | 0 and that's just a nop.

Thierry

> > The third cell of the specifier is a bitmask of flags.
> >=20
> > PWM_POLARITY_NORMAL is an enumeration value that evaluates to 0, so it
> > makes absolutely no sense as a flag.
>=20
> Using 0 or PWM_POLARITY_NORMAL doesn't have an effect on the compiled
> device tree, that's true. But having the term PWM_POLARITY_NORMAL (in
> contrast to a plain 0) in a dts file is useful in my eyes for human
> readers.

Yes, I suppose that's true.

> > PWM signals are considered to be "normal" by default, so no flag is
> > necessary to specify that.
>=20
> GPIOs are considered to be active high by default, still there is
> GPIO_ACTIVE_HIGH (which also evaluates to 0). Also there is
> IRQ_TYPE_NONE.

I'm aware of these. They carry the same risks as I mentioned above,
though. You can easily make mistakes that no software will be able to
detect. If you make a GPIO GPIO_ACTIVE_HIGH | GPIO_ACTIVE_LOW, it
becomes really confusing as to what that means. It really means that the
GPIO will be active-low because GPIO_ACTIVE_HIGH doesn't do anything.
But just reading that may make you think that perhaps HIGH is better
(because, well, it's high, or perhaps because it is listed first).
Having both may also be interpreted as "don't care".

In my opinion things become much easier when you don't have any of the
alternatives. If you don't specify PWM_POLARITY_INVERTED, well, it's
just not going to be inverted, it's going to be normal. No need to be
extra verbose about that.

Thierry

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5yrGsACgkQ3SOs138+
s6GzIg//UvHOxZqlcH1vZ9Mk4woahJF0Ehmg2m0b721XHppS/6hPoiKUnJfZqdbm
Hu5rFUsxIo01XT33yNQtyojogLEvT1JHAaBCxkcBlVc43Dee/2nsf5SehFBtUE7z
suJ7rZVOQpC73QYpLTrDgHcexR4KDjqS2Lxiv9PcY+VCAYW+M2GruTmjKfTB87hU
ApZRs24AfFywg8hX48tsPRQwNA3SkOO8sl2gsDKeSRlwFMTtL4aTCIGKXmQyYydv
Eyjz9NR1GIt95FPh5MeKR5SwrzIrau3qZm1KAcvUydrkP908H28/plRG0/I2FJCa
7bqlsavzrQFeFlal70N/+lPtnsB2SXVVPjCxa3yD5x4a+Gm0CGT3F2wXLdWhXP/T
Wpw9NoQi4SwzBiobOv+TgqjOU5eb7kJ5a+AHU58PCz1bIQZq4jMExU9pCb9N9KAz
SDSsKHX9GrLLuTf6xO/sbctvo8vnoUS2pxWxhWnxCoNP04TzJzjewWRu/wLpnzPC
+R4QaSeEJOBLORqA9skXqqLPY3hD/s1vU0au54a+S2nEZtZCNjdMevQd3pisLghX
pm2htChiGjHBCvrZhc4GeW1BHHZ1qdLuSzPAZdYiz8Tl9/BJ2PvIwgrsj2ejmtPI
9mKe9+bB4fAK1MvN+N7hFEkNKPdyK2dPaoV4NGULSwJEoHcGSSU=
=CkUz
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
