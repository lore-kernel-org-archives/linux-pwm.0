From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Subject: Re: [PATCH v3 2/2] pwm: Add Broadcom BCM7038 PWM controller support
Date: Mon, 7 Sep 2015 16:15:27 -0300
Message-ID: <55EDE24F.7020402@vanguardiasur.com.ar>
References: <1440811309-1289-1-git-send-email-f.fainelli@gmail.com>
 <1440811309-1289-3-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440811309-1289-3-git-send-email-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, thierry.reding@gmail.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Florian,

I wrote some observations below that maybe can be useful.

El 28/08/15 a las 22:21, Florian Fainelli escribi=F3:
> Add support for the BCM7038-style PWM controller found in all BCM7xxx=
 STB SoCs.
> This controller has a hardcoded 2 channels per controller, and cascad=
es a
> variable frequency generator on top of a fixed frequency generator wh=
ich offers
> a range of a 148ns period all the way to ~622ms periods.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v3:
>=20
> - make clock mandatory
> - removed a remaining div64_u64 use
>=20
> hanges in v2:
>=20
> - properly format comments
> - utilize do_div instead of div64_u64
> - avoid using a "done" variable for the while loop
> - utilize a parameterized register accessor
> - remove a bunch of unnecessary assignments
> - provide a module author
> - update depends to build on BMIPS_GENERIC (the other user)
> - removed artificial padding
> - removed used only once variable: dn
> - utilize devm_ioremap_resource
> - do not print success message
> - removed THIS_MODULE from platform_driver structure
>=20
>  drivers/pwm/Kconfig       |  10 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-brcmstb.c | 324 ++++++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 335 insertions(+)
>  create mode 100644 drivers/pwm/pwm-brcmstb.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index b1541f40fd8d..363c22b22071 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -111,6 +111,16 @@ config PWM_CLPS711X
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-clps711x.
> =20
> +config PWM_BRCMSTB
> +	tristate "Broadcom STB PWM support"
> +	depends on ARCH_BRCMSTB || BMIPS_GENERIC
> +	help
> +	  Generic PWM framework driver for the Broadcom Set-top-Box
> +	  SoCs (BCM7xxx).
> +
> +	  To compile this driver as a module, choose M Here: the module
> +	  will be called pwm-brcmstb.c.
> +
>  config PWM_EP93XX
>  	tristate "Cirrus Logic EP93xx PWM support"
>  	depends on ARCH_EP93XX
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index ec50eb5b5a8f..dc7b1b82d47e 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_PWM_ATMEL_TCB)	+=3D pwm-atmel-tcb.o
>  obj-$(CONFIG_PWM_BCM_KONA)	+=3D pwm-bcm-kona.o
>  obj-$(CONFIG_PWM_BCM2835)	+=3D pwm-bcm2835.o
>  obj-$(CONFIG_PWM_BFIN)		+=3D pwm-bfin.o
> +obj-$(CONFIG_PWM_BRCMSTB)	+=3D pwm-brcmstb.o
>  obj-$(CONFIG_PWM_CLPS711X)	+=3D pwm-clps711x.o
>  obj-$(CONFIG_PWM_EP93XX)	+=3D pwm-ep93xx.o
>  obj-$(CONFIG_PWM_FSL_FTM)	+=3D pwm-fsl-ftm.o
> diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
> new file mode 100644
> index 000000000000..9ea73755f281
> --- /dev/null
> +++ b/drivers/pwm/pwm-brcmstb.c
> @@ -0,0 +1,324 @@
> +/*
> + * Broadcom BCM7038 PWM driver
> + * Author: Florian Fainelli
> + *
> + * Copyright (C) 2015 Broadcom Corporation
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
> +
> +#include <linux/clk.h>
> +#include <linux/export.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +#define PWM_CTRL		0x00
> +#define  CTRL_START		BIT(0)
> +#define  CTRL_OEB		BIT(1)
> +#define  CTRL_FORCE_HIGH	BIT(2)
> +#define  CTRL_OPENDRAIN		BIT(3)
> +#define  CTRL_CHAN_OFFS		4
> +
> +#define PWM_CTRL2		0x04
> +#define  CTRL2_OUT_SELECT	BIT(0)
> +
> +#define PWM_CWORD_MSB		0x08
> +#define PWM_CWORD_LSB		0x0C
> +
> +#define PWM_CH_SIZE		0x8
> +
> +/* Number of bits for the CWORD value */
> +#define CWORD_BIT_SIZE		16
> +
> +/*
> + * Maximum control word value allowed when variable-frequency PWM is=
 used as a
> + * clock for the constant-frequency PMW.
> + */
> +#define CONST_VAR_F_MAX		32768
> +#define CONST_VAR_F_MIN		1
> +
> +#define PWM_ON(ch)		(0x18 + ((ch) * PWM_CH_SIZE))
> +#define  PWM_ON_MIN		1
> +#define PWM_PERIOD(ch)		(0x1C + ((ch) * PWM_CH_SIZE))
> +#define  PWM_PERIOD_MIN		0
> +
> +#define PWM_ON_PERIOD_MAX	0xff
> +
> +struct brcmstb_pwm_dev {
> +	void __iomem *base;
> +	struct clk *clk;
> +	struct pwm_chip chip;
> +};
> +
> +static inline u32 pwm_readl(struct brcmstb_pwm_dev *p, u32 off)

The function name 'pwm_readl' sounds to be very common. It might be
better to use a prefix here, don't you think? Maybe brcmstb_pwm_readl?

> +{
> +	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> +		return __raw_readl(p->base + off);
> +	else
> +		return readl_relaxed(p->base + off);
> +}
> +
> +static inline void pwm_writel(struct brcmstb_pwm_dev *p, u32 val, u3=
2 off)

Same as before here.

> +{
> +	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> +		__raw_writel(val, p->base + off);
> +	else
> +		writel_relaxed(val, p->base + off);
> +}
> +
> +static inline struct brcmstb_pwm_dev *to_brcmstb_pwm(struct pwm_chip=
 *ch)
> +{
> +	return container_of(ch, struct brcmstb_pwm_dev, chip);
> +}
> +
> +/*
> + * Fv is derived from the variable frequency output. The variable fr=
equency
> + * output is configured using this formula:
> + *
> + * W =3D cword, if cword < 2 ^ 15 else 16-bit 2's complement of cwor=
d
> + *
> + * Fv =3D W x 2 ^ -16 x 27Mhz (reference clock)
> + *
> + * The period is: (period + 1) / Fv and "on" time is on / (period + =
1)
> + *
> + * The PWM core framework specifies that the "duty_ns" parameter is =
in fact the
> + * "on" time, so this translates directly into our HW programming he=
re.
> + */
> +static int brcmstb_pwm_config(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> +			      int duty_ns, int period_ns)
> +{
> +	struct brcmstb_pwm_dev *b =3D to_brcmstb_pwm(chip);
> +	unsigned long pc, dc, cword =3D CONST_VAR_F_MAX;
> +	unsigned int ch =3D pwm->hwpwm;
> +	u64 val, rate;
> +	u32 reg;
> +
> +	/*
> +	 * If asking for a duty_ns equal to period_ns, we need to substract
> +	 * the period value by 1 to make it shorter than the "on" time and
> +	 * produce a flat 100% duty cycle signal, and max out the "on" time
> +	 */
> +	if (duty_ns =3D=3D period_ns) {
> +		dc =3D PWM_ON_PERIOD_MAX;
> +		pc =3D PWM_ON_PERIOD_MAX - 1;
> +		goto done;
> +	}
> +
> +	while (1) {
> +		/*
> +		 * Calculate the base rate from base frequency and current
> +		 * cword
> +		 */
> +		rate =3D (u64)clk_get_rate(b->clk) * (u64)cword;
> +		do_div(rate, 1 << CWORD_BIT_SIZE);
> +
> +		val =3D period_ns * rate;
> +		do_div(val, NSEC_PER_SEC);
> +		pc =3D val;
> +
> +		val =3D (duty_ns + 1) * rate;
> +		do_div(val, NSEC_PER_SEC);
> +		dc =3D val;
> +
> +		/*
> +		 * We can be called with separate duty and period updates,
> +		 * so do not reject dc =3D=3D 0 right away
> +		 */
> +		if (pc =3D=3D PWM_PERIOD_MIN ||
> +		   (dc < PWM_ON_MIN && duty_ns))

No break needed here, this expression can be written on a single line
increasing readability.

> +			return -EINVAL;
> +
> +		/* We converged on a calculation */
> +		if (pc <=3D PWM_ON_PERIOD_MAX && dc <=3D PWM_ON_PERIOD_MAX)
> +			break;
> +
> +		/*
> +		 * The cword needs to be a power of 2 for the variable
> +		 * frequency generator to output a 50% duty cycle variable
> +		 * frequency which is used as input clock to the fixed
> +		 * frequency generator.
> +		 */
> +		cword >>=3D 1;
> +
> +		/*
> +		 * Desired periods are too large, we do not have a divider
> +		 * for them
> +		 */
> +		if (cword < CONST_VAR_F_MIN)
> +			return -EINVAL;
> +	}
> +
> +done:
> +	/*
> +	 * Configure the defined "cword" value to have the variable frequen=
cy
> +	 * generator output a base frequency for the constant frequency
> +	 * generator to derive from.
> +	 */
> +	pwm_writel(b, cword >> 8, PWM_CWORD_MSB + ch * PWM_CH_SIZE);
> +	pwm_writel(b, cword & 0xff, PWM_CWORD_LSB + ch * PWM_CH_SIZE);
> +
> +	/* Select constant frequency signal output */
> +	reg =3D pwm_readl(b, PWM_CTRL2);
> +	reg |=3D (CTRL2_OUT_SELECT << (ch * CTRL_CHAN_OFFS));

A nitpick here, outer parenthesis can be avoided.

> +	pwm_writel(b, reg, PWM_CTRL2);

This read-modify-write sequence may be protected by some locking
mechanism. Notice that, as written in the docs: "PWM core does not
enforce any locking to pwm_enable(), pwm_disable() and pwm_config()".

> +
> +	/* Configure on and period value */
> +	pwm_writel(b, pc, PWM_PERIOD(ch));
> +	pwm_writel(b, dc, PWM_ON(ch));
> +
> +	return 0;
> +}
> +
> +static inline void brcmstb_pwm_enable_set(struct brcmstb_pwm_dev *b,
> +					  unsigned int ch, bool enable)
> +{
> +	unsigned int ofs =3D ch * CTRL_CHAN_OFFS;
> +	u32 reg;
> +
> +	reg =3D pwm_readl(b, PWM_CTRL);
> +	if (enable) {
> +		reg &=3D ~(CTRL_OEB << ofs);
> +		reg |=3D ((CTRL_START | CTRL_OPENDRAIN) << ofs);

Nit, outer parenthesis can be avoided.

> +	} else {
> +		reg &=3D ~((CTRL_START | CTRL_OPENDRAIN) << ofs);
> +		reg |=3D (CTRL_OEB << ofs);

Also here.

> +	}
> +	pwm_writel(b, reg, PWM_CTRL);

Again, R-M-W sequence may be protected by some locking mechanism.

> +}
> +
> +static int brcmstb_pwm_enable(struct pwm_chip *chip, struct pwm_devi=
ce *pwm)
> +{
> +	struct brcmstb_pwm_dev *b =3D to_brcmstb_pwm(chip);
> +
> +	brcmstb_pwm_enable_set(b, pwm->hwpwm, true);
> +
> +	return 0;
> +}
> +
> +static void brcmstb_pwm_disable(struct pwm_chip *chip, struct pwm_de=
vice *pwm)
> +{
> +	struct brcmstb_pwm_dev *b =3D to_brcmstb_pwm(chip);
> +
> +	brcmstb_pwm_enable_set(b, pwm->hwpwm, false);
> +}
> +
> +static const struct pwm_ops brcmstb_pwm_ops =3D {
> +	.config	=3D brcmstb_pwm_config,
> +	.enable	=3D brcmstb_pwm_enable,
> +	.disable =3D brcmstb_pwm_disable,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static const struct of_device_id brcmstb_pwm_of_match[] =3D {
> +	{ .compatible =3D "brcm,bcm7038-pwm", },
> +	{ /* sentinel */ }
> +};
> +
> +static int brcmstb_pwm_probe(struct platform_device *pdev)
> +{
> +	struct brcmstb_pwm_dev *p;
> +	struct resource *r;
> +	int ret;
> +
> +	p =3D devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
> +	if (!p)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Try to grab the clock and its rate, if not available, default
> +	 * to the base 27Mhz clock domain this block comes from.
> +	 */
> +	p->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(p->clk)) {
> +		dev_err(&pdev->dev, "failed to obtain clock\n");
> +		return PTR_ERR(p->clk);
> +	}
> +
> +	clk_prepare_enable(p->clk);
> +
> +	platform_set_drvdata(pdev, p);
> +
> +	p->chip.dev =3D &pdev->dev;
> +	p->chip.ops =3D &brcmstb_pwm_ops;
> +	/* Dynamically assign a PWM base */
> +	p->chip.base =3D -1;
> +	/* Static number of PWM channels for this controller */
> +	p->chip.npwm =3D 2;
> +	p->chip.can_sleep =3D true;
> +
> +	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	p->base =3D devm_ioremap_resource(&pdev->dev, r);
> +	if (!p->base)
> +		return -ENOMEM;

I think you're missing some cleanup routine here. You have a previous
call to clk_prepare_enable(), so you may have a call to
clk_disable_unprepare() here in order to exit cleanly.

> +
> +	ret =3D pwmchip_add(&p->chip);
> +	if (ret)
> +		dev_err(&pdev->dev, "failed to add PWM chip %d\n", ret);

Cleanup needed here too.

> +
> +	return ret;
> +}
> +
> +static int brcmstb_pwm_remove(struct platform_device *pdev)
> +{
> +	struct brcmstb_pwm_dev *p =3D platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(p->clk);
> +
> +	return pwmchip_remove(&p->chip);

AFAIK, pwmchip_remove() may return busy if the PWM chip provides a PWM
device that is still requested, so you shouldn't disable the clock
before you ensure the PWM chip has been successfuly removed.

It think you could do something like:

	ret =3D pwmchip_remove(&p->chip);
	if (ret)
		return ret;

	clk_disable_unprepare(p->clk);
	return 0;

> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int brcmstb_pwm_suspend(struct device *d)
> +{
> +	struct platform_device *pdev =3D to_platform_device(d);
> +	struct brcmstb_pwm_dev *p =3D platform_get_drvdata(pdev);
> +
> +	clk_disable(p->clk);
> +
> +	return 0;
> +}
> +
> +static int brcmstb_pwm_resume(struct device *d)
> +{
> +	struct platform_device *pdev =3D to_platform_device(d);
> +	struct brcmstb_pwm_dev *p =3D platform_get_drvdata(pdev);
> +
> +	clk_enable(p->clk);
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(brcmstb_pwm_pm_ops,
> +			 brcmstb_pwm_suspend, brcmstb_pwm_resume);
> +
> +static struct platform_driver brcmstb_pwm_driver =3D {
> +	.probe	=3D brcmstb_pwm_probe,
> +	.remove	=3D brcmstb_pwm_remove,
> +	.driver	=3D {
> +		.name =3D "pwm-brcmstb",
> +		.of_match_table =3D brcmstb_pwm_of_match,
> +		.pm =3D &brcmstb_pwm_pm_ops,
> +	},
> +};
> +module_platform_driver(brcmstb_pwm_driver);
> +
> +MODULE_AUTHOR("Florian Fainelli <f.fainelli@gmail.com>");
> +MODULE_DESCRIPTION("Broadcom STB PWM driver");
> +MODULE_ALIAS("platform:pwm-brcmstb");
> +MODULE_LICENSE("GPL");
>=20

--=20
Ariel D'Alessandro, VanguardiaSur
www.vanguardiasur.com.ar
