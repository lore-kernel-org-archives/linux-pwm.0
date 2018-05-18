From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 4/4] ARM: PWM: add allwinner sun8i pwm support.
Date: Fri, 18 May 2018 10:15:22 +0200
Message-ID: <20180518081522.eiwlqy2c2twc72qs@flea>
References: <20180225135308.GA14561@arx-s1>
 <20180226090038.etk5q4pd4rl5dvf6@flea.lan>
 <CAJeuY7-Dz1u9J8GMu=OdzJ2cJUnE3wEobJoQz6RV-ibjBjoW4A@mail.gmail.com>
 <20180515111711.l2g4vgsal7yr6dbr@flea>
 <CAJeuY79ObkssY_=SLG==7xZri10P3yWFhXC3=CUVrdQ+7cBoHA@mail.gmail.com>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tpj24l2pqvmxxz5t"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBG4X7LLQKGQEACVSIOI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <CAJeuY79ObkssY_=SLG==7xZri10P3yWFhXC3=CUVrdQ+7cBoHA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Hao Zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Claudiu Beznea <Claudiu.Beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--tpj24l2pqvmxxz5t
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2018 at 10:48:58PM +0800, Hao Zhang wrote:
> 2018-05-15 19:17 GMT+08:00 Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>:
> > Hi,
> >
> > On Mon, May 14, 2018 at 10:45:44PM +0800, Hao Zhang wrote:
> >> 2018-02-26 17:00 GMT+08:00 Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>:
> >> > Thanks for respinning this serie. It looks mostly good, but you stil=
l
> >> > have a quite significant number of checkpatch (--strict) warnings th=
at
> >> > you should address.
> >>
> >> Thanks for reviews :) ,i'm sorry for that, it will be fixed next
> >> time.  and, besides, in what situation were the checkpatch warning
> >> can be ignore=EF=BC=9F
> >
> > The only one that can be reasonably be ignored is the long line
> > warning, and only if complying to the limit would make it less easy to
> > understand.
> >
> >> >
> >> > On Sun, Feb 25, 2018 at 09:53:08PM +0800, hao_zhang wrote:
> >> >> +#define CAPTURE_IRQ_ENABLE_REG       0x0010
> >> >> +#define CFIE(ch)     BIT(ch << 1 + 1)
> >> >> +#define CRIE(ch)     BIT(ch << 1)
> >> >
> >> > You should also put your argument between parentheses here (and in a=
ll
> >> > your other macros).
> >>
> >> Do you mean like this ?
> >> #define CFIE(ch)     BIT((ch) << 1 + 1)
> >> #define CRIE(ch)     BIT((ch) << 1)
> >
> > Yep, exactly. Otherwise, if you do something like CRIE(1 + 1), the
> > result will be BIT(1 + 1 << 1), which will expand to 3, instead of 4.
> >
> > Also, CFIE looks a bit weird here, is it the offset that is
> > incremented, or the value? You should probably have parentheses to
> > make it explicit.
>=20
> The vallue,
> BIT(((ch) << 1) + 1) It seem not very nice...
>=20
> uhmm...
> In CAPTURE_IRQ_ENABLE_REG odd number is CFIE, even number is CRIE
> each channel has one CFIE and CRIE.
>=20
> we can also describe like this:
> #define CFIE(ch)     BIT((ch) * 2 + 1)
> #define CRIE(ch)     BIT((ch) * 2)

That works for me.

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

--tpj24l2pqvmxxz5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr+i5kACgkQ0rTAlCFN
r3TAQQ/+LQG/hSPZpDRYqeSWNaIQwLG2uiGt/6GGDsa5UJn/YaPkWZ2TgsZ9nUZb
fuqujyDzT/PKs5e8LcXlm1pVyILaKnVGW8zQsjIpG1mYkFJ16UAt7uLYxWAvHaoZ
G9OdXBr+hpnpjbQNW2TXLyTE/H9BcjDlJ9mvOQsgrOnVZYzvi9qlpkk7GKzSTwCR
k+StqmdoqfdGaQ/xmaNdRjYaDLi2YB1fEOPPvZYc3gSmEz6QhQFKy41LIw4eW232
lYmutv/S2EdaajimkLRENJsfL+BZZF41VQlKrgFPzZGMjv0Tx05hqheBJK3SID9P
z9Y65fbsqj4r+HKa7UyEV3NI+gr5UVhVB/OFCaelsE6P1Zl0gTqUXyxXHS5UyXvV
lga7bGPDGlEtfr6g8oOPrPKUusipmyncGeZbo2GuU2k2lc0uApNTGdAjtnlNhp+G
QiUYoQHnPJSltAsdLD4rUNyc6qISVvEGxbqvkTdSCJ2Qgtxd+fHmMNiHmMtyd9aw
fv12TzUFjRR2ISnZHkYYQjjUBMSmvpD7DEn6xLPV9+7ZfvzCBGNNl6cen7qd590j
vMmalYbEySaU7aS6hL4cv80ET4lfqIiqQvWXu6TO+cX+2ubkf1b8i5xyZ2n6rnxp
4NJX1XjwH1rBj0ozeWYqGYEL3a09kpnLshL6AumloS1rX3fNUO0=
=p0B0
-----END PGP SIGNATURE-----

--tpj24l2pqvmxxz5t--
