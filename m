From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: sun8i: Add PWM pin in H3
Date: Thu, 1 Sep 2016 21:51:12 +0200
Message-ID: <20160901195112.GG20462@lukather>
References: <20160831082520.25962-1-woogyom.kim@gmail.com>
 <20160831082520.25962-2-woogyom.kim@gmail.com>
 <20160831162002.GI14379@lukather>
 <998fe271-138b-ea4a-99ac-4cd75eefc9c4@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3578557489034678575=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <998fe271-138b-ea4a-99ac-4cd75eefc9c4@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Milo Kim <woogyom.kim@gmail.com>
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--===============3578557489034678575==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vSsTm1kUtxIHoa7M"
Content-Disposition: inline


--vSsTm1kUtxIHoa7M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 01, 2016 at 10:06:12PM +0900, Milo Kim wrote:
> On 09/01/2016 01:20 AM, Maxime Ripard wrote:
> >Hi Milo,
> >
> >On Wed, Aug 31, 2016 at 05:25:17PM +0900, Milo Kim wrote:
> >>H3 PA5 pin is assigned for single PWM channel.
> >>
> >>Cc: Rob Herring <robh+dt@kernel.org>
> >>Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> >>Cc: Chen-Yu Tsai <wens@csie.org>
> >>Cc: devicetree@vger.kernel.org
> >>Cc: linux-arm-kernel@lists.infradead.org
> >>Cc: linux-kernel@vger.kernel.org
> >>Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> >>---
> >> arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
> >> 1 file changed, 7 insertions(+)
> >>
> >>diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-=
h3.dtsi
> >>index fdf9fdb..05d0c4b 100644
> >>--- a/arch/arm/boot/dts/sun8i-h3.dtsi
> >>+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> >>@@ -360,6 +360,13 @@
> >> 				allwinner,pull =3D <SUN4I_PINCTRL_NO_PULL>;
> >> 			};
> >>
> >>+			pwm0_pin_a: pwm0@0 {
> >>+				allwinner,pins =3D "PA5";
> >>+				allwinner,function =3D "pwm0";
> >>+				allwinner,drive =3D <SUN4I_PINCTRL_10_MA>;
> >>+				allwinner,pull =3D <SUN4I_PINCTRL_NO_PULL>;
> >>+			};
> >>+
> >
> >Is it used on any boards?
> >
> >If not, we have the policy of not merging the pinctrl nodes that are
> >not used by anyone to avoid bloating the DT for no particular reason.
>=20
> Yes, I have. It's Nano Pi M1 which was derived from Orange Pi PC.
> The board DTS is ready to be sent out, but I'm not sure which is better.
>=20
> 	a) Send new board DTS file in other patch thread
>=20
> 	[PATCH v3 0/4] Add PWM feature in Allwinner H3
> 	[PATCH v3 1/4] ARM: dts: sun8i: Add PWM pin in H3
> 	..
> 	[PATCH v3 4/4] pwm: sunxi: Add H3 support
>=20
> 	[PATCH] ARM: dts: sun8i: Add Nano Pi M1 support
>=20
> Or
>=20
> 	b) Include the DTS in next patch-set v3
> 	[PATCH v3 0/4] Add PWM feature in Allwinner H3
> 	[PATCH v3 1/4] ARM: dts: sun8i: Add PWM pin in H3
> 	[PATCH v3 2/4] ARM: dts: sun8i: Add PWM controller node in H3
> 	[PATCH v3 3/4] ARM: dts: sun8i: Add Nano Pi M1 support
> 	...

Generally speaking, I'd prefer:

[PATCH v3 1/2] pwm: sunxi: Add H3 support
[PATCH v3 2/2] ARM: dts: sun8i: Add PWM controller node in H3

(It's usually better to add support for something and then add it)

And then

[PATCH v1 1/2] ARM: dts: sun8i: Add PWM pin in H3
[PATCH v1 2/2] ARM: dts: sun8i: Add Nano Pi M1 support

However, judging from the board documentation, that pin is labelled as
PWM1/GPIOA6, which means that they don't enforce any usage on that pin
(as opposed to the pin 3 and 5 for example, which are forced to i2c0).

In such a case, we also don't enforce anything, since any user should
be able to use it for whatever he or she wants.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--vSsTm1kUtxIHoa7M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXyIawAAoJEBx+YmzsjxAgjGQQAIZeKSxS4jPsfrpkXDL22AAp
W7aPszwpQCgCwEZxxnq7PGTg4ALe7zInBlLE9povrJQd7UPI0BOizN/vgDnTbVuF
fhdFt6tePUByNYYwz4E1XilUqcHWEUYp3n9euBWAspvFP7PCoU+H1sBDnAB8aVBT
/zIM9IIqnT8vPJIzugBF35P/zePAKXnyl0lrkM6emzQIFyA4QDt/FRKC0d2LkJsJ
ZiN7Q9E2gflwoTBqdWPctk3Wzb+RkI7xqVHG012vryp+jPYuvPG1/S7fHgRFSxv9
y8jNPLaBKfJFTk1sqpxxY8dd6bvqxVnkieiHYgNhlbNvSNWW5cgIIbZKFXURKsTl
gch2jO6szIy6OWHaMqdUh+3QAEvy7CkVqkHCEi6pAXWea+ADqoDeOp1zTsRI/JTp
38+jpwD+UP2jFaxZOzAQxY3m7T8X5EScoiX0Ck3IrM34E0NuzDM23wGzNhnnlQ0e
icL2LcBby8Il5pdiDrXC/M6CEOGPVhz727Lp1zlQ3EfzJ/baWjbNLf4d4cTx78Am
udk4fp0dtUX0KQhW+G/T+D/6w6jEgCBI+zWFPqlS0/Xsfqosg56QEKA0fKXs38j7
qlL1ZN6XYFs4mZ2Ji6pcrgMWOtlT5taf3rhG+mBdpgy6HGQ4xY92yRu9j5Ytb5WW
JFc28UJaj4EqewGD65mj
=PIe0
-----END PGP SIGNATURE-----

--vSsTm1kUtxIHoa7M--


--===============3578557489034678575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3578557489034678575==--
