From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC PATCH] pwm: add TLC59108/TLC59116 PWM driver
Date: Tue, 18 Aug 2015 16:19:59 +0200
Message-ID: <20150818141959.GF4381@lunn.ch>
References: <1439905927-27861-1-git-send-email-tomi.valkeinen@ti.com>
 <1439905927-27861-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:33020 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbbHRO1R (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 18 Aug 2015 10:27:17 -0400
Content-Disposition: inline
In-Reply-To: <1439905927-27861-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-leds@vger.kernel.org, Jacek Anaszewski <j.anaszewski@samsung.com>, Bryan Wu <cooloney@gmail.com>

Hi Tomi

I know you want more high level comments, not a code review, but
anyway...

On Tue, Aug 18, 2015 at 04:52:07PM +0300, Tomi Valkeinen wrote:
> The TLC59108/TLC59116 is an I2C bus controlled 8-bit LED driver. Each
> LED output has its own 8-bit resolution (256 steps) fixed-frequency
> individual PWM controller that operates at 97 kHz, with a duty cycle
> that is adjustable from 0% to 100%. The individual PWM controller allows
> each LED to be set to a specific brightness value.
> 
> TLC59108 has 8 outputs, TLC59116 has 16 outputs.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  .../devicetree/bindings/pwm/ti,tlc59108-pwm.txt    |  16 ++
>  drivers/pwm/Kconfig                                |  10 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-tlc591xx.c                         | 273 +++++++++++++++++++++
>  4 files changed, 300 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/ti,tlc59108-pwm.txt
>  create mode 100644 drivers/pwm/pwm-tlc591xx.c
> 
> diff --git a/Documentation/devicetree/bindings/pwm/ti,tlc59108-pwm.txt b/Documentation/devicetree/bindings/pwm/ti,tlc59108-pwm.txt
> new file mode 100644
> index 000000000000..5b9580b6ac94
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/ti,tlc59108-pwm.txt
> @@ -0,0 +1,16 @@
> +TI TLC59108/TLC59116 8/16-channel 8-bit PWM LED Sink Driver
> +===========================================================
> +
> +Required properties:
> +  - compatible: "ti,tlc59108-pwm" or "ti,tlc59116-pwm"
> +  - #pwm-cells: should be 2. See pwm.txt in this directory for a description of
> +    the cells format.
> +  - reg: physical base address and size of the registers map.

Cut and paste error. Reg is the i2c address.

> +
> +Example:
> +
> +tlc59108: tlc59108@40 {
> +	compatible = "ti,tlc59108-pwm";
> +	reg = <0x40>;
> +	#pwm-cells = <2>;
> +};
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index b1541f40fd8d..0a9c8fcf993e 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -373,4 +373,14 @@ config PWM_VT8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-vt8500.
>  
> +config PWM_TLC591XX
> +	tristate "TLC59108/TLC59116 PWM driver"
> +	depends on OF && I2C
> +	select REGMAP_I2C
> +	help
> +	  Generic PWM framework driver for TI TLC59108/TLC59116 PWM controller.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-tlc591xx.
> +
>  endif
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index ec50eb5b5a8f..75896890d6ec 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -35,3 +35,4 @@ obj-$(CONFIG_PWM_TIPWMSS)	+= pwm-tipwmss.o
>  obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
>  obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
>  obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
> +obj-$(CONFIG_PWM_TLC591XX)	+= pwm-tlc591xx.o
> diff --git a/drivers/pwm/pwm-tlc591xx.c b/drivers/pwm/pwm-tlc591xx.c
> new file mode 100644
> index 000000000000..cd49faa75eff
> --- /dev/null
> +++ b/drivers/pwm/pwm-tlc591xx.c
> @@ -0,0 +1,273 @@
> +/*
> + * Driver for TLC59108/TLC59116 I2C based PWM/LED chip
> + *
> + * Copyright 2014 Belkin Inc.
> + * Copyright 2015 Andrew Lunn
> + * Copyright 2015 Texas Instruments
> + *
> + * Authors:
> + * Andrew Lunn <andrew@lunn.ch>
> + * Vignesh R <vigneshr@ti.com>
> + * Tomi Valkeinen <tomi.valkeinen@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +#define TLC591XX_MAX_LEDS	16
> +
> +#define TLC591XX_MODE1		0x00
> +#define TLC591XX_PWM(n)		(0x02 + (n))
> +#define TLC591XX_MAXREG		0x1e
> +
> +#define LEDOUT_OFF		0x0
> +#define LEDOUT_ON		0x1
> +#define LEDOUT_DIM		0x2
> +#define LEDOUT_MASK		0x3
> +
> +#define TLC591XX_CLK_PERIOD	10309 /* period in ns */
> +#define TLC591XX_NO_STEPS	256
> +#define TLC591XX_LEDS_PER_REG	4
> +
> +struct tlc591xx_led {
> +	unsigned int led_no;
> +	struct tlc591xx_priv *priv;
> +};
> +
> +struct tlc591xx_priv {
> +	struct pwm_chip chip;
> +	struct regmap *regmap;
> +	struct tlc591xx_led leds[TLC591XX_MAX_LEDS];
> +	unsigned int reg_ledout_offset;
> +};
> +
> +static struct regmap_config tlc591xx_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = TLC591XX_MAXREG,
> +};
> +
> +struct tlc591xx_hw {
> +	unsigned int max_leds;
> +	unsigned int reg_ledout_offset;
> +};
> +
> +static const struct tlc591xx_hw tlc59116 = {
> +	.max_leds = 16,
> +	.reg_ledout_offset = 0x14,
> +};
> +
> +static const struct tlc591xx_hw tlc59108 = {
> +	.max_leds = 8,
> +	.reg_ledout_offset = 0x0c,
> +};
> +
> +static inline struct tlc591xx_priv *to_tlc591xx_priv(struct pwm_chip *c)
> +{
> +	return container_of(c, struct tlc591xx_priv, chip);
> +}
> +
> +static int tlc591xx_write_ledout(struct pwm_chip *chip, struct pwm_device *pwm,
> +	unsigned val)
> +{
> +	struct tlc591xx_priv *priv = to_tlc591xx_priv(chip);
> +	int led_no, led_grp;
> +	unsigned int reg, mask;
> +	unsigned shift;
> +
> +	led_no = (pwm->hwpwm) % TLC591XX_LEDS_PER_REG;
> +	led_grp = (pwm->hwpwm) / TLC591XX_LEDS_PER_REG;
> +
> +	reg = priv->reg_ledout_offset + led_grp;
> +	shift = led_no * 2;
> +	mask = LEDOUT_MASK << shift;
> +	val <<= shift;
> +
> +	return regmap_update_bits(priv->regmap, reg, mask, val);
> +}
> +
> +static int tlc591xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			       int duty_ns, int period_ns)
> +{
> +	struct tlc591xx_priv *priv = to_tlc591xx_priv(chip);
> +	unsigned val;
> +	int r;
> +
> +	if (period_ns != TLC591XX_CLK_PERIOD) {
> +		dev_err(chip->dev, "only period of 10309 ns is supported\n");
> +		return -EINVAL;
> +	}

The hardware does allow you to change the period, but there is only
one clock generator for all the channels. If you are going to make the
effort to try to model the hardware as a PWM, you should try to
actually implement the PWM API. Let the first channel which calls
config set the period, and return an error for any other channel which
picks a different period.

      Andrew
