From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] pwm: add Mediatek display PWM driver support
Date: Tue, 12 May 2015 15:32:04 +0200
Message-ID: <20150512133202.GA24684@ulmo.nvidia.com>
References: <1431336382-13167-1-git-send-email-yh.huang@mediatek.com>
 <1431336382-13167-3-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36831 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932579AbbELNcJ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 12 May 2015 09:32:09 -0400
Content-Disposition: inline
In-Reply-To: <1431336382-13167-3-git-send-email-yh.huang@mediatek.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2015 at 05:26:22PM +0800, YH Huang wrote:
> Add display PWM driver support to modify backlight for MT8173/MT6595.
>=20
> Signed-off-by: YH Huang <yh.huang@mediatek.com>
> ---
>  drivers/pwm/Kconfig             |   9 ++
>  drivers/pwm/Makefile            |   1 +
>  drivers/pwm/pwm-disp-mediatek.c | 225 ++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 235 insertions(+)
>  create mode 100644 drivers/pwm/pwm-disp-mediatek.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index b1541f4..9edbb5a 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -111,6 +111,15 @@ config PWM_CLPS711X
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-clps711x.
> =20
> +config PWM_DISP_MEDIATEK

Please make this "PWM_MEDIATEK_DISP" so we can keep everything sorted by
vendor.

> +	tristate "MEDIATEK display PWM driver"

"MediaTek"?

> +	depends on OF

Technically I think you need depends on HAS_IOMEM here to avoid breakage
on randconfig builds.

> +	help
> +	  Generic PWM framework driver for mediatek disp-pwm device.

"MediaTek"? Also perhaps this should describe what this PWM is instead
of just the "disp-pwm" which leaves everyone guessing what it is. From
the name I'd expect it to be the PWM that is used to control the
backlight brightness for display, but I think this description should
say that explicitly.

> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-disp-mediatek.

pwm-mediatek-disp

> +
>  config PWM_EP93XX
>  	tristate "Cirrus Logic EP93xx PWM support"
>  	depends on ARCH_EP93XX
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index ec50eb5..c5ff72a 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_PWM_BCM_KONA)	+=3D pwm-bcm-kona.o
>  obj-$(CONFIG_PWM_BCM2835)	+=3D pwm-bcm2835.o
>  obj-$(CONFIG_PWM_BFIN)		+=3D pwm-bfin.o
>  obj-$(CONFIG_PWM_CLPS711X)	+=3D pwm-clps711x.o
> +obj-$(CONFIG_PWM_DISP_MEDIATEK)	+=3D pwm-disp-mediatek.o

Also name this "pwm-mediatek-disp.o" to reflect the Kconfig name.

>  obj-$(CONFIG_PWM_EP93XX)	+=3D pwm-ep93xx.o
>  obj-$(CONFIG_PWM_FSL_FTM)	+=3D pwm-fsl-ftm.o
>  obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
> diff --git a/drivers/pwm/pwm-disp-mediatek.c b/drivers/pwm/pwm-disp-media=
tek.c
> new file mode 100644
> index 0000000..38293af
> --- /dev/null
> +++ b/drivers/pwm/pwm-disp-mediatek.c
> @@ -0,0 +1,225 @@
> +/*
> + * Mediatek display pulse-width-modulation controller driver.
> + * Copyright (c) 2015 MediaTek Inc.
> + * Author: YH Huang <yh.huang@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pwm.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define DISP_PWM_EN_OFF			(0x0)

The _OFF suffix here is unfortunate because I'm reading this as being
the "OFF" value for a field named "DISP_PWM_EN". I think it'd be better
to name this one DISP_PWM_EN. The same goes for any of the following
registers.

Also, drop the parentheses if the expression is simple.

> +#define PWM_ENABLE_SHIFT		(0x0)
> +#define PWM_ENABLE_MASK			(0x1 << PWM_ENABLE_SHIFT)
> +
> +#define DISP_PWM_COMMIT_OFF		(0x08)
> +#define PWM_COMMIT_SHIFT		(0x0)
> +#define PWM_COMMIT_MASK			(0x1 << PWM_COMMIT_SHIFT)
> +
> +#define DISP_PWM_CON_0_OFF		(0x10)
> +#define PWM_CLKDIV_SHIFT		(0x10)
> +#define PWM_CLKDIV_MASK			(0x3ff << PWM_CLKDIV_SHIFT)
> +#define PWM_CLKDIV_MAX			(0x000003ff)
> +
> +#define DISP_PWM_CON_1_OFF		(0x14)
> +#define PWM_PERIOD_SHIFT		(0x0)
> +#define PWM_PERIOD_MASK			(0xfff << PWM_PERIOD_SHIFT)
> +#define PWM_PERIOD_MAX			(0x00000fff)
> +/* Shift log2(PWM_PERIOD_MAX + 1) as divisor */
> +#define PWM_PERIOD_BIT_SHIFT		12

This is confusing, see below.

> +
> +#define PWM_HIGH_WIDTH_SHIFT		(0x10)
> +#define PWM_HIGH_WIDTH_MASK		(0x1fff << PWM_HIGH_WIDTH_SHIFT)
> +
> +#define NUM_PWM 1

You can drop this, it's only used once.

> +
> +struct mtk_disp_pwm_chip {
> +	struct pwm_chip	chip;
> +	struct device	*dev;
> +	struct clk	*clk_main;
> +	struct clk	*clk_mm;
> +	void __iomem	*mmio_base;
> +};

Please don't add this artificial padding, a single space is enough as a
separator. Also, I think you can drop the _chip suffix on the structure
name.

> +
> +static void mtk_disp_pwm_setting(void __iomem *address, u32 value, u32 m=
ask)

This is a bad name. I think you should adopt the naming of regmap, which
this effectively copies, so this should be:

	static void mtk_disp_pwm_update_bits(void __iomem *address, u32 mask, u32 =
value)

> +static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       int duty_ns, int period_ns)
> +{
> +	struct mtk_disp_pwm_chip *mpc;
> +	u64 div, rate;
> +	u32 clk_div, period, high_width, rem;
> +
> +	/*
> +	 * Find period, high_width and clk_div to suit duty_ns and period_ns.
> +	 * Calculate proper div value to keep period value in the bound.
> +	 *
> +	 * period_ns =3D 10^9 * (clk_div + 1) * (period +1) / PWM_CLK_RATE
> +	 * duty_ns =3D 10^9 * (clk_div + 1) * (high_width + 1) / PWM_CLK_RATE
> +	 *
> +	 * period =3D (PWM_CLK_RATE * period_ns) / (10^9 * (clk_div + 1)) - 1
> +	 * high_width =3D (PWM_CLK_RATE * duty_ns) / (10^9 * (clk_div + 1)) - 1
> +	 */
> +	mpc =3D container_of(chip, struct mtk_disp_pwm_chip, chip);

Can you add a static inline function to wrap the container_of()
invocation? You need to do this quite often and the wrapper will shorten
the code significantly:

	static inline struct mtk_disp_pwm *to_mtk_disp_pwm(struct pwm_chip *chip)
	{
		return container_of(chip, struct mtk_disp_pwm, chip);
	}

Also it's slightly more canonical to initialize the mpc variable as part
of the declaration.

> +	rate =3D clk_get_rate(mpc->clk_main);
> +	clk_div =3D div_u64_rem(rate * period_ns, NSEC_PER_SEC, &rem) >>
> +				PWM_PERIOD_BIT_SHIFT;
> +	if (clk_div > PWM_CLKDIV_MAX)
> +		return -EINVAL;
> +
> +	div =3D clk_div + 1;
> +	period =3D div64_u64(rate * period_ns, NSEC_PER_SEC * div);
> +	if (period > 0)
> +		period--;
> +	high_width =3D div64_u64(rate * duty_ns, NSEC_PER_SEC * div);
> +	if (high_width > 0)
> +		high_width--;
> +
> +	mtk_disp_pwm_setting(mpc->mmio_base + DISP_PWM_CON_0_OFF,
> +			     clk_div << PWM_CLKDIV_SHIFT, PWM_CLKDIV_MASK);
> +	mtk_disp_pwm_setting(mpc->mmio_base + DISP_PWM_CON_1_OFF,
> +			     (period << PWM_PERIOD_SHIFT) |
> +			(high_width << PWM_HIGH_WIDTH_SHIFT),
> +			PWM_PERIOD_MASK | PWM_HIGH_WIDTH_MASK);

Can you align these differently to make it more readable?

	mtk_display_pwm_update_bits(mpc->mmio_base + DISP_PWM_CON_1,
				    PWM_PERIOD_MASK | PWM_HIGH_WIDTH_MASK,
				    (period << PWM_PERIOD_SHIFT) |
					(high_width << PWM_HIGH_WIDTH_SHIFT));

Or perhaps split it into multiple steps to make it even more readable:

	value =3D (high_width << PWM_HIGH_WIDTH_SHIFT) |
		(period << PWM_PERIOD_SHIFT);
	mtk_display_pwm_update_bits(mpc->mmio_base + DISP_PWM_CON_1,
				    PWM_HIGH_WIDTH_MASK | PWM_PERIOD_MASK,
				    value);

> +static int mtk_disp_pwm_probe(struct platform_device *pdev)
> +{
> +	struct mtk_disp_pwm_chip *pwm;
> +	struct resource *r;
> +	int ret;
> +
> +	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	pwm->dev =3D &pdev->dev;
> +
> +	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pwm->mmio_base =3D devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(pwm->mmio_base))
> +		return PTR_ERR(pwm->mmio_base);
> +
> +	pwm->clk_main =3D devm_clk_get(&pdev->dev, "main");
> +	if (IS_ERR(pwm->clk_main))
> +		return PTR_ERR(pwm->clk_main);
> +	pwm->clk_mm =3D devm_clk_get(&pdev->dev, "mm");

I think it's more readable if a blank line separates the above two
lines.

> +	if (IS_ERR(pwm->clk_mm))
> +		return PTR_ERR(pwm->clk_mm);
> +
> +	ret =3D clk_prepare_enable(pwm->clk_main);
> +	if (ret < 0)
> +		return ret;
> +	ret =3D clk_prepare_enable(pwm->clk_mm);

Same here.

> +	if (ret < 0) {
> +		clk_disable_unprepare(pwm->clk_main);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, pwm);
> +
> +	pwm->chip.dev =3D &pdev->dev;
> +	pwm->chip.ops =3D &mtk_disp_pwm_ops;
> +	pwm->chip.base =3D -1;
> +	pwm->chip.npwm =3D NUM_PWM;
> +
> +	ret =3D pwmchip_add(&pwm->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);

Shouldn't you disable the clocks here?

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_disp_pwm_remove(struct platform_device *pdev)
> +{
> +	struct mtk_disp_pwm_chip *pc =3D platform_get_drvdata(pdev);
> +
> +	if (WARN_ON(!pc))
> +		return -ENODEV;

You can drop this. Better to let it crash so that you have to fix it if
you ever encounter it.

> +
> +	clk_disable_unprepare(pc->clk_main);
> +	clk_disable_unprepare(pc->clk_mm);
> +
> +	return pwmchip_remove(&pc->chip);
> +}
> +
> +static const struct of_device_id mtk_disp_pwm_of_match[] =3D {
> +	{ .compatible =3D "mediatek,mt6595-disp-pwm" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, mtk_disp_pwm_of_match);

No blank line between the above two lines.

> +
> +static struct platform_driver mtk_disp_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "mediatek-disp-pwm",
> +		.owner =3D THIS_MODULE,
> +		.of_match_table =3D mtk_disp_pwm_of_match,
> +	},
> +	.probe =3D mtk_disp_pwm_probe,
> +	.remove =3D mtk_disp_pwm_remove,
> +};
> +
> +module_platform_driver(mtk_disp_pwm_driver);

Same here. Also, no need to initialize .driver.owner,
module_platform_driver() does that for you.

Thierry

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVUgDPAAoJEN0jrNd/PrOhqg8P/2aaxdxkTpY19GRr+f2ojRx4
ccdJPaakxme9UJx7394zuLl4ehcXU1V8a8ktUPJ5QSiasH8He06mPferOPZbbECw
HgrD9hUJDkHC9JswzxNF/xiya2rSH+lG3UHsPy42ALNNkWIgRNqgepvZ2gGTH2Lm
4ovUHrYZkbgN901pqhGTns5aDT/IrZ4BYNk+CrAP/LEJgDO183yg9OdjK3K+1s+w
gIljDBD6so85O5DbIWTEh+KP4PMmRSHUisuRg/9oZD0pVD899gMHWjlgD+uC5OLT
ktjpQzD5vQpThc7CAM3J73K2T/6Flk1b8wetImkS41ygyFKs4i6wq9Wmyybab/Uq
+fwKn9dj2XsCR3VjWxPvMcNsEUlGfp03zwD3op3RL8jGPHcQNJn4SbCKQtgAdO7e
lku7u3Wk8F/Mg2PqNwoCKfKN/jdiScuToVUBKiNbOzoFWd4QQmbDM4nPNOS4CrYa
kU6lLQbJh7IPBTbBaDL84jkF/U0zkh3JQU1wzut/nur4kK1P+Ohl71NDw9kGrGWi
sxQ1DVWDgbjHN/ZXVQVmjKP08F8cOeCs2fFOCiilXGZBiF6o+5b/7WiiyXXcmgbz
lc1403JEnkNw1ii4Rx7je0847fxK9zin4nCPY0h2jSJgbNiIU1qA4qJhnCcYYlhw
fWYa5/dRPIm06Rjo8PIi
=/3uf
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
