Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CA734A78F;
	Mon, 14 Sep 2026 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375468; cv=none; b=Y4rq5zjDq+Al5D6YzKxFd1wXNCt8A0CCsoUXfQgXt77N6HfZ0+0M6OIp/qhsN1mopXo0jr2IMFvoLYB7J4LOsHR1fAdXDfDdacpdUBPLNwPdiNicGpdDWnqQXF8dP3nGQ1vUBjKcKJrDu9GkEI6GeCGsWukSbXoWmyRTL8+JPrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375468; c=relaxed/simple;
	bh=FApjsybsfDSVMmw+gxb77JCNCs6u6UHTMRRkamCj8TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jl4iOi2SlGV5Y/ZggkFrQnAXqcrJdAev90sPnzsgxx1YePzTpsKVGqZLgTd8WzX/Y2lHdf9BRGfar264dyPgJeS2IMKpWotiMDWvN78FTrkuUB5mwOoUQY8cRQOoCJ+zoM/X+ikO3jEQf00g9+Ay7cHOMEos/2zYpLJ+vJ86QOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rwj4HuiQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rwj4HuiQ"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E1D461F000FF;
	Mon, 14 Sep 2026 08:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789375465;
	bh=7a2/ibp36NrABheYol3LAYhLxpjLT2pX3v2Uyuz4AvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rwj4HuiQtNd14esUdf/Qvv6aPhmoQbFJ5UaoSQmWStFL9SLmR5fdBryWldc9drqLk
	 QWiGN58TXw15pyRwxaEGxoF0rNFbGJFPP+mKkEF2ae6xNGG63XxBSNE1oaFHToO/NB
	 EMPwopGEl4KU/hS9vipQRcDFedNZt2V393FN3qitUdunL1/nStuR6a3U/+wuADZiDx
	 v76HU2pRpti6w+2kCHhenVVhmkLgcCqjQ7uUOVKwy2bAJrhWetPeva8LOoqW5x3JK/
	 1w8Kgq2Q2CsIamelzJNL4BcA5QC1s6uiGbHhhS6vSyNAVy88/0/ouOcgcUQs3mQR9o
	 ITFRaQkcWAYRg==
Date: Mon, 14 Sep 2026 10:44:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cwweng@nuvoton.com
Subject: Re: [PATCH v5 2/2] pwm: Add Nuvoton MA35D1 PWM controller support
Message-ID: <aqexDgkF7Nqp-fML@monoceros>
References: <20260721062308.536947-1-cwweng.linux@gmail.com>
 <20260721062308.536947-3-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gj7lpiutmh7njnbh"
Content-Disposition: inline
In-Reply-To: <20260721062308.536947-3-cwweng.linux@gmail.com>


--gj7lpiutmh7njnbh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v5 2/2] pwm: Add Nuvoton MA35D1 PWM controller support
MIME-Version: 1.0

Hello,

On Tue, Jul 21, 2026 at 02:23:08PM +0800, Chi-Wen Weng wrote:
> +static int nuvoton_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			     const struct pwm_state *state)
> +{
> +	struct nuvoton_pwm *nvtpwm = nuvoton_pwm_from_chip(chip);
> +	unsigned int ch = pwm->hwpwm;
> +	u64 duty_cycles, period_cycles;
> +	u64 divisor;
> +	u32 cmpdat, period, prescale;
> +	int ret;
> +
> +	if (!state->enabled) {
> +		nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_POEN,
> +				MA35D1_PWM_POEN_EN(ch), 0);

Does this mean the output pin goes High-Z on disable?

> +		nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_CNTEN,
> +				MA35D1_PWM_CNTEN_EN(ch), 0);
> +
> +		return 0;
> +	}
> +
> +	prescale = nuvoton_pwm_get_prescale(nvtpwm, ch);
> +	divisor = (u64)NSEC_PER_SEC * (prescale + 1);
> +
> +	period_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
> +					    state->period, divisor);
> +	if (!period_cycles)
> +		return -EINVAL;
> +
> +	if (period_cycles > MA35D1_PWM_MAX_CYCLES)
> +		period_cycles = MA35D1_PWM_MAX_CYCLES;
> +
> +	duty_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
> +					  state->duty_cycle, divisor);
> +	if (duty_cycles > period_cycles)
> +		duty_cycles = period_cycles;
> +
> +	ret = nuvoton_pwm_config_channel(nvtpwm, ch);
> +	if (ret)
> +		return ret;
> +
> +	if (state->polarity == PWM_POLARITY_NORMAL)
> +		nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_POLCTL,
> +				MA35D1_PWM_POLCTL_INV(ch), 0);
> +	else
> +		nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_POLCTL,
> +				MA35D1_PWM_POLCTL_INV(ch),
> +				MA35D1_PWM_POLCTL_INV(ch));
> +
> +	/*
> +	 * In up-counting mode the counter counts from 0 to PERIOD inclusive.
> +	 * With zero point high and compare-up point low actions:
> +	 * - CMPDAT = 0 produces 0% duty.
> +	 * - CMPDAT > PERIOD produces 100% duty.
> +	 *
> +	 * period_cycles is limited to 0xffff, so PERIOD is at most 0xfffe
> +	 * and a 100% duty cycle can be represented by CMPDAT = 0xffff.
> +	 */
> +	period = period_cycles - 1;
> +	cmpdat = duty_cycles;
> +
> +	nuvoton_pwm_writel(nvtpwm, MA35D1_REG_PWM_PERIOD(ch), period);
> +	nuvoton_pwm_writel(nvtpwm, MA35D1_REG_PWM_CMPDAT(ch), cmpdat);

This is racy, right? (i.e. if a period end happens between these two
writes, we see (probably) one period with the new period length and the
old duty_cycle.

The result of the two questions should be a comment describing the
behaviour, otherwise the code looks fine on a quick glance.

Best regards
Uwe

--gj7lpiutmh7njnbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqns+QACgkQj4D7WH0S
/k5FSwf+Nk29Si7VT23M1ciM84MTOv3o0aAx6Syxa/FAYB/wGsbfOQfdrahzYO6y
/0gU4Zjql0+4nu6sNrz9e9AJWqSljze9z/j1zdZQ1qAqlKH0Vfph85hrqW2CnJrA
CwZiYCffuIHrITmJXG7ACtd2jTcdY8/YeUJQ3MuQlT4O67As/9VF+6RW+DUW4iFA
L9vWx4Y7hhWGz4+TozTipkFBAX3ResmC/fPpPr15T1NxLYiFZrZS0Mh8bHbj//7Y
5GmgHeuNqdiWWod/DN9iCDh9X1r8pu4ZewvCF+kDPYsQtZEgNZgi9I3QgadzaD1L
rihEHMMi/YGrk/xiXD4TragJYmBS6A==
=B1Dh
-----END PGP SIGNATURE-----

--gj7lpiutmh7njnbh--
