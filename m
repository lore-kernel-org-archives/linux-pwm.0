Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2303D647C;
	Fri, 11 Sep 2026 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789110204; cv=none; b=Iz3BQrfJaSnCateGcTXFjjKFG08SLdQksD/OIueqnDjA1Ke7P2tDYdVsVS5m955XWDJgeX976j3B2zigdn2SDMvRUqor/CC0By13Y0mDe9IzJsY+KFcl41qfvz54+ORe8fK4DFzQkD0YVD0MyDgDRYwKb+DpFXPdKygOVITtc2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789110204; c=relaxed/simple;
	bh=XfnCNwQRJmMHNboMQkxeZV5+wm9+CQAH6rOmQEgC1/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqKW1lPtFPikCCv/SqGcCXOD4AguyVzBMpejS5HqsDlIROwWrwaUPcAa6EGuFl1plXlXIGHtuujFKy1cG3CLJ5yhZkS1PNOiM/nIgp3zAG5RXGLm/rLpZoIHMaywLU//NveTm82RnLtQRJswzc9/Nx8pUYQLjeFWnH6F9J49FDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gg0J95fH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gg0J95fH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3421F000FF;
	Fri, 11 Sep 2026 07:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789110187;
	bh=fLOv9PqRHm0Dp6AEU3FrEQYqlkc9d2Rysj5SU5cG6RY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gg0J95fHymQW9M8DoQvwqtACHc8nmHNl3IQWWBWUFvaP/N3OpVH0jrAGtc44djAkT
	 3+G3/D5vLC4wPjCNtA0WMtNa/MO2TkPe+ebtT0UBqnDRZIkTsEYY1dAJmZPRs98rUD
	 MTp1DoYUVl4Xyk70tm07cBt9bKGNME+RcofIzO0pHken0ud47IeATdooHTXZXjsNX+
	 6/K92K/LJCRnlHk5J3CkxuKAOYAfuojyK1U4E7MqSpT85p7Z5gLNfE5K07Vcov9cEX
	 5Unv0Z/nW7hykBvwro5/waAjxNj8kmwAmp9xKsZUeK9e5HOSQzr27Q2OGR3euIz1ut
	 laaSeYJmaKqFA==
Date: Fri, 11 Sep 2026 09:03:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>, 
	Prasad Bolisetty <pbolisetty@axiado.com>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Tzu-Hao Wei <twei@axiado.com>, 
	Karthikeyan Mitran <kmitran@axiado.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: add Axiado AX3000 and AX3005
 PWM fan controller
Message-ID: <20260911-melodic-naughty-kestrel-efc72e@quoll>
References: <20260903-axiado-ax3000-pwm-fan-v2-0-ef43df46163e@axiado.com>
 <20260903-axiado-ax3000-pwm-fan-v2-1-ef43df46163e@axiado.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260903-axiado-ax3000-pwm-fan-v2-1-ef43df46163e@axiado.com>

On Thu, Sep 03, 2026 at 01:38:39AM -0700, Petar Stepanovic wrote:
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
>  .../bindings/hwmon/axiado,ax3000-pwm-fan.yaml      | 72 ++++++++++++++++++++++
>  MAINTAINERS                                        |  8 +++
>  2 files changed, 80 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

