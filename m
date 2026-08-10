Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23224374A0E;
	Mon, 10 Aug 2026 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786349994; cv=none; b=tvQAbwyDLmCAmscXpnQGo2mO206RCi0HZVGLTIFWnvVciXTCiU5wh4M4C7pDIrJXf7FPD03GevW0mF4Ev9Nw/Vg85ATwydI0ozmFrhXoaub1vEzFZr+sUDg7nFlGj20pPP5NAP4vZY0UXDHI6ks8dpOWqxFxpUAZQPpEzWYkSaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786349994; c=relaxed/simple;
	bh=+0zHsbKKSdSWk+OooCXutBVvPt1RvW9G/3d5XIAG4zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKxIGdnCHrsK9693Ni/iN35NuzpbRE10TIgchOVQdteKHmaE0jCPhrZRR4VjWKbWPF6yPL+1nkae63GbS3vBR6GFKrVBsJr23rfilfChMw2vmo5OA+vqBtlDGUDBbpdjH1ZwV6CUnj69902k3N5OPOjC16Dg4vsj3tW5XlJ72iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQoJTVtB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQoJTVtB"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 73C3F1F000E9;
	Mon, 10 Aug 2026 08:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786349992;
	bh=X0l27sujgt8axlsET/KfPjr1BsVyIenEI2ZM8n/Es8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YQoJTVtBGPeB+DUGLxAKisz3Jt5uTnb0oDK0lfCTkXDwpPE3EJ8IMsepPCnq6tn4W
	 SMfk3zoro/LO0InVY5jM/bA4X7oDsDZGk33wU7vI1c8ndj45iiPM5vBwCfa9bmF0tH
	 PpRyTtL+6qPaeuP6ZDu4xKb2DWfk3A0HqpGIJ+UGLuowqF7M3g066KAjQcFgBLibNa
	 HUq+3Z8Pv1CnhB7WkD74m8blcgjE12+rI3cja1sZdLkzeA1/YxutG5qwrP9Q9T1Sfl
	 hCYFEcvMbRyuMm+c33KQ3cbYUYGtFpxlNIlqM7Q7dG2Ki1CxBFgTad3MpM5rZmY4xe
	 JrXNPzu5nspTg==
Date: Mon, 10 Aug 2026 10:19:49 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: ben717@andestech.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] pwm: add Andes PWM driver support
Message-ID: <anmALNaygumsRcpd@monoceros>
References: <20260625-andes-pwm-v6-0-3aef11711017@andestech.com>
 <20260625-andes-pwm-v6-2-3aef11711017@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uzbsbfiixgtu7yom"
Content-Disposition: inline
In-Reply-To: <20260625-andes-pwm-v6-2-3aef11711017@andestech.com>


--uzbsbfiixgtu7yom
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/3] pwm: add Andes PWM driver support
MIME-Version: 1.0

On Thu, Jun 25, 2026 at 06:36:00PM +0800, Ben Zong-You Xie via B4 Relay wro=
te:
> From: Ben Zong-You Xie <ben717@andestech.com>
>=20
> Add a driver for the PWM controller found in Andes AE350 platforms and
> QiLai SoCs.
>=20
> The Andes PWM controller features:
> - 4 independent channels.
> - Dual clock source support (APB clock and external clock) to provide
>   a flexible range of frequencies.
> - Support for normal and inversed polarity.
>=20
> The driver implements the .apply() and .get_state() callbacks. Since the
> clock source of each channel can be selected by programming the
> register, clock selection logic is implemented to prioritize the
> external clock to maximize the supported period range, falling back to
> the APB clock for higher frequency requirements.
>=20
> Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
> ---
>  drivers/pwm/Kconfig     |  10 ++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-andes.c | 343 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 354 insertions(+)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index e8886a9b64d9..52dee4b7f081 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -73,6 +73,16 @@ config PWM_AIROHA
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-airoha.
> =20
> +config PWM_ANDES
> +	tristate "Andes PWM support"
> +	depends on ARCH_ANDES || COMPILE_TEST

Here are missing dependencies. At least REGMAP.

> +	help
> +	  Generic PWM framework driver for Andes platform, such as QiLai SoC
> +	  and AE350 platform.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-andes.
> +
>  config PWM_APPLE
>  	tristate "Apple SoC PWM support"
>  	depends on ARCH_APPLE || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 5630a521a7cf..c92369ee251d 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_PWM)		+=3D core.o
>  obj-$(CONFIG_PWM_AB8500)	+=3D pwm-ab8500.o
>  obj-$(CONFIG_PWM_ADP5585)	+=3D pwm-adp5585.o
>  obj-$(CONFIG_PWM_AIROHA)	+=3D pwm-airoha.o
> +obj-$(CONFIG_PWM_ANDES)		+=3D pwm-andes.o
>  obj-$(CONFIG_PWM_APPLE)		+=3D pwm-apple.o
>  obj-$(CONFIG_PWM_ARGON_FAN_HAT)	+=3D pwm-argon-fan-hat.o
>  obj-$(CONFIG_PWM_ATMEL)		+=3D pwm-atmel.o
> diff --git a/drivers/pwm/pwm-andes.c b/drivers/pwm/pwm-andes.c
> new file mode 100644
> index 000000000000..580e673d2cff
> --- /dev/null
> +++ b/drivers/pwm/pwm-andes.c
> @@ -0,0 +1,343 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Andes PWM, used in Andes AE350 platform and QiLai SoC
> + *
> + * Copyright (C) 2026 Andes Technology Corporation.
> + *
> + * Limitations:
> + * - When disabling a channel, the current period is not completed and t=
he
> + *   output is driven to the PARK level (low when ANDES_PWM_CH_CTRL_PARK=
 is
> + *   clear, high when it is set).
> + * - The current period will be completed first if reconfiguring.
> + * - Further, if the reconfiguration changes the clock source, the outpu=
t will
> + *   not be the old one nor the new one. And the output will be the new =
one
> + *   after writing to the reload register.
> + * - The hardware cannot run a 0% or 100% relative duty cycle; the driver
> + *   emulates these by disabling the channel and parking the output at t=
he
> + *   constant level.
> + * - A period or duty cycle larger than the selected clock can represent=
 is
> + *   rounded down to the largest achievable value rather than rejected.

The last item isn't a (hardware) property, but the right thing to do for
PWM drivers. So you can drop that.

> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/math64.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/time.h>
> +#include <linux/types.h>

I wonder what <linux/time.h> is used for.

> [...]
> +/*
> + * Hold the output at a constant level by parking the disabled channel. A
> + * disabled channel drives its output to the PARK level (low when @high =
is
> + * false, high when @high is true), which is used to emulate a 0% or 100%
> + * relative duty cycle.
> + */
> +static int andes_pwm_park(struct pwm_chip *chip, unsigned int channel,
> +			  bool high)
> +{
> +	struct andes_pwm *ap =3D andes_pwm_from_chip(chip);
> +
> +	regmap_assign_bits(ap->regmap, ANDES_PWM_CH_CTRL(channel),
> +			   ANDES_PWM_CH_CTRL_PARK, high);

Some calls to regmap_assign_bits() are checked, others are not. Please
make this consistent.

> +	return andes_pwm_enable(chip, channel, false);
> +}
> +
> +static int andes_pwm_config(struct pwm_chip *chip, unsigned int channel,
> +			    const struct pwm_state *state)
> +{
> +	struct andes_pwm *ap =3D andes_pwm_from_chip(chip);
> +	unsigned int clk_rate =3D ap->extclk_rate;
> +	unsigned int ctrl =3D ANDES_PWM_CH_CTRL_MODE_PWM;
> +	bool use_pclk =3D false;
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
> +	 * used only when the external clock is too fast to represent the period
> +	 * (it resolves fewer than two cycles) or is absent.
> +	 */
> +	period_cycles =3D mul_u64_u64_div_u64(clk_rate, state->period,
> +					    NSEC_PER_SEC);
> +	if (period_cycles < 2 * ANDES_PWM_CYCLE_MIN) {

With period_cycles =3D 1 you can only have duty_cycle =3D 0 or 1 which is
representable by the hardware (configuring either constant high or
constant low output).

> +		use_pclk =3D true;
> +		clk_rate =3D ap->pclk_rate;
> +		period_cycles =3D mul_u64_u64_div_u64(clk_rate, state->period,
> +						    NSEC_PER_SEC);
> +		if (period_cycles < 2 * ANDES_PWM_CYCLE_MIN)
> +			return -EINVAL;
> +	}
> +
> +	/*
> +	 * Round the period down to the largest value representable for every
> +	 * duty cycle, so the chosen period depends on the requested period
> +	 * alone. With both phases capped at ANDES_PWM_CYCLE_MAX, that bound is
> +	 * ANDES_PWM_CYCLE_MAX + ANDES_PWM_CYCLE_MIN cycles.
> +	 */
> +	period_cycles =3D min_t(u64, period_cycles,
> +			      ANDES_PWM_CYCLE_MAX + ANDES_PWM_CYCLE_MIN);
> +
> +	/* The duty cycle cannot exceed the (possibly clamped) period. */
> +	duty_cycles =3D mul_u64_u64_div_u64(clk_rate, state->duty_cycle,
> +					  NSEC_PER_SEC);
> +	duty_cycles =3D min_t(u64, duty_cycles, period_cycles);

empty line here please

> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED) {
> +		low_cycles =3D duty_cycles;
> +		high_cycles =3D period_cycles - low_cycles;
> +	} else {
> +		high_cycles =3D duty_cycles;
> +		low_cycles =3D period_cycles - high_cycles;
> +	}
> +
> +	/*
> +	 * A zero-length phase means a 0% or 100% relative duty cycle, which the
> +	 * hardware cannot run. Emit the matching constant level by parking the
> +	 * channel: high_cycles =3D=3D 0 stays low, low_cycles =3D=3D 0 stays h=
igh.
> +	 */
> +	if (!high_cycles)
> +		return andes_pwm_park(chip, channel, false);
> +	if (!low_cycles)
> +		return andes_pwm_park(chip, channel, true);
> +
> +	/*
> +	 * If changing the clock source here, the output will not be the old one

s/not/neither/

> +	 * nor the new one. And the output will be the new one after writing to
> +	 * the reload register.

I'd write:

	A change of clock source takes effect immediately, modifying the
	current output. Otherwise there is no glitch as the currently
	running period is completed before the new settings take effect.

> +	 */
> +	ctrl |=3D use_pclk ? ANDES_PWM_CH_CTRL_CLK : 0;
> +	ctrl |=3D (state->polarity =3D=3D PWM_POLARITY_INVERSED) ?
> +		ANDES_PWM_CH_CTRL_PARK : 0;
> +
> +	regmap_update_bits(ap->regmap, ANDES_PWM_CH_CTRL(channel),
> +			   ANDES_PWM_CH_CTRL_MASK, ctrl);
> +	reload =3D FIELD_PREP(ANDES_PWM_CH_RELOAD_HIGH, high_cycles - 1) |
> +		 FIELD_PREP(ANDES_PWM_CH_RELOAD_LOW, low_cycles - 1);
> +	regmap_write(ap->regmap, ANDES_PWM_CH_RELOAD(channel), reload);

empty line here

> +	return andes_pwm_enable(chip, channel, true);
> +}
> +
> +static int andes_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   const struct pwm_state *state)
> +{
> +	unsigned int channel =3D pwm->hwpwm;
> +
> +	if (!state->enabled) {
> +		if (pwm->state.enabled)
> +			andes_pwm_enable(chip, channel, false);
> +
> +		return 0;
> +	}
> +
> +	return andes_pwm_config(chip, channel, state);
> +}
> +
> +static int andes_pwm_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       struct pwm_state *state)
> +{
> +	struct andes_pwm *ap =3D andes_pwm_from_chip(chip);
> +	unsigned int channel =3D pwm->hwpwm;
> +	unsigned int ctrl;
> +	unsigned int clk_rate;
> +	unsigned int reload;
> +	u64 high_cycles;
> +	u64 low_cycles;
> +
> +	regmap_read(ap->regmap, ANDES_PWM_CH_CTRL(channel), &ctrl);
> +	clk_rate =3D FIELD_GET(ANDES_PWM_CH_CTRL_CLK, ctrl) ? ap->pclk_rate
> +							  : ap->extclk_rate;
> +	if (!clk_rate) {
> +		/*
> +		 * The selected clock source is unavailable, so the channel
> +		 * cannot be running; report it as disabled and avoid the
> +		 * division by zero below.
> +		 */
> +		state->enabled =3D false;
> +		state->period =3D 0;
> +		state->duty_cycle =3D 0;
> +		return 0;
> +	}
> +
> +	state->enabled =3D regmap_test_bits(ap->regmap, ANDES_PWM_CH_ENABLE,
> +					  ANDES_PWM_CH_ENABLE_PWM(channel)) > 0;
> +	state->polarity =3D FIELD_GET(ANDES_PWM_CH_CTRL_PARK, ctrl) ?
> +			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> +	regmap_read(ap->regmap, ANDES_PWM_CH_RELOAD(channel), &reload);
> +	high_cycles =3D FIELD_GET(ANDES_PWM_CH_RELOAD_HIGH, reload) + 1;
> +	low_cycles =3D FIELD_GET(ANDES_PWM_CH_RELOAD_LOW, reload) + 1;
> +
> +	/*
> +	 * high_cycles and low_cycles are each at most ANDES_PWM_CYCLE_MAX
> +	 * (0x10000, 17 bits) and NSEC_PER_SEC is below 2^30, so the products
> +	 * below are safe from 64-bit overflow.
> +	 */
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		state->duty_cycle =3D DIV_ROUND_UP_ULL(low_cycles * NSEC_PER_SEC,
> +						     clk_rate);
> +	else
> +		state->duty_cycle =3D DIV_ROUND_UP_ULL(high_cycles * NSEC_PER_SEC,
> +						     clk_rate);

This can be simplified a bit to:

	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
		duty_cycles =3D low_cycles;
	else
		duty_cycles =3D high_cycles;

	stat->duty_cycle =3D DIV_ROUND_UP_ULL(duty_cycles * NSEC_PER_SEC,
					    clk_rate);



> +	state->period =3D DIV_ROUND_UP_ULL((high_cycles + low_cycles) *
> +					 NSEC_PER_SEC, clk_rate);
> +
> +	return 0;
> +}
> [...]
> +static int andes_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct pwm_chip *chip;
> +	struct andes_pwm *ap;
> +	void __iomem *reg_base;
> +	unsigned long pclk_rate;
> +	unsigned long extclk_rate;
> +	int ret;
> +
> +	chip =3D devm_pwmchip_alloc(dev, ANDES_PWM_CH_MAX, sizeof(*ap));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	ap =3D andes_pwm_from_chip(chip);
> +	reg_base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(reg_base))
> +		return dev_err_probe(dev, PTR_ERR(reg_base),
> +				     "Failed to map I/O space\n");
> +
> +	ap->pclk =3D devm_clk_get_enabled(dev, "pclk");
> +	if (IS_ERR(ap->pclk))
> +		return dev_err_probe(dev, PTR_ERR(ap->pclk),
> +				     "Failed to get APB clock\n");
> +
> +	ap->extclk =3D devm_clk_get_optional_enabled(dev, "extclk");
> +	if (IS_ERR(ap->extclk))
> +		return dev_err_probe(dev, PTR_ERR(ap->extclk),
> +				     "Failed to get external clock\n");
> +
> +	/*
> +	 * If the clock rate is greater than 10^9, there may be an overflow when
> +	 * calculating the cycles in andes_pwm_config()
> +	 */
> +	pclk_rate =3D clk_get_rate(ap->pclk);
> +	extclk_rate =3D clk_get_rate(ap->extclk);

Please call devm_clk_rate_exclusive_get() to ensure the clk rates are
not changed behind your back.

> +	ap->pclk_rate =3D pclk_rate > NSEC_PER_SEC ? 0 : pclk_rate;
> +	ap->extclk_rate =3D extclk_rate > NSEC_PER_SEC ? 0 : extclk_rate;
> +
> +	if (!ap->pclk_rate && !ap->extclk_rate)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "No usable clock: pclk %lu Hz, extclk %lu Hz\n",
> +				     pclk_rate, extclk_rate);
> +
> +	ap->regmap =3D devm_regmap_init_mmio(dev, reg_base,
> +					   &andes_pwm_regmap_config);
> +	if (IS_ERR(ap->regmap))
> +		return dev_err_probe(dev, PTR_ERR(ap->regmap),
> +				     "Failed to initialize regmap\n");
> +
> +	chip->ops =3D &andes_pwm_ops;

I think you can add:

	chip->atomic =3D true;

> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
> +
> +	return 0;
> +}

Best regards
Uwe

--uzbsbfiixgtu7yom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp5iaIACgkQj4D7WH0S
/k4rLAgArMUgYpeDLHNqC5yOEu29U/jxy+phUX6rnBSsyTf7mKgLywT++WpN0AmY
9+/GMVeRntM1D2XsmBzMkWN/ofkMJOuUwvIUXDY2Nk6k2xzoDcpeg2bOCw8OrKAL
iK48UMjiOWOzzzPYrwTwa9uwliarbO/UT9xveTVQ4ZIi1WOUyed8tv3rADZ6SMea
3SRjOqvxMHymVbqSx1a3BgNFDknM/YSvwZr89IJ5k2fgShAXvTRxFTaBo4qDjQ9m
49Dy079rnHe7GaDyAzANfs6ehCwoUMojA90GMWCmZjaPloJZrPmvZShEdQjnwyg3
DosDZYAN1LkVnitlj+2DkAO39tKWaA==
=OzEI
-----END PGP SIGNATURE-----

--uzbsbfiixgtu7yom--
