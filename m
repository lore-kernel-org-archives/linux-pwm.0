Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5A23D9695;
	Fri,  5 Jun 2026 10:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654365; cv=none; b=FXGr9fhlrL6WfL4DPN1emFm6EOcXg/yslzgpO7l+/aLUsHUPbbRzIwMcMmL/wA83Vf+USKIQOfumkj4Gx32R8gXtBJOKhdubiOlP0mO4v9HN/d0DxKG2EHEdQwxTz2XUphiIc5is5FegJXYTn46g5rqS5fvyrGiAQFQqThiCuZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654365; c=relaxed/simple;
	bh=CIkR8cjMUVdvDHLzDkluGzPKK7bYP++kACeQWpOorjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWT7kfLHsHIbKWlOsbptGtpvByMoh+lc8eAwb4Vz2eIyleasYjREljaLpovJO4xJqxWorDRgMqMf5bdZOdcqwV35cKO+BiseaXcEkCXSqJeTVkeVPjawgwkGgHqUcLLeg1K2oG3UCzNhcqVwI5TDJr4zhNsja21eVK1OnQO9zvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDMz0iCQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDMz0iCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F641F00893;
	Fri,  5 Jun 2026 10:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780654364;
	bh=zhVrqnma09BbNTp2y8kw//UOaEXkKa12YV/Uc7Xou7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aDMz0iCQvwrMWTxQEqnGNObcI4VWqxC1fY7IqCm22urpWBhRnGAuuwU/I0kL+Rfjn
	 NjXAni2tReo9qPoUZp87MoA0un3rdcq3kdMcaw1lLZdWsDsQvSMzpKr4JCTLhkve2e
	 zgTJjI4Ct+poUlujBdNMp3W/YN4KWugmZI2eSxTGcYqQX1of7eSUb6GXRo6NZjEpYx
	 bQTJXl6vTfB/UVmdOz0fAUzeUuoavAoBLMsTaQjUM/aRU7ny2OOw9Rd+8HdX4H0qgt
	 z8UhULo0V3srwAhYilvfjrGTm7jCl93eGU+qWCdpX+BVwSAhvjYTR0OWA/8Bo3N7Fn
	 GuCxBHK8LqtLA==
Date: Fri, 5 Jun 2026 12:12:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: dongxuyang@eswincomputing.com
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk, 
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v7 1/2] dt-bindings: pwm: dwc: Add eswin compatible and
 resets property
Message-ID: <20260605-scrupulous-tasteful-nuthatch-5d8ce3@quoll>
References: <20260605082242.1541-1-dongxuyang@eswincomputing.com>
 <20260605082318.1599-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260605082318.1599-1-dongxuyang@eswincomputing.com>

On Fri, Jun 05, 2026 at 04:23:18PM +0800, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
> 
> EIC7700 use DesignWare IP for PWM controllers. Add ESWIN EIC7700 support
> in snps,dw-apb-timers-pwm2.yaml.
> 
> The DesignWare PWM includes separate reset signals dedicated to each clock
> domain:
> The presetn signal resets logic in pclk domain.
> The timer_N_resetn signal resets logic in the timer_N_clk domain.
> The resets are active-low.
> 
> The generic snps,dw-apb-timers-pwm2 binding allows one or two optional

I don't know what is the generic binding, but it does not allow. Open
the file: there are no resets at all, so it does not allow them. Or you
mixed tenses here and you wanted to describe the change?

The present tense describes current state of source code before applying
the patch. The patch transform that current state, so you don't use
present tense to show what will be future.

Unless you meant here a device, not binding. I would be picky here
except that your binding is incorrect which made me looking for answers.
I cannot find these answers.

> reset lines depending on SoC integration.
> 
> On EIC7700, the presetn and timer_N_resetn inputs are physically tied
> to a single reset line, therefore exactly one reset is required.
> 
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
> ---
>  .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml | 38 +++++++++++++++++--
>  1 file changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> index 7523a89a1773..a4b7929f2e05 100644
> --- a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> +++ b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> @@ -20,12 +20,11 @@ description:
>    instead of having to encode the IP version number in the device tree
>    compatible.
>  
> -allOf:
> -  - $ref: pwm.yaml#
> -
>  properties:
>    compatible:
> -    const: snps,dw-apb-timers-pwm2
> +    enum:
> +      - snps,dw-apb-timers-pwm2
> +      - eswin,eic7700-pwm
>  
>    reg:
>      maxItems: 1
> @@ -43,6 +42,12 @@ properties:
>        - const: bus
>        - const: timer
>  
> +  resets:
> +    minItems: 1
> +    items:
> +      - description: Interface bus reset
> +      - description: PWM timer logic reset
> +
>    snps,pwm-number:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: The number of PWM channels configured for this instance
> @@ -54,6 +59,22 @@ required:
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
> +          minItems: 1

Drop

> +          maxItems: 1

So you want to add resets for the existing variant claiming that they
were missing? Probably we should tell you that earlier, although the
patch was going odd directions, but you need to split it. First you fix
existing devices with explanation why. Then you add new compatible with
constraint for one reset.


Best regards,
Krzysztof

