Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC41F489888;
	Sat,  1 Aug 2026 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785601262; cv=none; b=JEvizukC0F2afO8kFsQPpebNaCeBDQ6jTRihVXcNIWSITD9fcsaLGE3vCbf9//iOPgK8XpDc8rH8RrgtJVfP0okaoUMgKtikrDSyC8Zlnv7wmGHS+OJKiPq/faqLgsVvg0JERF41Jiaxn8MUHyNqpsVZjCxosNLZuSUhk9Yv3c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785601262; c=relaxed/simple;
	bh=vzyC9WcnMfsZAuJMGqAuGmHxyrSMSxlc+aPAT42ArPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5S2vsseghM+Fw+ztBddk1kBpKeP1R//br0LlXwF+xI6mo9sKozOxVVPT3sY5EaWleeA7qFP92n/7TDzV0itOMQ2MVYoncs9umh0RwnJfP6FNu20qH28opQRtTy9hWT2Ifz+cfhe2+pL7JlacOOgeN+jj7AfwlZCuTE+wsHmhjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbuUcx0I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbuUcx0I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AA31F00AC4;
	Sat,  1 Aug 2026 16:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785601261;
	bh=XOU3Pf27lesda2KT1Pcf8d04dM1ZWJDKBNyIqWTrlQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GbuUcx0IS+vuyRhbCKusENd0v2PVqOSUu/nWdjUPLqX41OeegWep2yz73x3dhliNC
	 Pz66l+55gSzVxC0Y26rH3adgrSbC4wfdVlJKYdsUodq3ysQAYAh9BRp12Q5Sixr9Nw
	 0OhLw6vudJhKCW9B1o58Kypt8Ll+fvBPy6fqi2hBpYpp/FFB0CkaCCkSkp618jpmHx
	 CmUDE5voykn7VmPR+qPfVvpaJ4UFB34KwoJz7DFsVK+BtUIcekbc0BH4A7qbfYZw0H
	 yQDJBAjJ64GCl+RaU6KOcR3GDkdP8IYQSH5s9dfAQ/S6iey1cRzLetoEvSvFNxKAx4
	 uJYA+BvfX9pkQ==
Date: Sat, 1 Aug 2026 18:20:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, Andrew Morton <akpm@linux-foundation.org>, 
	"Darrick J. Wong" <djwong@us.ibm.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [hwmon-next PATCH v5 1/4] dt-bindings: hwmon: add adi,adt7470
Message-ID: <20260801-tentacled-nickel-herring-bfabbb@quoll>
References: <20260730-adt7470_thermalzone-v5-0-42995a6bb8c5@gmail.com>
 <20260730-adt7470_thermalzone-v5-1-42995a6bb8c5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260730-adt7470_thermalzone-v5-1-42995a6bb8c5@gmail.com>

On Thu, Jul 30, 2026 at 06:29:56PM -0300, Luiz Angelo Daros de Luca wrote:
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
>  .../devicetree/bindings/hwmon/adi,adt7470.yaml     | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml b/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml
> new file mode 100644
> index 000000000000..f653a06f241a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml
> @@ -0,0 +1,58 @@
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
> +  controlling up to 4 fans. The fan control lines are modeled
> +  as standard PWM channels.
> +
> +allOf:
> +  - if:
> +      required:
> +        - "#thermal-sensor-cells"
> +    then:
> +      $ref: /schemas/thermal/thermal-sensor.yaml#

Place the entire "allOf:" after "required:" block.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

