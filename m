Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B58E71D2E
	for <linux-pwm@archiver.kernel.org>; Fri, 29 Sep 2023 13:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjI2NKt (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Fri, 29 Sep 2023 09:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjI2NKs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Sep 2023 09:10:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2381B6;
        Fri, 29 Sep 2023 06:10:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2F8C433C7;
        Fri, 29 Sep 2023 13:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695993043;
        bh=5Ol5wAReAsTCoXnxR80HvvP42Eru4mOmS+P6qbZsgiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D6gSDAtnKEHECNEDsB6F3lZqPBFTgmdMExMCpOMwH34KXE5Zo8euVaVEa3LoxysTv
         t8roJKvnCVdEYwUL0x/blP6u5li6gS2RusB0aYvWArLwq7t4yQtxdf/qWRd9Lcnh9S
         qC5ffpyl4uFCbwBPfffvFa0+jidNj/axAQzPJmL9pRcWuEQ1A+awoQ1Q9uVtVyScGS
         iy/xsHcU8yoH8/eOrKNzJSnEFe/RSfmF4jgj7yfe5VKAMwPQCSONoYLhLKd8FEgYIo
         NKONdP7bPRj6UQUOJBtlBJR+iHxRy5F9yxvCHuptCVoi57k/Fx/AS+XOV1AqJ7p0Uv
         79c3a+GYQv52g==
Date:   Fri, 29 Sep 2023 14:10:39 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: Add T-HEAD PWM controller
Message-ID: <20230929-equipment-july-949cffaddc22@spud>
References: <20230928170254.413-1-jszhang@kernel.org>
 <20230928170254.413-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G32AAMWduI7PPuPP"
Content-Disposition: inline
In-Reply-To: <20230928170254.413-2-jszhang@kernel.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--G32AAMWduI7PPuPP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Fri, Sep 29, 2023 at 01:02:53AM +0800, Jisheng Zhang wrote:
> T-HEAD SoCs such as the TH1520 contain a PWM controller used
> among other things to control the LCD backlight, fan and so on.

"such as", are there others?

>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../devicetree/bindings/pwm/pwm-thead.yaml    | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-thead.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-thead.yaml b/Docum=
entation/devicetree/bindings/pwm/pwm-thead.yaml
> new file mode 100644
> index 000000000000..8a7cf7129321
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-thead.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-thead.yaml#

The filename etc should match the compatible, especially when afaict
there's only one applicable SoC.

Otherwise, this looks good to me.

Thanks,
Conor.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: T-HEAD PWM
> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - thead,th1520-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    pwm@ec01c000 {
> +        compatible =3D "thead,th1520-pwm";
> +        reg =3D <0xec01c000 0x1000>;
> +        clocks =3D <&clk 1>;
> +        #pwm-cells =3D <2>;
> +    };
> --=20
> 2.40.1
>=20

--G32AAMWduI7PPuPP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRbMzgAKCRB4tDGHoIJi
0jBTAP9bC/3fxKIett/RV53md9zbCAYSbpmA2h/aaFI/scbk7gD/Xgq9XvhDe+db
C1sCsh1BJQxISaGvnocyMU6nso6HMQ0=
=BboF
-----END PGP SIGNATURE-----

--G32AAMWduI7PPuPP--
