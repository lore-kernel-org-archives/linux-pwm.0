Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8108423A66;
	Mon, 29 Jun 2026 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745213; cv=none; b=fsY2tzj2ZDuJx+Icqc81H4l8lchvVEu4BWoX8ccvaXYEMBzDJmsqOu18DgUgH3LFpgSNcepj+5jOGJhmYHoQACaYD8lPOjM7Em2MuwXJDdnkipGftpse4o2yjCo9CfvOxhoAUUza+vjoIMD5lja0rNsHT3Kh+viOiMCMPifnjG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745213; c=relaxed/simple;
	bh=llCdvmwD3f5EGsaloe6xocEaQln4YLEOi/XZ9WPtg88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSJEi341V3z/+xI4ppNBVpqbyGsy5JnH5w6H+bWqyat1a1yUDtpEMmnC31+u3MG/4W3nzYeJVTUeVR1OkSI9InX4IACnf/lqUzk+RMFmfvMUJOrHuwe9fy/T8bylBUcQTQdebRpnb5iuXGoNBf+Fmp+rVthtgBDl4FaHshesfVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciEIFrPx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciEIFrPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2A41F00A3D;
	Mon, 29 Jun 2026 15:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782745211;
	bh=6p+eFWjhiLtnMGQUwrrOgD9HfsGzvqqndl5QcxUEoMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ciEIFrPxV5GFw/mxRKCJ8o7cbPyOYju8nHTVlWnZH5WrLq7HaO4lwEcB5aRWIKXxu
	 zoWLdZqk8zgXP3M4epuidlust3SuoXhBgbJEtdaE+v/ijVgobpAcGJqDk6npfuVH8f
	 GpOf3dHVI0gabIBpuMIi2BMPgFhf6MT2i6wyXDajOcPakqNEzLIQPci1DVRCieV7C3
	 LHGUiNYuksaUS86Ofsr3381ZvYpm8rERzIWeJZ+U332hJuMd/Y35pnpNj36+J/es3+
	 /kHTppYU16NyiCzMs5EmTTTcXT1oh4lUNUBl+AfhCS2swORKEpg3caoGkfsrDE0Yjw
	 Itp2Xyh4d/1Tg==
Date: Mon, 29 Jun 2026 16:00:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 1/3] dt-bindings: pwm: opencores: Update compatibles,
 examples and maintainers
Message-ID: <20260629-unedited-tarmac-b6eaaaced8fc@spud>
References: <20260629063601.63917-1-hal.feng@starfivetech.com>
 <20260629063601.63917-2-hal.feng@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oTxfEJL/1/eWeBeU"
Content-Disposition: inline
In-Reply-To: <20260629063601.63917-2-hal.feng@starfivetech.com>

--oTxfEJL/1/eWeBeU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 02:35:59PM +0800, Hal Feng wrote:
> Remove the jh8100 compatible since the JH8100 SoC has been canceled and
> will not be released. Add the jhb100 compatible to replace it.
>=20
> Change the register size in examples to 0x10, since an OpenCores PTC IP
> has only 4 32-bit registers: CNTR, HRC, LRC and CTRL.

Actually, please also add a fixes tag to the original commit adding the
binding.

Cheers,
Conor.

>=20
> I will maintain this pwm module in place of William.
>=20
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  Documentation/devicetree/bindings/pwm/opencores,pwm.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml b/D=
ocumentation/devicetree/bindings/pwm/opencores,pwm.yaml
> index 52a59d245cdb..42c5d2b6326d 100644
> --- a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: OpenCores PWM controller
> =20
>  maintainers:
> -  - William Qiu <william.qiu@starfivetech.com>
> +  - Hal Feng <hal.feng@starfivetech.com>
> =20
>  description:
>    The OpenCores PTC ip core contains a PWM controller. When operating in=
 PWM
> @@ -23,7 +23,7 @@ properties:
>        - enum:
>            - starfive,jh7100-pwm
>            - starfive,jh7110-pwm
> -          - starfive,jh8100-pwm
> +          - starfive,jhb100-pwm
>        - const: opencores,pwm-v1
> =20
>    reg:
> @@ -49,7 +49,7 @@ examples:
>    - |
>      pwm@12490000 {
>          compatible =3D "starfive,jh7110-pwm", "opencores,pwm-v1";
> -        reg =3D <0x12490000 0x10000>;
> +        reg =3D <0x12490000 0x10>;
>          clocks =3D <&clkgen 181>;
>          resets =3D <&rstgen 109>;
>          #pwm-cells =3D <3>;
> --=20
> 2.43.2
>=20

--oTxfEJL/1/eWeBeU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakKIdwAKCRB4tDGHoIJi
0gigAP9N5K8X2TSAkyzyTu+kpvOQHJEoarApLQm4rhdCmzeGjgEApQzOHlW7QO2Z
ZY/1qEFPIOPiY9c5zrVEYt+Azbp6OgY=
=mcXf
-----END PGP SIGNATURE-----

--oTxfEJL/1/eWeBeU--
