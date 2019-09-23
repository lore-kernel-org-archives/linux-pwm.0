From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v9 07/11] dt-bindings: pwm: pwm-mediatek: add a property
 "num-pwms"
Date: Mon, 23 Sep 2019 15:36:26 +0200
Message-ID: <20190923133626.GA4671@ulmo>
References: <1568933351-8584-1-git-send-email-sam.shih@mediatek.com>
 <1568933351-8584-8-git-send-email-sam.shih@mediatek.com>
 <20190921002149.GB86019@mithrandir>
 <1569208857.4102.9.camel@mtksdccf07>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1569208857.4102.9.camel@mtksdccf07>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Shih <sam.shih@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: linux-pwm@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2019 at 11:20:57AM +0800, Sam Shih wrote:
> On Sat, 2019-09-21 at 02:21 +0200, Thierry Reding wrote:
> > On Fri, Sep 20, 2019 at 06:49:07AM +0800, Sam Shih wrote:
> > > From: Ryder Lee <ryder.lee@mediatek.com>
> > >=20
> > > This adds a property "num-pwms" in example so that we could
> > > specify the number of PWM channels via device tree.
> > >=20
> > > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > > Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> > > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > > Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Changes since v6:
> > > Follow reviewers's comments:
> > > - The subject should indicate this is for Mediatek
> > >=20
> > > Changes since v5:
> > > - Add an Acked-by tag
> > > - This file is original v4 patch 5/10
> > > (https://patchwork.kernel.org/patch/11102577/)
> > >=20
> > > ---
> > >  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > You failed to address Rob's questions repeatedly and I agree with him
> > that you can just as easily derive the number of PWMs from the specific
> > compatible string. I won't be applying this and none of the patches that
> > depend on it.
> >=20
>=20
> Hi,=20
>=20
> Thanks for getting back to me.
>=20
> New pwm driver (patch 04/11 : "pwm: mediatek: allocate the clks array
> dynamically") can support different variants with different number of
> PWMs by the new property <num-pwms>
>=20
> For example:
> 1. Use "num-pwms" =3D <2> and assign clocks pwm1, pwm2 for mt7622
> 2. Use "num-pwms" =3D <6> and assign clocks pwm1, pwm2, pwm3, pwm4, pwm5,
> pwm6 for mt7622.
>=20
> If we just as easily derive the number of PWMs from the specific
> compatible string in this document:
>=20
>    - "pwm1-6": the six per PWM clocks for mt7622
>   =20
> This looks like all "pwm1", "pwm2", "pwm3", "pwm4", "pwm5", "pwm6" is
> required property in DT, It doesn't make sense.

I don't understand. Why doesn't that make sense? If your hardware block
has 6 PWMs and each can be driven by its own clock, then you need to
provide references for each of those clocks, otherwise you won't be able
to use them.

>   =20
> So we removed those descriptions and added =20
>=20
>    - "pwm1-N": the PWM clocks for each channel=20
>   =20
>   =20
> But the max number of clocks from the compatible string are still
> important information that should be provide in this document.
>=20
>=20
> What do you think of this?
>=20
>    - "pwm1-N": per PWM clocks for mt2712, the max number of PWM channels
> is 8
>=20
>    - "pwm1-N": per PWM clocks for mt7622, the max number of PWM channels
> is 6
>=20
>    - "pwm1-N": per PWM clocks for mt7623, the max number of PWM channels
> is 5

That's what's in the bindings already, isn't it?

	 - clocks: phandle and clock specifier of the PWM reference clock.
	 - clock-names: must contain the following, except for MT7628 which
			has no clocks
	   - "top": the top clock generator
	   - "main": clock used by the PWM core
	   - "pwm1-8": the eight per PWM clocks for mt2712
	   - "pwm1-6": the six per PWM clocks for mt7622
	   - "pwm1-5": the five per PWM clocks for mt7623

Note that the description of the "clocks" property isn't quite accurate.
It should be something like:

	- clocks: One phandle and clock specifier for each entry in the
	          "clock-names" property.

In the above you clearly describe which PWMs you have to specify for
each generation of the hardware block.

>=20
>    where N starting from 1 to the maximum number of PWM channels
>    - num-pwms: the number of PWM channels.

That's redundant information. The specific number of PWMs in already
implied by the compatible string, so you don't need to duplicate that
information here.

Thierry

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2IylEACgkQ3SOs138+
s6EpJg//QC3ldqkwsoa+KY+dhrpZlAxv2zdjRAxF8rCag6XtDLtIlvV66zVQeowZ
5+NMRQqJHAdqFzNPZO8wxH7Dkiexw50Wpa64Xb1JEyVAmotqvfiyJr59MG9CGZ+T
EW7o+U8WHGdVT6xtkUZ17QQHK6OqvitX8GmXU746FXuza5zYkp3quVFtjQ1V2GNR
N2s3dvvfhIcqjm0GhN310Pp2vHCyczDmpCbppC+QNfkArUCW25oDFck69ceBdXXG
1UjtIasUcEoTC8qrK31Yk2GctIxkF0KiPKX24Kuk3oDTqCb3Acp/eNQmE3j0zs+1
+3a2Xgs5jADOprnJLpszBvlO+PKCybVAAhW65QgcH67spbgNVxuhXCjmSpplelfI
F7FJEbz+nI2Az36ogFtewhvVPFa5SqPKUEygCjE5eRd62HooiUiEK/zXbBfE5eNm
72viYDW0wwkmqjLIuahyji2HMlu3ImG3moqiQH1OaZkaivONUzWqn2fsEVdQaI4I
o41UMHnZNWs7znhcs2SeGZNrLSvC4mdetpXDOuVr9WWqunzIckHDabA/hm5yMvFD
l/Oiyyv9AcIICgAFBXq1+4bfbztgS7wAek6JDYRUHBj4jBI+3J0zEvK7ah246wlg
pp+mPQhPxMx+VbEpB5BVx0/KB1eQ6+8E9+zyB227JdD4oLR3G9Y=
=Za9m
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
