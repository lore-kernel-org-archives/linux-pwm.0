Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794137811;
	b=nloFh+Pc/cx09/MAlUvn+ihhzkF/JFE7XRwsMkf7atsaZO21RVkRK69KodLkiZvfdf3h
	 Y1prL8tmO+sxTO2V6hHsatFCppkHc9eq5M92g6sEb9SMSdHyNG5DV2veIS5HrUWp6EmYx
	 7pvb8T1DvF8pihJUGfNtSngbI8SOJrF1cxO7unAVK9KchpQavX9WZiRp8Cby0wSWZBznY
	 QSCMxrdkZjQiAEjL39yWhavrgUmsorqmK/mHJ/vAXUYDG+bhnkycT6wJUp9OmTzEgnwU7
	 mZCzid8H/McwYjscLEnG4wkJKsmVVsQ1o+NAZtipMuv2Pb7F6ImTL5OKbYBFjm9sRUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137811;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lmjN69Vv8biZ5SGMcgF5cRLTFcd7u9RIX4XoIvN+/6Q=;
	b=unNxDGO4+TnnIHx2NnYI1jVzS4YqMEO8kiCJZxfBmTVbCRAc4TUNmveofIkILcaDkTjx
	 1xGf2y8CBkTATo5+9kBC7JTrFighPB/6TZxC/T86w2+ecn1C1Qod93erehLGXQGlQemqe
	 D99W0tuzCiJzVE8W1TJsctqZgq2bSRJdxOF4FAxcOc/6qzpiUxG6XG6D1kLYrCyhG3dMS
	 1EIrKwlZ2+7IG8lEzjYeitYmhScxiokYBC6ZFOA2aKQzwi+7JuFMpHsOyXb07IEUbBy8f
	 J8b8pq9BLsoQHLFJn4oOdsTR+JEvTxC3oHprSD7zACpomUvK+eSnC85Icw7RGA+Akow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GuDWRHRj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 39A14606A31C;
	Sun,  8 Nov 2026 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GuDWRHRj
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 259E91F0089F;
	Sun,  8 Nov 2026 11:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794137811;
	bh=lmjN69Vv8biZ5SGMcgF5cRLTFcd7u9RIX4XoIvN+/6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GuDWRHRjYWZADZIG9/LWzJDKUxs/mek7Nsu97BwOm03sEFivJo5U3UQ0xIH7GpRG7
	 rGbbx4T87DX9YEn8l53BX4Ugkj7lRUxyvSqy7aM/nmXFOSAxmYe5ydVmSaJyi3MmQc
	 JJTr7N4/tgcWfte8qJuaRBXrDAn9MUg5O3bIplSwIDMlbiMpBD2gDjdg9DJfzEUd8n
	 vWeqDbUkO3TV6iu8cKevoxcNmdHsWzGaPf6iu17AwRGPYe+slM6RdYEeDYGbmeSagF
	 P/+DPJJN4bW73+wdv7lEMI3LBskqyxaKDnYMJg2c01HtDlu2N6YDUJ243+o43Agpwm
	 gHMBL+t5P6o+Q==
Date: Sun, 8 Nov 2026 12:36:48 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: ben717@andestech.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] pwm: add Andes PWM driver support
Message-ID: <avBbSsojNV9UIZGT@monoceros>
References: <20260812-andes-pwm-v7-0-a806da8185d1@andestech.com>
 <20260812-andes-pwm-v7-2-a806da8185d1@andestech.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fsrqznbb3afk5cgn"
Content-Disposition: inline
In-Reply-To: <20260812-andes-pwm-v7-2-a806da8185d1@andestech.com>


--fsrqznbb3afk5cgn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v7 2/3] pwm: add Andes PWM driver support
MIME-Version: 1.0

Hello,

On Wed, Aug 12, 2026 at 11:24:05AM +0800, Ben Zong-You Xie via B4 Relay wrote:
> +static int andes_pwm_config(struct pwm_chip *chip, unsigned int channel,
> +			    const struct pwm_state *state)
> +{
> +	struct andes_pwm *ap = andes_pwm_from_chip(chip);
> +	unsigned int clk_rate = ap->extclk_rate;
> +	unsigned int ctrl = ANDES_PWM_CH_CTRL_MODE_PWM;
> +	bool use_pclk = false;
> +	u64 high_cycles;
> +	u64 low_cycles;
> +	u64 period_cycles;
> +	u64 duty_cycles;
> +	u32 reload;
> +
> +	/*
> +	 * Reload register for PWM mode:
> +	 *
> +	 *		31 : 16    15 : 0
> +	 *		PWM16_Hi | PWM16_Lo
> +	 *
> +	 * The high duration is (PWM16_Hi + 1) cycles and the low duration is
> +	 * (PWM16_Lo + 1) cycles, so each phase spans ANDES_PWM_CYCLE_MIN to
> +	 * ANDES_PWM_CYCLE_MAX cycles. The hardware period (their sum) can reach
> +	 * 2 * ANDES_PWM_CYCLE_MAX cycles, but the PWM core requires the period
> +	 * to be chosen from the requested period alone, independent of the duty
> +	 * cycle. That holds only while both phases stay within
> +	 * ANDES_PWM_CYCLE_MAX for every duty split, so the usable period is
> +	 * capped at ANDES_PWM_CYCLE_MAX + ANDES_PWM_CYCLE_MIN cycles.
> +	 *
> +	 * The controller has two clock sources, the APB clock and an external
> +	 * clock. Since the external clock frequency must be slower than the APB
> +	 * clock, it is tried first for its wider period range; the APB clock is
> +	 * used only when the external clock resolves fewer than two cycles (or
> +	 * is absent) and is itself usable.
> +	 */
> +	period_cycles = mul_u64_u64_div_u64(clk_rate, state->period,
> +					    NSEC_PER_SEC);
> +	if (period_cycles < 2 * ANDES_PWM_CYCLE_MIN && ap->pclk_rate) {
> +		use_pclk = true;
> +		clk_rate = ap->pclk_rate;
> +		period_cycles = mul_u64_u64_div_u64(clk_rate, state->period,
> +						    NSEC_PER_SEC);

This only helps if ap->pclk_rate > clk_rate. So maybe check that instead
of ap->pclk_rate != 0?

There is still room for improvement: Consider

	ap->extclk_rate = 10000
	ap->pclk_rate = 20000

	state->period = 3100000
	state->duty_cycle = 1550000

Then your algo picks extclk as period_cycles = 31 with it and then
result in duty_cyles = 1500000 while with pclk you could achieve an
exact match. But I think the way the parameters are picked is consistent
and so it's fine to keep it as is.

> +	}
> +
> +	/*
> +	 * A single cycle is still usable: the duty cycle can then only be zero
> +	 * or one cycle, and both are emitted by parking the channel below.
> +	 */
> +	if (!period_cycles)
> +		return -EINVAL;
> +
> +	/*
> +	 * Round the period down to the largest value representable for every
> +	 * duty cycle, so the chosen period depends on the requested period
> +	 * alone. With both phases capped at ANDES_PWM_CYCLE_MAX, that bound is
> +	 * ANDES_PWM_CYCLE_MAX + ANDES_PWM_CYCLE_MIN cycles.
> +	 */
> +	period_cycles = min_t(u64, period_cycles,
> +			      ANDES_PWM_CYCLE_MAX + ANDES_PWM_CYCLE_MIN);
> +
> +	/* The duty cycle cannot exceed the (possibly clamped) period. */
> +	duty_cycles = mul_u64_u64_div_u64(clk_rate, state->duty_cycle,
> +					  NSEC_PER_SEC);
> +	duty_cycles = min_t(u64, duty_cycles, period_cycles);
> +
> +	if (state->polarity == PWM_POLARITY_INVERSED) {
> +		low_cycles = duty_cycles;
> +		high_cycles = period_cycles - low_cycles;
> +	} else {
> +		high_cycles = duty_cycles;
> +		low_cycles = period_cycles - high_cycles;
> +	}
> +
> +	/*
> +	 * A zero-length phase means a 0% or 100% relative duty cycle, which the
> +	 * hardware cannot run. Emit the matching constant level by parking the
> +	 * channel: high_cycles == 0 stays low, low_cycles == 0 stays high.
> +	 */
> +	if (!high_cycles)
> +		return andes_pwm_park(chip, channel, false);
> +	if (!low_cycles)
> +		return andes_pwm_park(chip, channel, true);
> +
> +	/*
> +	 * A change of clock source takes effect immediately, modifying the
> +	 * current output. Otherwise there is no glitch as the currently running
> +	 * period is completed before the new settings take effect.
> +	 */
> +	ctrl |= use_pclk ? ANDES_PWM_CH_CTRL_CLK : 0;
> +	ctrl |= (state->polarity == PWM_POLARITY_INVERSED) ?
> +		ANDES_PWM_CH_CTRL_PARK : 0;

So with the PARK bit set the ANDES_PWM_CH_RELOAD_HIGH bitmap actually
configures the time (in ticks) the signal is low? If that isn't the
case, don't claim to support inversed polarity.

> +	regmap_update_bits(ap->regmap, ANDES_PWM_CH_CTRL(channel),
> +			   ANDES_PWM_CH_CTRL_MASK, ctrl);
> +	reload = FIELD_PREP(ANDES_PWM_CH_RELOAD_HIGH, high_cycles - 1) |
> +		 FIELD_PREP(ANDES_PWM_CH_RELOAD_LOW, low_cycles - 1);
> +	regmap_write(ap->regmap, ANDES_PWM_CH_RELOAD(channel), reload);
> +
> +	return andes_pwm_enable(chip, channel, true);
> +}

Best regards
Uwe

--fsrqznbb3afk5cgn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrwXs0ACgkQj4D7WH0S
/k58mAgAnabuczjQcPJoWXObCa6DD2mxMkp7HgfCo7KGQffXrm4DSK7pHDB5tT4q
rYqbxDgr2ckjBjSzZ65tDsZt0SjxQvy87j1lYoDxt/ojKdhIAMnK/GXep9w1wcL4
xAHD62JiE5Kl9FUud4pHD9lN1lutYwhg8bKVRQQqz3JD0aQmIAhUOXjhGlzk2oGD
nKj0ya0ZFDI1GNkTf9gTPgyBEnJU2dYRkE++ApnsDztwKptl8F3wKheo+WW1/Nmf
i1Ao2/dfLYqdmWqXgNlwGoR5ROODfiYLn69wdtJZOXndUOvwyxN1xb4AW7057XGu
oId5Uya57I6D+uuGCHRNQp7yeaWeYg==
=D5fF
-----END PGP SIGNATURE-----

--fsrqznbb3afk5cgn--
