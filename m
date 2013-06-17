Return-Path: <thierry.reding@gmail.com>
Date: Mon, 17 Jun 2013 22:29:11 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 08/15] pwm: Add new pwm-samsung driver
Message-ID: <20130617202910.GB5265@mithrandir>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
 <1370467100-10820-9-git-send-email-tomasz.figa@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <1370467100-10820-9-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2013 at 11:18:13PM +0200, Tomasz Figa wrote:
> This patch introduces new Samsung PWM driver, which uses Samsung
> PWM/timer master driver to control shared parts of the hardware.
>=20
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Sorry for jumping in so late, I've been busy with other things lately.

> ---
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-samsung.c | 528 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 529 insertions(+)
>  create mode 100644 drivers/pwm/pwm-samsung.c
>=20
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 229a599..833c3ac 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_PWM_MXS)		+=3D pwm-mxs.o
>  obj-$(CONFIG_PWM_PUV3)		+=3D pwm-puv3.o
>  obj-$(CONFIG_PWM_PXA)		+=3D pwm-pxa.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung-legacy.o
> +obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SPEAR)		+=3D pwm-spear.o
>  obj-$(CONFIG_PWM_TEGRA)		+=3D pwm-tegra.o
>  obj-$(CONFIG_PWM_TIECAP)	+=3D pwm-tiecap.o
> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> new file mode 100644
> index 0000000..61bed3d
> --- /dev/null
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -0,0 +1,528 @@
> +/* drivers/pwm/pwm-samsung.c

Nit: this line can be dropped. It serves no purpose.

> + *
> + * Copyright (c) 2007 Ben Dooks
> + * Copyright (c) 2008 Simtec Electronics
> + *     Ben Dooks <ben@simtec.co.uk>, <ben-linux@fluff.org>
> + * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
> + *
> + * PWM driver for Samsung SoCs
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.
> +*/

Nit: the */ should align with the * above.

> +struct samsung_pwm_channel {
> +	unsigned long period_ns;
> +	unsigned long duty_ns;
> +	unsigned long tin_ns;
> +};
> +
> +struct samsung_pwm_chip {
> +	struct pwm_chip chip;
> +	struct samsung_pwm_variant variant;
> +	struct samsung_pwm_channel channels[SAMSUNG_PWM_NUM];

The new driver for Renesas did something similar, but I want to
discourage storing per-channel data within the chip structure.

The PWM framework provides a way to store this information along with
the PWM device (see pwm_{set,get}_chip_data()).

> +
> +	void __iomem *base;
> +	struct clk *base_clk;
> +	struct clk *tclk0;
> +	struct clk *tclk1;
> +};
> +#define to_samsung_pwm_chip(chip)	\
> +			container_of(chip, struct samsung_pwm_chip, chip)

Can you turn this into a static inline function please?

> +#ifndef CONFIG_CLKSRC_SAMSUNG_PWM
> +static DEFINE_SPINLOCK(samsung_pwm_lock);
> +#endif

Why is this lock global? Shouldn't it more correctly be part of
samsung_pwm_chip?

> +static void pwm_samsung_set_divisor(struct samsung_pwm_chip *pwm,
> +					unsigned int channel, u8 divisor)

Nit: please align arguments on subsequent lines with the first argument
of the first line. There's many more of these but I haven't mentioned
them all explicitly.

> +static inline int pwm_samsung_is_tdiv(struct samsung_pwm_chip *chip,

Any particular reason for making this inline?

> +static int pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +		int duty_ns, int period_ns)
> +{
> +	struct samsung_pwm_chip *our_chip =3D to_samsung_pwm_chip(chip);
> +	struct samsung_pwm_channel *chan =3D &our_chip->channels[pwm->hwpwm];
> +	unsigned long tin_ns =3D chan->tin_ns;
> +	unsigned int tcon_chan =3D pwm->hwpwm;
> +	unsigned long tin_rate;
> +	unsigned long period;
> +	unsigned long flags;
> +	unsigned long tcnt;

Many of these unsigned long variable could be declared on a single line
to make the function shorter.

> +	long tcmp;
> +	u32 tcon;
> +
> +	/* We currently avoid using 64bit arithmetic by using the
> +	 * fact that anything faster than 1Hz is easily representable
> +	 * by 32bits. */

Can you turn these into proper block-style comments? Like so:

	/*
	 * We currently...
	 * ...
	 * by 32 bits.
	 */

> +	if (period_ns > NSEC_PER_SEC || duty_ns > NSEC_PER_SEC)
> +		return -ERANGE;

Note that technically you only need to check period_ns because the core
already ensures that duty_ns <=3D period_ns.

> +static int pwm_samsung_set_polarity(struct pwm_chip *chip,
> +			struct pwm_device *pwm, enum pwm_polarity polarity)
> +{
> +	struct samsung_pwm_chip *our_chip =3D to_samsung_pwm_chip(chip);
> +	unsigned int channel =3D pwm->hwpwm;
> +	unsigned long flags;
> +	u32 tcon;
> +
> +	if (channel > 0)
> +		++channel;

You have to repeat that in quite a few places, so I wonder if it'd make
sense to wrap it into a function and add a comment about why the
increment is necessary.

> +static struct pwm_ops pwm_samsung_ops =3D {

"static const" please.

> +#ifdef CONFIG_OF
> +static const struct samsung_pwm_variant s3c24xx_variant =3D {
> +	.bits		=3D 16,
> +	.div_base	=3D 1,
> +	.has_tint_cstat	=3D false,
> +	.tclk_mask	=3D (1 << 4),
> +};
> +
> +static const struct samsung_pwm_variant s3c64xx_variant =3D {
> +	.bits		=3D 32,
> +	.div_base	=3D 0,
> +	.has_tint_cstat	=3D true,
> +	.tclk_mask	=3D (1 << 7) | (1 << 6) | (1 << 5),
> +};
> +
> +static const struct samsung_pwm_variant s5p64x0_variant =3D {
> +	.bits		=3D 32,
> +	.div_base	=3D 0,
> +	.has_tint_cstat	=3D true,
> +	.tclk_mask	=3D 0,
> +};
> +
> +static const struct samsung_pwm_variant s5p_variant =3D {
> +	.bits		=3D 32,
> +	.div_base	=3D 0,
> +	.has_tint_cstat	=3D true,
> +	.tclk_mask	=3D (1 << 5),
> +};
> +
> +static const struct of_device_id samsung_pwm_matches[] =3D {
> +	{ .compatible =3D "samsung,s3c2410-pwm", .data =3D &s3c24xx_variant },
> +	{ .compatible =3D "samsung,s3c6400-pwm", .data =3D &s3c64xx_variant },
> +	{ .compatible =3D "samsung,s5p6440-pwm", .data =3D &s5p64x0_variant },
> +	{ .compatible =3D "samsung,s5pc100-pwm", .data =3D &s5p_variant },
> +	{ .compatible =3D "samsung,exynos4210-pwm", .data =3D &s5p64x0_variant =
},
> +	{},
> +};
> +#endif
> +
> +static int pwm_samsung_parse_dt(struct samsung_pwm_chip *chip)
> +{
> +	struct device_node *np =3D chip->chip.dev->of_node;
> +	const struct of_device_id *match;
> +	struct property *prop;
> +	const __be32 *cur;
> +	u32 val;
> +
> +	match =3D of_match_node(samsung_pwm_matches, np);
> +	if (!match)
> +		return -ENODEV;
> +
> +	memcpy(&chip->variant, match->data, sizeof(chip->variant));
> +
> +	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, val) {
> +		if (val >=3D SAMSUNG_PWM_NUM) {
> +			pr_warning("%s: invalid channel index in samsung,pwm-outputs property=
\n",
> +								__func__);
> +			continue;
> +		}
> +		chip->variant.output_mask |=3D 1 << val;

Could the output_mask be moved to the struct samsung_pwm_chip instead?
The reason I ask is because it would allow you to make the variant
constant throughout the driver.

> +static int pwm_samsung_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct samsung_pwm_chip *chip;
> +	struct resource *res;
> +	int ret;
> +
> +	chip =3D devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +	if (chip =3D=3D NULL) {
> +		dev_err(dev, "failed to allocate driver data\n");
> +		return -ENOMEM;
> +	}
> +
> +	chip->chip.dev =3D &pdev->dev;
> +	chip->chip.ops =3D &pwm_samsung_ops;
> +	chip->chip.base =3D -1;
> +	chip->chip.npwm =3D SAMSUNG_PWM_NUM;
> +
> +	if (pdev->dev.of_node) {

Maybe add an IS_ENABLED(CONFIG_OF) check here? That'd allow all OF-
related code to be thrown away if OF isn't selected.

> +		ret =3D pwm_samsung_parse_dt(chip);
> +		if (ret)
> +			return ret;
> +
> +		chip->chip.of_xlate =3D of_pwm_xlate_with_flags;
> +		chip->chip.of_pwm_n_cells =3D 3;
> +	} else {
> +		if (!pdev->dev.platform_data) {
> +			dev_err(&pdev->dev, "no platform data specified\n");
> +			return -EINVAL;
> +		}
> +
> +		memcpy(&chip->variant, pdev->dev.platform_data,
> +							sizeof(chip->variant));
> +	}

Obviously this needs some modification in order for the variant to
become constant. But I think you can easily do so by making the driver
match using the platform_driver's id_table field, similar to how the
matching is done for OF.

> +	chip->base =3D devm_request_and_ioremap(&pdev->dev, res);
> +	if (!chip->base) {
> +		dev_err(&pdev->dev, "failed to request and map registers\n");
> +		return -ENOMEM;
> +	}

devm_request_and_ioremap() is now deprecated and in the process of being
removed. You should use devm_ioremap_resource() instead.

> +
> +	chip->base_clk =3D devm_clk_get(&pdev->dev, "timers");
> +	if (IS_ERR(chip->base_clk)) {
> +		dev_err(dev, "failed to get timer base clk\n");
> +		return PTR_ERR(chip->base_clk);
> +	}
> +	clk_prepare_enable(chip->base_clk);

You need to check the return value of clk_prepare_enable(). And if I was
very pedantic, there should be a blank line before this one.

> +	ret =3D pwmchip_add(&chip->chip);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register pwm\n");

"failed to register PWM chip" please.

> +		goto err_clk_disable;
> +	}
> +
> +	dev_info(dev, "base_clk at %lu, tclk0 at %lu, tclk1 at %lu\n",
> +		clk_get_rate(chip->base_clk),
> +		!IS_ERR(chip->tclk0) ? clk_get_rate(chip->tclk0) : 0,
> +		!IS_ERR(chip->tclk1) ? clk_get_rate(chip->tclk1) : 0);
> +
> +	platform_set_drvdata(pdev, chip);
> +
> +	return 0;
> +
> +err_clk_disable:
> +	clk_disable_unprepare(chip->base_clk);
> +
> +	return ret;

There's only a single case where this can actually happen, so I don't
think you need the label here. Just put the clk_disable_unprepare() call
and the return statement where you jump to the label.

> +#ifdef CONFIG_PM

I think this should really be CONFIG_PM_SLEEP.

> +static struct dev_pm_ops pwm_samsung_pm_ops =3D {

"static const" please.

Thierry

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRv3GWAAoJEN0jrNd/PrOhWxAP/iTNJNVcklB1vxrz+nsd6c6/
w1YX60HfoyTCYT4+jNav4IRujITfiHO1LeVQ9eZn3XAKWgwRFdypN+TlolvQC07w
stI2ob2BIcNPyU1u8LB1V/jB0Q4rCIM4ITOrRwLYcgh3Ucm8TmzH8KVcC9AKB3sJ
G6wlP9fT8fl4sN1mKagMBFei7TVF+zxRHsQWiUC6ijTTu6i4eeZYTH7Lo+8OVvEd
1L/qerpVv8xv/83WSsrK7OZ8wbR0KPfhxoOYkUWqwND1ijO9X36wFRMqXcVcQ3/M
iIa9+Rmr9KunMyW5teTHG38rsB1E+VFpIMQIUqcaMZxkWASvsNbfSwkMj5Gg0O1P
2R/kphLq6mVCVR1rS25BWnoAHAiGHMP782aI3JpqQxChScECw737Aic9eICnNF3H
RiC2AahOM6qJMjViFyBR6WTnUO8mCJBlC58Xnee6Myg9c2ZUUsVThAkFqzX3J0eh
78BYXyFhtBTQBRdep9UyVZiBOIQMHu5Am5A3kyELypqzJWJvMlMPZSE9NYpRDWfW
SboyZnIVM25Pbw+v5B4oRYonS+oWAjS8ms7+wRR0mFaChlsrcCZ0pJTvyzED+7Tn
e+UIBISKfsCaC5CfMWDlVoQqv9O0jx2n4Rqio1Te5Q1Sjhr8VjBgHAYt5oEmd70x
A44uPpa4wXwRXO3i0PKM
=mRCm
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
