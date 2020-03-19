From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 2/7] dt-bindings: pwm: document the PWM polarity flag
Date: Thu, 19 Mar 2020 18:04:55 +0100
Message-ID: <20200319170455.GC3354541@ulmo>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-3-oleksandr.suvorov@toradex.com>
 <20200317174344.GB1464607@ulmo>
 <20200317213056.futfiwn4qgr2njye@pengutronix.de>
 <20200318230539.GB2874972@ulmo>
 <20200319070510.gc6hr53gn7n2osvb@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200319070510.gc6hr53gn7n2osvb-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Barker <pbarker-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Marcel Ziswiler <marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Igor Opaniuk <igor.opaniuk-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Philippe Schenker <philippe.schenker-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2020 at 08:05:10AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Mar 19, 2020 at 12:05:39AM +0100, Thierry Reding wrote:
> > On Tue, Mar 17, 2020 at 10:30:56PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > Hello Thierry,
> > >=20
> > > On Tue, Mar 17, 2020 at 06:43:44PM +0100, Thierry Reding wrote:
> > > > On Tue, Mar 17, 2020 at 02:32:26PM +0200, Oleksandr Suvorov wrote:
> > > > > Add the description of PWM_POLARITY_NORMAL flag.
> > > > >=20
> > > > > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
> > > > > ---
> > > > >=20
> > > > >  Documentation/devicetree/bindings/pwm/pwm.txt | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Docu=
mentation/devicetree/bindings/pwm/pwm.txt
> > > > > index 084886bd721e..440c6b9a6a4e 100644
> > > > > --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> > > > > +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> > > > > @@ -46,6 +46,7 @@ period in nanoseconds.
> > > > >  Optionally, the pwm-specifier can encode a number of flags (defi=
ned in
> > > > >  <dt-bindings/pwm/pwm.h>) in a third cell:
> > > > >  - PWM_POLARITY_INVERTED: invert the PWM signal polarity
> > > > > +- PWM_POLARITY_NORMAL: don't invert the PWM signal polarity
> > > >=20
> > > > This doesn't make sense. PWM_POLARITY_NORMAL is not part of the DT =
ABI.
> > >=20
> > > "is not part of the DT ABI" is hardly a good reason. If it's sensible=
 to
> > > be used, it is sensible to define it.
> >=20
> > That's exactly it. It's not sensible at all to use it.
>=20
> If you think the argument is "It is not sensible to be used." then please
> say so and don't add "PWM_POLARITY_NORMAL is not part of the DT ABI."
> which seems to be irrelevant now.

I did say that, didn't I? I said that it doesn't make sense because it
isn't part of the ABI. And since this is the document that defines the
DT ABI, why should we add something that isn't part of the ABI?

Now, if you want to make this part of the ABI, then that should be done
as part of this patch so that the patch is actually consistent.

> > If you define it here it means people are allowed to do stuff like
> > this:
> >=20
> > 	pwms =3D <&pwm 1234 PWM_POLARITY_INVERTED | PWM_POLARITY_NORMAL>;
> >=20
> > which doesn't make sense.
>=20
> I would hope that a human reader would catch this.

Maybe. At the same time we're now moving towards automatic checking of
device trees against a binding. These tools will only ever see the
binary representation, so won't be able to spot this nonsense. The whole
purpose of having these tools is so that we don't have to do the tedious
work of manually inspecting all device tree files. It's also not
guaranteed that we'll even be seeing all of the device tree files ever
written against these bindings.

>=20
> > What's more, it impossible for the code to even notice that you're
> > being silly because | PWM_POLARITY_NORMAL is just | 0 and that's just
> > a nop.
>=20
> I think this argument is a bad one. Whenever you introduce a
> function or symbol you can use it in a wrong way. With this argument you
> can also say GPIO_ACTIVE_LOW doesn't make sense because
>=20
> 	pwms =3D <&pwm 1234 GPIO_ACTIVE_LOW>;
>=20
> is silly.

Yes, it's also obviously silly to try and eat a hammer. I was assuming
people have at least /some/ sense and try not to use GPIO related flags
with PWM specifiers. And because I think that people aren't totally
stupid, I think they'll be capable of understanding that by default a
PWM will be "normal" and only if they want to deviate from "normal" do
they need to do something special, like specify PWM_POLARITY_INVERTED.

I'm growing tired of this discussion, to be honest. So if you really
absolutely must have PWM_POLARITY_NORMAL so that you can read DT files
without having to think, then fine, I'll take a patch that adds that.
But please let's not confuse the definitions for DT with the polarity
enum in the API.

Thierry

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5zpjQACgkQ3SOs138+
s6HFjg//bYCq9+SPY2/y5xYub6u1UZ/gQnGt3lAjF0sQFhvO5DRux4OMJpsDWrry
3/HGGq8lvnsjeLHK8a0h5mlTWruNfq4LzF+q5jFIYQENARZsfQSEJMw8e1XS5tnP
CDOuTN2yHAdZMACBso687GfeQAMEVC3wAF9FVB2rOs+V06TKQvjI9F8l8/RVM/0f
B4E+DHaIxSrzp80r0XnF2MXlVbm/gDCVDPfKrdF2mnRrp6M0Wz32yuZArCpsAWWH
J26o7REYk9GP/oCXyx8tKzr0wmrzKKT/O4Qq20cR7Rk/IdNKonhEd4PrZJ9QCEOs
FMbQBtoSHr9eW1O40y7z5aVCNRQv0u6507x/lkw1exstlBR/CGWe07YQGex71bvK
3c4Z/mw7bXK+T5XhGh2qHBpRRB3kUtnZbubZHm6AMflLVejEBeEa07Git64RevSL
L4q/9Nt7SRpmcvahvdPj11cBo2hDcYO4KOsuiPD2IVdcz0KHCmSVFLpFqYMjOhYs
r4WXQAyB6fcDxiTsPnse+xX6rJyDgJ9qD8TsVgn3/Pj0ToMQsyosaeLoX3o3rH9u
EpzEhLaHJCVa9wMwknSDLyaejnEw84a/l6fECe28V3KYpJ6MT+EuWqYQSjOY4seE
lSSil7t0zWcEwwH4EVdgjFe/68jrNsBJEcwBpvwnwVmer5xzogg=
=t8el
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
