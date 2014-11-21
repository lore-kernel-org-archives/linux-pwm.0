From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Subject: RE: [PATCH v3 1/4] pwm: Imagination Technologies PWM DAC driver
Date: Fri, 21 Nov 2014 06:14:27 +0000
Message-ID: <27E62D98F903554192E3C13AFCC91C3C2F509B8E@hbmail01.hb.imgtec.org>
References: <1416495240-22821-1-git-send-email-Naidu.Tellapati@imgtec.com>
	<1416495240-22821-2-git-send-email-Naidu.Tellapati@imgtec.com>,<CAL1qeaE-QkyXtu30zEZgoA51L6oa8+=e5BewBQQ2+5XnfKOW1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:37871 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbaKUGOd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Nov 2014 01:14:33 -0500
In-Reply-To: <CAL1qeaE-QkyXtu30zEZgoA51L6oa8+=e5BewBQQ2+5XnfKOW1Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andrew Bresticker <abrestic@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, James Hartley <James.Hartley@imgtec.com>, Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Arul Ramasamy <Arul.Ramasamy@imgtec.com>, Sai Masarapu <Sai.Masarapu@imgtec.com>, Phani Movva <Phani.Movva@imgtec.com>

Hi Andrew,

Many thanks for the review.

> On Thu, Nov 20, 2014 at 6:53 AM,  <Naidu.Tellapati@imgtec.com> wrote:
>> From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>>
>> The Pistachio SOC from Imagination Technologies includes a Pulse Width
>> Modulation DAC which produces 1 to 4 digital bit-outputs which represent
>> digital waveforms. These PWM outputs are primarily in charge of controlling
>> backlight LED devices.
>>
>> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>> Signed-off-by: Sai Masarapu <Sai.Masarapu@imgtec.com>

>> diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
>> new file mode 100644
>> index 0000000..ed71148
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-img.c
v> @@ -0,0 +1,284 @@
>> +/*
>> + * Imagination Technologies Pulse Width Modulator driver
>> + *
>> + * Copyright (c) 2014, Imagination Technologies
>> + *
>> + * Based on drivers/pwm/pwm-tegra.c, Copyright (c) 2010, NVIDIA Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *

> Comment block should end on this line.

OK. Will address this in the new Patch set.

>> + */

> Put a newline here.

OK. Will address this in the new Patch set.

>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +
>> +/* PWM registers */
>> +#define CR_PWM_CTRL_CFG                                0x0000
v> +#define CR_PWM_CTRL_CFG_NO_SUB_DIV             0
>> +#define CR_PWM_CTRL_CFG_SUB_DIV0               1
>> +#define CR_PWM_CTRL_CFG_SUB_DIV1               2
>> +#define CR_PWM_CTRL_CFG_SUB_DIV0_DIV1          3
>> +#define CR_PWM_CTRL_CFG_DIV_SHIFT(ch)          ((ch) * 2 + 4)
>> +#define CR_PWM_CTRL_CFG_DIV_MASK               0x3
>> +
>> +#define CR_PWM_CH_CFG(ch)                      (0x4 + (ch) * 4)
>> +#define CR_PWM_CH_CFG_TMBASE_SHIFT             0
>> +#define CR_PWM_CH_CFG_DUTY_SHIFT               16
>> +
>> +#define CR_PERIP_PWM_PDM_CONTROL               0x0140
>> +#define CR_PERIP_PWM_PDM_CONTROL_CH_MASK       0x1
>> +#define CR_PERIP_PWM_PDM_CONTROL_CH_SHIFT(ch)  ((ch) * 4)
>> +
>> +#define IMG_NUM_PWM                            4
>> +#define MAX_TMBASE_STEPS                       65536
>> +
>> +struct img_pwm_chip {
>> +       struct device   *dev;
>> +       struct pwm_chip chip;
>> +       struct clk      *pwm_clk;
>> +       struct clk      *sys_clk;
>> +       void __iomem    *base;
>> +       struct regmap   *periph_regs;
>> +};
>> +
>> +static inline struct img_pwm_chip *to_img_pwm_chip(struct pwm_chip *chip)
>> +{
>> +       return container_of(chip, struct img_pwm_chip, chip);
>> +}
>> +
>> +static inline void img_pwm_writel(struct img_pwm_chip *chip,
>> +                                 unsigned int reg, unsigned long val)
>> +{
>> +       writel(val, chip->base + reg);
>> +}
>> +
>> +static inline unsigned int img_pwm_readl(struct img_pwm_chip *chip,
>> +                                        unsigned int reg)
>> +{
>> +       return readl(chip->base + reg);
>> +}
>> +
>> +static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>> +                         int duty_ns, int period_ns)
>> +{
>> +       unsigned int div;
>> +       unsigned int divider;
>> +       unsigned int duty_steps;
>> +       unsigned int tmbase_steps;
>> +       unsigned long val;
>> +       unsigned long mul;
>> +       unsigned long output_clk_hz;
>> +       unsigned long input_clk_hz;
>> +

> No need for a newline here.

OK. Will address this in the new Patch set.

>> +       struct img_pwm_chip *pwm_chip;
>> +
>> +       pwm_chip = to_img_pwm_chip(chip);
>> +
>> +       input_clk_hz = clk_get_rate(pwm_chip->pwm_clk);
>> +       output_clk_hz = DIV_ROUND_UP(NSEC_PER_SEC, period_ns);
>> +
>> +       mul = DIV_ROUND_UP(input_clk_hz, output_clk_hz);
>> +       if (mul > MAX_TMBASE_STEPS * 512) {
>> +               dev_err(chip->dev,
>> +                       "failed to configure timebase steps/divider value.\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (mul <= MAX_TMBASE_STEPS)
>> +               divider = 1;
>> +       else if (mul <= MAX_TMBASE_STEPS * 8)
>> +               divider = 8;
>> +       else if (mul <= MAX_TMBASE_STEPS * 64)
>> +               divider = 64;
>> +       else if (mul <= MAX_TMBASE_STEPS * 512)
>> +               divider = 512;
>> +
>> +       tmbase_steps = DIV_ROUND_UP(mul, divider);
>> +

> ... or here.

OK. Will address this in the new Patch set.

>> +       duty_steps = DIV_ROUND_UP(tmbase_steps * duty_ns, period_ns);
>> +
>> +       switch (divider) {
>> +       case 1:
>> +               div = CR_PWM_CTRL_CFG_NO_SUB_DIV;
>> +               break;
>> +       case 8:
>> +               div = CR_PWM_CTRL_CFG_SUB_DIV0;
>> +               break;
>> +       case 64:
>> +               div = CR_PWM_CTRL_CFG_SUB_DIV1;
>> +               break;
>> +       case 512:
>> +               div = CR_PWM_CTRL_CFG_SUB_DIV0_DIV1;
>> +               break;
>> +       }

> I think the above if/else chain and switch statement can be combined
> into a single block.  Something like:

Ok. Will address this in the new Patch set.

> if (mul <= MAX_TMBASE_STEPS) {
>        div = CR_PWM_CTRL_CFG_NO_SUB_DIV;
>        tmbase_steps = mul;
> } else if (mul <= MAX_TMBASE_STEPS * 8) {
>        div = CR_PWM_CTRL_CFG_SUB_DIV0;
>        tmbase_steps = DIV_ROUND_UP(mul, 8);
> } else if ...


Regards,
Naidu.