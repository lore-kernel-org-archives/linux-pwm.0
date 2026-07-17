Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634E53B4E9B
	for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2026 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280130; cv=none; b=YLBEb2tYBvC6x7b1G3ykLs7D57DoonAGuIPgGeYdgzDALlUhitpbZ3zUu+AEeMqWgVmRTcAwwXI7W73z/BoZwH0TITGYkqwxCldpMQAmjGJz4IsSzKnkHnhbst99IoAZEvmxdXi8M2foFUhNYmxqYK+2REBMjGlmzr2Ul92t1zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280130; c=relaxed/simple;
	bh=7xdOZGot6BtG+nkkhzDAvDczSMEadk3BnxqsMRs+TSw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3pB+Qhy37IiWTPCJsdhVAeeJE/xuSiykEW+4hpOrq7RsfAAhLASt8suhgp2KR8I/bmsx7uluq3TRQCzuVS5XnvSh5qCpjW/KkVTI6lCevsPsu2IfPwf8M29+WWC9+3wdoDuq7KOWTE/rsOsu8hA7ARhQ22lgIEPDyWPgI8Jtss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jb1o91ue; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jb1o91ue"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso1544525e9.3
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2026 02:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784280126; x=1784884926; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gzjBXZKIKg4NMJoFDhnAAkVBwR6E1EVSUHn48IzBxJ8=;
        b=Jb1o91ueqniRLSCQoeWwQVh9rnYnvxKTZLzaXV389NTCH0Uw7ayIlTP5M43wTE5Mt/
         uOxTgqHOls0Eiqu760MexeooopRqytH0wmJOG+JqbFWC8sdwuw+opKuR0z6gxSlaSOLG
         /3WZ5gK4uhNlXENEFW4eT3SwdEgQQ2SlGFxssYzk26csgfG1tGmfn1oTUYxRt/NG8GyC
         JDT575onu643mGt4PXfvRr3FojbQuLLgznYeDnod1ehQkw7dtRjFSaIQSKWkiIS3nfkj
         2MYmz1/8QJCUbZd6rIZflQdya2lBb08NETUz5lOYC8EKDRW2G7TZZQDJDV/WHf4u2ar/
         vqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784280126; x=1784884926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gzjBXZKIKg4NMJoFDhnAAkVBwR6E1EVSUHn48IzBxJ8=;
        b=MuQ55YSsbuXFmkQMxPx+DKyKz+qIxHcbUjkhA+n4XsE6JJuwo9MrcpfgCydJRMkwpe
         55qfBc9P4NAuFuJ72msXmI9Dv1fgpVRmg3rn2iJ8IGt720/ksewIfRhkHpurXYct4a57
         ynUpDUOhZMfwzcT7oIbr8ADAdjMde42LA/hPycw50NWwXtpY1YBXOf8+xzL0hJtM/dtz
         IdAty+u1mGBNJlag3a5cotI6kNWgz3xrf6C8aFVcGVw9+yc40IQlWw9gaSzAGG3LdCKx
         UbRf66CJ8gV9kIJs6egZ7B4SaEiPiWLhQ3slEYW0EQPG73BJCRgWdMV5Vap2z5S4xjWX
         opnA==
X-Forwarded-Encrypted: i=1; AHgh+RppUE736qqhnOcxg1n0DOrFuPR2UYa/GvTOFJW4NFS+951IrhUhGpfEotP989Gk/bz65VxBBqzOE7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwasJe0cqyxrCioanREovYyPrYbuibVX+L/0aaEsl2b4imNvhOC
	n/c2gO0sXGbSFXBro60L85eYIOwdCQWy8dBtIT8VXEBdrXajEwk3/dWHgPwRnayzIKzUwG204o7
	OH0KRvvs=
X-Gm-Gg: AfdE7cmKOJeAjY0zyjhaXSOdROQmjcsBSU1Sfr1yibFN885XVYx7ewZO14sjspg9R6O
	6AkE3UUZII3Qnd0Ugf4Y/8xDMJp0KH3x7W9T0PfzRQNQq1M+Bc9JZWvGwTNdbhtu6oRcl1BpC8f
	WsbVt/kN3qWdKsw2YGq2/P5MVGm1lDrzJ31JEF2DuY7vorVO/qvhPx1sKSfcyiorowEG6hohm2a
	3y5wJCLF3VpPMo9lTw7GTRzz+gmZ7ayrPGjJTX7J+NL3oBRrGCA+5eMz9f0WnZHXsdwKnDx2ONe
	Ecqzn0Qa2GDPmswM+Yb/uFO56s5PWK3JcM18Kkn+geJdK5T7DBznsVguuI9XbDhvKAyW3gEbmFg
	hJWHStIB/Hbos+rXik5BeWPCjtb6jynLMW2JeIA8wq+J1v313BMLPcV+RRqpXZRkv+Cj2P8//gz
	JxrWW0a7i0ZwY=
X-Received: by 2002:a05:600c:a40c:b0:492:53e8:3bc1 with SMTP id 5b1f17b1804b1-4954a3eb0b4mr13340425e9.17.1784280126576;
        Fri, 17 Jul 2026 02:22:06 -0700 (PDT)
Received: from localhost ([195.94.145.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c96fecsm40535225e9.11.2026.07.17.02.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 02:22:06 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 17 Jul 2026 11:25:35 +0200
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>, linux-pwm@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com,
	Sean Young <sean@mess.org>, Julian Braha <julianbraha@gmail.com>
Subject: Re: [PATCH v6 2/3] pwm: rp1: Add RP1 PWM controller driver
Message-ID: <aln1D3E5QZULZ2U1@apocalypse>
References: <cover.1783097764.git.andrea.porta@suse.com>
 <5171610d8bebdd10eea44bff5236502d765b5918.1783097764.git.andrea.porta@suse.com>
 <alibzwe9Mjf3GxJo@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alibzwe9Mjf3GxJo@monoceros>

Hi Uwe,

On 11:18 Thu 16 Jul     , Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Jul 03, 2026 at 07:05:25PM +0200, Andrea della Porta wrote:
> > +static int rp1_pwm_round_waveform_tohw(struct pwm_chip *chip,
> > +				       struct pwm_device *pwm,
> > +				       const struct pwm_waveform *wf,
> > +				       void *_wfhw)
> > +{
> > +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> > +	u64 period_ticks, duty_ticks, offset_ticks;
> > +	struct rp1_pwm_waveform *wfhw = _wfhw;
> > +	u64 clk_rate = rp1->clk_rate;
> > +	int ret = 0;
> > +
> > +	if (!wf->period_length_ns) {
> > +		wfhw->enabled = false;
> > +		wfhw->inverted_polarity = (pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED);
> 
> pwm_get_polarity(pwm) looks wrong here for several reasons. 1st the
> polarity is defined in *wf and should not depend on the current state,
> 2nd for a disabled hardware the polarity doesn't matter anyhow, and 3rd
> you should not call pwm API functions from the lowlevel driver (which
> might interfere with subsystem locking).

Ok, but in this case what the output of the disabled channel should be?
If it was inverted before the disable, would it make sense to let the output
be high? Or are we allowed to hard code a polarity value on disable?

> 
> Also please initialize the whole structure, best done using:
> 
> 	*wfhw = (typeof(*wfhw)){
> 		.enabled = false,
> 	}

Ack. In this case inverted_polarity would be falsei though, see above.

> 
> > +		return 0;
> > +	}
> > +
> > +	period_ticks = mul_u64_u64_div_u64(wf->period_length_ns, clk_rate, NSEC_PER_SEC);
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
> > +
> > +	duty_ticks = mul_u64_u64_div_u64(wf->duty_length_ns, clk_rate, NSEC_PER_SEC);
> > +	duty_ticks = min(duty_ticks, period_ticks);
> > +	offset_ticks = mul_u64_u64_div_u64(wf->duty_offset_ns, clk_rate, NSEC_PER_SEC);
> > +	if (offset_ticks >= period_ticks) {
> > +		u64 remainder;
> > +
> > +		div64_u64_rem(offset_ticks, period_ticks, &remainder);
> > +		offset_ticks = remainder;
> 
> 		offset_ticks = period_ticks - 1;

Ack.

> 
> > +	}
> > +	if (duty_ticks && offset_ticks &&
> > +	    duty_ticks + offset_ticks >= period_ticks) {
> > +		wfhw->duty_ticks = period_ticks - duty_ticks;
> > +		wfhw->inverted_polarity = true;
> > +	} else {
> > +		wfhw->duty_ticks = duty_ticks;
> > +		wfhw->inverted_polarity = false;
> > +	}
> > +	/* Account for the extra tick at the end of the period */
> > +	wfhw->period_ticks = period_ticks - 1;
> > +
> > +	wfhw->enabled = true;
> > +
> > +	return ret;
> > +}
> > +
> > +static int rp1_pwm_round_waveform_fromhw(struct pwm_chip *chip,
> > +					 struct pwm_device *pwm,
> > +					 const void *_wfhw,
> > +					 struct pwm_waveform *wf)
> > +{
> > +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> > +	const struct rp1_pwm_waveform *wfhw = _wfhw;
> > +	u64 clk_rate = rp1->clk_rate;
> > +	u64 ticks;
> > +
> > +	*wf = (struct pwm_waveform){ };
> > +
> > +	if (!wfhw->enabled)
> > +		return 0;
> > +
> > +	wf->period_length_ns = DIV_ROUND_UP_ULL(((u64)wfhw->period_ticks + 1) * NSEC_PER_SEC,
> > +						clk_rate);
> > +
> > +	if (!wfhw->inverted_polarity) {
> > +		wf->duty_length_ns = DIV_ROUND_UP_ULL((u64)wfhw->duty_ticks * NSEC_PER_SEC,
> > +						      (u32)clk_rate);
> > +	} else {
> > +		if (wfhw->duty_ticks > (u64)wfhw->period_ticks + 1) {
> > +			/* 100% duty cycle case */
> > +			ticks = 0;
> > +		} else {
> > +			ticks = (u64)wfhw->period_ticks + 1 - wfhw->duty_ticks;
> > +		}
> > +		wf->duty_length_ns = DIV_ROUND_UP_ULL(ticks * NSEC_PER_SEC, clk_rate);
> > +		wf->duty_offset_ns = wf->period_length_ns - wf->duty_length_ns;
> 
> The duty_offset_ns calculation is wrong.
> 
> Consider clk_rate = 3000000, period_ticks = 8, inverted_polarity = true and
> duty_ticks = 4.
> 
> Then you have:
> 
> 	.period_length_ns = 2666.6666666666666 ns ~> 2667
> 	.duty_length_ns = 1333.3333333333333 ns -> 1334
> 	.duty_offset_ns = 1333.3333333333333 ns -> 1334
> 
> but .period_length_ns - .duty_length_ns is 1333.
> 
> To get this right, you have to calculate
> 
> 	wf->duty_offset_ns = DIV_ROUND_UP_ULL((u64)(wfhw->period_ticks + 1 - ticks) * NSEC_PER_SEC, clk_rate);

So it will end up as 'duty_length_ns + duty_offset_ns > period_length_ns', which is
timing violation. Is it allowed (or even required) in the PWM subsystem?

> 
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int rp1_pwm_write_waveform(struct pwm_chip *chip,
> > +				  struct pwm_device *pwm,
> > +				  const void *_wfhw)
> > +{
> > +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> > +	const struct rp1_pwm_waveform *wfhw = _wfhw;
> > +	u32 value, ctrl;
> > +
> > +	/* set polarity */
> > +	regmap_read(rp1->regmap, RP1_PWM_CHAN_CTRL(pwm->hwpwm), &value);
> > +	if (!wfhw->inverted_polarity)
> > +		value &= ~RP1_PWM_CHAN_CTRL_POLARITY;
> > +	else
> > +		value |= RP1_PWM_CHAN_CTRL_POLARITY;
> > +	regmap_write(rp1->regmap, RP1_PWM_CHAN_CTRL(pwm->hwpwm), value);
> > +
> > +	/* early exit if disabled */
> > +	regmap_read(rp1->regmap, RP1_PWM_GLB_CTRL, &ctrl);
> > +	if (!wfhw->enabled) {
> > +		ctrl &= ~RP1_PWM_GLB_CTRL_CHANNEL_ENABLE(pwm->hwpwm);
> > +		goto exit_disable;
> 
> Please don't use goto unless for error handling.

Ack.

> 
> > +	}
> > +
> > +	/* set period and duty cycle */
> > +	regmap_write(rp1->regmap,
> > +		     RP1_PWM_RANGE(pwm->hwpwm), wfhw->period_ticks);
> > +	regmap_write(rp1->regmap,
> > +		     RP1_PWM_DUTY(pwm->hwpwm), wfhw->duty_ticks);
> > +
> > +	/* enable the channel */
> > +	ctrl |= RP1_PWM_GLB_CTRL_CHANNEL_ENABLE(pwm->hwpwm);
> > +exit_disable:
> > +	regmap_write(rp1->regmap, RP1_PWM_GLB_CTRL, ctrl);
> > +
> > +	rp1_pwm_apply_config(chip, pwm);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rp1_pwm_read_waveform(struct pwm_chip *chip,
> > +				 struct pwm_device *pwm,
> > +				 void *_wfhw)
> > +{
> > +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> > +	struct rp1_pwm_waveform *wfhw = _wfhw;
> > +	u32 value;
> > +
> > +	regmap_read(rp1->regmap, RP1_PWM_GLB_CTRL, &value);
> > +	wfhw->enabled = !!(value & RP1_PWM_GLB_CTRL_CHANNEL_ENABLE(pwm->hwpwm));
> > +
> > +	regmap_read(rp1->regmap, RP1_PWM_CHAN_CTRL(pwm->hwpwm), &value);
> > +	wfhw->inverted_polarity = !!(value & RP1_PWM_CHAN_CTRL_POLARITY);
> > +
> > +	if (wfhw->enabled) {
> > +		regmap_read(rp1->regmap, RP1_PWM_RANGE(pwm->hwpwm), &wfhw->period_ticks);
> > +		regmap_read(rp1->regmap, RP1_PWM_DUTY(pwm->hwpwm), &wfhw->duty_ticks);
> > +	} else {
> > +		wfhw->period_ticks = 0;
> > +		wfhw->duty_ticks = 0;
> > +	}
> 
> Ideally use *wfhw = (typeof(*wfhw)){ ... } here, too, to make it obvious
> that the complete struct is initialized.


Ack.

> 
> > +
> > +	return 0;
> > +}
> > [...]
> > +static struct platform_driver rp1_pwm_driver = {
> > +	.probe = rp1_pwm_probe,
> > +	.remove = rp1_pwm_remove,
> > +	.driver = {
> > +		.name = "rp1-pwm",
> > +		.of_match_table = rp1_pwm_of_match,
> > +		.pm = pm_ptr(&rp1_pwm_pm_ops),
> > +		.suppress_bind_attrs = true,
> 
> If the driver cannot be removed, .remove() is just dead code. Drop it
> and note in a comment that this is needed because a syscon cannot be
> removed.

Ack.

Many thanks,
Andrea

> 
> Best regards
> Uwe


