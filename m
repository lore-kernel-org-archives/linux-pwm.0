Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823527;
	b=VkmTXc3h2cQqj8wgLRizSuili3zPh3z9vgAoiMAfjpksagIrVZHLGsfqtN+Ld0h/HsHE
	 N+d5lYPfZKCHvLl6ltNuNYWj+mFyguhusqSpsOmDDHmq9qc4re6uwXt7Rsb/De5PBYCLU
	 Qq7OoOqRfiS1TpZGrEZYlfkZ1x6QkuJfpUfUzKKvgEA3Oax0B15n9xDY2wYZoussbMyV2
	 I/9ybFpSGAQmt0y0brOJXwgZgdZAKN6o55/aJLWWPRUrNjXibYiQEWD7HzCFWzHUqkA01
	 PkAZh7bn0Aw1RdnFfBI3B1W6eQUGDuXdNB3QR2CWit1zLxL7N13PG23LYALQO7bjv6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823527;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jZJQub7WVBqa3DlcYaGmxuwOzFvkFwraR0ZB0NxDfgk=;
	b=Vuhyg4kHFPv8b2WAZmGMHuPmTW7C9odDOolep4r611inh5MxM9SsjM3ZR+rr4uZVQ5zl
	 moQBgOwNS11pplvDtYgXf7tdRpnjiv+OyQRGkjO8iwuisBqBglDkZuFbclgEtuG40BYo+
	 GQS9TtbpL9XNSf/98e7bRI2Xxpy2XyJsuf4AvSWAQ0huhG7SnPku/VWXp2N1X7TCZ3XFc
	 vThffMYSnCQOPTUTyvRkBHlGQKlchBHs0yJ/D/K0vN1eQYvXNYprtGZki5ytdtlVaApXq
	 i5GlevVMws0M/xB86OOguFKeRWc5IjMBY/U795vRFZaAzFAemio54ALVSpvM7sU64Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XV1xRc9w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F336606A329;
	Mon, 16 Nov 2026 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XV1xRc9w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F4B1F000C4;
	Mon, 16 Nov 2026 10:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794823527;
	bh=jZJQub7WVBqa3DlcYaGmxuwOzFvkFwraR0ZB0NxDfgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XV1xRc9wRL6M/+N2/7RiJ3+T/xrZAp36SDEvKDQ0TG2oPFvZzzKkb/C0etl1x9zOf
	 1nPF0fqGhWxMp7vw5GMfmsrMyIS02hvje7wAT2CdCG/q1dN9pQoq4QruhzXa155zfN
	 8+iZAZuDxo+GNmZ5oVgG9PjFYSOyg5zHaHOhl6qGGPFCG26U0/mcjODIs+9g5RWdu1
	 /Poj3CICZfP+2pFFwuyK3xMqEzpBTsYC8X6ZuJ9G3f85Xo+m58Ub8GjIxf3yWkmLTa
	 cXkkArI3F+qkdP/LawmGytMpDwLDYrji7lHqP10KyRy5GIS/Wpq7+Dl5EqVPFicYn5
	 wea1jY6tyFMsQ==
Date: Mon, 16 Nov 2026 11:05:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
	Ajit Pandey <ajit.pandey@oss.qualcomm.com>, Imran Shaik <imran.shaik@oss.qualcomm.com>, 
	Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: pwm: qcom: add Shikra PWM controller
Message-ID: <20261116-grumpy-pudu-of-reputation-9fb39e@quoll>
References: <20261116-pwm_qcom_shikra-v1-0-67ee4553adc5@oss.qualcomm.com>
 <20261116-pwm_qcom_shikra-v1-1-67ee4553adc5@oss.qualcomm.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116-pwm_qcom_shikra-v1-1-67ee4553adc5@oss.qualcomm.com>

On Mon, Nov 16, 2026 at 12:29:48PM +0530, Taniya Das wrote:
> +patternProperties:
> +  "^pwm@[0-9a-f]+$":
> +    type: object
> +    description: Per-frame PWM channel sub-node.

I don't get the need for the children. The the parent has pwm-cells, so
it should be enough.

> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +        description: This frame's own absolute register range.
> +
> +      qcom,frame-index:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Hardware frame index within the PWM block. It is the PWM index
> +          used in the first cell of a consumer PWM specifier and selects
> +          the corresponding enable bit in PWM_TOPCTL0.

And this seems to be duplicating the value passed through phandle/pwm-cells.

> +        maximum: 9

Best regards,
Krzysztof

