Received: from Atcsqr.andestech.com (220-128-198-181.hinet-ip.hinet.net [220.128.198.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157EA313546;
	Tue, 11 Aug 2026 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.128.198.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443594; cv=none; b=WphqyZsY4l+cYHMcYgjHBHWu3YnMORGqSsdeRHDSQPrQXNZuEl9Lgdeum1gIdAYlQH6PMn4JrwnPAOP8XGSX3JZCjMZA+i7n3s1eyXRqcdmX1mwBB8krpqtrzR5PBS1KHZvquljPedD8LnBp18hHTYMoCSb1SNRRIQaS/oZUp9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443594; c=relaxed/simple;
	bh=0qITWxovGHIYN4ak5oWI1wKjybmermaw7qYn0IN3Bd8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGxKWZOJcmuTC9NKS1zbWswrOfTICIIAbUcwhofu46cnBeEgnp6SlSKHf7hMpNiLz4TuW2DnPdxFNftuKsmlYQc9nThqf9JDQnNJzRRs4wWaGf9WIzxdzpxX+vwxEX2D8beuQMRL34CAG7EnwMcs4HNVzuosTnHryoKwPSrlm3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=220.128.198.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 67BABnmx079655;
	Tue, 11 Aug 2026 18:11:49 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from mail.andestech.com (atcpcs54.andestech.com [10.0.1.154])
	by Atcsqr.andestech.com with ESMTPS id 67BABPnj079113
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 18:11:25 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs54.andestech.com
 (10.0.1.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Tue, 11 Aug
 2026 18:11:25 +0800
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Aug
 2026 18:11:25 +0800
Date: Tue, 11 Aug 2026 18:11:23 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/3] pwm: add Andes PWM driver support
Message-ID: <anr1SzK9p1UKcyiv@swlinux02>
References: <20260625-andes-pwm-v6-0-3aef11711017@andestech.com>
 <20260625-andes-pwm-v6-2-3aef11711017@andestech.com>
 <anmALNaygumsRcpd@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anmALNaygumsRcpd@monoceros>
User-Agent: Mutt/2.3.0 (2026-01-25)
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs54.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 67BABnmx079655

Hi Uwe,

Thanks for the review.

On Mon, Aug 10, 2026 at 10:19:49AM +0200, Uwe Kleine-König wrote:
> Subject: Re: [PATCH v6 2/3] pwm: add Andes PWM driver support
>
> On Thu, Jun 25, 2026 at 06:36:00PM +0800, Ben Zong-You Xie via B4 Relay wrote:
> > From: Ben Zong-You Xie <ben717@andestech.com>
> >
> > Add a driver for the PWM controller found in Andes AE350 platforms and
> > QiLai SoCs.
> >
> > The Andes PWM controller features:
> > - 4 independent channels.
> > - Dual clock source support (APB clock and external clock) to provide
> >   a flexible range of frequencies.
> > - Support for normal and inversed polarity.
> >
> > The driver implements the .apply() and .get_state() callbacks. Since the
> > clock source of each channel can be selected by programming the
> > register, clock selection logic is implemented to prioritize the
> > external clock to maximize the supported period range, falling back to
> > the APB clock for higher frequency requirements.
> >
> > Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
> > ---
> >  drivers/pwm/Kconfig     |  10 ++
> >  drivers/pwm/Makefile    |   1 +
> >  drivers/pwm/pwm-andes.c | 343 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 354 insertions(+)
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index e8886a9b64d9..52dee4b7f081 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -73,6 +73,16 @@ config PWM_AIROHA
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-airoha.
> >
> > +config PWM_ANDES
> > +	tristate "Andes PWM support"
> > +	depends on ARCH_ANDES || COMPILE_TEST
>
> Here are missing dependencies. At least REGMAP.
>

Right. v7 will have:

        depends on ARCH_ANDES || COMPILE_TEST
        depends on HAS_IOMEM && COMMON_CLK
        select REGMAP_MMIO

> > +	help
> > +	  Generic PWM framework driver for Andes platform, such as QiLai SoC
> > +	  and AE350 platform.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called pwm-andes.
> > +
> >  config PWM_APPLE
> >  	tristate "Apple SoC PWM support"
> >  	depends on ARCH_APPLE || COMPILE_TEST
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 5630a521a7cf..c92369ee251d 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -3,6 +3,7 @@ obj-$(CONFIG_PWM)		+= core.o
> >  obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
> >  obj-$(CONFIG_PWM_ADP5585)	+= pwm-adp5585.o
> >  obj-$(CONFIG_PWM_AIROHA)	+= pwm-airoha.o
> > +obj-$(CONFIG_PWM_ANDES)		+= pwm-andes.o
> >  obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
> >  obj-$(CONFIG_PWM_ARGON_FAN_HAT)	+= pwm-argon-fan-hat.o
> >  obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
> > diff --git a/drivers/pwm/pwm-andes.c b/drivers/pwm/pwm-andes.c
> > new file mode 100644
> > index 000000000000..580e673d2cff
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-andes.c
> > @@ -0,0 +1,343 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for Andes PWM, used in Andes AE350 platform and QiLai SoC
> > + *
> > + * Copyright (C) 2026 Andes Technology Corporation.
> > + *
> > + * Limitations:
> > + * - When disabling a channel, the current period is not completed and the
> > + *   output is driven to the PARK level (low when ANDES_PWM_CH_CTRL_PARK is
> > + *   clear, high when it is set).
> > + * - The current period will be completed first if reconfiguring.
> > + * - Further, if the reconfiguration changes the clock source, the output will
> > + *   not be the old one nor the new one. And the output will be the new one
> > + *   after writing to the reload register.
> > + * - The hardware cannot run a 0% or 100% relative duty cycle; the driver
> > + *   emulates these by disabling the channel and parking the output at the
> > + *   constant level.
> > + * - A period or duty cycle larger than the selected clock can represent is
> > + *   rounded down to the largest achievable value rather than rejected.
>
> The last item isn't a (hardware) property, but the right thing to do for
> PWM drivers. So you can drop that.
>

Will drop in v7.

> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/math64.h>
> > +#include <linux/minmax.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/time.h>
> > +#include <linux/types.h>
>
> I wonder what <linux/time.h> is used for.
>

NSEC_PER_SEC.

> > [...]
> > +/*
> > + * Hold the output at a constant level by parking the disabled channel. A
> > + * disabled channel drives its output to the PARK level (low when @high is
> > + * false, high when @high is true), which is used to emulate a 0% or 100%
> > + * relative duty cycle.
> > + */
> > +static int andes_pwm_park(struct pwm_chip *chip, unsigned int channel,
> > +			  bool high)
> > +{
> > +	struct andes_pwm *ap = andes_pwm_from_chip(chip);
> > +
> > +	regmap_assign_bits(ap->regmap, ANDES_PWM_CH_CTRL(channel),
> > +			   ANDES_PWM_CH_CTRL_PARK, high);
>
> Some calls to regmap_assign_bits() are checked, others are not. Please
> make this consistent.
>

Will make the check consistent in v7.

> > +	return andes_pwm_enable(chip, channel, false);
> > +}
> > +
> > +static int andes_pwm_config(struct pwm_chip *chip, unsigned int channel,
> > +			    const struct pwm_state *state)
> > +{
> > +	struct andes_pwm *ap = andes_pwm_from_chip(chip);
> > +	unsigned int clk_rate = ap->extclk_rate;
> > +	unsigned int ctrl = ANDES_PWM_CH_CTRL_MODE_PWM;
> > +	bool use_pclk = false;
> > +	u64 high_cycles;
> > +	u64 low_cycles;
> > +	u64 period_cycles;
> > +	u64 duty_cycles;
> > +	u32 reload;
> > +
> > +	/*
> > +	 * Reload register for PWM mode:
> > +	 *
> > +	 *		31 : 16    15 : 0
> > +	 *		PWM16_Hi | PWM16_Lo
> > +	 *
> > +	 * The high duration is (PWM16_Hi + 1) cycles and the low duration is
> > +	 * (PWM16_Lo + 1) cycles, so each phase spans ANDES_PWM_CYCLE_MIN to
> > +	 * ANDES_PWM_CYCLE_MAX cycles. The hardware period (their sum) can reach
> > +	 * 2 * ANDES_PWM_CYCLE_MAX cycles, but the PWM core requires the period
> > +	 * to be chosen from the requested period alone, independent of the duty
> > +	 * cycle. That holds only while both phases stay within
> > +	 * ANDES_PWM_CYCLE_MAX for every duty split, so the usable period is
> > +	 * capped at ANDES_PWM_CYCLE_MAX + ANDES_PWM_CYCLE_MIN cycles.
> > +	 *
> > +	 * The controller has two clock sources, the APB clock and an external
> > +	 * clock. Since the external clock frequency must be slower than the APB
> > +	 * clock, it is tried first for its wider period range; the APB clock is
> > +	 * used only when the external clock is too fast to represent the period
> > +	 * (it resolves fewer than two cycles) or is absent.
> > +	 */
> > +	period_cycles = mul_u64_u64_div_u64(clk_rate, state->period,
> > +					    NSEC_PER_SEC);
> > +	if (period_cycles < 2 * ANDES_PWM_CYCLE_MIN) {
>
> With period_cycles = 1 you can only have duty_cycle = 0 or 1 which is
> representable by the hardware (configuring either constant high or
> constant low output).
>

Right, v7 will only reject zero:

      if (period_cycles < 2 * ANDES_PWM_CYCLE_MIN && ap->pclk_rate) {
              use_pclk = true;
              clk_rate = ap->pclk_rate;
              period_cycles = mul_u64_u64_div_u64(clk_rate, state->period,
                                                  NSEC_PER_SEC);
      }

      if (!period_cycles)
              return -EINVAL;

I still switch to pclk at two cycles though. If extclk only resolves one
cycle, pclk may well manage a real waveform, which beats parking.

> > +		use_pclk = true;
> > +		clk_rate = ap->pclk_rate;
> > +		period_cycles = mul_u64_u64_div_u64(clk_rate, state->period,
> > +						    NSEC_PER_SEC);
> > +		if (period_cycles < 2 * ANDES_PWM_CYCLE_MIN)
> > +			return -EINVAL;
> > +	}
> > +
> > +	/*
> > +	 * Round the period down to the largest value representable for every
> > +	 * duty cycle, so the chosen period depends on the requested period
> > +	 * alone. With both phases capped at ANDES_PWM_CYCLE_MAX, that bound is
> > +	 * ANDES_PWM_CYCLE_MAX + ANDES_PWM_CYCLE_MIN cycles.
> > +	 */
> > +	period_cycles = min_t(u64, period_cycles,
> > +			      ANDES_PWM_CYCLE_MAX + ANDES_PWM_CYCLE_MIN);
> > +
> > +	/* The duty cycle cannot exceed the (possibly clamped) period. */
> > +	duty_cycles = mul_u64_u64_div_u64(clk_rate, state->duty_cycle,
> > +					  NSEC_PER_SEC);
> > +	duty_cycles = min_t(u64, duty_cycles, period_cycles);
>
> empty line here please
>

Will add in v7.

> > +	if (state->polarity == PWM_POLARITY_INVERSED) {
> > +		low_cycles = duty_cycles;
> > +		high_cycles = period_cycles - low_cycles;
> > +	} else {
> > +		high_cycles = duty_cycles;
> > +		low_cycles = period_cycles - high_cycles;
> > +	}
> > +
> > +	/*
> > +	 * A zero-length phase means a 0% or 100% relative duty cycle, which the
> > +	 * hardware cannot run. Emit the matching constant level by parking the
> > +	 * channel: high_cycles == 0 stays low, low_cycles == 0 stays high.
> > +	 */
> > +	if (!high_cycles)
> > +		return andes_pwm_park(chip, channel, false);
> > +	if (!low_cycles)
> > +		return andes_pwm_park(chip, channel, true);
> > +
> > +	/*
> > +	 * If changing the clock source here, the output will not be the old one
>
> s/not/neither/
>
> > +	 * nor the new one. And the output will be the new one after writing to
> > +	 * the reload register.
>
> I'd write:
>
> 	A change of clock source takes effect immediately, modifying the
> 	current output. Otherwise there is no glitch as the currently
> 	running period is completed before the new settings take effect.
>

Will take your wording. The Limitations block at the top described the same
thing the same way, so I replaced it there too.

> > +	 */
> > +	ctrl |= use_pclk ? ANDES_PWM_CH_CTRL_CLK : 0;
> > +	ctrl |= (state->polarity == PWM_POLARITY_INVERSED) ?
> > +		ANDES_PWM_CH_CTRL_PARK : 0;
> > +
> > +	regmap_update_bits(ap->regmap, ANDES_PWM_CH_CTRL(channel),
> > +			   ANDES_PWM_CH_CTRL_MASK, ctrl);
> > +	reload = FIELD_PREP(ANDES_PWM_CH_RELOAD_HIGH, high_cycles - 1) |
> > +		 FIELD_PREP(ANDES_PWM_CH_RELOAD_LOW, low_cycles - 1);
> > +	regmap_write(ap->regmap, ANDES_PWM_CH_RELOAD(channel), reload);
>
> empty line here
>

Will add in v7.

> > +	return andes_pwm_enable(chip, channel, true);
> > +}
> > +
> > +static int andes_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			   const struct pwm_state *state)
> > +{
> > +	unsigned int channel = pwm->hwpwm;
> > +
> > +	if (!state->enabled) {
> > +		if (pwm->state.enabled)
> > +			andes_pwm_enable(chip, channel, false);
> > +
> > +		return 0;
> > +	}
> > +
> > +	return andes_pwm_config(chip, channel, state);
> > +}
> > +
> > +static int andes_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			       struct pwm_state *state)
> > +{
> > +	struct andes_pwm *ap = andes_pwm_from_chip(chip);
> > +	unsigned int channel = pwm->hwpwm;
> > +	unsigned int ctrl;
> > +	unsigned int clk_rate;
> > +	unsigned int reload;
> > +	u64 high_cycles;
> > +	u64 low_cycles;
> > +
> > +	regmap_read(ap->regmap, ANDES_PWM_CH_CTRL(channel), &ctrl);
> > +	clk_rate = FIELD_GET(ANDES_PWM_CH_CTRL_CLK, ctrl) ? ap->pclk_rate
> > +							  : ap->extclk_rate;
> > +	if (!clk_rate) {
> > +		/*
> > +		 * The selected clock source is unavailable, so the channel
> > +		 * cannot be running; report it as disabled and avoid the
> > +		 * division by zero below.
> > +		 */
> > +		state->enabled = false;
> > +		state->period = 0;
> > +		state->duty_cycle = 0;
> > +		return 0;
> > +	}
> > +
> > +	state->enabled = regmap_test_bits(ap->regmap, ANDES_PWM_CH_ENABLE,
> > +					  ANDES_PWM_CH_ENABLE_PWM(channel)) > 0;
> > +	state->polarity = FIELD_GET(ANDES_PWM_CH_CTRL_PARK, ctrl) ?
> > +			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> > +	regmap_read(ap->regmap, ANDES_PWM_CH_RELOAD(channel), &reload);
> > +	high_cycles = FIELD_GET(ANDES_PWM_CH_RELOAD_HIGH, reload) + 1;
> > +	low_cycles = FIELD_GET(ANDES_PWM_CH_RELOAD_LOW, reload) + 1;
> > +
> > +	/*
> > +	 * high_cycles and low_cycles are each at most ANDES_PWM_CYCLE_MAX
> > +	 * (0x10000, 17 bits) and NSEC_PER_SEC is below 2^30, so the products
> > +	 * below are safe from 64-bit overflow.
> > +	 */
> > +	if (state->polarity == PWM_POLARITY_INVERSED)
> > +		state->duty_cycle = DIV_ROUND_UP_ULL(low_cycles * NSEC_PER_SEC,
> > +						     clk_rate);
> > +	else
> > +		state->duty_cycle = DIV_ROUND_UP_ULL(high_cycles * NSEC_PER_SEC,
> > +						     clk_rate);
>
> This can be simplified a bit to:
>
> 	if (state->polarity == PWM_POLARITY_INVERSED)
> 		duty_cycles = low_cycles;
> 	else
> 		duty_cycles = high_cycles;
>
> 	stat->duty_cycle = DIV_ROUND_UP_ULL(duty_cycles * NSEC_PER_SEC,
> 					    clk_rate);
>

Will apply in v7.

> > +	state->period = DIV_ROUND_UP_ULL((high_cycles + low_cycles) *
> > +					 NSEC_PER_SEC, clk_rate);
> > +
> > +	return 0;
> > +}
> > [...]
> > +static int andes_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct pwm_chip *chip;
> > +	struct andes_pwm *ap;
> > +	void __iomem *reg_base;
> > +	unsigned long pclk_rate;
> > +	unsigned long extclk_rate;
> > +	int ret;
> > +
> > +	chip = devm_pwmchip_alloc(dev, ANDES_PWM_CH_MAX, sizeof(*ap));
> > +	if (IS_ERR(chip))
> > +		return PTR_ERR(chip);
> > +
> > +	ap = andes_pwm_from_chip(chip);
> > +	reg_base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(reg_base))
> > +		return dev_err_probe(dev, PTR_ERR(reg_base),
> > +				     "Failed to map I/O space\n");
> > +
> > +	ap->pclk = devm_clk_get_enabled(dev, "pclk");
> > +	if (IS_ERR(ap->pclk))
> > +		return dev_err_probe(dev, PTR_ERR(ap->pclk),
> > +				     "Failed to get APB clock\n");
> > +
> > +	ap->extclk = devm_clk_get_optional_enabled(dev, "extclk");
> > +	if (IS_ERR(ap->extclk))
> > +		return dev_err_probe(dev, PTR_ERR(ap->extclk),
> > +				     "Failed to get external clock\n");
> > +
> > +	/*
> > +	 * If the clock rate is greater than 10^9, there may be an overflow when
> > +	 * calculating the cycles in andes_pwm_config()
> > +	 */
> > +	pclk_rate = clk_get_rate(ap->pclk);
> > +	extclk_rate = clk_get_rate(ap->extclk);
>
> Please call devm_clk_rate_exclusive_get() to ensure the clk rates are
> not changed behind your back.
>

Will do this for both clocks, before clk_get_rate().

> > +	ap->pclk_rate = pclk_rate > NSEC_PER_SEC ? 0 : pclk_rate;
> > +	ap->extclk_rate = extclk_rate > NSEC_PER_SEC ? 0 : extclk_rate;
> > +
> > +	if (!ap->pclk_rate && !ap->extclk_rate)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "No usable clock: pclk %lu Hz, extclk %lu Hz\n",
> > +				     pclk_rate, extclk_rate);
> > +
> > +	ap->regmap = devm_regmap_init_mmio(dev, reg_base,
> > +					   &andes_pwm_regmap_config);
> > +	if (IS_ERR(ap->regmap))
> > +		return dev_err_probe(dev, PTR_ERR(ap->regmap),
> > +				     "Failed to initialize regmap\n");
> > +
> > +	chip->ops = &andes_pwm_ops;
>
> I think you can add:
>
> 	chip->atomic = true;
>

Right, will add in v7.

> > +	ret = devm_pwmchip_add(dev, chip);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
> > +
> > +	return 0;
> > +}
>
> Best regards
> Uwe

Thanks,
Ben
