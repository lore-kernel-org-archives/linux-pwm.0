From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] pwm: add DT bindings for the STMPE PWM
Date: Mon, 7 Mar 2016 10:26:41 +0100
Message-ID: <20160307092641.GG31189@ulmo.nvidia.com>
References: <1455455317-17043-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PpAOPzA3dXsRhoo+"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35468 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbcCGJ0q (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Mar 2016 04:26:46 -0500
Content-Disposition: inline
In-Reply-To: <1455455317-17043-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org


--PpAOPzA3dXsRhoo+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 14, 2016 at 02:08:37PM +0100, Linus Walleij wrote:
> This adds fairly standard device tree bindings for the STMPE
> PWM found in STMPE24xx multi-purpose expanders.
>=20
> Cc: devicetree@vger.kernel.org
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt | 18 ++++++++++++=
++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt b/Doc=
umentation/devicetree/bindings/pwm/st,stmpe-pwm.txt
> new file mode 100644
> index 000000000000..c8b53f39ae31
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt
> @@ -0,0 +1,18 @@
> +=3D=3D ST STMPE PWM controller =3D=3D
> +
> +This is a PWM block embedded in the ST Microelectronics STMPE
> +(ST Multi-Purpose Expander) chips. The PWM is registered as a
> +subdevices of the STMPE MFD device.
> +
> +Required properties:
> +- compatible: should be:
> +  - "st,stmpe-pwm"
> +- #pwm-cells: should be 2. See pwm.txt in this directory for a descripti=
on of
> +  the cells format.
> +
> +Example:
> +
> +stmpe1_pwm0: stmpe_pwm {

Shouldn't the node name simply be "pwm"? stmpe_pwm is kind of redundant
given that this is to be embedded in an MFD node that will, presumably,
be called stmpe.

Thierry

--PpAOPzA3dXsRhoo+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW3UlRAAoJEN0jrNd/PrOh6C8QAK1yF2dGvPfnc+NT4GaoRHwu
BXjvOf+xXx4yi+z10SmLXJWPn+5RSyasg+ka8M0WRz9KES1ROLuHQ+/kvhUFlgVu
JsjqCeiiG8k0iD1EAZV4EEyRcPOFpNSvv25FwnmLRVZhIYB8/xCPNXIUBxWnz7mg
K+qUOzq9gsem3m+0gDohAYlCMmSUNJD3JQ/CaDimAXv+OUkvx+3f04nypda7gsb2
KTxrZRYjUni3z6agm9TbcV1FowCRjXhgT3YPfJYQEdwAHG8WH0ruuc6rp3lNRAuf
YRcs2LgxzBu83D2z43/rsrp5FHx6hR7xnx+/UZeYt59oeGziDGr/ozVBUEB2EB+P
RSKOaB2i0xONyfWUdRuL4mG5Mw6FVmhyjkEyAqZ+hJFnumq4gj5RtUEgWsFC/eFT
6uFcWZk2qGFI5T/8EdU4+3nXYfVBevE+U0cF/dR2hz/e4i6xcqfSi6ecoA+7Teak
9I0BQyYXFTsm6NuNS0QIo2hOjqPF0r2NlHH1mLuoa/YdaSCYtNZ4ZX5qPjWnGqZm
SszXk0yS9do9r00spgABDPNavRDySQ8/GtkR1XuJ0ATfHcQ8vYxyynAE3/SuWYLM
7t47MOeFEV51FK+wUx82xuM5UuUjztIrmWgGXmr1e2Pfx+wUD6nvlCVDvnyQ8zH/
6XRry/V3/t3d2QsnC+Ro
=9eBP
-----END PGP SIGNATURE-----

--PpAOPzA3dXsRhoo+--
