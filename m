Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707054A498E;
	Mon, 21 Sep 2026 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002127; cv=none; b=MHGZ0ZBzwVylKpY0bgZ1qQLi48A6zcvs4LlMFBEYMAjTCQfJ7gh2vR4dckkB1/Fnh1/dXbVZc33lRbE+evscOW+Ri1TKWXruPYNxlVqcKZYTq6xVM5MA6yHra1HDJ7oN1/CL6UBhc9YObQea4FhjNxt/b6GrIAus8U+/BWOG7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002127; c=relaxed/simple;
	bh=NKTifSDflitLQjdfAzo5qNWT+zQGTs7TAS2iKtcdBPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEPUiVoHneYjTWh//wy+0e6Fa67Re3dYy8YS76EZ4AZLgmOoCdpcATDRijQqTeglcJMr9WLdx+c5vqCztzhs4+Gj4NaAnIZm4HUSNUnCs1PtdLbh5pWszUgwOuXQQXSsi1L4MvyC/j92pZF2JsJcn4YemnFCUPxl5Z89WyEwu9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QENe3acR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QENe3acR"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5912C1F000FF;
	Mon, 21 Sep 2026 14:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790002124;
	bh=95BoNoyBnS7EiZNoov/GT1S0dobxbX/rx/A/TW4Y+lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QENe3acRXOT+cK9tRA47gQ2P4AbRZaFyBPQIszaBcTHT2aySooj4SuAzq4sp2JXQj
	 iJnL/x1Vo47KM02dKgb/ba0g0UP+K9GWryG6n9kPqHmPY44xZ8SxW5YwTQ0V6ieeeJ
	 ScwfJ7aGfWPsGC09fmAvqr1zAVjVMH4nGZeoM+9bfqWNqnEJZrli2YJnLn0PEcUs/O
	 cdWR5LE+wI7VwwnaAF5xHPrwz3XJ8I0S17k851+AigMqIMXCIlrfX+Ni3Z4qNJ4NY4
	 rRiG2FvHQTwwr4Agw+ZKc9wfdMt/y9m+HpCMjrfKvTcX2nHibPT/h6CGLckhesaqlZ
	 vQTb0rFEq5dTQ==
Date: Mon, 21 Sep 2026 16:48:42 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>, 
	Prasad Bolisetty <pbolisetty@axiado.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Harshit Shah <hshah@axiado.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v5 2/2] pwm: add Axiado AX3000 PWM driver
Message-ID: <arFAy5wMZ2Rl7ubj@monoceros>
References: <20260921-axiado-ax3000-pwm-v5-0-202aad28e129@axiado.com>
 <20260921-axiado-ax3000-pwm-v5-2-202aad28e129@axiado.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tnydnd7lsyvlx4t2"
Content-Disposition: inline
In-Reply-To: <20260921-axiado-ax3000-pwm-v5-2-202aad28e129@axiado.com>


--tnydnd7lsyvlx4t2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v5 2/2] pwm: add Axiado AX3000 PWM driver
MIME-Version: 1.0

On Mon, Sep 21, 2026 at 12:21:31AM -0700, Petar Stepanovic wrote:
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 0dc0d2b69025..4466a29e780a 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_PWM_ARGON_FAN_HAT)	+= pwm-argon-fan-hat.o
>  obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
>  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
>  obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
> +obj-$(CONFIG_PWM_AXIADO)	+= pwm-axiado.o
>  obj-$(CONFIG_PWM_AXI_PWMGEN)	+= pwm-axi-pwmgen.o
>  obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
>  obj-$(CONFIG_PWM_BCM_IPROC)	+= pwm-bcm-iproc.o
> diff --git a/drivers/pwm/pwm-axiado.c b/drivers/pwm/pwm-axiado.c
> new file mode 100644
> index 000000000000..781053e255f0
> --- /dev/null
> +++ b/drivers/pwm/pwm-axiado.c
> @@ -0,0 +1,277 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * SPDX-FileCopyrightText: 2021-2026 Axiado Corporation.
> + */
> +

Is there a public reference manual for that hardware? If so, adding a
link here would be awesome.

> +/*
> + * Limitations:
> + * - Only normal polarity is supported.
> + * - The hardware has no shadow registers, so configuration changes take
> + *   effect immediately without waiting for the current period to complete.
> + * - The output is driven high while the hardware is disabled.
> + * - Supported period range: 2 through 0xfffffffe PWM input clock cycles;
> + *   0xffffffff is reserved by the hardware for a constant low output.
> + *   Longer periods are clamped to the maximum.
> + * - A 0% duty cycle is emitted using the constant low encoding because the
> + *   hardware interprets a zero high time as a constant high output. The
> + *   requested period is lost in that case and is reported as a single clock
> + *   cycle.
> + * - A 100% duty cycle is supported and emits a constant high output.
> + */
> [...]
> +static int
> +axiado_pwm_round_waveform_tohw(struct pwm_chip *chip,
> +			       struct pwm_device *pwm,
> +			       const struct pwm_waveform *wf,
> +			       void *_wfhw)
> +{
> +	struct axiado_pwm_chip *axpwm = pwmchip_get_drvdata(chip);
> +	struct axiado_pwm_waveform *wfhw = _wfhw;
> +	u64 period;
> +	u64 duty;
> +	int ret = 0;
> +
> +	/* Encode a disabled request as a zeroed hardware waveform. */
> +	if (!wf->period_length_ns) {
> +		*wfhw = (struct axiado_pwm_waveform) { };
> +
> +		return 0;
> +	}
> +
> +	period = mul_u64_u64_div_u64(wf->period_length_ns, axpwm->rate,
> +				     NSEC_PER_SEC);
> +	duty = mul_u64_u64_div_u64(wf->duty_length_ns, axpwm->rate,
> +				   NSEC_PER_SEC);
> +
> +	if (!duty) {
> +		/*
> +		 * A zero high time makes the hardware emit a constant high
> +		 * output, so use the constant low period encoding for a 0%
> +		 * duty cycle. The high time must stay non-zero because it
> +		 * takes precedence over that encoding. The requested period
> +		 * is lost, .round_waveform_fromhw() reports a single clock
> +		 * cycle instead.
> +		 */
> +		*wfhw = (struct axiado_pwm_waveform) {
> +			.period = AXIADO_PWM_PERIOD_CONST_LOW,
> +			.duty = AXIADO_PWM_DUTY_MIN,
> +			.enabled = true,
> +		};
> +
> +		/* That single cycle is longer than a sub-cycle request. */
> +		return period ? 0 : 1;
> +	}
> +
> +	if (period < AXIADO_PWM_PERIOD_MIN) {
> +		period = AXIADO_PWM_PERIOD_MIN;
> +		ret = 1;
> +	} else if (period > AXIADO_PWM_PERIOD_MAX) {
> +		period = AXIADO_PWM_PERIOD_MAX;
> +	}
> +
> +	/*
> +	 * Period clamping can leave the converted duty greater than the
> +	 * final hardware period. In that case, clamp it to 100% duty.
> +	 */
> +	if (duty > period)
> +		duty = period;

So with period in [AXIADO_PWM_PERIOD_MIN, AXIADO_PWM_PERIOD_MAX], duty =
period yields a constant high output? If so, why is there a special
encoding for const high?

> +	*wfhw = (struct axiado_pwm_waveform) {
> +		.period = period,
> +		.duty = duty,
> +		.enabled = true,
> +	};
> +
> +	return ret;
> +}
> +
> +static int
> +axiado_pwm_round_waveform_fromhw(struct pwm_chip *chip,
> +				 struct pwm_device *pwm,
> +				 const void *_wfhw,
> +				 struct pwm_waveform *wf)
> +{
> +	struct axiado_pwm_chip *axpwm = pwmchip_get_drvdata(chip);
> +	const struct axiado_pwm_waveform *wfhw = _wfhw;
> +	u32 period = wfhw->period;
> +	u32 duty = wfhw->duty;
> +
> +	if (!wfhw->enabled) {
> +		*wf = (struct pwm_waveform) {
> +			.period_length_ns = 0,
> +		};
> +
> +		return 0;
> +	}
> +
> +	/*
> +	 * The constant low encoding doesn't hold a period. Report the
> +	 * shortest one, the output is low for all of it either way.
> +	 */
> +	if (period == AXIADO_PWM_PERIOD_CONST_LOW) {
> +		period = 1;
> +		duty = 0;
> +	} else if (duty > period) {
> +		duty = period;
> +	}

You don't handle wfhw->duty == 0 here. I think this is what Sashiko
pointed out. While .round_waveform_tohw() doens't produce this setting,
it would still be good to handle that in case the driver is loaded with
this setting applied in hardware.

> +	*wf = (struct pwm_waveform) {
> +		.period_length_ns =
> +			mul_u64_u64_div_u64_roundup(period, NSEC_PER_SEC,
> +						    axpwm->rate),
> +		.duty_length_ns =
> +			mul_u64_u64_div_u64_roundup(duty, NSEC_PER_SEC,
> +						    axpwm->rate),
> +		.duty_offset_ns = 0,
> +	};
> +
> +	return 0;
> +}

Best regards
Uwe

--tnydnd7lsyvlx4t2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqxQ8cACgkQj4D7WH0S
/k7Uigf/XkGXqZJB9VBHl6LGR9+YtK2QKCI4RtGM5Ejt+6pf4XPIlnKLVZflNdDe
kLLMOwwQ1cQUv53G6g/oDfrnJGEYsjklgxOXYxKNJLnoElDreJVtnq0G/kf8f0qG
sGhWC43SeibhUgxvZlN7M4AvqqFJkp/y+Ra/P8msoGm6mVsm+c0lqQnomHb0cpps
MP7NPeAVc9JJznYm3LtFOJt0lNXWQf3WQDipRIgkI5Af+KyszHg+YCvME9I4yoXF
mKARwyvvlryrYraVwyQPbeoWMePZqWD8gYFUC4EVVQ3Lv3V2+4uNoxpyUkbM6HWI
s/JhDbyOClE/G4bnhHGOt/wiy6HgGg==
=4Tg2
-----END PGP SIGNATURE-----

--tnydnd7lsyvlx4t2--
