From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [resend PATCH 1/3] pwm: mediatek: drop flag 'has_clks'
Date: Fri, 16 Nov 2018 11:22:44 +0100
Message-ID: <20181116102244.GB14769@ulmo>
References: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
 <20181114124752.GI2620@ulmo>
 <20181116064748.6c7shn3am4wejrnj@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181116064748.6c7shn3am4wejrnj@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, Weijie Gao <weijie.gao@mediatek.com>, Roy Luo <cheng-hao.luo@mediatek.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>
List-Id: linux-pwm@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 07:47:48AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Nov 14, 2018 at 01:47:52PM +0100, Thierry Reding wrote:
> > On Tue, Nov 13, 2018 at 10:08:22AM +0800, Ryder Lee wrote:
> > > The flag 'has_clks' and related checks are superfluous as the CCF
> > > subsystem does this for you.
> >=20
> > Both of these mechanisms aren't equivalent. While CCF can deal with
> > optional clocks, what the has_clks flag actually means is that the
> > device doesn't need a clock (or doesn't have a clock input) on the
> > devices where it is cleared.
> >=20
> > So I'd actually be in favor of keeping the has_clks property because it
> > serves as an additional sanity check. For example if you run this driver
> > on an SoC that "has clocks" but if you don't list them in DT, then after
> > this patch the driver will happily continue without clocks, even though
> > it may break completely without those clocks. I've seen SoCs respond to
> > disabled clocks for a hardware block in different ways, in many cases an
> > access to any of the registers will completely hang the CPU. In other
> > cases it may just crash in some other way or give you some sort of
> > machine exception. None of those are good, and make the tiny bit of
> > additional code required to support the has_clks flag very attractive.
> >=20
> > But that's just my opinion. If you prefer to throw away that safety
> > barrier, be my guest. But if you do, please move this functionality into
> > the clock framework first and then make the driver use it.
>=20
> The usual policy is: If the things specified in the dt are
> wrong or incomplete, it's ok to fail however you like. So from a
> correctness POV I think the change is fine.

Erm... that's pretty much what I said. It doesn't necessarily mean that
it's the right thing to do, though. If we know that clocks are required
and we don't find them in DT, it's better to complain and let the user
know exactly what is wrong rather than just let it crash and have them
track down the bug without additional information.

Thierry

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvumnQACgkQ3SOs138+
s6FeCg/+IGbZAVX4NM9KqGMAlCKbZZHB50ybxRy44LZmoepfGNAyx/aTSRIUqJPJ
nZpBi4xS+lDw2cDg9yhBkIGbDvcKZciTsR7zq2AEPgg0jeigRlqZk0uTSkzJdYnA
WcNnv1MW8L3X74MpLlBVU7iqpQb1ihj3VaLgqH7ySdMVp70G+b18SSZYjxoxvsGP
9PbCroW823NhLfNLLYe6Goc3B2AzHFY3imB0wHhE3qPCewxT5qv9v7VqGRozGR4Y
Ne2gY738btUEPCiU/1ncMzNQ3zSB16ip3YUSX7abJFf8FGR2W9EZZ0KzNsNPreV/
hEDF56dJNDDB3HrpxW7t4KBOzct2tbjWLQLKNuDYxshdsOolNIb7IgtOCiddTHi/
Yo+vA74iquxsAFlL5bjWwkSyem6UeZFztBt6IQHL/WvaiosrvxGzYau061Nf3E6T
q+13Bv3bUKU3H2Fm8bLi1OnRkENUsbHurzXY+Q9uw8i0k08FIf8lH2LbDYs6E7U7
lLYfQhAaJlurHPepdctFzCZGXpUStYu/sVj/QDbhqPssXi6/AgiMcYnWLxufWDwN
/wKfjMAg9AmBpXuZTmDJBQF6KuUzDsAhvhxcbHgpfO/8tAMHC2aDKp6dTmAvC3/W
VNo/2hmln98pZlhy+cqhjygcqXl77BnSBUKSS/h1UjTuIeBvi+k=
=oX8L
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
