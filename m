From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [PATCH 2/2 v2] pwm: add a driver for the STMPE PWM
Date: Mon, 2 May 2016 18:08:13 +0300
Message-ID: <57276D5D.90706@mentor.com>
References: <1459891357-28352-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:48792 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbcEBPIX (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 2 May 2016 11:08:23 -0400
In-Reply-To: <1459891357-28352-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>

Hi Linus,

On 06.04.2016 00:22, Linus Walleij wrote:
> This adds a driver for the STMPE 24xx series of multi-purpose
> I2C expanders. (I think STMPE means ST Microelectronics
> Multi-Purpose Expander.) This PWM was designed in accordance with
> Nokia specifications and is kind of weird and usually just
> switched between max and zero dutycycle. However it is indeed
> a PWM so it needs to live in the PWM subsystem.
> 
> This PWM is mostly used for white LED backlight.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

let me do some shallow review for you.

> ---
> ChangeLog v2->v3:
> - Use pwm_is_enabled() instead of local state tracking.
> - Convert to builtin_platform_driver_probe() and tag the init
>   code with _init, we're not going modular with this driver.
> - Get rid of some pointless (u8) casts
> - Convert an if () else if () else if () ladder into a switch
>   statement.
> - Make a set of #defines for the PWM state machine instruction
>   words.
> - Don't brag about the driver being initialized.
> ChangeLog v1->v2:
> - Split off the MFD hunk from the patch: no need to worry about
>   that, it can be merged orthogonally to the MFD tree.
> ---
>  drivers/pwm/Kconfig     |   7 ++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-stmpe.c | 299 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 307 insertions(+)
>  create mode 100644 drivers/pwm/pwm-stmpe.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index c182efc62c7b..1a491d094e2e 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -362,6 +362,13 @@ config PWM_STI
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sti.
>  
> +config PWM_STMPE
> +	bool "STMPE expander PWM export"
> +	depends on MFD_STMPE
> +	help
> +	  This enables support for the PWMs found in the STMPE I/O
> +	  expanders.
> +
>  config PWM_SUN4I
>  	tristate "Allwinner PWM support"
>  	depends on ARCH_SUNXI || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index dd35bc121a18..790353b7454e 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
>  obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
>  obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
> +obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
>  obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
>  obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
> diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
> new file mode 100644
> index 000000000000..e560b583ef28
> --- /dev/null
> +++ b/drivers/pwm/pwm-stmpe.c
> @@ -0,0 +1,299 @@
> +/*
> + * Copyright (C) 2016 Linaro Ltd.
> + *
> + * Author: Linus Walleij <linus.walleij@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2, as
> + * published by the Free Software Foundation.
> + *
> + */
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/pwm.h>
> +#include <linux/of.h>
> +#include <linux/mfd/stmpe.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>

Here alphabetically sorted list of header files would be better IMHO.

> +
> +#define STMPE24XX_PWMCS		0x30
> +#define PWMCS_EN_PWM0		BIT(0)
> +#define PWMCS_EN_PWM1		BIT(1)
> +#define PWMCS_EN_PWM2		BIT(2)

These 3 bitfields are actually not used in the code.

> +#define STMPE24XX_PWMIC0	0x38
> +#define STMPE24XX_PWMIC1	0x39
> +#define STMPE24XX_PWMIC2	0x3a
> +#define STMPE_PWM_24XX_PINBASE	21
> +
> +struct stmpe_pwm {
> +	struct stmpe *stmpe;
> +	struct pwm_chip chip;
> +	u8 lastduty;
> +};
> +
> +static inline struct stmpe_pwm *to_stmpe_pwm(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct stmpe_pwm, chip);
> +}
> +
> +static int stmpe_24xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct stmpe_pwm *stmpe_pwm = to_stmpe_pwm(chip);
> +	int ret;
> +	u8 val;
> +
> +	ret = stmpe_reg_read(stmpe_pwm->stmpe, STMPE24XX_PWMCS);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "error reading PWM%d control\n",
> +			pwm->hwpwm);
> +		return ret;
> +	}
> +
> +	val = ret;
> +	val |= BIT(pwm->hwpwm);
> +
> +	ret = stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, val);
> +	if (ret) {
> +		dev_err(chip->dev, "error writing PWM%d control\n",
> +			pwm->hwpwm);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void stmpe_24xx_pwm_disable(struct pwm_chip *chip,
> +				struct pwm_device *pwm)
> +{
> +	struct stmpe_pwm *stmpe_pwm = to_stmpe_pwm(chip);
> +	int ret;
> +	u8 val;
> +
> +	ret = stmpe_reg_read(stmpe_pwm->stmpe, STMPE24XX_PWMCS);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "error reading PWM%d control\n",
> +			pwm->hwpwm);
> +		return;
> +	}
> +
> +	val = ret;
> +	val &= ~BIT(pwm->hwpwm);
> +
> +	ret = stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, val);
> +	if (ret) {
> +		dev_err(chip->dev, "error writing PWM%d control\n",
> +			pwm->hwpwm);
> +		return;
> +	}
> +}

Here *_pwm_disable()/*_pwm_enable() functions are quite verbose, to save
LoC you may consider to add a wrapped *_pwm_enable_disable(..., bool
enable) or so.

> +
> +/* STMPE 24xx PWM instructions */
> +#define SMAX		0x007F
> +#define SMIN		0x00FF
> +#define GTS		0x0000
> +#define LOAD_2403	BIT(14) /* Only available on 2403 */
> +#define RAMPUP		0x0000
> +#define RAMPDOWN	BIT(7)
> +#define PRESCALE_512	BIT(14)
> +#define STEPTIME_1	BIT(8)
> +#define BRANCH		BIT(15) | BIT(13)
> +

May be move macro declarations to the top and add an STMPE 24xx specific prefix?

> +static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +				int duty_ns, int period_ns)
> +{
> +	struct stmpe_pwm *stmpe_pwm = to_stmpe_pwm(chip);
> +	u8 reg;
> +	int ret;
> +	unsigned int i, pin;
> +	u16 program[3] = {
> +		SMAX,
> +		GTS,
> +		GTS,
> +	};
> +
> +	/* Make sure we are disabled */
> +	if (pwm_is_enabled(pwm)) {
> +		stmpe_24xx_pwm_disable(chip, pwm);
> +	} else {
> +		/* Connect the PWM to the pin */
> +		pin = pwm->hwpwm;
> +		/* On STMPE2401 and 2403 pins 21,22,23 are used */
> +		if (stmpe_pwm->stmpe->partnum == STMPE2401 ||
> +		stmpe_pwm->stmpe->partnum == STMPE2403)
> +			pin += STMPE_PWM_24XX_PINBASE;
> +		ret = stmpe_set_altfunc(stmpe_pwm->stmpe,
> +					BIT(pin),
> +					STMPE_BLOCK_PWM);
> +		if (ret) {
> +			dev_err(chip->dev, "unable to connect PWM%d to pin\n",
> +				pwm->hwpwm);
> +			return ret;
> +		}
> +	}
> +
> +	/* STMPE24XX */
> +	switch (pwm->hwpwm) {
> +        case 0:

Odd indentation, should be reported by checkpatch, probably there are more
of them.

> +		reg = STMPE24XX_PWMIC0;
> +		break;
> +	case 1:
> +		reg = STMPE24XX_PWMIC1;
> +		break;
> +	case 2:
> +		reg = STMPE24XX_PWMIC1;
> +		break;
> +	default:
> +		/* Should not happen as npwm is 3 */
> +		return -ENODEV;
> +	}
> +
> +	dev_dbg(chip->dev, "PWM%d: config duty %d ns, period %d ns\n",
> +		pwm->hwpwm, duty_ns, period_ns);
> +	if (duty_ns == 0) {
> +		if (stmpe_pwm->stmpe->partnum == STMPE2401)
> +			program[0] = SMAX; /* off all the time */
> +		if (stmpe_pwm->stmpe->partnum == STMPE2403)
> +			program[0] = LOAD_2403 | 0xFF; /* LOAD 0xFF */
> +		stmpe_pwm->lastduty = 0x00;
> +	} else if (duty_ns == period_ns) {
> +		if (stmpe_pwm->stmpe->partnum == STMPE2401)
> +			program[0] = SMIN; /* on all the time */
> +		if (stmpe_pwm->stmpe->partnum == STMPE2403)
> +			program[0] = LOAD_2403 | 0x00; /* LOAD 0x00 */
> +		stmpe_pwm->lastduty = 0xFF;
> +	} else {
> +		unsigned long cyc;
> +		u8 val;
> +
> +		/*
> +		 * Counter goes from 0x00 to 0xFF repeatedly at 32768 Hz,
> +		 * (means a period of 30517 ns)
> +		 * then this is compared to the counter from the ramp,
> +		 * if this is >= pwm counter the output is high.
> +		 * With LOAD we can define how much of the cycle it is on.
> +		 *
> +		 * Prescale = 0 -> 2 kHz -> T = 1/f = 488281,25 ns
> +		 */
> +		/* Scale to 0..FF */
> +		cyc = duty_ns * 256;
> +		cyc = DIV_ROUND_CLOSEST(cyc, period_ns);
> +		val = cyc;

You should be able to do here

   val = DIV_ROUND_CLOSEST(cyc, period_ns);

or even

   val = DIV_ROUND_CLOSEST(duty_ns * 256, period_ns);

if there is no overflow.

> +
> +		if (val == stmpe_pwm->lastduty) {
> +			/* Run the old program */
> +			if (pwm_is_enabled(pwm))
> +				stmpe_24xx_pwm_enable(chip, pwm);
> +			return 0;
> +		} else if (stmpe_pwm->stmpe->partnum == STMPE2403) {

Since the second (and the third) else-if checks for another type of
condition, I would propose to remove chained else-if here, fortunately the
first check ends with return.

> +			/* STMPE2403 can simply set the right PWM value */
> +			program[0] = LOAD_2403 | val;
> +			program[1] = 0x0000;
> +		} else if (stmpe_pwm->stmpe->partnum == STMPE2401) {
> +			/* STMPE2401 need a complex program */
> +			u16 incdec = 0x0000;
> +
> +			if (stmpe_pwm->lastduty < val)
> +				/* Count up */
> +				incdec = RAMPUP | (val - stmpe_pwm->lastduty);
> +			else
> +				/* Count down */
> +				incdec = RAMPDOWN | (stmpe_pwm->lastduty - val);
> +			/* Step to desired value, smoothly */
> +			program[0] = PRESCALE_512 | STEPTIME_1 | incdec;
> +			/* Loop eternally to 0x00 */
> +			program[1] = BRANCH;
> +		}
> +
> +		dev_dbg(chip->dev, "PWM%d: val = %02x, lastduty = %02x, "
> +			"program=%04x,%04x,%04x\n", pwm->hwpwm, val,
> +			stmpe_pwm->lastduty, program[0], program[1],
> +			program[2]);
> +		stmpe_pwm->lastduty = val;
> +	}
> +
> +	/*
> +	 * We can write programs of up to 64 16-bit words into this
> +	 * channel.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(program); i++) {
> +		u8 val;
> +
> +		val = (program[i] >> 8) & 0xFF;
> +		ret = stmpe_reg_write(stmpe_pwm->stmpe, reg, val);
> +		if (ret) {
> +			dev_err(chip->dev, "error writing reg %02x\n", reg);
> +			return ret;
> +		}
> +		val = program[i] & 0xFF;
> +		ret = stmpe_reg_write(stmpe_pwm->stmpe, reg, val);
> +		if (ret) {
> +			dev_err(chip->dev, "error writing reg %02x\n", reg);
> +			return ret;
> +		}
> +	}
> +
> +	/* If we were enabled, re-enable this PWM */
> +	if (pwm_is_enabled(pwm))
> +		stmpe_24xx_pwm_enable(chip, pwm);

I would propose to split stmpe_24xx_pwm_config() into the actual config
function clear from is_enabled()/enable() code and a tiny wrapper which
sets the controller into a defined power state.

> +
> +	/* Sleep for 200ms so we're sure it will take effect */
> +	msleep(200);
> +
> +	dev_dbg(chip->dev, "programmed PWM%u, %d bytes\n",
> +		pwm->hwpwm, i);
> +	return 0;

Empty line before return may decorate the code.

> +}
> +
> +static const struct pwm_ops stmpe_24xx_pwm_ops = {
> +	.config = stmpe_24xx_pwm_config,
> +	.enable = stmpe_24xx_pwm_enable,
> +	.disable = stmpe_24xx_pwm_disable,
> +	.owner = THIS_MODULE,

Is .owner assignment still needed?

> +};
> +
> +static int __init stmpe_pwm_probe(struct platform_device *pdev)
> +{
> +	struct stmpe *stmpe = dev_get_drvdata(pdev->dev.parent);
> +	struct stmpe_pwm *pwm;
> +	int ret;
> +
> +	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	pwm->stmpe = stmpe;
> +	pwm->chip.dev = &pdev->dev;
> +	pwm->chip.base = -1;
> +	if (stmpe->partnum == STMPE2401 || stmpe->partnum == STMPE2403) {
> +		pwm->chip.ops = &stmpe_24xx_pwm_ops;
> +		pwm->chip.npwm = 3;
> +	} else if (stmpe->partnum == STMPE1601) {
> +		dev_err(&pdev->dev, "STMPE1601 PWM not yet supported\n");
> +		return -ENODEV;
> +	} else {
> +		dev_err(&pdev->dev, "Unsupported STMPE PWM\n");
> +		return -ENODEV;
> +	}

Here I don't see a significant difference between "STMPE1601 PWM not yet
supported" and "Unsupported STMPE PWM", it makes sense to combine them.

> +
> +	ret = stmpe_enable(stmpe, STMPE_BLOCK_PWM);
> +	if (ret)
> +		return ret;
> +
> +	ret = pwmchip_add(&pwm->chip);
> +	if (ret)
> +		return ret;

STMPE_BLOCK_PWM is left enabled on error path.

> +	platform_set_drvdata(pdev, pwm);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver stmpe_pwm_driver = {
> +	.driver = {
> +		.name = "stmpe-pwm",
> +		.suppress_bind_attrs = true,

Hm, I didn't know about this attribute, here its usage seems to
be appropriate.

> +	},
> +};
> +builtin_platform_driver_probe(stmpe_pwm_driver, stmpe_pwm_probe);
> 

--
With best wishes,
Vladimir
