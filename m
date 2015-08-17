From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v6 2/3] pwm: add MediaTek display PWM driver support
Date: Mon, 17 Aug 2015 15:23:00 +0200
Message-ID: <20150817132259.GM8453@ulmo.nvidia.com>
References: <1437380237-28961-1-git-send-email-yh.huang@mediatek.com>
 <1437380237-28961-3-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nrXiCraHbXeog9mY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437380237-28961-3-git-send-email-yh.huang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com
List-Id: linux-pwm@vger.kernel.org


--nrXiCraHbXeog9mY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2015 at 04:17:16PM +0800, YH Huang wrote:
> Add display PWM driver support to modify backlight for MT8173 and MT6595.
> The PWM has one channel to control the brightness of the display.
> When the (high_width / period) is closer to 1, the screen is brighter;
> otherwise, it is darker.
>=20
> Signed-off-by: YH Huang <yh.huang@mediatek.com>
> ---
>  drivers/pwm/Kconfig        |  10 ++
>  drivers/pwm/Makefile       |   1 +
>  drivers/pwm/pwm-mtk-disp.c | 232 +++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 243 insertions(+)
>  create mode 100644 drivers/pwm/pwm-mtk-disp.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index b1541f4..f5b03a4 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -211,6 +211,16 @@ config PWM_LPSS_PLATFORM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-lpss-platform.
> =20
> +config PWM_MTK_DISP
> +	tristate "MediaTek display PWM driver"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST

This is going to break randconfig builds. From a quick look your driver
will fail to build at least on architectures that don't set HAVE_IOMEM.
I know that's quite exotic, but I've had to deal with fallout from
things like this in the past. If you want || COMPILE_TEST you should at
least add a "depends on HAVE_IOMEM".

linux/clk.h seems to have stubs for all of the functions that you use,
so those shouldn't be a problem.

> +	help
> +	  Generic PWM framework driver for MediaTek disp-pwm device.
> +	  The PWM is used to control the backlight brightness for display.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-mtk-disp.
> +
>  config PWM_MXS
>  	tristate "Freescale MXS PWM support"
>  	depends on ARCH_MXS && OF
[...]
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> new file mode 100644
> index 0000000..69682a0
> --- /dev/null
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -0,0 +1,232 @@
> +/*
> + * MediaTek display pulse-width-modulation controller driver.
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

The above two aren't correctly sorted.

> +#include <linux/slab.h>
> +
> +#define DISP_PWM_EN		0x00
> +#define PWM_ENABLE_MASK		BIT(0)
> +
> +#define DISP_PWM_COMMIT		0x08
> +#define PWM_COMMIT_MASK		BIT(0)
> +
> +#define DISP_PWM_CON_0		0x10
> +#define PWM_CLKDIV_SHIFT	16
> +#define PWM_CLKDIV_MAX		0x3ff
> +#define PWM_CLKDIV_MASK		(PWM_CLKDIV_MAX << PWM_CLKDIV_SHIFT)
> +
> +#define DISP_PWM_CON_1		0x14
> +#define PWM_PERIOD_MASK		0xfff
> +/* Shift log2(PWM_PERIOD_MASK + 1) as divisor */
> +#define PWM_PERIOD_BIT_SHIFT	12

There are still two names for the same value here. I thought we had
agreed on this becoming something like the below?

	#define PWM_PERIOD_BIT_SHIFT 12
	#define PWM_PERIOD_MASK ((1 << PWM_PERIOD_BIT_SHIFT) - 1)

Although PWM_PERIOD_BIT_WIDTH would probably be a better name. Or
PWM_PERIOD_BITS or similar.

> +static int mtk_disp_pwm_remove(struct platform_device *pdev)
> +{
> +	struct mtk_disp_pwm *mdp =3D platform_get_drvdata(pdev);
> +	int ret =3D pwmchip_remove(&mdp->chip);

I'd prefer this to be separate lines:

	int ret;

	ret =3D pwmchip_remove(&mdp->chip);

Thierry

--nrXiCraHbXeog9mY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV0eAwAAoJEN0jrNd/PrOhyL0P/REAzOpYLmhyH7rvc4ZQg7uw
DKqlPtictW4j6KE9u2H1RBhbbvbD8OcNxH1Jl6hODkT/9bsfot97IGdtIxQ5NOuh
ptAjY232SMRQOom71Svc0OCwOedqUyvd2rgotDMk2ZrMQNVHySZWU9bwrSwjLRg3
kRC1IWMGnpHYE5r97PEozAPFJBkw1edQmK84PISMT4A9+bJqaRVuyOf1sNH4dt/L
RnvsILntNCD0UP37KYoEzA+U7sAAs4rUKGNiyHPV1LS75HNCWxoDEIkSh7blvAsD
fmelS0rloeBgSUyc4OMs2uCc3+Yar5nZ/wpgs/2CUC20MyQ7CcU+vPe9g7hLwQy1
Pri3PEsTq84/xfz1eyentqBecQx8473JSLOnBnL7G8XjSngGyWgN6iQdGOP6QpXW
5qwvQQyQAna9by6ZiHoNH1eIZnjpJpRoa4+jF0aZAn8F/lsAtQrjsE3jJzcWOFIo
a7uOxSXdgV+y9gsu1cGO769s7ZyAPlDCu2ZSW/gLxebFMMferIw78qXRwLXBWCYs
BIR2e6OGnvTJnOAEzr9XQw1acuwL9TE7eC8Nc3KtMqbh0z4BBOfcNffMHhTXjP7M
zSOpBfltIk/dmxeY+7Ckvuw2Kddn1IlEhkfv6mH+wr1+MZu0aWfTH29vHnEp5jAv
6rF+1jVA3pShgNCvpI1A
=KEnB
-----END PGP SIGNATURE-----

--nrXiCraHbXeog9mY--
