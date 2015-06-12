From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: add MediaTek display PWM
 bindings
Date: Fri, 12 Jun 2015 12:23:45 +0200
Message-ID: <20150612102344.GG19400@ulmo.nvidia.com>
References: <1432214964-40644-1-git-send-email-yh.huang@mediatek.com>
 <1432214964-40644-2-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HCdXmnRlPgeNBad2"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34587 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbbFLKYY (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jun 2015 06:24:24 -0400
Content-Disposition: inline
In-Reply-To: <1432214964-40644-2-git-send-email-yh.huang@mediatek.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>


--HCdXmnRlPgeNBad2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2015 at 09:29:23PM +0800, YH Huang wrote:
> Document the device-tree binding of MediatTek display PWM.

s/MediatTek/MediaTek/

>=20
> Signed-off-by: YH Huang <yh.huang@mediatek.com>

This could use a more verbose commit message. You could mention what the
PWM is typically used for (display I presume). Perhaps mention how many
channels it exposes and so on.

> ---
>  .../devicetree/bindings/pwm/pwm-mtk-disp.txt       | 25 ++++++++++++++++=
++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Doc=
umentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> new file mode 100644
> index 0000000..f55bf92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> @@ -0,0 +1,25 @@
> +MediaTek display PWM controller
> +
> +Required properties:
> + - compatible: should be "mediatek,<name>-disp-pwm"
> +   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC
> +   - "mediatek,mt6595-disp-pwm": found on mt6595 SoC
> + - reg: physical base address and length of the controller's registers
> + - #pwm-cells: must be 2. See pwm.txt in this directory
> +   for a description of the cell format

You can use the full line width of 78/80 characters, no need to wrap
this prematurely.

> + - clocks: phandle and clock specifier of the PWM reference clock
> + - clock-names: must contain the following
> +   - "main": clock used to generate PWM signals
> +   - "mm": sync signals from the modules of mmsys
> +
> +Example:
> +	pwm0: pwm@1401e000 {
> +		compatible =3D "mediatek,mt8173-disp-pwm",
> +			     "mediatek,mt6595-disp-pwm";
> +		reg =3D <0 0x1401e000 0 0x1000>;
> +		#pwm-cells =3D <2>;
> +		clocks =3D <&mmsys MM_DISP_PWM026M>,
> +			 <&mmsys MM_DISP_PWM0MM>;
> +		clock-names =3D "main",
> +			      "mm";

No need to waste a line,

		clock-names =3D "main", "mm";

fits on a single line just fine.

Thierry

--HCdXmnRlPgeNBad2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVerMwAAoJEN0jrNd/PrOhnaQP/jlJM4eGnhjjO4FGETxfqdJj
MD4PVxjykkdXTDpqv+UZEThgRNzyEPX7xp5cFuiy/e6fFlVcV5zWrFyypw3tru9Y
qAELrPi9xXGn7jEgkNLaFjUJANciXxeRqgLcrq8EUzvSmf210/oefO0/YekVaaxd
D1SfiPQ1/dmwsOQo+lShPF6/3wKhG/tj+umL9eWk6YkpjEImQqGdMhedXeb8mMu+
g1WbGtlcCGY54F0UOIPoV4nL1VqDvjs6hGWHFKK0oubiXEy4vic0TxxYRtrleA4g
S2mxigbE2fV4Fvpx5ka539er3jW/GdeGKuU7fyOJL5TCnMe80G1UklWlQx+avS41
dossTjM26kor8lo5FZW2so7yiz5tLfWEASZkuBOX5XZnv1vGg9Ro7PTVREh5AdoJ
Sly4OLDOiXL/r1KdZTliM12zJ0piIIthQs+892QoOqH1aAKJ80g44/a0zo7AZve5
tgwiNqikWN9lbXW9FzAS0CI8aLxDVPILQROT+GPtND/YlrMcUahZADsRdxaCxAK2
toIpKQ4utYPAaFZlOFum0v/Sls8CaI2G1icwqE9asTMSrImv4l2Rp3wB+vkSgWZy
buSzA0H2nHk39V+vdGSt2muhjwiNXOFedgy4xf6f+AyxfgdwmMLwweuciuYTqql/
qZawnGDxf8cfeLomeR/M
=V+Up
-----END PGP SIGNATURE-----

--HCdXmnRlPgeNBad2--
