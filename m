Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CC9492E53;
	Wed,  9 Sep 2026 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949564; cv=none; b=Z1K6NPF2XmWQPC6Gz/ovVJYgE6CoGCjDyX7RTD4vRY6VtpfjjIOMfW+S3YECyyLGcRRN+I8iuKwUCwFEjFoAhu/gY0sjngm0i8Zgxc0an8ly2/Qw67EgJ4jXFYY7pSEUA13oxS0GKa7NEhBTeSK8GpPXVpPH+i4zxEqnePqPR/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949564; c=relaxed/simple;
	bh=BPAIlXRJ5+ayuM6NcP2vLxMvbFcCQ9LIqTNwO9mkpiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWvG3TeY5z2/rfzX0sc96w/rx8JyZlb533VuYXpO4QzerSDw5U0Tg1fUoh9gRvI1AWj0OP9vZ6N8Zmr12+RsGWH6FrmjCJLupvz+otoLHSgiwDKYNtC3KA0PhN0WZhYRu+sU20VjrJeNAYFGohARpomhvyhGr/D+8d06WoKAriM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVwe3CBq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVwe3CBq"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A700E1F00A3A;
	Wed,  9 Sep 2026 10:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788949562;
	bh=HI6oCWAggKVgjHHUXtpNDIwKg2A2M537aYICfyDxn1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iVwe3CBq8/usNlhm35flLzb5fcpMR0UuH9N8wIWgci28WA6myoHXIM/lscjeAAoMD
	 TChl7PyzhxkxwnkH2DHdVJqn0PLM52FDyhhIJzT/XhvY32Iyz3s3k5NBICZupZfG2o
	 1k0ryL2mUkvHWqDeXg/JLu9RDKYGFSidYg+iy6fGFC8J6bbqnnsXp5O3xJk55b3FsC
	 t0vu0Suk9CXQiPf3qPX/H875UajC9g868mjqqS8IVnI3XCg4NTsEfoGMfcTBbWUl+N
	 JU5mrxU5MrF9ExQN/Mb9Tc71prr0wEOIfdSTOsLcrDeALaC6tx1lj5Lwnc3alwNQLM
	 +LFDUWjK5so3A==
Date: Wed, 9 Sep 2026 12:25:59 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>, 
	Prasad Bolisetty <pbolisetty@axiado.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Harshit Shah <hshah@axiado.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v4 2/2] pwm: add Axiado AX3000 PWM driver
Message-ID: <aqElQj-H80PEXY0U@monoceros>
References: <20260908-axiado-ax3000-pwm-v4-0-19a03671cd5b@axiado.com>
 <20260908-axiado-ax3000-pwm-v4-2-19a03671cd5b@axiado.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d2hth543vljjdczy"
Content-Disposition: inline
In-Reply-To: <20260908-axiado-ax3000-pwm-v4-2-19a03671cd5b@axiado.com>


--d2hth543vljjdczy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/2] pwm: add Axiado AX3000 PWM driver
MIME-Version: 1.0

Hello,

On Tue, Sep 08, 2026 at 01:28:35AM -0700, Petar Stepanovic wrote:
> The Axiado AX3000 and AX3005 SoCs include a single-channel PWM
> controller.
>=20
> Add a driver supporting period, duty-cycle, and enable-state
> configuration through the Linux PWM framework.
>=20
> Disabling the hardware controller drives its output high. Implement a
> logically disabled PWM using the controller's constant-low encoding
> instead. The same encoding is used for an enabled PWM with a 0% duty
> cycle, so cache the logical state and requested period for readback.

The purpose of disabling the hardware is to save power. If the result is
that the output goes to the high state that's mildly strange, but not
unseen. Still disable the hardware in that case. (And any consumer
driver that relies on a low output on disable is wrong and needs
fixing.)

> diff --git a/drivers/pwm/pwm-axiado.c b/drivers/pwm/pwm-axiado.c
> new file mode 100644
> index 000000000000..e1d408809694
> --- /dev/null
> +++ b/drivers/pwm/pwm-axiado.c
> @@ -0,0 +1,332 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021-2026 Axiado Corporation.

It's not universally done in the kernel, but I'd be happy to see this
formalized as:

	SPDX-FileCopyrightText: 2021-2026 Axiado Corporation.

> + */
> +
> +/*

Please put "Limitations:" here such that

	sed -rn '/Limitations:/,/\*\/?$/p' drivers/pwm/*.c


gives the details.

> + * - Supports normal polarity. Configuration changes take effect immedia=
tely
> + *   without waiting for the current period to complete.
> + * - The hardware output remains high when the controller is disabled.
> + *   Therefore, a logically disabled PWM is implemented using the hardwa=
re
> + *   constant-low representation.
> + * - Supported period range: 2 through 0xfffffffe PWM input clock cycles;
> + *   0xffffffff is reserved by the hardware for a constant-low output.
> + *   Longer periods are clamped to the maximum.
> + * - 0% duty cycle: Programmed as a constant-low period because the
> + *   hardware interprets a zero high time as a constant-high output.
> + *   Consequently, the requested period cannot be read back while the
> + *   duty cycle is 0%.
> + * - 100% duty cycle: Fully supported and produces a constant-high outpu=
t.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +/* Register offsets */
> +#define AXIADO_PWM_CTRL_REG	0x0000
> +#define AXIADO_PWM_PERIOD_REG	0x0004
> +#define AXIADO_PWM_HIGH_REG	0x0008
> +
> +/* Period and duty cycle limits */
> +#define AXIADO_PWM_PERIOD_MIN	2
> +#define AXIADO_PWM_PERIOD_MAX	0xfffffffe
> +#define AXIADO_PWM_PERIOD_CONST_LOW	0xffffffff
> +#define AXIADO_PWM_DUTY_MIN	1
> +
> +/* Control register bits */
> +#define AXIADO_PWM_CTRL_ENABLE	BIT(0)
> +
> +struct axiado_pwm_chip {
> +	void __iomem *base;
> +	unsigned long rate;
> +	u32 cached_period;
> +	bool logically_disabled;
> +};
> +
> +struct axiado_pwm_waveform {
> +	u32 period;
> +	u32 duty;
> +	bool enabled;
> +};
> +
> +static int
> +axiado_pwm_round_waveform_tohw(struct pwm_chip *chip,
> +			       struct pwm_device *pwm,
> +			       const struct pwm_waveform *wf,
> +			       void *_wfhw)
> +{
> +	struct axiado_pwm_chip *axpwm =3D pwmchip_get_drvdata(chip);
> +	struct axiado_pwm_waveform *wfhw =3D _wfhw;
> +	u64 period;
> +	u64 duty;
> +	int ret =3D 0;
> +
> +	/* Encode a disabled request as a zeroed hardware waveform. */
> +	if (!wf->period_length_ns) {
> +		*wfhw =3D (struct axiado_pwm_waveform) {};

{ } please (i.e. a space in the empty initializer).

> +		return 0;
> +	}
> +
> +	/* Only an edge-aligned waveform starting at offset zero is supported. =
*/
> +	if (wf->duty_offset_ns)
> +		return -EINVAL;

That is wrong. You're supposed to implement the biggest duty_offset_ns
not bigger than the requested value. That's 0 and should happen
successfully (and silently).

> +	if (wf->duty_length_ns > wf->period_length_ns)
> +		return -EINVAL;

No need to check that. If you see this happen, that's a bug in the pwm
core.

> +	period =3D mul_u64_u64_div_u64(wf->period_length_ns, axpwm->rate,
> +				     NSEC_PER_SEC);
> +
> +	if (period < AXIADO_PWM_PERIOD_MIN) {
> +		period =3D AXIADO_PWM_PERIOD_MIN;
> +		ret =3D 1;
> +	} else if (period > AXIADO_PWM_PERIOD_MAX) {
> +		period =3D AXIADO_PWM_PERIOD_MAX;
> +	}
> +
> +	/*
> +	 * Keep the rounded period for a 0% duty cycle. .write_waveform()
> +	 * translates it to the hardware constant-low representation.
> +	 */
> +	if (!wf->duty_length_ns) {
> +		*wfhw =3D (struct axiado_pwm_waveform) {
> +			.period =3D period,
> +			.duty =3D 0,
> +			.enabled =3D true,
> +		};

This happens also without the special handling, right? So the if could
be dropped.

> +		return ret;
> +	}
> +
> +	duty =3D mul_u64_u64_div_u64(wf->duty_length_ns, axpwm->rate,
> +				   NSEC_PER_SEC);
> +
> +	/*
> +	 * Preserve an exact 100% duty request when the hardware period has
> +	 * been clamped.
> +	 */
> +	if (wf->duty_length_ns =3D=3D wf->period_length_ns)
> +		duty =3D period;

With the check below for duty > period this isn't needed.

> +	/*
> +	 * Period clamping can leave the converted duty greater than the
> +	 * final hardware period. In that case, clamp it to 100% duty.
> +	 */
> +	if (duty > period)
> +		duty =3D period;
> +
> +	*wfhw =3D (struct axiado_pwm_waveform) {
> +		.period =3D period,
> +		.duty =3D duty,
> +		.enabled =3D true,
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
> +	struct axiado_pwm_chip *axpwm =3D pwmchip_get_drvdata(chip);
> +	const struct axiado_pwm_waveform *wfhw =3D _wfhw;
> +
> +	if (!wfhw->enabled) {
> +		*wf =3D (struct pwm_waveform) {
> +			.period_length_ns =3D 0,
> +			.duty_length_ns =3D 0,
> +			.duty_offset_ns =3D 0,
> +		};

nitpick: setting .period_length_ns =3D 0 is sufficient here and that's
what other drivers do.

> +		return 0;
> +	}
> +
> +	*wf =3D (struct pwm_waveform) {
> +		.period_length_ns =3D
> +			mul_u64_u64_div_u64_roundup(wfhw->period, NSEC_PER_SEC,
> +						    axpwm->rate),
> +		.duty_length_ns =3D
> +			mul_u64_u64_div_u64_roundup(wfhw->duty, NSEC_PER_SEC,
> +						    axpwm->rate),
> +		.duty_offset_ns =3D 0,
> +	};
> +
> +	return 0;
> +}
> +
> +static int axiado_pwm_read_waveform(struct pwm_chip *chip,
> +				    struct pwm_device *pwm,
> +				    void *_wfhw)
> +{
> +	struct axiado_pwm_chip *axpwm =3D pwmchip_get_drvdata(chip);
> +	struct axiado_pwm_waveform *wfhw =3D _wfhw;
> +	u32 period;
> +	u32 duty;
> +	u32 ctrl;
> +
> +	/*
> +	 * A logically disabled request is implemented as a constant-low
> +	 * hardware waveform because disabling the controller drives the
> +	 * output high.
> +	 */
> +	if (axpwm->logically_disabled) {
> +		*wfhw =3D (struct axiado_pwm_waveform) {};
> +		return 0;

that looks wrong. At least the first readout before .write_waveform()
was called might be bogus then.

> +	}
> +
> +	ctrl =3D readl(axpwm->base + AXIADO_PWM_CTRL_REG);
> +	period =3D readl(axpwm->base + AXIADO_PWM_PERIOD_REG);
> +	duty =3D readl(axpwm->base + AXIADO_PWM_HIGH_REG);
> +
> +	/* The constant-low encoding doesn't hold the period, so restore it. */

This isn't needed. If the output is constant low, just report period =3D
1 and drop .cached_period.

> +	if (period =3D=3D AXIADO_PWM_PERIOD_CONST_LOW) {
> +		period =3D axpwm->cached_period;
> +		duty =3D 0;
> +	} else if (duty > period) {
> +		duty =3D period;
> +	}
> +
> +	*wfhw =3D (struct axiado_pwm_waveform) {
> +		.period =3D period,
> +		.duty =3D duty,
> +		.enabled =3D !!(ctrl & AXIADO_PWM_CTRL_ENABLE),
> +	};
> +
> +	return 0;
> +}
> +
> +static int axiado_pwm_write_waveform(struct pwm_chip *chip,
> +				     struct pwm_device *pwm,
> +				     const void *_wfhw)
> +{
> +	struct axiado_pwm_chip *axpwm =3D pwmchip_get_drvdata(chip);
> +	const struct axiado_pwm_waveform *wfhw =3D _wfhw;
> +	u32 period =3D wfhw->period;
> +	u32 duty =3D wfhw->duty;
> +
> +	if (!wfhw->enabled) {
> +		/*
> +		 * Disabling the controller drives its output high. Implement
> +		 * the logically disabled state using the constant-low hardware
> +		 * representation instead.
> +		 */
> +		writel(AXIADO_PWM_PERIOD_CONST_LOW,
> +		       axpwm->base + AXIADO_PWM_PERIOD_REG);
> +		writel(AXIADO_PWM_DUTY_MIN,
> +		       axpwm->base + AXIADO_PWM_HIGH_REG);
> +		writel(AXIADO_PWM_CTRL_ENABLE,
> +		       axpwm->base + AXIADO_PWM_CTRL_REG);
> +		axpwm->logically_disabled =3D true;
> +
> +		return 0;
> +	}
> +
> +	/*
> +	 * A zero high time produces a constant high output, so use the
> +	 * constant-low period encoding for a 0% duty cycle. Keep the high time
> +	 * non-zero because a zero value takes precedence over that encoding.
> +	 * Cache the requested period for .read_waveform().
> +	 */
> +	if (!duty) {
> +		axpwm->cached_period =3D period;
> +		period =3D AXIADO_PWM_PERIOD_CONST_LOW;
> +		duty =3D AXIADO_PWM_DUTY_MIN;
> +	}
> +
> +	/*
> +	 * The hardware has no shadow registers. These writes may alter the
> +	 * active waveform before the current period has completed.
> +	 */
> +	writel(period, axpwm->base + AXIADO_PWM_PERIOD_REG);
> +	writel(duty, axpwm->base + AXIADO_PWM_HIGH_REG);
> +	writel(AXIADO_PWM_CTRL_ENABLE, axpwm->base + AXIADO_PWM_CTRL_REG);
> +	axpwm->logically_disabled =3D false;

Ideally all the special case handling happens in the
=2Eround_waveform_tohw() callback such that .write_waveform() is as quick
as possible and just writes the content of axiado_pwm_waveform to the
registers.

> +
> +	return 0;
> +}

I was about to write something else, but was interrupted and don't
remember. :-\ So I might still find something when I look at your next
revision.

Best regards
Uwe

--d2hth543vljjdczy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqhNDQACgkQj4D7WH0S
/k5KzAgAr9O1wuud8O2wU6xGCBdGpB75kvETqBK50abgti5xxWRWRRNVzTSQUALQ
A8XcMT7WT35vg57EUiz0INaWeXutiPCc2YZoGviqLCk9F+RGW5kJiEys5BtfOlQ+
ExA1tMY5byCi/jFnn579OnKlgtTcFp7e6i0NXiw50dbTxacoHFW2Vit+WZ6SeNC2
pO+iJvTbBqJhb4JMgHPawAQxB5x4DsBBiWIZZYzjwifaS4y2mQLiZCcXcP6sMc55
fyLIjPOXdFH6pMQohOS0v/Khcvbm5ntzvyLXMIt71MfXP+iob0+xrZTde+qlt+P5
AliXnbSX4oDOxyC7bOGceHol4Qobxg==
=HTm2
-----END PGP SIGNATURE-----

--d2hth543vljjdczy--
