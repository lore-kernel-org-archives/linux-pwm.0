Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E867E33D6ED;
	Tue, 11 Aug 2026 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470493; cv=none; b=lWxCGj57G9VI3g1AifjcDaByClsuGtsed82O71gNM5mtNZKD6pyx6dksAhcsf2EnekMgq1CYRP//HmwF5T92edM8vXME0n5dQBnu5VgMfYMaRCq4TcNWkM2rpXaNNN0kUwypGATZvKI1eG72enPYajdT2r4wV6t7ZLmRX9Ss3nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470493; c=relaxed/simple;
	bh=bWcGc9MGWql3bYi+7d3qmdmwQwpUuHbzgX3+REZaOdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSk4lQWf/usEsfnlc0rvBplvGEF+gJOjJneYWhFqleHC1X8Lusm4L7t3bbdFmrryFvXCZB6z89mG8mRo+5jY6bGDnW9a9Jq+DoED9bgyz99vblPKu2yx7QWWysQ3uzpfxWKE/SPDr8l6F97CM14MDfIQtRsfkw7ar6LwYZ+gDlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0GN7Iwe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0GN7Iwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C041F000E9;
	Tue, 11 Aug 2026 17:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786470489;
	bh=hhbmpDHoO5cLRxJcMRaAzIKo6MeOaFfMtDAsDeBrB8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c0GN7IweDOwmZM3MvcdQW2gncOFKyMAa6YoWV+YCr3nlQggZbN+hNITRnBKUxfbCu
	 bOIaTCvMlSV6A/tUiBTneuTGz5eZYWTQV73ohNX83Xx0s9oJewDJy4ZeX6YcT7Xafe
	 QcRCOzeh0HFj4mc1bWCdKzaNnr133lkRP6lNretZiZC5owHQQunLf6opudxBEjhAC0
	 2QQonuweeJsyDPD76Ljcz9SYwesqNlVF0Zn18suEYgDrMtuhCgL5sDmQ164u0QybIK
	 9XsnPTxFTP/+isx459L7sOZitPPB7/dvJt44/H1XodsAzTi6dA1D28BEgQ/zMsEvzE
	 nhBfp3NXPw7gA==
Date: Tue, 11 Aug 2026 12:48:08 -0500
From: Rob Herring <robh@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: Re: [PATCH] dt-bindings: pwm: Convert TI PWM Subsystem to DT schema
Message-ID: <20260811174808.GA2709327-robh@kernel.org>
References: <20260811092208.687731-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811092208.687731-1-egbostina@gmail.com>

On Tue, Aug 11, 2026 at 09:22:08AM +0000, Eduard Bostina wrote:
> Convert the Texas Instruments SoC PWM Subsystem bindings
> to DT schema.
> 
> During the conversion, the following updates were made:
> - 'counter' node was added to the allowed child nodes
>   list to resolve dtbs_check warnings. Some eqep nodes
>   use 'counter' instead of 'eqep'.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> ---
>  .../devicetree/bindings/pwm/pwm-tipwmss.txt   | 58 --------------
>  .../devicetree/bindings/pwm/ti,pwmss.yaml     | 77 +++++++++++++++++++
>  2 files changed, 77 insertions(+), 58 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/ti,pwmss.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt b/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
> deleted file mode 100644
> index 4633697fbda1..000000000000
> --- a/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
> +++ /dev/null
> @@ -1,58 +0,0 @@
> -TI SOC based PWM Subsystem
> -
> -Required properties:
> -- compatible: Must be "ti,<soc>-pwmss".
> -  for am33xx  - compatible = "ti,am33xx-pwmss";
> -  for am4372  - compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
> -  for dra746 - compatible = "ti,dra746-pwmss", "ti,am33xx-pwmss"
> -
> -- reg: physical base address and size of the registers map.
> -- address-cells: Specify the number of u32 entries needed in child nodes.
> -		  Should set to 1.
> -- size-cells: specify number of u32 entries needed to specify child nodes size
> -		in reg property. Should set to 1.
> -- ranges: describes the address mapping of a memory-mapped bus. Should set to
> -	   physical address map of child's base address, physical address within
> -	   parent's address  space and length of the address map. For am33xx,
> -	   3 set of child register maps present, ECAP register space, EQEP
> -	   register space, EHRPWM register space.
> -
> -Also child nodes should also populated under PWMSS DT node.
> -
> -Example:
> -epwmss0: epwmss@48300000 { /* PWMSS for am33xx */
> -	compatible = "ti,am33xx-pwmss";
> -	reg = <0x48300000 0x10>;
> -	ti,hwmods = "epwmss0";
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -	ranges = <0x48300100 0x48300100 0x80   /* ECAP */
> -		  0x48300180 0x48300180 0x80   /* EQEP */
> -		  0x48300200 0x48300200 0x80>; /* EHRPWM */
> -
> -	/* child nodes go here */
> -};
> -
> -epwmss0: epwmss@48300000 { /* PWMSS for am4372 */
> -	compatible = "ti,am4372-pwmss","ti,am33xx-pwmss"
> -	reg = <0x48300000 0x10>;
> -	ti,hwmods = "epwmss0";
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -	ranges = <0x48300100 0x48300100 0x80   /* ECAP */
> -		  0x48300180 0x48300180 0x80   /* EQEP */
> -		  0x48300200 0x48300200 0x80>; /* EHRPWM */
> -
> -	/* child nodes go here */
> -};
> -
> -epwmss0: epwmss@4843e000 { /* PWMSS for DRA7xx */
> -	compatible = "ti,dra746-pwmss", "ti,am33xx-pwmss";
> -	reg = <0x4843e000 0x30>;
> -	ti,hwmods = "epwmss0";
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -	ranges;
> -
> -	/* child nodes go here */
> -};
> diff --git a/Documentation/devicetree/bindings/pwm/ti,pwmss.yaml b/Documentation/devicetree/bindings/pwm/ti,pwmss.yaml
> new file mode 100644
> index 000000000000..53f88139dcd4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/ti,pwmss.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/ti,pwmss.yaml#

ti,am33xx-pwmss.yaml for the filename.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments SoC PWM Subsystem
> +
> +maintainers:
> +  - Eduard Bostina <egbostina@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: ti,am33xx-pwmss
> +      - items:
> +          - enum:
> +              - ti,am4372-pwmss
> +              - ti,dra746-pwmss
> +          - const: ti,am33xx-pwmss
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^(ecap|eqep|pwm|counter)@[0-9a-f]+$":
> +    type: object
> +    description: Child nodes for ECAP, EQEP (counter), and EHRPWM

       required:
         - compatible

> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwm@48300000 { /* PWMSS for am33xx */
> +        compatible = "ti,am33xx-pwmss";
> +        reg = <0x48300000 0x10>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0x48300100 0x48300100 0x80>,   /* ECAP */
> +                 <0x48300180 0x48300180 0x80>,   /* EQEP */
> +                 <0x48300200 0x48300200 0x80>;   /* EHRPWM */
> +    };
> +
> +  - |
> +    pwm@48300000 { /* PWMSS for am4372 */
> +        compatible = "ti,am4372-pwmss", "ti,am33xx-pwmss";
> +        reg = <0x48300000 0x10>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0x48300100 0x48300100 0x80>,   /* ECAP */
> +                 <0x48300180 0x48300180 0x80>,   /* EQEP */
> +                 <0x48300200 0x48300200 0x80>;   /* EHRPWM */
> +    };
> +
> +  - |
> +    pwm@4843e000 { /* PWMSS for DRA7xx */
> +        compatible = "ti,dra746-pwmss", "ti,am33xx-pwmss";
> +        reg = <0x4843e000 0x30>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +    };

One example is enough.

Rob

