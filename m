From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Subject: Re: [PATCH v5 1/5] pwm: add the Berlin pwm controller driver
Date: Mon, 7 Sep 2015 16:28:06 -0300
Message-ID: <55EDE546.9080804@vanguardiasur.com.ar>
References: <1440576450-17420-1-git-send-email-antoine.tenart@free-electrons.com>
 <1440576450-17420-2-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35877 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbbIGT2M (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Sep 2015 15:28:12 -0400
Received: by qgx61 with SMTP id 61so67454918qgx.3
        for <linux-pwm@vger.kernel.org>; Mon, 07 Sep 2015 12:28:11 -0700 (PDT)
In-Reply-To: <1440576450-17420-2-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Antoine Tenart <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, thierry.reding@gmail.com
Cc: zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Antoine,

Just one observation below.

El 26/08/15 a las 05:07, Antoine Tenart escribi=F3:
> Add a PWM controller driver for the Marvell Berlin SoCs. This PWM
> controller has 4 channels.
>=20
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
>  drivers/pwm/Kconfig      |   9 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-berlin.c | 227 +++++++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 237 insertions(+)
>  create mode 100644 drivers/pwm/pwm-berlin.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index b1541f40fd8d..1773da8145b8 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -92,6 +92,15 @@ config PWM_BCM2835
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-bcm2835.
> =20
> +config PWM_BERLIN
> +	tristate "Berlin PWM support"
> +	depends on ARCH_BERLIN
> +	help
> +	  PWM framework driver for Berlin.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-berlin.
> +
>  config PWM_BFIN
>  	tristate "Blackfin PWM support"
>  	depends on BFIN_GPTIMERS
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index ec50eb5b5a8f..670c5fce8bbb 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+=3D pwm-atmel-hlcd=
c.o
>  obj-$(CONFIG_PWM_ATMEL_TCB)	+=3D pwm-atmel-tcb.o
>  obj-$(CONFIG_PWM_BCM_KONA)	+=3D pwm-bcm-kona.o
>  obj-$(CONFIG_PWM_BCM2835)	+=3D pwm-bcm2835.o
> +obj-$(CONFIG_PWM_BERLIN)	+=3D pwm-berlin.o
>  obj-$(CONFIG_PWM_BFIN)		+=3D pwm-bfin.o
>  obj-$(CONFIG_PWM_CLPS711X)	+=3D pwm-clps711x.o
>  obj-$(CONFIG_PWM_EP93XX)	+=3D pwm-ep93xx.o
> diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
> new file mode 100644
> index 000000000000..3a373fd72892
> --- /dev/null
> +++ b/drivers/pwm/pwm-berlin.c
> @@ -0,0 +1,227 @@
> +/*
> + * Marvell Berlin PWM driver
> + *
> + * Copyright (C) 2015 Marvell Technology Group Ltd.
> + *
> + * Antoine Tenart <antoine.tenart@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/spinlock.h>
> +
> +#define BERLIN_PWM_EN			0x0
> +#define BERLIN_PWM_CONTROL		0x4
> +#define BERLIN_PWM_DUTY			0x8
> +#define BERLIN_PWM_TCNT			0xc
> +
> +#define BERLIN_PWM_ENABLE		BIT(0)
> +#define BERLIN_PWM_INVERT_POLARITY	BIT(3)
> +#define BERLIN_PWM_PRESCALE_MASK	0x7
> +#define BERLIN_PWM_PRESCALE_MAX		4096
> +#define BERLIN_PWM_MAX_TCNT		65535
> +
> +struct berlin_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	void __iomem *base;
> +	spinlock_t lock;
> +};
> +
> +#define to_berlin_pwm_chip(chip)	\
> +	container_of((chip), struct berlin_pwm_chip, chip)
> +
> +#define berlin_pwm_readl(chip, channel, offset)		\
> +	readl_relaxed((chip)->base + (channel) * 0x10 + offset)
> +#define berlin_pwm_writel(val, chip, channel, offset)	\
> +	writel_relaxed(val, (chip)->base + (channel) * 0x10 + offset)
> +
> +/* prescaler table: {1, 4, 8, 16, 64, 256, 1024, 4096} */
> +static const u32 prescaler_diff_table[] =3D {
> +	1, 4, 2, 2, 4, 4, 4, 4,
> +};
> +
> +static int berlin_pwm_config(struct pwm_chip *chip, struct pwm_devic=
e *pwm_dev,
> +			     int duty_ns, int period_ns)
> +{
> +	struct berlin_pwm_chip *pwm =3D to_berlin_pwm_chip(chip);
> +	int prescale =3D 0;
> +	u32 val, duty, period;
> +	u64 cycles;
> +
> +	cycles =3D clk_get_rate(pwm->clk);
> +	cycles *=3D period_ns;
> +	do_div(cycles, NSEC_PER_SEC);
> +
> +	while (cycles > BERLIN_PWM_MAX_TCNT)
> +		do_div(cycles, prescaler_diff_table[++prescale]);
> +
> +	if (cycles > BERLIN_PWM_MAX_TCNT)
> +		return -EINVAL;
> +
> +	period =3D cycles;
> +	cycles *=3D duty_ns;
> +	do_div(cycles, period_ns);
> +	duty =3D cycles;
> +
> +	spin_lock(&pwm->lock);
> +
> +	val =3D berlin_pwm_readl(pwm, pwm_dev->hwpwm, BERLIN_PWM_CONTROL);
> +	val &=3D ~BERLIN_PWM_PRESCALE_MASK;
> +	val |=3D prescale;
> +	berlin_pwm_writel(val, pwm, pwm_dev->hwpwm, BERLIN_PWM_CONTROL);
> +
> +	berlin_pwm_writel(duty, pwm, pwm_dev->hwpwm, BERLIN_PWM_DUTY);
> +	berlin_pwm_writel(period, pwm, pwm_dev->hwpwm, BERLIN_PWM_TCNT);
> +
> +	spin_unlock(&pwm->lock);
> +
> +	return 0;
> +}
> +
> +static int berlin_pwm_set_polarity(struct pwm_chip *chip,
> +				   struct pwm_device *pwm_dev,
> +				   enum pwm_polarity polarity)
> +{
> +	struct berlin_pwm_chip *pwm =3D to_berlin_pwm_chip(chip);
> +	u32 val;
> +
> +	spin_lock(&pwm->lock);
> +
> +	val =3D berlin_pwm_readl(pwm, pwm_dev->hwpwm, BERLIN_PWM_CONTROL);
> +
> +	if (polarity =3D=3D PWM_POLARITY_NORMAL)
> +		val &=3D ~BERLIN_PWM_INVERT_POLARITY;
> +	else
> +		val |=3D BERLIN_PWM_INVERT_POLARITY;
> +
> +	berlin_pwm_writel(val, pwm, pwm_dev->hwpwm, BERLIN_PWM_CONTROL);
> +
> +	spin_unlock(&pwm->lock);
> +
> +	return 0;
> +}
> +
> +static int berlin_pwm_enable(struct pwm_chip *chip, struct pwm_devic=
e *pwm_dev)
> +{
> +	struct berlin_pwm_chip *pwm =3D to_berlin_pwm_chip(chip);
> +	u32 val;
> +
> +	spin_lock(&pwm->lock);
> +
> +	val =3D berlin_pwm_readl(pwm, pwm_dev->hwpwm, BERLIN_PWM_EN);
> +	val |=3D BERLIN_PWM_ENABLE;
> +	berlin_pwm_writel(val, pwm, pwm_dev->hwpwm, BERLIN_PWM_EN);
> +
> +	spin_unlock(&pwm->lock);
> +
> +	return 0;
> +}
> +
> +static void berlin_pwm_disable(struct pwm_chip *chip,
> +			       struct pwm_device *pwm_dev)
> +{
> +	struct berlin_pwm_chip *pwm =3D to_berlin_pwm_chip(chip);
> +	u32 val;
> +
> +	spin_lock(&pwm->lock);
> +
> +	val =3D berlin_pwm_readl(pwm, pwm_dev->hwpwm, BERLIN_PWM_EN);
> +	val &=3D ~BERLIN_PWM_ENABLE;
> +	berlin_pwm_writel(val, pwm, pwm_dev->hwpwm, BERLIN_PWM_EN);
> +
> +	spin_unlock(&pwm->lock);
> +}
> +
> +static const struct pwm_ops berlin_pwm_ops =3D {
> +	.config =3D berlin_pwm_config,
> +	.set_polarity =3D berlin_pwm_set_polarity,
> +	.enable =3D berlin_pwm_enable,
> +	.disable =3D berlin_pwm_disable,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static const struct of_device_id berlin_pwm_match[] =3D {
> +	{ .compatible =3D "marvell,berlin-pwm" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, berlin_pwm_match);
> +
> +static int berlin_pwm_probe(struct platform_device *pdev)
> +{
> +	struct berlin_pwm_chip *pwm;
> +	struct resource *res;
> +	int ret;
> +
> +	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pwm->base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(pwm->base))
> +		return PTR_ERR(pwm->base);
> +
> +	pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(pwm->clk))
> +		return PTR_ERR(pwm->clk);
> +
> +	ret =3D clk_prepare_enable(pwm->clk);
> +	if (ret)
> +		return ret;
> +
> +	pwm->chip.dev =3D &pdev->dev;
> +	pwm->chip.ops =3D &berlin_pwm_ops;
> +	pwm->chip.base =3D -1;
> +	pwm->chip.npwm =3D 4;
> +	pwm->chip.can_sleep =3D true;
> +	pwm->chip.of_xlate =3D of_pwm_xlate_with_flags;
> +	pwm->chip.of_pwm_n_cells =3D 3;
> +
> +	spin_lock_init(&pwm->lock);
> +
> +	ret =3D pwmchip_add(&pwm->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to add PWM chip: %d\n", ret);
> +		return ret;

I think you're missing some cleanup routine here. You have a previous
call to clk_prepare_enable(), so you may have a call to
clk_disable_unprepare() here in order to exit cleanly, don't you think?

> +	}
> +
> +	platform_set_drvdata(pdev, pwm);
> +
> +	return 0;
> +}
> +
> +static int berlin_pwm_remove(struct platform_device *pdev)
> +{
> +	struct berlin_pwm_chip *pwm =3D platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret =3D pwmchip_remove(&pwm->chip);
> +	if (ret)
> +		return ret;
> +
> +	clk_disable_unprepare(pwm->clk);
> +	return 0;
> +}
> +
> +static struct platform_driver berlin_pwm_driver =3D {
> +	.probe	=3D berlin_pwm_probe,
> +	.remove	=3D berlin_pwm_remove,
> +	.driver	=3D {
> +		.name	=3D "berlin-pwm",
> +		.of_match_table =3D berlin_pwm_match,
> +	},
> +};
> +module_platform_driver(berlin_pwm_driver);
> +
> +MODULE_AUTHOR("Antoine Tenart <antoine.tenart@free-electrons.com>");
> +MODULE_DESCRIPTION("Marvell Berlin PWM driver");
> +MODULE_LICENSE("GPL v2");
>=20

--=20
Ariel D'Alessandro, VanguardiaSur
www.vanguardiasur.com.ar
