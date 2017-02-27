From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/3] pwm: sunxi: Add A64 support
Date: Mon, 27 Feb 2017 08:44:58 +0100
Message-ID: <20170227074458.ivj5el2u4glhyrpw@lukather>
References: <20170225074216.64868-1-icenowy@aosc.xyz>
 <20170225074216.64868-2-icenowy@aosc.xyz>
 <CAGb2v67OaUps1yffyZ8pBvMwbAU+6WC2pPkt25e5i+SYU1nrDw@mail.gmail.com>
 <870861488014589@web9m.yandex.ru>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jlehaupqitc2vs5u"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBB65RZ7CQKGQEI4PV65Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <870861488014589-IyhJ2jtAr7tuio3avFS2gg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--jlehaupqitc2vs5u
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 25, 2017 at 05:23:09PM +0800, Icenowy Zheng wrote:
>=20
>=20
> 25.02.2017, 16:53, "Chen-Yu Tsai" <wens-jdAy2FN1RRM@public.gmane.org>:
> > On Sat, Feb 25, 2017 at 3:42 PM, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org> wrote=
:
> >> =C2=A0A64 PWM controller has same register layout as sun4i driver, so =
it works
> >> =C2=A0by adding A64 specific data.
> >>
> >> =C2=A0Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
> >> =C2=A0---
> >> =C2=A0=C2=A0drivers/pwm/pwm-sun4i.c | 9 +++++++++
> >> =C2=A0=C2=A01 file changed, 9 insertions(+)
> >>
> >> =C2=A0diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> >> =C2=A0index 1284ffa05921..ca3431e03fb8 100644
> >> =C2=A0--- a/drivers/pwm/pwm-sun4i.c
> >> =C2=A0+++ b/drivers/pwm/pwm-sun4i.c
> >> =C2=A0@@ -290,6 +290,12 @@ static const struct sun4i_pwm_data sun4i_pw=
m_data_h3 =3D {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.npwm =3D 1,
> >> =C2=A0=C2=A0};
> >>
> >> =C2=A0+static const struct sun4i_pwm_data sun4i_pwm_data_a64 =3D {
> >> =C2=A0+ .has_prescaler_bypass =3D true,
> >> =C2=A0+ .has_rdy =3D true,
> >> =C2=A0+ .npwm =3D 1,
> >> =C2=A0+};
> >> =C2=A0+
> >
> > This seems to be tha same as the H3. Any differences between the
> > H3 and A64? Otherwise please just use that compatible.
>=20
> H3 is also same as A13...
>=20
> See http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/4=
86595.html

What I meant was that you should have a compatible in your DT like this:

compatible =3D "allwinner,sun50i-a64-pwm", "allwinner,sun5i-a13-pwm".

There's no need to add a new one in the driver (for now).

And you still haven't fixed the size.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--jlehaupqitc2vs5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYs9j2AAoJEBx+YmzsjxAg/68P/jjnRUtaJyV2ytm1YLt2G+M/
HCpm8RT5fagzG5i5FraHNh94MghSS+uR4V8oTYgU0t5mej6hFC948IGvZcrjpNTR
iKFw2wHA4M+plsT7vWO8kTU25H5iXOJTcE/bjhWK/1UGYEJU/meMdghT4lQkBkdh
KxuRF7IqG9Oloh1ZO61TUqqfuA0t5WRmxpWckQVf1+sMAw4Eygh9vsFzb6JK+2ie
kOp6x7hv3w9C6umQI1xtD2v1hYtQ8EwTvTvQniNWcpPq8+rNTMG3HCY9j+QUtWJZ
7s9VQg4ZtlfHrtokeLwaC6iPzVmQYsZr5fXXdVfQ8RTWpb0peY+bfqIrZxvjoAn0
CsIcFoSZMkfiS1LFE79SEejNkfM63P3lZMZyz9yWlh0auyY95wCxjNSJn/ynztwG
vi5TSbVhIdXhcFs3OXPx35iZS9k5G4rSU2xvrBn+V6sgArpMMg+s5dSRh55GuZhk
RHdOwt4oqpzO+Y6OojTfQExEs1XacMhaLnsQHTnvEQfqnB9N2ub6gHchYYlcO5rv
gf1TKMWa1UQ3Flgz1mKxs4klkw3MWxoIo65LLpUpfHOWWkET5wdBe4F1Uhe6T+tP
izsGyq1w62J0iSkiMTEesjw9WuONAIOhnKeAFrVekPUWJ0Ed9yJ10TZ35rSD6G3k
/M0xcjTPVuQC0pFKDm4/
=Hc1t
-----END PGP SIGNATURE-----

--jlehaupqitc2vs5u--
