Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7F31F4C96;
	Sat, 25 Jul 2026 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784992016; cv=none; b=MUHvpn2CsCuh6UZSXHpPOVUq9qqA/nG/nTh9dzPCmQsIOwNN8+zv37cZXdl9ysllRf5N0vOjFCv86DCkDTIe0bDi4Hb7Z1C/bYMmmQ2t9xnfE2/3vbgeWmzWX4v0mKgeUQhcGY+nbCfJBAuA1DlKV3da+63MDMvtSw/iYmWA6wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784992016; c=relaxed/simple;
	bh=8x3GQg7NJGcIC91g0ZOXVhu4Rix8xJIer/8C7FAbMaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a60nv8YLkhHTHfsXujNKAakFH9VnKLAhd8zpa2lByFHzHtAB5mDPru+6SomlVGTDEeaTtSMLAMtM6mEtsvm3fdHgynJKKPhSzytTbXRFNXapftoFKaK7DKH4rdOX0UGXhGrhIkQ1/kcrQE+WOf0LqFqVSzOF9l7c5yGoHq0U1ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNErDO6z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNErDO6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD7E1F000E9;
	Sat, 25 Jul 2026 15:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784992015;
	bh=JiJkbdZnlxrVjk8lpZbAYX8cJjyvAOcWfk61sdjCaVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RNErDO6z7X5HZ3hh/b/h6zTih3g1ceLkxrGyf13wJ16vftldkbRddXBfR24OXEjX3
	 +OjNWGNNc58ehvwJ2OE5+X+eQ5jPb6GclTNGRaesuyiJqSWBZwTOwdXiBc/PeJeCTs
	 JRqkiMqoZ/VxFXVIpUXUcGLGAM1qJrhCKpLoiFt4NnRHFbELg4g+2vwNEO7BUVh7ez
	 dQil7aunDhXiG8dJyTeplB6h9Ys4861JX7jO2th7j4urDIgaiM61I88T0Iek5KAjmB
	 AvZb/8ME56R+tNOY8ZOULzULKTyX96SXdia4mkyo2IluyBZAN65jduJG7RoG0FoFIk
	 Mwd3m/yGZFlwQ==
Date: Sat, 25 Jul 2026 17:06:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: dongxuyang@eswincomputing.com
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	p.zabel@pengutronix.de, daniel.lezcano@kernel.org, tglx@kernel.org, 
	ningyu@eswincomputing.com, linmin@eswincomputing.com, xuxiang@eswincomputing.com, 
	wangguosheng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v13 2/5] dt-bindings: pwm: dwc: Add eswin compatible
Message-ID: <20260725-lurking-emotional-tarsier-ff05dc@quoll>
References: <20260724084153.1473-1-dongxuyang@eswincomputing.com>
 <20260724084320.1586-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724084320.1586-1-dongxuyang@eswincomputing.com>

On Fri, Jul 24, 2026 at 04:43:20PM +0800, dongxuyang@eswincomputing.com wrote:
>    reg:
>      maxItems: 1
> @@ -44,11 +43,13 @@ properties:
>        - const: timer
> 
>    resets:
> +    minItems: 1
>      items:
>        - description: Interface bus (presetn) reset
>        - description: PWM timer logic (timer_N_resetn) reset
> 
>    reset-names:
> +    minItems: 1

Drop minItems in such case - resets with one item won't be allowed to be
used with reset-names

>      items:
>        - const: bus
>        - const: timer
> @@ -64,6 +65,23 @@ required:
>    - clocks
>    - clock-names
> 
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: eswin,eic7700-pwm
> +    then:
> +      properties:
> +        resets:
> +          items:
> +            - description: Combined APB interface and timer logic reset
> +        reset-names: false
> +      required:
> +        - resets

else:
  properties:
    resets:
      minItems: 2
    reset-names:
      minItems: 2

> +
>  additionalProperties: false
> 
>  examples:
> @@ -75,3 +93,12 @@ examples:

Best regards,
Krzysztof

