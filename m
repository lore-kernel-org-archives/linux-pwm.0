From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 1/2] mfd: add atmel-hlcdc driver
Date: Tue, 7 Oct 2014 10:44:27 +0100
Message-ID: <20141007094427.GW25331@lee--X1>
References: <1412603324-18789-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412603324-18789-2-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:50562 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbaJGJoe (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 05:44:34 -0400
Received: by mail-ie0-f181.google.com with SMTP id at20so5000550iec.12
        for <linux-pwm@vger.kernel.org>; Tue, 07 Oct 2014 02:44:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1412603324-18789-2-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org

On Mon, 06 Oct 2014, Boris Brezillon wrote:

> The HLCDC IP available on some Atmel SoCs (i.e. at91sam9n12, at91sam9=
x5
> family or sama5d3 family) exposes 2 subdevices:
> - a display controller (controlled by a DRM driver)
> - a PWM chip
>=20
> The MFD device provides a regmap and several clocks (those connected
> to this hardware block) to its subdevices.
>=20
> This way concurrent accesses to the iomem range are handled by the re=
gmap
> framework, and each subdevice can safely access HLCDC registers.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Tested-by: Anthony Harivel <anthony.harivel@emtrion.de>
> Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  drivers/mfd/Kconfig             |   6 ++
>  drivers/mfd/Makefile            |   1 +
>  drivers/mfd/atmel-hlcdc.c       | 122 ++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/atmel-hlcdc.h |  85 ++++++++++++++++++++++++++++
>  4 files changed, 214 insertions(+)
>  create mode 100644 drivers/mfd/atmel-hlcdc.c
>  create mode 100644 include/linux/mfd/atmel-hlcdc.h

Applied for v3.19.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index de5abf2..1b925f7 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -59,6 +59,12 @@ config MFD_AAT2870_CORE
>  	  additional drivers must be enabled in order to use the
>  	  functionality of the device.
> =20
> +config MFD_ATMEL_HLCDC
> +	tristate
> +	select MFD_CORE
> +	select REGMAP_MMIO
> +	depends on OF
> +
>  config MFD_BCM590XX
>  	tristate "Broadcom BCM590xx PMUs"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index f001487..df36f68 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -156,6 +156,7 @@ obj-$(CONFIG_MFD_PM8921_CORE) 	+=3D pm8921-core.o=
 ssbi.o
>  obj-$(CONFIG_TPS65911_COMPARATOR)	+=3D tps65911-comparator.o
>  obj-$(CONFIG_MFD_TPS65090)	+=3D tps65090.o
>  obj-$(CONFIG_MFD_AAT2870_CORE)	+=3D aat2870-core.o
> +obj-$(CONFIG_MFD_ATMEL_HLCDC)	+=3D atmel-hlcdc.o
>  obj-$(CONFIG_MFD_INTEL_MSIC)	+=3D intel_msic.o
>  obj-$(CONFIG_MFD_PALMAS)	+=3D palmas.o
>  obj-$(CONFIG_MFD_VIPERBOARD)    +=3D viperboard.o
> diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
> new file mode 100644
> index 0000000..cfd58f4
> --- /dev/null
> +++ b/drivers/mfd/atmel-hlcdc.c
> @@ -0,0 +1,122 @@
> +/*
> + * Copyright (C) 2014 Free Electrons
> + * Copyright (C) 2014 Atmel
> + *
> + * Author: Boris BREZILLON <boris.brezillon@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License version 2 as pu=
blished by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Lic=
ense for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License=
 along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/mfd/atmel-hlcdc.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define ATMEL_HLCDC_REG_MAX		(0x4000 - 0x4)
> +
> +static const struct mfd_cell atmel_hlcdc_cells[] =3D {
> +	{
> +		.name =3D "atmel-hlcdc-pwm",
> +		.of_compatible =3D "atmel,hlcdc-pwm",
> +	},
> +	{
> +		.name =3D "atmel-hlcdc-dc",
> +		.of_compatible =3D "atmel,hlcdc-display-controller",
> +	},
> +};
> +
> +static const struct regmap_config atmel_hlcdc_regmap_config =3D {
> +	.reg_bits =3D 32,
> +	.val_bits =3D 32,
> +	.reg_stride =3D 4,
> +	.max_register =3D ATMEL_HLCDC_REG_MAX,
> +};
> +
> +static int atmel_hlcdc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct atmel_hlcdc *hlcdc;
> +	struct resource *res;
> +	void __iomem *regs;
> +
> +	hlcdc =3D devm_kzalloc(dev, sizeof(*hlcdc), GFP_KERNEL);
> +	if (!hlcdc)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	regs =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	hlcdc->irq =3D platform_get_irq(pdev, 0);
> +	if (hlcdc->irq < 0)
> +		return hlcdc->irq;
> +
> +	hlcdc->periph_clk =3D devm_clk_get(dev, "periph_clk");
> +	if (IS_ERR(hlcdc->periph_clk)) {
> +		dev_err(dev, "failed to get peripheral clock\n");
> +		return PTR_ERR(hlcdc->periph_clk);
> +	}
> +
> +	hlcdc->sys_clk =3D devm_clk_get(dev, "sys_clk");
> +	if (IS_ERR(hlcdc->sys_clk)) {
> +		dev_err(dev, "failed to get system clock\n");
> +		return PTR_ERR(hlcdc->sys_clk);
> +	}
> +
> +	hlcdc->slow_clk =3D devm_clk_get(dev, "slow_clk");
> +	if (IS_ERR(hlcdc->slow_clk)) {
> +		dev_err(dev, "failed to get slow clock\n");
> +		return PTR_ERR(hlcdc->slow_clk);
> +	}
> +
> +	hlcdc->regmap =3D devm_regmap_init_mmio(dev, regs,
> +					      &atmel_hlcdc_regmap_config);
> +	if (IS_ERR(hlcdc->regmap))
> +		return PTR_ERR(hlcdc->regmap);
> +
> +	dev_set_drvdata(dev, hlcdc);
> +
> +	return mfd_add_devices(dev, -1, atmel_hlcdc_cells,
> +			       ARRAY_SIZE(atmel_hlcdc_cells),
> +			       NULL, 0, NULL);
> +}
> +
> +static int atmel_hlcdc_remove(struct platform_device *pdev)
> +{
> +	mfd_remove_devices(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id atmel_hlcdc_match[] =3D {
> +	{ .compatible =3D "atmel,sama5d3-hlcdc" },
> +	{ /* sentinel */ },
> +};
> +
> +static struct platform_driver atmel_hlcdc_driver =3D {
> +	.probe =3D atmel_hlcdc_probe,
> +	.remove =3D atmel_hlcdc_remove,
> +	.driver =3D {
> +		.name =3D "atmel-hlcdc",
> +		.of_match_table =3D atmel_hlcdc_match,
> +	},
> +};
> +module_platform_driver(atmel_hlcdc_driver);
> +
> +MODULE_ALIAS("platform:atmel-hlcdc");
> +MODULE_AUTHOR("Boris Brezillon <boris.brezillon@free-electrons.com>"=
);
> +MODULE_DESCRIPTION("Atmel HLCDC driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/atmel-hlcdc.h b/include/linux/mfd/atme=
l-hlcdc.h
> new file mode 100644
> index 0000000..1279ab1
> --- /dev/null
> +++ b/include/linux/mfd/atmel-hlcdc.h
> @@ -0,0 +1,85 @@
> +/*
> + * Copyright (C) 2014 Free Electrons
> + * Copyright (C) 2014 Atmel
> + *
> + * Author: Boris BREZILLON <boris.brezillon@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License version 2 as pu=
blished by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Lic=
ense for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License=
 along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __LINUX_MFD_HLCDC_H
> +#define __LINUX_MFD_HLCDC_H
> +
> +#include <linux/clk.h>
> +#include <linux/regmap.h>
> +
> +#define ATMEL_HLCDC_CFG(i)		((i) * 0x4)
> +#define ATMEL_HLCDC_SIG_CFG		LCDCFG(5)
> +#define ATMEL_HLCDC_HSPOL		BIT(0)
> +#define ATMEL_HLCDC_VSPOL		BIT(1)
> +#define ATMEL_HLCDC_VSPDLYS		BIT(2)
> +#define ATMEL_HLCDC_VSPDLYE		BIT(3)
> +#define ATMEL_HLCDC_DISPPOL		BIT(4)
> +#define ATMEL_HLCDC_DITHER		BIT(6)
> +#define ATMEL_HLCDC_DISPDLY		BIT(7)
> +#define ATMEL_HLCDC_MODE_MASK		GENMASK(9, 8)
> +#define ATMEL_HLCDC_PP			BIT(10)
> +#define ATMEL_HLCDC_VSPSU		BIT(12)
> +#define ATMEL_HLCDC_VSPHO		BIT(13)
> +#define ATMEL_HLCDC_GUARDTIME_MASK	GENMASK(20, 16)
> +
> +#define ATMEL_HLCDC_EN			0x20
> +#define ATMEL_HLCDC_DIS			0x24
> +#define ATMEL_HLCDC_SR			0x28
> +#define ATMEL_HLCDC_IER			0x2c
> +#define ATMEL_HLCDC_IDR			0x30
> +#define ATMEL_HLCDC_IMR			0x34
> +#define ATMEL_HLCDC_ISR			0x38
> +
> +#define ATMEL_HLCDC_CLKPOL		BIT(0)
> +#define ATMEL_HLCDC_CLKSEL		BIT(2)
> +#define ATMEL_HLCDC_CLKPWMSEL		BIT(3)
> +#define ATMEL_HLCDC_CGDIS(i)		BIT(8 + (i))
> +#define ATMEL_HLCDC_CLKDIV_SHFT		16
> +#define ATMEL_HLCDC_CLKDIV_MASK		GENMASK(23, 16)
> +#define ATMEL_HLCDC_CLKDIV(div)		((div - 2) << ATMEL_HLCDC_CLKDIV_SH=
=46T)
> +
> +#define ATMEL_HLCDC_PIXEL_CLK		BIT(0)
> +#define ATMEL_HLCDC_SYNC		BIT(1)
> +#define ATMEL_HLCDC_DISP		BIT(2)
> +#define ATMEL_HLCDC_PWM			BIT(3)
> +#define ATMEL_HLCDC_SIP			BIT(4)
> +
> +#define ATMEL_HLCDC_SOF			BIT(0)
> +#define ATMEL_HLCDC_SYNCDIS		BIT(1)
> +#define ATMEL_HLCDC_FIFOERR		BIT(4)
> +#define ATMEL_HLCDC_LAYER_STATUS(x)	BIT((x) + 8)
> +
> +/**
> + * Structure shared by the MFD device and its subdevices.
> + *
> + * @regmap: register map used to access HLCDC IP registers
> + * @periph_clk: the hlcdc peripheral clock
> + * @sys_clk: the hlcdc system clock
> + * @slow_clk: the system slow clk
> + * @irq: the hlcdc irq
> + */
> +struct atmel_hlcdc {
> +	struct regmap *regmap;
> +	struct clk *periph_clk;
> +	struct clk *sys_clk;
> +	struct clk *slow_clk;
> +	int irq;
> +};
> +
> +#endif /* __LINUX_MFD_HLCDC_H */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
