Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBC73D969D;
	Thu, 16 Jul 2026 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193525; cv=none; b=FlY9g+cw4L6SdzuqodZBIJMl+Jw7W31Bm2O5LMv2dwZbBgr+h+gqzg+/AjXXX/nZX3jzzCCru5yOydS/DyED7FzxveFj6YmLCegXTCsXT1A8gxtd3FSLxi9FJILFaZuCrccTTFHZua7YGBEw9TVKbNTjN3roBGxyMNkM1DXZmNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193525; c=relaxed/simple;
	bh=EDz8kRCG2Lua5q4CXzDibq15TpC2uW5IWpqbrXH1u+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCrCa42BhQhVCUhfros3OODvwtiIlSnty633xHI4A/xgZvTRllOfiPTzQaG3TpWvt4LvkPZKthxe3N53+96vfsJWVpcAsBbccJQrOUo3SVrL7Bt7QWaF30CEpd1VKqyEKcCN16FWeMRngg01FtJqMBkdCoqgPipa7IHRr4+HHMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nv3cAleC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nv3cAleC"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 34DD01F000E9;
	Thu, 16 Jul 2026 09:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784193523;
	bh=PufDVCHDfk+K2XGfK3RL33FCeDZYB4LV2HI5pP5tT8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nv3cAleCx3IDxvdag8QA1Z2zrUSvBPmi0uKvEtaOpcqBsze7ySsz0Jl43z9pwWZDq
	 LYdH8yRyYO9Vs4RM6ZtHm0rlHClP1nmSMBAlZcViYagwAuqrQqF7KwIY0wGaoJAED4
	 h+J3sIajho+9TyRKa+OrZIJtJVoS/liO0MuNiFXeN50IidhMCC5IryS/erOQH6rDHE
	 ilYerjy+f2rXQUleXUttyCPUkZIaQD+hckikDfAxoIwL3QL308zrXJjBc5rjSl6sQw
	 PlRzoN4S9O+VZSs5aSSWNcXdxvbpBTS0zsgQ0Q6f9ZQ/jCiGNqenKsYtgaRvqChu8O
	 Kng61h6AT4puA==
Date: Thu, 16 Jul 2026 11:18:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Naushir Patuck <naush@raspberrypi.com>, Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com, 
	Sean Young <sean@mess.org>, Julian Braha <julianbraha@gmail.com>
Subject: Re: [PATCH v6 2/3] pwm: rp1: Add RP1 PWM controller driver
Message-ID: <alibzwe9Mjf3GxJo@monoceros>
References: <cover.1783097764.git.andrea.porta@suse.com>
 <5171610d8bebdd10eea44bff5236502d765b5918.1783097764.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zxlx2zmpzeyxgeid"
Content-Disposition: inline
In-Reply-To: <5171610d8bebdd10eea44bff5236502d765b5918.1783097764.git.andrea.porta@suse.com>


--zxlx2zmpzeyxgeid
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v6 2/3] pwm: rp1: Add RP1 PWM controller driver
MIME-Version: 1.0

Hello,

On Fri, Jul 03, 2026 at 07:05:25PM +0200, Andrea della Porta wrote:
> +static int rp1_pwm_round_waveform_tohw(struct pwm_chip *chip,
> +				       struct pwm_device *pwm,
> +				       const struct pwm_waveform *wf,
> +				       void *_wfhw)
> +{
> +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> +	u64 period_ticks, duty_ticks, offset_ticks;
> +	struct rp1_pwm_waveform *wfhw = _wfhw;
> +	u64 clk_rate = rp1->clk_rate;
> +	int ret = 0;
> +
> +	if (!wf->period_length_ns) {
> +		wfhw->enabled = false;
> +		wfhw->inverted_polarity = (pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED);

pwm_get_polarity(pwm) looks wrong here for several reasons. 1st the
polarity is defined in *wf and should not depend on the current state,
2nd for a disabled hardware the polarity doesn't matter anyhow, and 3rd
you should not call pwm API functions from the lowlevel driver (which
might interfere with subsystem locking).

Also please initialize the whole structure, best done using:

	*wfhw = (typeof(*wfhw)){
		.enabled = false,
	}

> +		return 0;
> +	}
> +
> +	period_ticks = mul_u64_u64_div_u64(wf->period_length_ns, clk_rate, NSEC_PER_SEC);
> +
> +	/*
> +	 * The period is limited to U32_MAX, and it will be decremented by one later
> +	 * to allow 100% duty cycle.
> +	 */
> +	if (period_ticks > U32_MAX) {
> +		period_ticks = U32_MAX;
> +	} else if (period_ticks < 2) {
> +		period_ticks = 2;
> +		ret = 1;
> +	}
> +
> +	duty_ticks = mul_u64_u64_div_u64(wf->duty_length_ns, clk_rate, NSEC_PER_SEC);
> +	duty_ticks = min(duty_ticks, period_ticks);
> +	offset_ticks = mul_u64_u64_div_u64(wf->duty_offset_ns, clk_rate, NSEC_PER_SEC);
> +	if (offset_ticks >= period_ticks) {
> +		u64 remainder;
> +
> +		div64_u64_rem(offset_ticks, period_ticks, &remainder);
> +		offset_ticks = remainder;

		offset_ticks = period_ticks - 1;

> +	}
> +	if (duty_ticks && offset_ticks &&
> +	    duty_ticks + offset_ticks >= period_ticks) {
> +		wfhw->duty_ticks = period_ticks - duty_ticks;
> +		wfhw->inverted_polarity = true;
> +	} else {
> +		wfhw->duty_ticks = duty_ticks;
> +		wfhw->inverted_polarity = false;
> +	}
> +	/* Account for the extra tick at the end of the period */
> +	wfhw->period_ticks = period_ticks - 1;
> +
> +	wfhw->enabled = true;
> +
> +	return ret;
> +}
> +
> +static int rp1_pwm_round_waveform_fromhw(struct pwm_chip *chip,
> +					 struct pwm_device *pwm,
> +					 const void *_wfhw,
> +					 struct pwm_waveform *wf)
> +{
> +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> +	const struct rp1_pwm_waveform *wfhw = _wfhw;
> +	u64 clk_rate = rp1->clk_rate;
> +	u64 ticks;
> +
> +	*wf = (struct pwm_waveform){ };
> +
> +	if (!wfhw->enabled)
> +		return 0;
> +
> +	wf->period_length_ns = DIV_ROUND_UP_ULL(((u64)wfhw->period_ticks + 1) * NSEC_PER_SEC,
> +						clk_rate);
> +
> +	if (!wfhw->inverted_polarity) {
> +		wf->duty_length_ns = DIV_ROUND_UP_ULL((u64)wfhw->duty_ticks * NSEC_PER_SEC,
> +						      (u32)clk_rate);
> +	} else {
> +		if (wfhw->duty_ticks > (u64)wfhw->period_ticks + 1) {
> +			/* 100% duty cycle case */
> +			ticks = 0;
> +		} else {
> +			ticks = (u64)wfhw->period_ticks + 1 - wfhw->duty_ticks;
> +		}
> +		wf->duty_length_ns = DIV_ROUND_UP_ULL(ticks * NSEC_PER_SEC, clk_rate);
> +		wf->duty_offset_ns = wf->period_length_ns - wf->duty_length_ns;

The duty_offset_ns calculation is wrong.

Consider clk_rate = 3000000, period_ticks = 8, inverted_polarity = true and
duty_ticks = 4.

Then you have:

	.period_length_ns = 2666.6666666666666 ns ~> 2667
	.duty_length_ns = 1333.3333333333333 ns -> 1334
	.duty_offset_ns = 1333.3333333333333 ns -> 1334

but .period_length_ns - .duty_length_ns is 1333.

To get this right, you have to calculate

	wf->duty_offset_ns = DIV_ROUND_UP_ULL((u64)(wfhw->period_ticks + 1 - ticks) * NSEC_PER_SEC, clk_rate);

> +	}
> +
> +	return 0;
> +}
> +
> +static int rp1_pwm_write_waveform(struct pwm_chip *chip,
> +				  struct pwm_device *pwm,
> +				  const void *_wfhw)
> +{
> +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> +	const struct rp1_pwm_waveform *wfhw = _wfhw;
> +	u32 value, ctrl;
> +
> +	/* set polarity */
> +	regmap_read(rp1->regmap, RP1_PWM_CHAN_CTRL(pwm->hwpwm), &value);
> +	if (!wfhw->inverted_polarity)
> +		value &= ~RP1_PWM_CHAN_CTRL_POLARITY;
> +	else
> +		value |= RP1_PWM_CHAN_CTRL_POLARITY;
> +	regmap_write(rp1->regmap, RP1_PWM_CHAN_CTRL(pwm->hwpwm), value);
> +
> +	/* early exit if disabled */
> +	regmap_read(rp1->regmap, RP1_PWM_GLB_CTRL, &ctrl);
> +	if (!wfhw->enabled) {
> +		ctrl &= ~RP1_PWM_GLB_CTRL_CHANNEL_ENABLE(pwm->hwpwm);
> +		goto exit_disable;

Please don't use goto unless for error handling.

> +	}
> +
> +	/* set period and duty cycle */
> +	regmap_write(rp1->regmap,
> +		     RP1_PWM_RANGE(pwm->hwpwm), wfhw->period_ticks);
> +	regmap_write(rp1->regmap,
> +		     RP1_PWM_DUTY(pwm->hwpwm), wfhw->duty_ticks);
> +
> +	/* enable the channel */
> +	ctrl |= RP1_PWM_GLB_CTRL_CHANNEL_ENABLE(pwm->hwpwm);
> +exit_disable:
> +	regmap_write(rp1->regmap, RP1_PWM_GLB_CTRL, ctrl);
> +
> +	rp1_pwm_apply_config(chip, pwm);
> +
> +	return 0;
> +}
> +
> +static int rp1_pwm_read_waveform(struct pwm_chip *chip,
> +				 struct pwm_device *pwm,
> +				 void *_wfhw)
> +{
> +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> +	struct rp1_pwm_waveform *wfhw = _wfhw;
> +	u32 value;
> +
> +	regmap_read(rp1->regmap, RP1_PWM_GLB_CTRL, &value);
> +	wfhw->enabled = !!(value & RP1_PWM_GLB_CTRL_CHANNEL_ENABLE(pwm->hwpwm));
> +
> +	regmap_read(rp1->regmap, RP1_PWM_CHAN_CTRL(pwm->hwpwm), &value);
> +	wfhw->inverted_polarity = !!(value & RP1_PWM_CHAN_CTRL_POLARITY);
> +
> +	if (wfhw->enabled) {
> +		regmap_read(rp1->regmap, RP1_PWM_RANGE(pwm->hwpwm), &wfhw->period_ticks);
> +		regmap_read(rp1->regmap, RP1_PWM_DUTY(pwm->hwpwm), &wfhw->duty_ticks);
> +	} else {
> +		wfhw->period_ticks = 0;
> +		wfhw->duty_ticks = 0;
> +	}

Ideally use *wfhw = (typeof(*wfhw)){ ... } here, too, to make it obvious
that the complete struct is initialized.

> +
> +	return 0;
> +}
> [...]
> +static struct platform_driver rp1_pwm_driver = {
> +	.probe = rp1_pwm_probe,
> +	.remove = rp1_pwm_remove,
> +	.driver = {
> +		.name = "rp1-pwm",
> +		.of_match_table = rp1_pwm_of_match,
> +		.pm = pm_ptr(&rp1_pwm_pm_ops),
> +		.suppress_bind_attrs = true,

If the driver cannot be removed, .remove() is just dead code. Drop it
and note in a comment that this is needed because a syscon cannot be
removed.

Best regards
Uwe

--zxlx2zmpzeyxgeid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpYoe4ACgkQj4D7WH0S
/k50FQf/QwRdC9Xs5xWKlewjS+C+Q1ErIf4QMfE3jUVIH3RvwgpNeuZEX2XdGVzq
TCPID7ykFKhk9QEw0fSa5wZozhBU57L9RVTtiBcq61WNwGykd7230xF4G7nr0PDn
1MU+bRA2qMAYcZd8aplWPtnI8aqb6LrlFVVuSd9vfxjqq5YIi5wA6NDcpbnGYNYg
oeqe2gsh8/qn5571U7qtq0VMdaEhUfhxn1ihGhUiiy/NC9m5TQMPtgNjqXM0lV+3
fY9B13NzhzdtCfR81x/zCr67w6s6f+EXJ8Iodzx5Un2XzXdp84MCqhkir53ZsEiS
Mrp8wr7vpEaeHyHIMIV3PUAWYuwvBg==
=Bc65
-----END PGP SIGNATURE-----

--zxlx2zmpzeyxgeid--
