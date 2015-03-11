From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: atmel-hlcdc: add errata handling for sama5d4
Date: Wed, 11 Mar 2015 12:00:56 +0100
Message-ID: <20150311110055.GE22149@ulmo.nvidia.com>
References: <1424447898-2791-1-git-send-email-nicolas.ferre@atmel.com>
 <20150220170613.424edbb5@bbrezillon>
 <54E7603A.5010309@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y2zxS2PfCDLh6JVG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54E7603A.5010309@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org


--y2zxS2PfCDLh6JVG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2015 at 05:26:34PM +0100, Nicolas Ferre wrote:
> Le 20/02/2015 17:06, Boris Brezillon a =C3=A9crit :
> > Hi Nicolas,
> >=20
> > On Fri, 20 Feb 2015 16:58:18 +0100
> > Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> >=20
> >> sama5d4 SoC also has an errata on the HLCDC PWM. It is the same as the=
 sama5d3
> >> that is forbidding the use of div1 prescaler.
> >>
> >> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> >=20
> > The "atmel,sama5d4-hlcdc" compatible string is not yet documented in
> > the atmel-hlcdc MFD driver binding, but this shouldn't hurt, so
>=20
> Yes, I'll document it when I'm submitting your patches that add the
> compatibility strings to the drivers/mfd/atmel-hlcdc.c. (with
> atmel,at91sam9x5-hlcdc as well).
>=20
> > Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

I'll take your word on it that this will be documented, so I've applied
this.

Thanks,
Thierry

--y2zxS2PfCDLh6JVG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVACBmAAoJEN0jrNd/PrOhvNsP/AphKx3yD1lNj9s3cHEpP1Jp
niZYstQe+70qb7KJrZMhq2xim2MysHRisfHpo7URegExDQQNZuTiaZVJQRwhtEIQ
g1ySaMkl46g0ByYhqyAMKnwbyqbl5LRx9zqM5PMff2GsG8mBC1S8XjRejuqnOi4j
MrcKDZfhAtbpbHH8Eu9Q/Y2T0joiWlsVDGnSAk93fcySGdJYBxt0hFt2g0RnoPo6
avQ026qVxj/3GbOgfwtwtrZrrDg5M69MgqO7RGcQytyORRP03t/6+g6pyKO/KKQl
+jmxj3Jn8bZ8peZ3S+aj92hvImjQjPNH0ZFHsKeARZFiZrdK5JSjIFzJ5pLhXQwY
+O5o/ctaYai5jhTd+2pvdJGTxPM7x92nNOIV8/2klB7Zjp8/7NnLgyJEBTRMdYfc
e5vIvDmSPoL549UxspgSH56jThfrbBo1P+IK/YQjA57aJdIQay7fazOSaryqr6R8
kJEb0G7czTv1JyQyt0Oos/WA6nIZwtD82l87FPqGLngj2JqOt5Qbw52Jq7CeIw2W
JbGUXh2CWq8mnshUZg3OiInTc2DNRXtWl4qKoJWOFNHTJ7K60CJo47Got8okBWaJ
skLN33yt6DL1/M9H67AuPjkwYMPfkGGIyrvKKlACaBw96xQfGiL4/6iC++vgzLzv
WNHjxxrgRvcqorF6eXR4
=o1Bo
-----END PGP SIGNATURE-----

--y2zxS2PfCDLh6JVG--
