Return-Path: <thierry.reding@gmail.com>
Date: Tue, 27 Mar 2018 23:52:17 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4] dt-bindings: pwm: rcar: Document r8a774[35] PWM
 bindings
Message-ID: <20180327215216.GA28163@mithrandir>
References: <1513768543-7943-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <1513768543-7943-1-git-send-email-fabrizio.castro@bp.renesas.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2017 at 11:15:43AM +0000, Fabrizio Castro wrote:
> This patch adds compatible strings specific to r8a774[35], no driver
> change is needed as the fallback compatible string will activate the
> right code.
>=20
> Also, this patch replaces the example with a DT snippet used
> for adding PWM0 support to an r8a7743 based platform as the r8a7743 is
> now the first platform fully compatible with this driver and its PWM DT
> nodes refer to up-to-date code.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3->v4:
> * The changelog now explains why the patch is replacing the example.
>=20
>  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 10 +++++++-=
--
>  1 file changed, 7 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq6vQ0ACgkQ3SOs138+
s6F/uA//Y/qN88plLV0PE2FbU34DDMYZv6eReQPVWP3FW/zabZerxtd2Q4B6RNvH
FW6ahyXVeQ4N7+0qx2JMnZQxPDZW2HsuqIfQatxC1C0faMaAbOX/gEobeEyM4+vD
HrWn0MuV5XyLAOtyluhRBDnSGizB/kKDpHK0m7Jb9Gt1Z2rIMhacK1AwX0jr2NUD
NNUSSU1EjhOL22ly6CQzOQqTkws6OcggZCWY7Gvh6Be7IBGMFVR3TSFbBmiSNhZn
FrGtRy7VCSwYINrQDPtBho6MBDdCow/0B8qwzmpSBAJNxDbjb8Rd3ouKQVp99enL
l8/gbOYYSLh2yC3xEnCXdVuxX1zexy9aR+oMb65pmx13vuPm3hzSIdl8Bv9ZG3L+
g0mv2qANImZjHbMIDJLlCPOyIHIKngLqsN92NWFEB92rx9pUQkhH/JJtdzqCbfp5
XnGda/2ooyEeVux+wPMHZmQXRW2N912LO7sFQUwV0WYhrPQR6Hu2IbvyPxBBMPsb
D+Cx0fEmcN5PTiX5Lmy02COviEn+sIeEpqw1qZCFC6G2Lz/gVb/u2/rA/m07bAc1
YwtKHVSF5GLaRJX8I1eD9dFEka7gzJesWsSSunSrFvhrQxPrNSVRIsQviSrS1bAH
UkK6LS+hne9400xFTT6DPEO2CXRjwbzWvEWwUR7hLwNmQWjngaE=
=ecM4
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
