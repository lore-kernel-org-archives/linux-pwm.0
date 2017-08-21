From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 2/2] pwm: add ZTE ZX PWM device driver
Date: Mon, 21 Aug 2017 08:03:52 +0200
Message-ID: <20170821060352.GC18996@ulmo>
References: <1501143817-15843-1-git-send-email-shawnguo@kernel.org>
 <1501143817-15843-3-git-send-email-shawnguo@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33376 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbdHUGD4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Aug 2017 02:03:56 -0400
Received: by mail-wr0-f196.google.com with SMTP id 30so3640947wrk.0
        for <linux-pwm@vger.kernel.org>; Sun, 20 Aug 2017 23:03:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1501143817-15843-3-git-send-email-shawnguo@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Baoyou Xie <xie.baoyou@sanechips.com.cn>, Xin Zhou <zhou.xin8@sanechips.com.cn>, Jun Nie <jun.nie@linaro.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2017 at 04:23:37PM +0800, Shawn Guo wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
>=20
> It adds PWM device driver for ZTE ZX family SoCs.  The PWM controller
> supports 4 devices with polarity configuration.
>=20
> The driver has been tested with pwm-regulator support to scale core
> voltage via cpufreq.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/pwm/Kconfig  |   9 ++
>  drivers/pwm/Makefile |   1 +
>  drivers/pwm/pwm-zx.c | 270 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 280 insertions(+)
>  create mode 100644 drivers/pwm/pwm-zx.c

I've applied this, with some bikeshedding applied. See below for the
changes I made.

I should say, though, that this is pretty much perfect and the below
changes are just because I'm having an extra nit-picky day.

> diff --git a/drivers/pwm/pwm-zx.c b/drivers/pwm/pwm-zx.c
> new file mode 100644
> index 000000000000..39d5e6bf0510
> --- /dev/null
> +++ b/drivers/pwm/pwm-zx.c
> @@ -0,0 +1,270 @@
> +/*
> + * Copyright (C) 2017 Sanechips Technology Co., Ltd.
> + * Copyright 2017 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +
> +#define ZX_PWM_MODE		0x0
> +#define ZX_PWM_CLKDIV_SHIFT	2
> +#define ZX_PWM_CLKDIV_MASK	GENMASK(11, 2)
> +#define ZX_PWM_CLKDIV(x)	(((x) << ZX_PWM_CLKDIV_SHIFT) & \
> +					 ZX_PWM_CLKDIV_MASK)
> +#define ZX_PWM_POLAR		BIT(1)
> +#define ZX_PWM_EN		BIT(0)
> +#define ZX_PWM_PERIOD		0x4
> +#define ZX_PWM_DUTY		0x8
> +
> +#define ZX_PWM_NUM		4
> +#define ZX_PWM_CLKDIV_MAX	1023
> +#define ZX_PWM_PERIOD_MAX	65535
> +
> +struct zx_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *pclk;
> +	struct clk *wclk;
> +	void __iomem *base;
> +};
> +
> +static inline struct zx_pwm_chip *to_zx_pwm_chip(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct zx_pwm_chip, chip);
> +}
> +
> +static inline u32 zx_pwm_readl(struct zx_pwm_chip *zpc, unsigned int hwp=
wm,
> +			       unsigned int offset)
> +{
> +	return readl(zpc->base + (hwpwm + 1) * 0x10 + offset);
> +}
> +
> +static inline void zx_pwm_writel(struct zx_pwm_chip *zpc, unsigned int h=
wpwm,
> +				 unsigned int offset, u32 val)
> +{
> +	writel(val, zpc->base + (hwpwm + 1) * 0x10 + offset);
> +}
> +
> +static void zx_pwm_set_mask(struct zx_pwm_chip *zpc, unsigned int hwpwm,
> +			    unsigned int offset, u32 mask, u32 value)
> +{
> +	u32 data;
> +
> +	data =3D zx_pwm_readl(zpc, hwpwm, offset);
> +	data &=3D ~mask;
> +	data |=3D value & mask;
> +	zx_pwm_writel(zpc, hwpwm, offset, data);
> +}
> +
> +static void zx_pwm_get_state(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     struct pwm_state *state)
> +{
> +	struct zx_pwm_chip *zpc =3D to_zx_pwm_chip(chip);
> +	unsigned long rate;
> +	int div;

I made this unsigned because it can't ever be negative.

> +	u64 tmp;
> +	u32 val;
> +
> +	val =3D zx_pwm_readl(zpc, pwm->hwpwm, ZX_PWM_MODE);
> +	state->polarity =3D (val & ZX_PWM_POLAR) ? PWM_POLARITY_NORMAL :
> +						 PWM_POLARITY_INVERSED;
> +	state->enabled =3D (val & ZX_PWM_EN) ? true : false;

I turned the above into:

	if (...)
		state->... =3D ...;
	else
		state->... =3D ...;

because I think that makes it more readable.

> +
> +	div =3D (val & ZX_PWM_CLKDIV_MASK) >> ZX_PWM_CLKDIV_SHIFT;
> +	rate =3D clk_get_rate(zpc->wclk);
> +
> +	tmp =3D zx_pwm_readl(zpc, pwm->hwpwm, ZX_PWM_PERIOD);
> +	tmp *=3D div * NSEC_PER_SEC;
> +	state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, rate);
> +
> +	tmp =3D zx_pwm_readl(zpc, pwm->hwpwm, ZX_PWM_DUTY);
> +	tmp *=3D div * NSEC_PER_SEC;
> +	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, rate);
> +}
> +
> +static int zx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 unsigned int duty_ns, unsigned int period_ns)
> +{
> +	struct zx_pwm_chip *zpc =3D to_zx_pwm_chip(chip);
> +	unsigned int period_cycles;
> +	unsigned int duty_cycles;

Collapsed the above two lines.

> +	unsigned long long c;
> +	unsigned long rate;
> +	int div =3D 1;

Made this unsigned because, again, it can't ever be negative.

> +
> +	/* Find out the best divider */
> +	rate =3D clk_get_rate(zpc->wclk);
> +	while (1) {
> +		c =3D rate / div;
> +		c =3D c * period_ns;
> +		do_div(c, NSEC_PER_SEC);
> +		if (c < ZX_PWM_PERIOD_MAX)
> +			break;
> +		div++;
> +		if (div > ZX_PWM_CLKDIV_MAX)
> +			return -ERANGE;

Added some blank lines in the above for readability.

> +	}
> +
> +	/* Calculate duty cycles */
> +	period_cycles =3D c;
> +	c *=3D duty_ns;
> +	do_div(c, period_ns);
> +	duty_cycles =3D c;
> +
> +	/*
> +	 * If the pwm is being enabled, we have to temporarily disable it
> +	 * before configuring the registers.
> +	 */

pwm -> PWM in prose because it is an abbreviation.

> +	if (pwm_is_enabled(pwm))
> +		zx_pwm_set_mask(zpc, pwm->hwpwm, ZX_PWM_MODE, ZX_PWM_EN, 0);
> +
> +	/* Set up registers */
> +	zx_pwm_set_mask(zpc, pwm->hwpwm, ZX_PWM_MODE, ZX_PWM_CLKDIV_MASK,
> +			ZX_PWM_CLKDIV(div));
> +	zx_pwm_writel(zpc, pwm->hwpwm, ZX_PWM_PERIOD, period_cycles);
> +	zx_pwm_writel(zpc, pwm->hwpwm, ZX_PWM_DUTY, duty_cycles);
> +
> +	/* Re-enable the pwm if needed */

Ditto.

> +	if (pwm_is_enabled(pwm))
> +		zx_pwm_set_mask(zpc, pwm->hwpwm, ZX_PWM_MODE,
> +				ZX_PWM_EN, ZX_PWM_EN);
> +
> +	return 0;
> +}
> +
> +static int zx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			struct pwm_state *state)
> +{
> +	struct zx_pwm_chip *zpc =3D to_zx_pwm_chip(chip);
> +	struct pwm_state cstate;
> +	int ret;
> +
> +	pwm_get_state(pwm, &cstate);
> +
> +	if (state->polarity !=3D cstate.polarity)
> +		zx_pwm_set_mask(zpc, pwm->hwpwm, ZX_PWM_MODE, ZX_PWM_POLAR,
> +				(state->polarity =3D=3D PWM_POLARITY_INVERSED) ?
> +				 0 : ZX_PWM_POLAR);
> +
> +	if (state->period !=3D cstate.period ||
> +	    state->duty_cycle !=3D cstate.duty_cycle) {
> +		ret =3D zx_pwm_config(chip, pwm, state->duty_cycle,
> +				    state->period);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (state->enabled !=3D cstate.enabled) {
> +		if (state->enabled) {
> +			ret =3D clk_prepare_enable(zpc->wclk);
> +			if (ret)
> +				return ret;
> +			zx_pwm_set_mask(zpc, pwm->hwpwm, ZX_PWM_MODE,

Added a blank line between the above two for readability.

> +					ZX_PWM_EN, ZX_PWM_EN);
> +		} else {
> +			zx_pwm_set_mask(zpc, pwm->hwpwm, ZX_PWM_MODE,
> +					ZX_PWM_EN, 0);
> +			clk_disable_unprepare(zpc->wclk);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops zx_pwm_ops =3D {
> +	.apply =3D zx_pwm_apply,
> +	.get_state =3D zx_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int zx_pwm_probe(struct platform_device *pdev)
> +{
> +	struct zx_pwm_chip *zpc;
> +	struct resource *res;
> +	int ret;
> +	int i;

Made this unsigned.

> +
> +	zpc =3D devm_kzalloc(&pdev->dev, sizeof(*zpc), GFP_KERNEL);
> +	if (!zpc)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	zpc->base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(zpc->base))
> +		return PTR_ERR(zpc->base);
> +
> +	zpc->pclk =3D devm_clk_get(&pdev->dev, "pclk");
> +	if (IS_ERR(zpc->pclk))
> +		return PTR_ERR(zpc->pclk);
> +
> +	zpc->wclk =3D devm_clk_get(&pdev->dev, "wclk");
> +	if (IS_ERR(zpc->wclk))
> +		return PTR_ERR(zpc->wclk);
> +
> +	ret =3D clk_prepare_enable(zpc->pclk);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * PWM devices may be enabled by firmware, and let's disable all of
> +	 * them initially to save power.
> +	 */
> +	for (i =3D 0; i < ZX_PWM_NUM; i++)
> +		zx_pwm_set_mask(zpc, i, ZX_PWM_MODE, ZX_PWM_EN, 0);
> +
> +	zpc->chip.dev =3D &pdev->dev;
> +	zpc->chip.ops =3D &zx_pwm_ops;
> +	zpc->chip.base =3D -1;
> +	zpc->chip.npwm =3D ZX_PWM_NUM;
> +	zpc->chip.of_xlate =3D of_pwm_xlate_with_flags;
> +	zpc->chip.of_pwm_n_cells =3D 3;

I moved the initialization loop below here, then removed ZX_PWM_NUM and
hard-coded it to 4, then made the loop use zpc->chip.npwm.

The reason why I did that is to make it clearer that you should use the
available variables wherever possible and avoid macros if you don't have
to use them. This way we set the parameter (npwm) in a single place and
use the parameter, rather than the value in all other places. This also
avoids the macro becoming the parameter, because the macro may become
invalid at a later point (let's say on a new generation of the chip with
a different number of PWM channels).

> +	ret =3D pwmchip_add(&zpc->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to add pwm chip %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, zpc);
> +
> +	return 0;
> +}
> +
> +static int zx_pwm_remove(struct platform_device *pdev)
> +{
> +	struct zx_pwm_chip *zpc =3D platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(zpc->pclk);
> +
> +	return pwmchip_remove(&zpc->chip);
> +}

I've changed this to:

	ret =3D pwmchip_remove(&zpc->chip);
	clk_disable_unprepare(zpc->pclk);

	return ret

just in case we ever end up touching registers during pwmchip_remove(),
at which point pclk might need to be kept running until after it
finishes.

Like I said, all in all great work. Applied to for-4.14/drivers.

Thanks,
Thierry

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmad8YACgkQ3SOs138+
s6Gx5hAAstlhwffvYKBC5sQjorfWYK7FDc3ZwouoxnpxWDwCNC4nJyO3YCARdULD
xCGfIU3/CmRj0qvcf/+TF+a43N322BweP2eKl+5FqattGjHub0k95uIKDvNh3A0m
/FtPs4dZXr/nS9tIMydhq7M33VByHuuD0HGACyJ5lzmqhYyakHjVKIZrgRlXY9J5
+rUHs8A36szuaPZVZIocUGl4RKZCPIvpif7mbxrt5rWU2sfUhIyvzRQCAKGU1YrX
I7PQrZgx8QRkxRZrVH15ejkp203eA0kTNU7oQuiqP7JbZydoVpsb0dzA46Urhdd0
NcYNQLem7yqpxgGiXnIfZHTC/fe5R+CfRCmUpE/MJaJMv27xoLLxANwsLQSH4KlC
dLYOzPoQCt0hnWrAy3FYXDwDt9cMijmugd4EzteYhK4GtSWPv3DZ9BhesdpS0+3z
lmYkUsdT1nHN5bIo/zHgG/ng+8//2VlyNQGvQRQCRspLAboxXMSZ8iyrwiJMoghN
EVGrKK+TGX2kLQyZu2U+1q1Z5XKMAPk7sihjhAPo27dmT48FxltF0dOlu9HfElQq
vk5+icVrese30QO0EXPm17m8nazbwF8AN8arxaWuKhthNgqJDoK7kJUbYGeIE9OZ
mhTzSuXzgL1MPjgdKXmWxpzT+k/mnJ5Kp+cUi3b3HQ1PCf1pfZc=
=070L
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
