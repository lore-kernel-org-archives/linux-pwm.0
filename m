From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 4/4] ARM: PWM: add allwinner sun8i pwm support.
Date: Tue, 15 May 2018 13:17:11 +0200
Message-ID: <20180515111711.l2g4vgsal7yr6dbr@flea>
References: <20180225135308.GA14561@arx-s1>
 <20180226090038.etk5q4pd4rl5dvf6@flea.lan>
 <CAJeuY7-Dz1u9J8GMu=OdzJ2cJUnE3wEobJoQz6RV-ibjBjoW4A@mail.gmail.com>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gknln4zbx57iat3f"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBQUD5PLQKGQEVBG6DFQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <CAJeuY7-Dz1u9J8GMu=OdzJ2cJUnE3wEobJoQz6RV-ibjBjoW4A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Hao Zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Claudiu Beznea <Claudiu.Beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--gknln4zbx57iat3f
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 14, 2018 at 10:45:44PM +0800, Hao Zhang wrote:
> 2018-02-26 17:00 GMT+08:00 Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>:
> > Thanks for respinning this serie. It looks mostly good, but you still
> > have a quite significant number of checkpatch (--strict) warnings that
> > you should address.
>=20
> Thanks for reviews :) ,i'm sorry for that, it will be fixed next
> time.  and, besides, in what situation were the checkpatch warning
> can be ignore=EF=BC=9F

The only one that can be reasonably be ignored is the long line
warning, and only if complying to the limit would make it less easy to
understand.

> >
> > On Sun, Feb 25, 2018 at 09:53:08PM +0800, hao_zhang wrote:
> >> +#define CAPTURE_IRQ_ENABLE_REG       0x0010
> >> +#define CFIE(ch)     BIT(ch << 1 + 1)
> >> +#define CRIE(ch)     BIT(ch << 1)
> >
> > You should also put your argument between parentheses here (and in all
> > your other macros).
>=20
> Do you mean like this ?
> #define CFIE(ch)     BIT((ch) << 1 + 1)
> #define CRIE(ch)     BIT((ch) << 1)

Yep, exactly. Otherwise, if you do something like CRIE(1 + 1), the
result will be BIT(1 + 1 << 1), which will expand to 3, instead of 4.

Also, CFIE looks a bit weird here, is it the offset that is
incremented, or the value? You should probably have parentheses to
make it explicit.

> >
> >> +static const u16 div_m_table[] =3D {
> >> +     1,
> >> +     2,
> >> +     4,
> >> +     8,
> >> +     16,
> >> +     32,
> >> +     64,
> >> +     128,
> >> +     256
> >> +};
> >
> > If this is just a power of two, you can use either the power of two /
> > ilog2 to switch back and forth, instead of using that table.
>=20
> I think using table is more explicit and extended...

If you didn't have a simple mapping between the register values and
the divider value, then yeah, sure. But it's not the case here.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--gknln4zbx57iat3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr6waEACgkQ0rTAlCFN
r3RPFw/+JeurQEegEMeIm4JNTp7dnYT+zmfEGSK062yJIhYgiCXgWxxyqPd+2SnZ
w0VoeGkC7ylD3R/5oRt5CCm2dce9JaOSJhYjRXU3zBsYicXQpWF0SgSgg8rfhmVb
YFxPLqXYkW21szGXpufgx2en04pq9B1++FqbrgQzdKz4wc2UVGn9Ywz/se7FEDb1
ACqJyolA3e7XiFJv3jhtZimoHGr1MReBNgPiwS9sHrGweB03R/NUfeb04G9w/ARo
6DdeyHWjH+36TpZCzwMQPXwrqYpSjbFYEKf5vjVc2PB848+2h7p2vSmym/26vCkC
xXvS/b/mNlp6EIEIWQs4ZdQKrYR4pCZq9M4WneBiLtVlq+ygiFn7uKeFGRjJukno
iEiJrG3jOhnR2/37222rt/DZkb6oofJPtKyJadVwakQ3pFLeE8dB4a8xqsoHHoj1
aPMzZhovzRNkWRZoeffbegOEVTahVABjrEiHuQb+8NDYbpb137pEHWJTRiBUhV+4
h10Ez1d2OvugF7kZlkw2IVuzXdp4C5n3JMenTJ12el1JrjO7bfi+ddPVs3B/Iy7b
CbPG/Ex+RAEULULg8dhpNmuweF5GN9pUlsAoxpPC/33Lg3Zx3AXyAdqWpjOLE0U7
nOsqUEPtnywqyu7xGwPFN8LDagoXEhXn1V8vVEQUm3KNpvlFxgs=
=apZD
-----END PGP SIGNATURE-----

--gknln4zbx57iat3f--
