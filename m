Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA8135AC20
	for <linux-pwm@vger.kernel.org>; Fri,  3 Jul 2026 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090134; cv=none; b=oMzGw/uMzDdwCvrrE3ns/uOfdLtnn+kVnaKJKnoT2IFK6MHYEcS+hmHsVDVeZcf27FZIsTBM7/YwP9fPGiHrh6XEaQOX5K97esZX1a4Dwt0tHcJZztgEV2JLID1g4wyrf8tTtjB2G+9G7apSxLw9A+dhQaaKBio/CYHpTFb1ar8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090134; c=relaxed/simple;
	bh=HqK0apG2WBVp9keeHQN4EfAdivjOtfyBmEcKP8064hw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riRQIpcselYotoLBdJr7x1aHKzADeDkZvljjPEuRGuEKB9irJ/CtHpsaDMTPBsaL63zFn0+28om6Qv2/xJCwZD8cm/sAFnxFlPh4Xkdb3tJU9EeTKb1I0/6h8icWS4603wnnCtHuwLG2Y8Kty5ZB6DW5I5hs/tzzpLePhVcr018=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e+7lz/PP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e+7lz/PP"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493c733f15aso5958075e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 03 Jul 2026 07:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783090131; x=1783694931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RtbeAb4anjju2Gg5Hr2svmQH8LAj1CgUb05x/8fx3ZI=;
        b=e+7lz/PPnTzecXOAHSvZyU3R8gflwVZHQobEZRvjqS0VJt1OD2OxEdy7uypE1VSXhW
         Wo2KlJRzSCCadbsZ3g6xor/zF/CAXgJy6mmpT3K1jfMsg8F79YWpFcfLzyeZzCUsqyAv
         Z38B0wbs9LazAhImGpTwxhyrRbFe+rB6YqhnWSPxRIwvZ6bxF6qt9zg6794DgkVcD8GA
         2QwPxfSpHgUdlj55ugttafXDrD1xYpkTFOjhBZqJZtQDe+jOxlrDvErQrG0kxvvBIxxJ
         L7A0zCVWI1NwbNMbs4zpW+/VO1jsEH50fgePG27cYspi5SJLTDHDEESLHvoSWn3LNgj3
         +ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783090131; x=1783694931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtbeAb4anjju2Gg5Hr2svmQH8LAj1CgUb05x/8fx3ZI=;
        b=p84aDVez4rfeSGiT6XIAfW2msy7mW8GlfnPFaK2H8ppR1uSRlL6gf0W5QYDxOhrcH5
         QJIlJVamyDzLVUnK6+h+TuugoCAsAgcZiE/X6EUOnOk3VLn7sb8spjaGvsoiLEGDKNPD
         1xjejoHUAoNAjaZPUzfoiGl8bdw9VGJD45cgKEV5Obi7sABEd43gNMT45btSkUhS0mYZ
         0gSnJZ5G8jsQUzCaZBg5RxPdQTKVBs+F6S9N3X5NOC7/PTfSCsS4U45SYJfQb0rr39Wh
         oCxfZ52tFca+wlXr/bsC7MR3QiOJ3ZtZipDFcLwuyxnrPHrfoBFz425sHis//LEkPMzY
         8p8Q==
X-Forwarded-Encrypted: i=1; AFNElJ95Avgerv/FAECuYDfC/iJV4W4jeNnHa8WAadK4sa1qU6EUBpIvKrwvqteDlD0GPm6CMvrmviAtI7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG60C99r2u1B3Pjoz3hkNGDyHpvb0yJroHo348blPCoXQxKZIX
	gXYeF60I5giAsNLAW1Hwlh7qOY8o8OSLQ4GUnLXrNA49JKo4mPT8d2jykLE2yA21UFQ=
X-Gm-Gg: AfdE7ckniDmBm3Rm+G5N8vuhX8yx26KiqqNz1ZSYJTuxdkucT3GZKDjfE0mQ50j9VCc
	F6d9ForjXcHFOYwlpl/cERTogcT+vzq3g2qgURGXtMcv/0FDJMHhM3hfvSVTzI3G8J3J0TbMlfD
	WjEDMPAV4vRwhMefAhQR9YcXJUkgadwnhpuAJvz3WgOqmjm006OkQDQ8XQTPZHMtPIhj97As0/E
	AOHIICunycBIsYtzio8hyC5z9XGGJyA97fbBHmPPJT5OOn7nk/i/oyFU6uIxY+ue14DSwg4ziH8
	zk8szO5VWmbjnO/E8rFdQgPU4OWVFwWk+3xUqSP1mxPG00ER9i9ZhtsoYRmnL0o46gWtUfvNYBu
	sTxIRGVSMJniY+e1MdUQQp1PLezidM6ruXsRb3l60RKhn+/zsqGCaRGHN0JXlOOGodN1Uya7XtO
	qF/2A72VzP3bg=
X-Received: by 2002:a05:600c:34c5:b0:493:bc4a:e7d3 with SMTP id 5b1f17b1804b1-493d0f4efa6mr1735385e9.39.1783090131280;
        Fri, 03 Jul 2026 07:48:51 -0700 (PDT)
Received: from localhost ([195.94.145.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637568dsm149767675e9.4.2026.07.03.07.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 07:48:50 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 3 Jul 2026 16:52:17 +0200
To: Sean Young <sean@mess.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com
Subject: Re: [PATCH v5 2/3] pwm: rp1: Add RP1 PWM controller driver
Message-ID: <akfMoQfzmEEiH9VC@apocalypse>
References: <cover.1780670224.git.andrea.porta@suse.com>
 <f8dd46a553351adaf9d29fbba9f98e803b672fe7.1780670224.git.andrea.porta@suse.com>
 <aiwX2YWVJnDNTNiu@extorris.mess.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiwX2YWVJnDNTNiu@extorris.mess.org>

Hi Sean,

On 15:29 Fri 12 Jun     , Sean Young wrote:
> On Fri, Jun 12, 2026 at 04:01:27PM +0200, Andrea della Porta wrote:
> > From: Naushir Patuck <naush@raspberrypi.com>
> > 
> > The Raspberry Pi RP1 southbridge features an embedded PWM
> > controller with 4 output channels, alongside an RPM interface
> > to read the fan speed on the Raspberry Pi 5.
> > 
> > Add the supporting driver.
> > 

<...snip...>
> 
> I don't understand the point of the clk_enabled field. If the probe
> function succeeds, then clk_enabled = true. It is set to false during
> suspend, but after suspend the only thing which can follow is resume,
> I think. In resume, we set it in to true again unconditionally. So
> it is always true, no?

It's true unless enabling the clock again in rp1_pwm_resume() will fail.
That will trap the unbalanced condition mentioned by Uwe in:
https://lore.kernel.org/all/adiW1tBC8Imd14LD@monoceros/

> 
> > +};
> > +
> > +struct rp1_pwm_waveform {
> > +	u32 period_ticks;
> > +	u32 duty_ticks;
> > +	bool enabled;
> > +	bool inverted_polarity;
> > +};
> > +

<...snip...>

> > +
> > +	/*
> > +	 * The period is limited to U32_MAX, and it will be decremented by one later
> > +	 * to allow 100% duty cycle.
> > +	 */
> > +	if (period_ticks > U32_MAX) {
> > +		period_ticks = U32_MAX;
> > +	} else if (period_ticks < 2) {
> > +		period_ticks = 2;
> > +		ret = 1;
> > +	}
> 
> period_ticks = clamp(period_ticks, 2, U32_MAX);
> 
> Although that misses out the `ret = 1;` which I am not sure about anyway.

But we need that ret = 1 to announce that values have been rounded.

> 
> > +
> > +	duty_ticks = mul_u64_u64_div_u64(wf->duty_length_ns, clk_rate, NSEC_PER_SEC);
> > +	duty_ticks = min(duty_ticks, period_ticks);
> > +	offset_ticks = mul_u64_u64_div_u64(wf->duty_offset_ns, clk_rate, NSEC_PER_SEC);
> > +	if (offset_ticks >= period_ticks)
> > +		offset_ticks %= period_ticks;
> > +	if (duty_ticks && offset_ticks &&
> > +		ret = dev_err_probe(dev, -EINVAL, "Clock rate > 1 GHz is not supported\n");

<...snip...>

> > +		goto err_disable_clk;
> > +	}
> > +	rp1->clk_rate = clk_rate;
> > +
> > +	chip->ops = &rp1_pwm_ops;
> 
> Can we add the following please:
> 
> 	 chip->atomic = true; 
> 
> This means that the pwm can be controlled from atomic context (not process
> context) using pwm_apply_atomic(). This is very helpful for the pwm-ir-tx
> driver, which produces a much more faithful IR signal in atomic context.
> 
> Using pwm for infrared tx is much nicer than using gpio which bit bangs
> the IR signal and holds the CPU with interrupts disabled for upto one second.
> 
> As far as I can see there is no sleeping code in these code paths, so we
> should be fine.

Sure, added.

Many thanks,
Andrea

> 
> Thanks,
> 
> Sean
>

<...snip...>
