Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025C838E12D;
	Thu, 24 Sep 2026 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267717; cv=none; b=EdGvbcu3K4lAlpMFGv9zTTM/v20nIF+bK0Ln5srsMY8G1eh1H//YkHSI1CGG8ZkSLVeQNJ7GL8UaI+R78urG4hbBAaXcBmwb+c8D/41uT/Nrji13rE3plQFiUG+oqu910O3SAvcDupt32ntThaM65QaN6G5OfYx2btJI1qEvFak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267717; c=relaxed/simple;
	bh=uiRLL+CiEYwzXCUUI9gbvRuZN8jBA00Inc6AATY0gcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0BIXU0OVEFnEfAM0FyYFJAi8EsvKklO+/1EEtmDPGwt5C6qxfOedk6967cjqMrtlSLQ3hetFfWZNs1Npq12TSWzOMiGVqsj0RUjikP6l26/JWjI2dSOXCl23s5SW6voGoSLyDT8o9lSn6I7qJMy/AHLaFFOPOZBKuMVYD9cPg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krgJkDjS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krgJkDjS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC8D1F00893;
	Thu, 24 Sep 2026 16:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267715;
	bh=uoAmk3wqtlAFZLLsvBCYCQm3vEyTOG8AHswxcziVCCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=krgJkDjSbVkzY9W1gQBRw6y5foA5Kp9V4FZ62zmtf4P9B2qV+hCn2agi/dvhvyvc1
	 RstWYFaXlmNgNSowtUS4whXUuSIo62BXJfUEUnyjKirdlkd0+1nq4iLnPDMi/BO2Md
	 s5yVyQlfJGr8UKi+FWqsiA46ch2VAL+R1kDZ3B3xsoLSyIRsU1LkEsrYNKykrS3Hp7
	 LqBVM40MlI04fNBqyDzsAT8jnB6E4rLzeamaBj7v7KMm6n2yYaxuWxiQDXj3vTGYCA
	 2vhOuotbVQUDj+P6wSXsEddyx2MI93uWyKFFQLuPlNZbzSIo+/iYSv+kF4jdg8kTFr
	 Vpva06qLTldUg==
Date: Thu, 24 Sep 2026 17:35:10 +0100
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
Subject: Re: [PATCH 1/3] dt-bindings: pwm: amlogic: Add core clock for T7
Message-ID: <20260924-reprimand-taste-3481319d9e31@spud>
References: <20260924-add-t7-sys-pwm-clk-v1-0-05b91e87f0a9@aliel.fr>
 <20260924-add-t7-sys-pwm-clk-v1-1-05b91e87f0a9@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YEpPhNbtW+Xfzqe4"
Content-Disposition: inline
In-Reply-To: <20260924-add-t7-sys-pwm-clk-v1-1-05b91e87f0a9@aliel.fr>

--YEpPhNbtW+Xfzqe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 05:14:28PM +0200, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>=20
> The T7 PWM controller has a system clock (the register access clock)
> in addition to the two input clocks of channels A and B. Add it as a
> third clock, named "core", for the amlogic,t7-pwm compatible, and
> require clock-names for this SoC for clarity.

What additional clarity does that actually bring? I think it's kinda
less clear, because the git history is required to explain why drivers
cannot fetch the existing clocks by name.

>=20
> The other compatibles are left unchanged. Add an example showing the
> T7 usage with its fallback to amlogic,meson-s4-pwm.
>=20
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>  .../devicetree/bindings/pwm/pwm-amlogic.yaml       | 37 ++++++++++++++++=
+++---
>  1 file changed, 33 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Doc=
umentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> index c337d85da40f1..9212a40d9fe48 100644
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
> @@ -135,17 +135,38 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            enum:
> -              - amlogic,meson-s4-pwm
> +            const: amlogic,t7-pwm
>      then:
>        properties:
>          clocks:
>            items:
>              - description: input clock of PWM channel A
>              - description: input clock of PWM channel B
> -        clock-names: false
> +            - description: gate clock for the PWM controller
> +        clock-names:
> +          items:
> +            - const: clk_a
> +            - const: clk_b

I'd rather "channel-a" or similar, we try not to state the obvious in
the names of clocks etc - of course this is a clock!

> +            - const: core
>        required:
>          - clocks
> +        - clock-names
> +    else:
> +      if:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - amlogic,meson-s4-pwm
> +      then:
> +        properties:
> +          clocks:
> +            items:
> +              - description: input clock of PWM channel A
> +              - description: input clock of PWM channel B
> +          clock-names: false

Are you sure that the s4-pwm doesn't also have this core clock? Seems
likely, no?

Cheers,
Conor.

> +        required:
> +          - clocks
> =20
>    - if:
>        properties:
> @@ -182,3 +203,11 @@ examples:
>        clocks =3D <&pwm_src_a>, <&pwm_src_b>;
>        #pwm-cells =3D <3>;
>      };
> +  - |
> +    pwm@60000 {
> +      compatible =3D "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
> +      reg =3D <0x60000 0x24>;
> +      clocks =3D <&clk_a>, <&clk_b>, <&core>;
> +      clock-names =3D "clk_a", "clk_b", "core";
> +      #pwm-cells =3D <3>;
> +    };
>=20
> --=20
> 2.49.0
>=20
>=20

--YEpPhNbtW+Xfzqe4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarVRPgAKCRB4tDGHoIJi
0qrvAQDzOljDwun39UgsyfijL72uq4IJ63XXhGMQL7O1stwipwEA12NojbsOpKfq
H2MqdB9c+5gUZXemfAGmrG9+Hcf8lwo=
=NsG0
-----END PGP SIGNATURE-----

--YEpPhNbtW+Xfzqe4--
