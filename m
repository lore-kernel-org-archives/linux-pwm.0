Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E847E431A34;
	Wed, 12 Aug 2026 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533393; cv=none; b=avevjoCglJI9sVkXbF3n9T7pvTb36Bt2bqWTwcJbwc18OPkw9FSO7FH8qVkOUSBOhA54M+2pCs8h4GSuse+dJ9040Waq0B5xcW1EfQeTxNATRb7Vr+nUwxmypl9LJgrsCIWQOiSNgna2hoq4Q4i/uaI8ro6GUx8dArcKEbV1Lb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533393; c=relaxed/simple;
	bh=UkrJAuwGmMF/fNtON2HKSi5JO/fwDV6RkKpWMrh9VcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFYoRgJBYe9nxBbW0W8FCkVo5D+9ZT48XTH5YsNo4GVQLvCcE4m0Y8rqKs4BI7kA+rS4jkW2SUmVpuxOJ0Hsth+yCBpQMYkKz/3YCBZDSFnN2V+ewaxs4zsvn/19vnOrZZ7km25ED4CcuwF+UX30BYBBXhWiWLxbN/s+1S1Cxk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aq7b+b7P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aq7b+b7P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEB71F000E9;
	Wed, 12 Aug 2026 11:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786533390;
	bh=bXJAoKuOzaSXieVdd1OyY5L7/X1+2blaPqmx6LTftp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aq7b+b7PcLmUOEwd9UicdMfO87JgdcEtptnXSCcIaSWvrXr1ePMlHrIKMCMgDJRoe
	 3IsYqPg00fvZLBvex1B84lsnSnpAJKQNNfdZJRdlj3o9mEo2sro2TuYIkZQ9yXoH6B
	 rxMEz5m/yTiX35wWi4zR+Ak4dt3cw4nY1oEgYvPVOvLt4oqEi25Q7AhB4h/8Ac3JTu
	 1SeA6OSlIJTPkubkkO5OHP610vxPikIYNqJtQyXg72dk32xyBtqVc+RyJL1en1E0LX
	 qIv4L/33x6zTNJb4+5EFNDuzGkVCOYrxCiUmGjvbn4BjzJNfRI1txUD+5+lgDacvnk
	 +4etDeFAQiBcw==
Date: Wed, 12 Aug 2026 13:16:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>, 
	Prasad Bolisetty <pbolisetty@axiado.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: add Axiado AX3000 PWM
Message-ID: <20260812-fearless-antelope-of-might-cf3eff@quoll>
References: <20260811-axiado-ax3000-pwm-v3-0-6ceaccd812cf@axiado.com>
 <20260811-axiado-ax3000-pwm-v3-1-6ceaccd812cf@axiado.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260811-axiado-ax3000-pwm-v3-1-6ceaccd812cf@axiado.com>

On Tue, Aug 11, 2026 at 02:01:50AM -0700, Petar Stepanovic wrote:
> The Axiado AX3000 and AX3005 SoCs include PWM controllers that can be
> used to generate configurable PWM output signals.
> 
> Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
> ---
>  .../devicetree/bindings/pwm/axiado,ax3000-pwm.yaml | 53 ++++++++++++++++++++++
>  MAINTAINERS                                        |  8 ++++
>  2 files changed, 61 insertions(+)
> 

Where did you explain reason to drop the tag?

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

Please read:
https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state in the patch changelog
or cover letter why and what changed.
</form letter>

> diff --git a/Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml b/Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml
> new file mode 100644
> index 000000000000..7297abccbc24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/axiado,ax3000-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Axiado AX3000 PWM controller
> +
> +maintainers:
> +  - Petar Stepanovic <pstepanovic@axiado.com>
> +  - Akhila Kavi <akavi@axiado.com>
> +  - Prasad Bolisetty <pbolisetty@axiado.com>
> +
> +description:
> +  The Axiado PWM controller found on the AX3000 and AX3005 SoCs.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: axiado,ax3000-pwm
> +      - items:
> +          - const: axiado,ax3000-pwm

So 3000 is listed twice. You need to test your DTS.

Best regards,
Krzysztof

