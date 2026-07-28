Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6283E9C23;
	Tue, 28 Jul 2026 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785226501; cv=none; b=K2r//w7jd9PJbyz91hpEQwKs6RmuLVRe3A0J/RAnZIyZqUhbyHgQsZpoyKnsaCsHKStDkJUlLtj8xod2WrkgP3TA9KilrBnf1lA1oi/asOp6bMb8htT9BwVPRIhhrhCN5TKFRt8AZ8qNDYYM7MImBDBg/ucuSGlIYES5QN5iPY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785226501; c=relaxed/simple;
	bh=6sCw83xeDb9TiCnGMEyASNsxNgG6WOBthsHYEk30gqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1nk3G6kAVgOs5RJQd8Spa9zrlSF4A7b9N/HmW5AFPSkEZiS5nvyVOVtySzhXmpDMhVO3pVQ8Lu38ZeVAqGV+lux2DNlH17bz/Nneg5VNkaMTpxW2Ws3IuRa/Jf9LaXKooB9UcGw/okC5lmEjwW5G5iNDVjyXJm8kRbI7LRuhqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdtecIJp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdtecIJp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301651F000E9;
	Tue, 28 Jul 2026 08:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785226499;
	bh=VbVfbQVXiHOc8qh8RP/fXcKcL1E22GNnDBNxe0mbHzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XdtecIJpPd9uqw26Z1KuiZ3VN8luSU8kzcZjS8FxHz2/JQ+H+WpwBympTmIl8Zi4A
	 4NztyC9gRvKm9zw5x24pxljiVp5KXcDnpWyYSYNvoAp18xvvgidu5NFM+pt0PdK93q
	 7S1RyX0ohDLFfspAwq4LgV89s+4gQ5zhOvGe5wPfQVrYcEJmo2YAH3pAHCTU4mIKl/
	 NPltFpMSAUu1tJlD2gSWoDSpTEMlGUjI9ymHQ/bOrUMBkNqpXJrm6lo6NgyBPANz6y
	 +3IVpOotm9cNfMJly0xcXaIgT46aaObBAtVlcO6wrU06WDi7zD/5v5NYjm1Ez3BK2R
	 cpeMtr5qDbn5w==
Date: Tue, 28 Jul 2026 10:14:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, Andrew Morton <akpm@linux-foundation.org>, 
	"Darrick J. Wong" <djwong@us.ibm.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [hwmon-next PATCH v3 1/4] dt-bindings: hwmon: adi,adt7470
Message-ID: <20260728-meteoric-quixotic-sunfish-0de2cb@quoll>
References: <20260728-adt7470_thermalzone-v3-0-d4586478cdba@gmail.com>
 <20260728-adt7470_thermalzone-v3-1-d4586478cdba@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728-adt7470_thermalzone-v3-1-d4586478cdba@gmail.com>

On Tue, Jul 28, 2026 at 12:07:09AM -0300, Luiz Angelo Daros de Luca wrote:
> The Analog Devices ADT7470 is a multichannel temperature sensor and
> PWM fan controller. It supports monitoring up to 10 external
> temperature sensors and controlling up to 4 fans.
> 
> Add the device tree binding documentation for it. This includes
> support for the thermal framework by defining the "#thermal-sensor-cells"
> property, and models the fan control lines as PWM channels by
> defining the "#pwm-cells" property.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
>  .../devicetree/bindings/hwmon/adi,adt7470.yaml     | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml b/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml
> new file mode 100644
> index 000000000000..bb2375a4a490
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml
> @@ -0,0 +1,55 @@
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
> +description:
> +  Multi-channel temperature monitor and PWM fan controller.
> +  It supports monitoring up to 10 external temperature sensors and
> +  controlling up to four fans. The fan control lines are modeled
> +  as standard PWM channels.
> +
> +properties:
> +  compatible:
> +    const: adi,adt7470
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 3
> +    description:
> +      See Documentation/devicetree/bindings/pwm/pwm.yaml for the
> +      generic PWM binding description.

Drop description.

You OTOH, miss ref to pwm schema. Referencing here in description should
raise you questions... And then use unevaluatedProperties.

> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +    description:
> +      Number of cells required to uniquely identify the temperature sensors.

Drop sentence, you never need to explain standard properties. It only
adds bloat and more places to fix/change if we do any refactoring.

> +      Valid index values are 0 to 9, corresponding to temp1 through temp10.

Only this is needed.

Best regards,
Krzysztof

