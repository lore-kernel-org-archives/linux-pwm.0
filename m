Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257F226C385;
	Thu,  6 Aug 2026 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022200; cv=none; b=tm937dy4X1W+zaFvCVo0WcLt3xKnDdecxEDBWVNfc+EJ994G1opxjka22cIbprFyI6l4ms0Abi1EI6Mhyhu3BcxVobxu+LJziHiJz7iy8AD0WMDxsaEi8XVyejzzrqIG2D2Dtg1yExxrkbT0dyO2PEMCqKfuC/fLq64TqnVrru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022200; c=relaxed/simple;
	bh=gtYXydAMBAKg593kaElUjKb/G08Lqn4qoJ/UEL29VC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IixDQ4hf4lgCBVj62ysWrirfLQQSKR9VOBuRUTOLzHCykXZ5zX/k63E1KiNZqysgzJYLParR9CyQo0VEusMxzPy/lAI0co3reZxN8RNl2xAivFkO9vRSHGBonYPS4C+Ini+i6U2QFibNqYbgaH2la/wIM17Y7CXMBEVomDL7Inc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYTTH2YZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYTTH2YZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DAA1F000E9;
	Thu,  6 Aug 2026 13:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786022194;
	bh=8O3Jm/KCpUxHmdI56AF1wTxRqOJCMDI/5j9/Q6443Ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OYTTH2YZ95hRG04hyNETNtpBAmuqnutIGsr5526ph4/Spdpox8qylIrZLTN2uJeBJ
	 v6OAiOPKkmABiofnuehJ9uheHaIhy99SVgixWZkBUyUc9/4tmUcXoOIcri5X5/G2YD
	 zj6/fCqjKXrLbJuL7JOHgFKZZKwN9mbs4H9cfEImkJQC4VjC/HiJAaUYyQ+DNouog6
	 uevVcXkGTmcu/rmvNKUgidInV3RVrEPw8CD7UN9FMBqSMYCT0ZXfCgP2TxMJhjM8ti
	 tdzuY4Lmjf5fOxwo6R3fOk3huIa7nmHtCD0tA4V8JEPvXIpYtdGB2Ql7SLIO3UdBpP
	 MMgcU7pcNIdmA==
Date: Thu, 6 Aug 2026 08:16:33 -0500
From: Rob Herring <robh@kernel.org>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Tzu-Hao Wei <twei@axiado.com>,
	Karthikeyan Mitran <kmitran@axiado.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: add Axiado AX3000 and AX3005 PWM
 fan controller
Message-ID: <20260806131633.GA30560-robh@kernel.org>
References: <20260806-axiado-ax3000-pwm-fan-v1-0-f6db4cf2166b@axiado.com>
 <20260806-axiado-ax3000-pwm-fan-v1-1-f6db4cf2166b@axiado.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-axiado-ax3000-pwm-fan-v1-1-f6db4cf2166b@axiado.com>

On Thu, Aug 06, 2026 at 02:01:29AM -0700, Petar Stepanovic wrote:
> Add a Devicetree binding for the PWM fan controller found on the
> Axiado AX3000 and AX3005 SoCs.
> 
> The controller measures fan speed using a hardware tachometer block.
> Fan speed is controlled through a PWM signal supplied by an external
> PWM controller.
> 
> Add a MAINTAINERS entry for the binding.
> 
> Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
> ---
>  .../bindings/hwmon/axiado,ax3000-pwm-fan.yaml      | 68 ++++++++++++++++++++++
>  MAINTAINERS                                        |  8 +++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/axiado,ax3000-pwm-fan.yaml b/Documentation/devicetree/bindings/hwmon/axiado,ax3000-pwm-fan.yaml
> new file mode 100644
> index 000000000000..a985f49bbdcd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/axiado,ax3000-pwm-fan.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/axiado,ax3000-pwm-fan.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Axiado AX3000 and AX3005 PWM Fan Controller
> +
> +maintainers:
> +  - Petar Stepanovic <pstepanovic@axiado.com>
> +  - Akhila Kavi <akavi@axiado.com>
> +  - Prasad Bolisetty <pbolisetty@axiado.com>
> +
> +description:
> +  The Axiado AX3000 and AX3005 fan controllers use a hardware tachometer
> +  block to measure fan speed. Fan speed is controlled through a PWM signal
> +  supplied by an external PWM controller.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: axiado,ax3000-pwm-fan
> +      - items:
> +          - const: axiado,ax3005-pwm-fan
> +          - const: axiado,ax3000-pwm-fan
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  pwms:
> +    maxItems: 1
> +    description:
> +      PWM specifier used to control fan speed.
> +
> +  pulses-per-revolution:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    default: 2
> +    description:
> +      Number of tachometer pulses generated per fan revolution.

This is a property of a fan, not the fan controller. The fan(s) should 
be represented as child node(s) under this device. Use the common fan 
binding, fan-common.yaml. See other bindings using it.

Rob
