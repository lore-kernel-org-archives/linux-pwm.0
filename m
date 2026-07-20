Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF82A21D3F5;
	Mon, 20 Jul 2026 06:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784530062; cv=none; b=KKXJGUTuF1fifpuHi4UCBkC3OnaMnZ+pCNGHm/9fiNjwwkArGbjuE/6F9cW6kA3TZvLTcoeYStePsRVHWCR/iA5qdydQ9CKMEXVJ3EZCNj8hbcwy9imiFVzhaZ4Jar+7nFj7/+LbZBxku5+5YqSgmXZsIZW8keSqaN/04jso6y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784530062; c=relaxed/simple;
	bh=xo2IZXzCWZ7HRjoTS9bFuF+m9ESOAMVvc91hPBQp8Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaCbbuCLI3jN1qA1oOspBMoYymjQJI1m/I0E/KvqCDfg1FM9ZwS7rYo0QwdCYt+YQ1X4QLcKGktd2qVWcbiv1uaCWas7lB9kC7BIW9PZaXT0OlTqK4WhKeJeevGTH6NXRXBF/je4MKSc48P6JxvAZG0m97S47grF6UrwZzy5Bz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EotMaIxk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EotMaIxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283BB1F000E9;
	Mon, 20 Jul 2026 06:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784530061;
	bh=AUtF5naa3NiHGPmGPNbT0g6G1VJ+GTYQZSr4Fh0o0Ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EotMaIxk6fRiLCHgn83evAm89GRZ2Uhkrpm8DMkkX4DfbzoHpD40IeN6ny9Ponfhm
	 PjYfCQM5SrUZgDdauPqP+pBnpFPhPLC5+WB/2dJkpUndaBDOyC1uxTntmYrr1sfjiu
	 jzsHTYgfF21wSMfFj6XXfZSk5melyyKfVH/IlBJCyRdUmnfPM5qX5ia7l4uoPUeyPA
	 Y0b94/yguieDO9olGWGlXgKSoMGrMg02ljCvpDcCq5MRSCRluxOKywacKA7rW+wZji
	 e/W9zdXaanJch5r8DxsGmr2u4WviD57+pyXGsPzqrCHuqILgccvkclTiLTKr48uwtr
	 wRT5yJDGMyh8A==
Date: Mon, 20 Jul 2026 08:47:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, Andrew Morton <akpm@linux-foundation.org>, 
	"Darrick J. Wong" <djwong@us.ibm.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: hwmon: add binding for adi,adt7470
Message-ID: <20260720-placid-fanatic-shrimp-d2bcd2@quoll>
References: <20260717-adt7470_thermalzone-v2-0-a55147958fad@gmail.com>
 <20260717-adt7470_thermalzone-v2-1-a55147958fad@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717-adt7470_thermalzone-v2-1-a55147958fad@gmail.com>

On Fri, Jul 17, 2026 at 05:59:14PM -0300, Luiz Angelo Daros de Luca wrote:
> The Analog Devices ADT7470 is a temperature monitor and PWM fan
> controller. It supports up to 10 external temperature sensors and
> up to 4 PWM fan outputs.

A nit, subject: drop second/last, redundant "binding for". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

> 
> Add the YAML device tree binding documentation for it. This includes

s/YAML//
There is no YAML in Devicetree.

> support for the thermal framework by defining the "#thermal-sensor-cells"
> property, and support for the PWM subsystem by defining the "#pwm-cells"
> property.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
>  .../devicetree/bindings/hwmon/adi,adt7470.yaml     | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml b/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml
> new file mode 100644
> index 000000000000..14bb6359c91f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/adi,adt7470.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADT7470 hwmon sensor
> +
> +maintainers:
> +  - Luiz Angelo Daros de Luca <luizluca@gmail.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The ADT7470 is a temperature monitor and multiple PWM outputs.
> +  It supports monitoring up to 10 external temperature sensors and controlling
> +  up to four fans.

"controling fans" is confusing and suggests this is a fan controller, so
you would need to reference proper schema for that. It is just PWM
output, no? PWM output could also go to LEDs or motors (well, fan is a
motor).

> +
> +properties:
> +  compatible:
> +    const: adi,adt7470
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2
> +    description: |
> +      Number of cells in a PWM specifier.
> +      - The first cell is the PWM channel (0 to 3).
> +      - The second cell is the PWM period in nanoseconds.
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Number of cells required to uniquely identify the temperature sensors.
> +      Valid index values are 0 to 9, corresponding to temp1 through temp10.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adt7470: hwmon@2f {
> +            compatible = "adi,adt7470";
> +            reg = <0x2f>;
> +            #pwm-cells = <2>;
> +            #thermal-sensor-cells = <1>;
> +        };
> +    };
> +
> +    fan0 {

Drio the node, not relevant. And then drop adt7470 label from hwmon
node.

> +        compatible = "pwm-fan";
> +        /* Connects to PWM channel 0 with a 50000 ns (20 kHz) period */
> +        pwms = <&adt7470 0 50000>;
> +        cooling-levels = <0 100 150 255>;
> +    };
> 
> -- 
> 2.55.0
> 
