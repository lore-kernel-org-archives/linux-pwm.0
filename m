From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC PATCH 2/7] dt-bindings: pwm: document the PWM polarity flag
Date: Thu, 19 Mar 2020 00:05:39 +0100
Message-ID: <20200318230539.GB2874972@ulmo>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-3-oleksandr.suvorov@toradex.com>
 <20200317174344.GB1464607@ulmo>
 <20200317213056.futfiwn4qgr2njye@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200317213056.futfiwn4qgr2njye@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Paul Barker <pbarker@konsulko.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--H+4ONPRPur6+Ovig
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
> > > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
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

> (And as far as I understand it, the term PWM_POLARITY_INVERTED isn't
> part of the DT ABI either. Only the value 1 has a meaning (for some PWM
> controlers).)
>=20
> > The third cell of the specifier is a bitmask of flags.
> >=20
> > PWM_POLARITY_NORMAL is an enumeration value that evaluates to 0, so it
> > makes absolutely no sense as a flag.
>=20
> Using 0 or PWM_POLARITY_NORMAL doesn't have an effect on the compiled
> device tree, that's true. But having the term PWM_POLARITY_NORMAL (in
> contrast to a plain 0) in a dts file is useful in my eyes for human
> readers.
>=20
> > PWM signals are considered to be "normal" by default, so no flag is
> > necessary to specify that.
>=20
> GPIOs are considered to be active high by default, still there is
> GPIO_ACTIVE_HIGH (which also evaluates to 0). Also there is
> IRQ_TYPE_NONE.

I'm aware of those. That doesn't mean that everything needs to have
symbolic names.

Thierry

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5yqUMACgkQ3SOs138+
s6GPcg/+N73P7VPsn68ABt9OMpT62+RvFprrJJFPeRfRvnxjtQfvnfdV5KblV8Z2
Cq2KKBVSeFkWWLLXWQHsBZYJ9oXXgkBHfIU4vdlkW55L8DWMyAztCu+0gob8tufk
u9AoYhvAfZN4hWa03WweDIFpX7jfbqeQCQ5LOygJDAcRb426xowyzNwGtMtXpHo4
Sl4KI08IN5WUFqG78ywvGIcogQ7Y4YTVYmU/wbPDrN2I65kqEn4YIZLWRes0t2gp
CF8DaJfUXPMPiutTpCqiq19Tvr95RbrIPaYCAOW9jdH6oo51q148ghg/03WuDuxD
Q3Q/B7ElsGw5Pw19jBGcVVXVOs60iZbkkMqtRWRGAvM+HKbADDYNyl1dVLH0yG9U
6Ac912W/rhdGsT6wSgZk3k+ecl4QhKfvxGrDqKzZ9zuVs8qDMYIiUPWzLxLolljG
bScb9XRW0O2ToPjGSQKZlKJj7vdC9eHwP3EM1/84oetS5AOajIL7DXhPtjtnOhhP
1T8sI2JT6uLoy9kQ5X9jQRi1yAkGfXGlHH8MyM5lr6kUFkoe2KBrV5hp6wDhi81b
AvYpL1vUilGov/jpaap4Z5Kx1KupIFvKmWWkGwsxFtCec5Onpvs9dpEOSXU7HWTE
rpN4N0KeMiUqd+NTCK3OV9R/OidbZMy5ewERSyxPVR7oGL3JpM8=
=VpZF
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
