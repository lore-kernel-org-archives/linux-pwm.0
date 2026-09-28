Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457E24EDCD0;
	Mon, 28 Sep 2026 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613997; cv=none; b=CniwkbqLoz7+E8CIeaOpPQSjgiII9TZzw0f2ubtZVsutcvbj5XBaKXSQtsCwwBGcITo5LOlhok9zFDg2ADB/6xPSE3uBoUisXRwNG4DYqeNMCqkLAmPhxEA0cb0lIbJPppMAOd/ZqkU7jsv6uayvB41Eiy+W3qt54x45NpeqGsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613997; c=relaxed/simple;
	bh=wESeYm1NEZEOQV3/9wrGqU7/i2/MTXSfeQ3kLceJ4YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCJYSSMRMzPaYh1XLiQWhM4ulkIjPnnEf0SmlVukwbTd1M+sYIM3GFqr+YVqYqGByrL+ElUmU4a1SqB52lTUgWmHVeQtPgR+J092yjbXJMB0ZRSqboYFLpx93t4jV/cr/3G+oVqconLeEfPSDIN1rgLBhaojm3u+/6ZzCSu4Qmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kibERWQ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kibERWQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE241F000FF;
	Mon, 28 Sep 2026 16:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613996;
	bh=OuEIbSM39AWn3fOJgnOsyJgctCK52FPvPnATEJOiJZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kibERWQ7ya9eZx0yUmrvPFr3QcQrB8256DiRNHXVkXTRCfmO19BrG9dEIT1hDSB9h
	 X5bg0EOKOKoUm4Xx6tKtvs26iwkwQAlOWopPMVo9umQD8b5zTM/FY5etd+owpxmsUv
	 TYZleYU1VKWaoaIYGSxS5LFTuOGZp+XSkKdgqahN3OWPawEPhTeVsFrs7EVc7ypfG/
	 LZVxQJ4RbOva4eI6JOT/I6JiT6A4AlEvG0F9swMlOSveamz86iaLZ+bbaBc6liJYZv
	 lrSSeOFTXjZ/0MsFjtdhhld0V6+IXCprrfZsKc55brla+vOnI91aKphTua0zlT6/Mk
	 84MKCsRWNmRQg==
Date: Mon, 28 Sep 2026 17:46:31 +0100
From: Conor Dooley <conor@kernel.org>
To: linux-kernel-dev@aliel.fr
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: pwm: amlogic: Add core clock for S4
 like
Message-ID: <20260928-cardiac-relax-cdccdecdd4c2@spud>
References: <20260927-add-t7-sys-pwm-clk-v3-0-18d66abea4d1@aliel.fr>
 <20260927-add-t7-sys-pwm-clk-v3-1-18d66abea4d1@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NO7UUlGWjKuFSfWY"
Content-Disposition: inline
In-Reply-To: <20260927-add-t7-sys-pwm-clk-v3-1-18d66abea4d1@aliel.fr>

--NO7UUlGWjKuFSfWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 04:28:15PM +0200, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>=20
> The T7, A1, C3, and S4 PWM controllers have a system clock in
> addition to the two input clocks of channels A and B.
>=20
> The channel clocks are acquired by index in the pwm driver,
> where the core clock is fetched by name, with optional get
> which is silent when not provided.
>=20
> Require clock-names and minimum 3 items for S4, and devices
> which fallback to S4, where the PWM devices do not work
> without all 3 clocks.
>=20
> Add an example showing T7 usage with its fallback to
> amlogic,meson-s4-pwm.
>=20
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>  .../devicetree/bindings/pwm/pwm-amlogic.yaml        | 21 +++++++++++++++=
+++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Doc=
umentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> index c337d85da40f1..e9cd5f1fdf264 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> @@ -62,7 +62,7 @@ properties:
> =20
>    clock-names:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 3
> =20
>    power-domains:
>      maxItems: 1
> @@ -143,9 +143,15 @@ allOf:
>            items:
>              - description: input clock of PWM channel A
>              - description: input clock of PWM channel B
> -        clock-names: false
> +            - description: gate clock for the PWM controller
> +        clock-names:
> +          items:
> +            - const: channel-a
> +            - const: channel-b
> +            - const: core
>        required:
>          - clocks
> +        - clock-names
> =20
>    - if:
>        properties:
> @@ -179,6 +185,15 @@ examples:
>      pwm@1000 {
>        compatible =3D "amlogic,meson-s4-pwm";
>        reg =3D <0x1000 0x10>;
> -      clocks =3D <&pwm_src_a>, <&pwm_src_b>;
> +      clocks =3D <&pwm_src_a>, <&pwm_src_b>, <&pwm_src_core>;
> +      clock-names =3D "channel-a", "channel-b", "core";
> +      #pwm-cells =3D <3>;
> +    };
> +  - |
> +    pwm@60000 {

If you respin, drop the second example please, since it doesn't actually
do anything different anymore.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> +      compatible =3D "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
> +      reg =3D <0x60000 0x24>;
> +      clocks =3D <&channel_a>, <&channel_b>, <&core>;
> +      clock-names =3D "channel-a", "channel-b", "core";
>        #pwm-cells =3D <3>;
>      };
>=20
> --=20
> 2.49.0
>=20
>=20

--NO7UUlGWjKuFSfWY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarqZ5wAKCRB4tDGHoIJi
0ok+APwNheWAYEM9WF+sBQYkU6EVCY1bbe9VWk1PlHlrguTn7QD/byNsbcsFBPVx
UFNlan7GYFGIaWMoGbPggPiiF1g1jwk=
=Zdvc
-----END PGP SIGNATURE-----

--NO7UUlGWjKuFSfWY--
