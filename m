From: Otto Sabart <ottosabart@seberm.com>
Subject: [PATCH 1/1] doc: gpio-mvebu: fix broken reference to
 cp110-system-controller0.txt file
Date: Wed, 9 Jan 2019 20:07:41 +0100
Message-ID: <8fd140950dd0bb859f9a48d8b25fb919cbb3cc6b.1547059503.git.ottosabart@seberm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pwm@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The cp110-system-controller0.txt file was renamed to
cp110-system-controller.txt.

Fixes: 4aa5496980e4 ("dt-bindings: cp110: rename cp110 syscon file")
Signed-off-by: Otto Sabart <ottosabart@seberm.com>
---
 Documentation/devicetree/bindings/gpio/gpio-mvebu.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Docume=
ntation/devicetree/bindings/gpio/gpio-mvebu.txt
index 38ca2201e8ae..2e097b57f170 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
@@ -14,8 +14,6 @@ Required properties:
=20
     "marvell,armada-8k-gpio" should be used for the Armada 7K and 8K
     SoCs (either from AP or CP), see
-    Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0=
=2Etxt
-    and
     Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.=
txt
     for specific details about the offset property.
=20
--=20
2.17.2


--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlw2Rn4ACgkQgjuumfi+
Hjxfiw/9Fk7Ox0asGlTrDCjLScq8iEd1p1iAgMz26Ut5NKHWaKqBEGajxQIhQnUN
utxLjTWH8QDcGItpbzvTYcnKrF+mRhcpDvHZ/O8dhac5ZYA7qcA/106aRB/MSogh
u3/GeVNokIGUtXi8xepJvm9vmYnhdgqOild8hxc9Frr1x26ORpgPBbWurcf7YFZJ
SET3fv86kPjPWaLakjT67ULGPhhX5RxJv8M4QllsyLJfvBntrxH5ACMovdTciV8A
PBEWQQ1gMlD4cCnrvviuG/ySZig0JCG2DcYWaZsp8yOw+zYFExavgSHkoxESFC/P
1UoVldOmp5QKGOMYfrD4SjysZJnaLhsw/kJVGDwTiHtXc5iYd95Jercp47Vmd8TJ
u2bkmgEIVlCkAiMjZBuYlxr0HI6kISe55V+FqCtco3q8/ZUQCnUOsL3gkFDMtepq
2fvD9Lw9Crr3lrcnCZVLJYMAZ8oKxNSQCuMCZjMiHeJyE7T1yNJbK80QruG4tKO1
k504yGakideglEWAXUJaKuevEBGALwxLBZu+EkMFdBHPGLcbALNcfAIhbdniX6lQ
o6+XZkHxrU4hxnyZtnFJTucPSQ1oLcCqgEF5PtasXnhCmTWF6wGsc0EN4tWWIq0E
pWvNLfoaHb4CS4PeDSP04GA63D1A6t7FSH+fHmhswgUS2PpoQ1U=
=/a7b
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
