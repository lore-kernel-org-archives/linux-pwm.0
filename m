From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: add pwm driver for HiSilicon BVT SOCs
Date: Wed, 24 Aug 2016 15:05:46 +0200
Message-ID: <20160824130546.GD3714@ulmo.ba.sec>
References: <1471852213-86777-1-git-send-email-yuanjian12@hisilicon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36598 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753148AbcHXNFw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 24 Aug 2016 09:05:52 -0400
Content-Disposition: inline
In-Reply-To: <1471852213-86777-1-git-send-email-yuanjian12@hisilicon.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jian Yuan <yuanjian12@hisilicon.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, xuejiancheng@hisilicon.com, kevin.lixu@hisilicon.com, jalen.hsu@hisilicon.com


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2016 at 03:50:13PM +0800, Jian Yuan wrote:
> From: yuanjian <yuanjian12@hisilicon.com>
>=20
> Add pwm driver for HiSilicon BVT SOCs

pwm -> PWM, please. It'd be good to have more information here about
what the hardware can do, where to find it, etc.

>=20
> Reviewed-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
> Signed-off-by: Jian Yuan <yuanjian12@hisilicon.com>
> ---
> Change Log:
> v2:
> The number of PWMs is change to be probeable based on the compatible stri=
ng.
>=20
>  .../devicetree/bindings/pwm/pwm-hibvt.txt          |  18 ++
>  drivers/pwm/Kconfig                                |  10 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-hibvt.c                            | 274 +++++++++++++++=
++++++
>  4 files changed, 303 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>  create mode 100644 drivers/pwm/pwm-hibvt.c
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt b/Docume=
ntation/devicetree/bindings/pwm/pwm-hibvt.txt
> new file mode 100644
> index 0000000..1274119
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
> @@ -0,0 +1,18 @@
> +Hisilicon PWM controller
> +
> +Required properties:
> +-compatible: should contain one soc specific compatible string and one g=
eneric compatible
> +string "hisilicon, hibvt-pwm". The soc specific strings supported includ=
ing:

Why the generic compatible string? You've already shown in the driver
that the two versions you support aren't compatible.

Also soc -> SoC, please.

> +	"hisilicon,hi3516cv300-pwm"
> +- reg: physical base address and length of the controller's registers.
> +- clocks: phandle and clock specifier of the PWM reference clock.
> +- resets: offset address and offset bit for reset or unreset of the cont=
roller.

That's weird. Usually this should say just that the property should
contain the phandle plus a reset specifier for the controller reset. The
above description already defines what the specifier looks like, which
may not be true on all SoCs that this hardware gets integrated into.

> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index c182efc..3c48768 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -158,6 +158,15 @@ config PWM_FSL_FTM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-fsl-ftm.
> =20
> +config PWM_HIBVT
> +	tristate "HiSilicon BVT PWM support"
> +	depends on ARCH_HISI
> +	help
> +	  Generic PWM framework driver for hisilicon BVT SOCs.

Please use a consistent spelling for HiSilicon. Also: SOC -> SoC.

> @@ -438,4 +447,5 @@ config PWM_VT8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-vt8500.
> =20
> +

Please don't add this extra blank line.

> diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
[...]
> new file mode 100644
> index 0000000..84f617e
> --- /dev/null
> +++ b/drivers/pwm/pwm-hibvt.c
> @@ -0,0 +1,274 @@
> +/*
> + * PWM Controller Driver for HiSilicon BVT SOCs
> + *
> + * Copyright (c) 2016 HiSilicon Technologies Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +
> +#define PWM_CFG0_ADDR(x)    (((x) * 0x20) + 0x0)
> +#define PWM_CFG1_ADDR(x)    (((x) * 0x20) + 0x4)
> +#define PWM_CFG2_ADDR(x)    (((x) * 0x20) + 0x8)
> +#define PWM_CTRL_ADDR(x)    (((x) * 0x20) + 0xC)
> +
> +#define PWM_ENABLE_SHIFT    0
> +#define PWM_ENABLE_MASK		BIT(0)
> +
> +#define PWM_POLARITY_SHIFT	1
> +#define PWM_POLARITY_MASK	BIT(1)
> +
> +#define PWM_KEEP_SHIFT	    2
> +#define PWM_KEEP_MASK	    BIT(2)
> +
> +#define PWM_PERIOD_MASK	    GENMASK(31, 0)
> +#define PWM_DUTY_MASK	    GENMASK(31, 0)

There's inconsistent padding in the above. I thought checkpatch warned
about this nowadays.

> +
> +struct hibvt_pwm_chip {
> +	struct pwm_chip	chip;
> +	struct clk	*clk;
> +	void __iomem	*mmio_base;
> +	struct reset_control *rstc;
> +};

No artificial padding with tabs above. A single space between type and
variable name is good enough. Also why the extra mmio_ prefix for the
I/O memory base address? You use the much shorter "base" for variables
elsewhere, why not in this structure?

> +
> +static int pwm_num_array[] =3D {8, 4};

static const unsigned, please. Or better yet, introduce a separate
structure for this type of SoC-specific data. Something like:

	struct hibvt_pwm_soc {
		unsigned int num_pwms;
	};

> +
> +static inline
> +struct hibvt_pwm_chip *to_hibvt_pwm_chip(struct pwm_chip *chip)

It's more idiomatic to put the return type on the first line as well.

> +{
> +	return container_of(chip, struct hibvt_pwm_chip, chip);
> +}
> +
> +static void hibvt_pwm_set_bits(void __iomem *base, unsigned int offset,
> +					unsigned int mask, unsigned int data)

Please align arguments on subsequent lines with the first argument on
the first line. And use u32 for mask and data since that's what readl()
and writel() use.

> +{
> +	void __iomem *address =3D base + offset;
> +	unsigned int value;

u32, please.

> +
> +	value =3D readl(address);
> +	value &=3D ~mask;
> +	value |=3D (data & mask);
> +	writel(value, address);
> +}
> +
> +static int hibvt_pwm_enable(struct pwm_chip *chip, struct pwm_device *pw=
m)
> +{
> +	struct hibvt_pwm_chip *hi_pwm_chip =3D to_hibvt_pwm_chip(chip);
> +	unsigned int offset;
> +
> +	offset =3D PWM_CTRL_ADDR(pwm->hwpwm);
> +	hibvt_pwm_set_bits(hi_pwm_chip->mmio_base, offset,

I don't think the temporary variable "offset" is useful here.

> +			PWM_ENABLE_MASK, 0x1);

Also, please align this properly.

> +
> +	return 0;
> +}
> +
> +static void hibvt_pwm_disable(struct pwm_chip *chip,
> +					struct pwm_device *pwm)

The above will fit on a single line.

> +{
> +	struct hibvt_pwm_chip *hi_pwm_chip =3D to_hibvt_pwm_chip(chip);
> +	unsigned int offset;
> +
> +	offset =3D PWM_CTRL_ADDR(pwm->hwpwm);
> +	hibvt_pwm_set_bits(hi_pwm_chip->mmio_base, offset,
> +			PWM_ENABLE_MASK, 0x0);

Again, I don't think the offset variable is any good here.

> +}
> +
> +static int hibvt_pwm_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +					int duty_cycle_ns, int period_ns)
> +{
> +	struct hibvt_pwm_chip *hi_pwm_chip =3D to_hibvt_pwm_chip(chip);
> +	unsigned int offset;
> +	unsigned int freq;
> +	unsigned int period_num, duty_num;

Why the _num suffix? You could just name them "period" and "duty". Also
you can put the last four variables above on the same line.

> +
> +	freq =3D div_u64(clk_get_rate(hi_pwm_chip->clk), 1000000);
> +
> +	period_num =3D div_u64(freq * period_ns, 1000);
> +	duty_num =3D div_u64(period_num * duty_cycle_ns, period_ns);
> +
> +	offset =3D PWM_CFG0_ADDR(pwm->hwpwm);
> +	hibvt_pwm_set_bits(hi_pwm_chip->mmio_base, offset,
> +			PWM_PERIOD_MASK, period_num);
> +
> +	offset =3D PWM_CFG1_ADDR(pwm->hwpwm);
> +	hibvt_pwm_set_bits(hi_pwm_chip->mmio_base, offset,
> +			PWM_DUTY_MASK, duty_num);

offset can be dropped here as well, in my opinion.

> +
> +	return 0;
> +}
> +
> +static int hibvt_pwm_set_polarity(struct pwm_chip *chip,
> +					struct pwm_device *pwm,
> +					enum pwm_polarity polarity)
> +{
> +	struct hibvt_pwm_chip *hi_pwm_chip =3D to_hibvt_pwm_chip(chip);
> +	unsigned int offset;
> +
> +	offset =3D PWM_CTRL_ADDR(pwm->hwpwm);
> +	if (polarity =3D=3D PWM_POLARITY_INVERSED)
> +		hibvt_pwm_set_bits(hi_pwm_chip->mmio_base, offset,
> +				PWM_POLARITY_MASK, (0x1 << PWM_POLARITY_SHIFT));
> +	else
> +		hibvt_pwm_set_bits(hi_pwm_chip->mmio_base, offset,
> +				PWM_POLARITY_MASK, (0x0 << PWM_POLARITY_SHIFT));
> +
> +	return 0;
> +}
> +
> +void hibvt_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +				struct pwm_state *state)
> +{
> +	struct hibvt_pwm_chip *hi_pwm_chip =3D to_hibvt_pwm_chip(chip);
> +	void __iomem *base;
> +	unsigned int offset;
> +	unsigned int freq;
> +	unsigned int period_num, duty_num;
> +	unsigned int enable;

I think you could trim the list of variables down a little. offset can
go away for reasons given above. And of the other four, the only one
that you need to reuse is freq, so period_num, duty_num and enable can
all be replaced by a "value" variable, for example. Also, make that an
u32, because that's what readl() returns.

> +
> +	freq =3D div_u64(clk_get_rate(hi_pwm_chip->clk), 1000000);
> +	base =3D hi_pwm_chip->mmio_base;
> +
> +	offset =3D PWM_CFG0_ADDR(pwm->hwpwm);
> +	period_num =3D readl(base + offset);
> +	state->period =3D div_u64(period_num * 1000, freq);
> +
> +	offset =3D PWM_CFG1_ADDR(pwm->hwpwm);
> +	duty_num =3D readl(base + offset);
> +	state->duty_cycle =3D div_u64(duty_num * 1000, freq);
> +
> +	offset =3D PWM_CTRL_ADDR(pwm->hwpwm);
> +	enable =3D readl(base + offset);
> +	state->enabled =3D (PWM_ENABLE_MASK & enable);
> +}
> +
> +static struct pwm_ops hibvt_pwm_ops =3D {
> +	.enable       =3D hibvt_pwm_enable,
> +	.disable      =3D hibvt_pwm_disable,
> +	.config       =3D hibvt_pwm_config,
> +	.set_polarity =3D hibvt_pwm_set_polarity,
> +	.get_state    =3D hibvt_pwm_get_state,

Please don't mix legacy and atomic support. If you support .get_state(),
you should implement .apply() instead of .enable()/.disable()/.config().
Also, please remove the artificial padding.

> +
> +	.owner        =3D THIS_MODULE,
> +};
> +
> +static const struct of_device_id hibvt_pwm_of_match[];

No need for this...

> +
> +static int hibvt_pwm_probe(struct platform_device *pdev)
> +{
> +	struct hibvt_pwm_chip *pwm_chip;
> +	const struct of_device_id *of_id =3D
> +				of_match_device(hibvt_pwm_of_match, &pdev->dev);

=2E.. if you use of_device_get_match_data() here.

> +	struct resource *res;
> +	int ret =3D 0;

No need to initialize to 0 here.

> +	int i;

unsigned int, please.

> +	int offset;
> +	int pwm_nums;

I think both of these can be dropped. See below.

> +
> +	if (!of_id)
> +		return -ENODEV;
> +
> +	pwm_chip =3D devm_kzalloc(&pdev->dev, sizeof(*pwm_chip), GFP_KERNEL);
> +	if (pwm_chip =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	pwm_chip->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(pwm_chip->clk)) {
> +		dev_err(&pdev->dev, "getting clock failed with %ld\n",
> +				PTR_ERR(pwm_chip->clk));
> +		return PTR_ERR(pwm_chip->clk);
> +	}
> +
> +	pwm_nums =3D *((int *)of_id->data);

This becomes a lot easier to read if you use a proper structure for the
SoC specific data:

	const struct hibvt_pwm_soc *soc =3D of_device_get_match_data(&pdev->dev);

	pwm_chip->chip.npwm =3D soc->num_pwms;

> +
> +	pwm_chip->chip.ops =3D &hibvt_pwm_ops;
> +	pwm_chip->chip.dev =3D &pdev->dev;
> +	pwm_chip->chip.base =3D -1;
> +	pwm_chip->chip.npwm =3D pwm_nums;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pwm_chip->mmio_base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(pwm_chip->mmio_base))
> +		return PTR_ERR(pwm_chip->mmio_base);
> +
> +	ret =3D clk_prepare_enable(pwm_chip->clk);
> +	if (ret < 0)
> +		return ret;
> +
> +	pwm_chip->rstc =3D devm_reset_control_get(&pdev->dev, NULL);
> +	if (IS_ERR(pwm_chip->rstc))
> +		return PTR_ERR(pwm_chip->rstc);
> +

You might want to move clk_prepare_enable() below this so you don't keep
it enabled when the reset control can't be requested.

> +	reset_control_assert(pwm_chip->rstc);
> +	msleep(30);
> +	reset_control_deassert(pwm_chip->rstc);
> +
> +	ret =3D pwmchip_add(&pwm_chip->chip);
> +	if (ret < 0)
> +		return ret;

You might want to assert the reset and disable and unprepare the clock
when this fails.

> +
> +	for (i =3D 0; i < pwm_nums; i++) {
> +		offset =3D PWM_CTRL_ADDR(i);
> +		hibvt_pwm_set_bits(pwm_chip->mmio_base, offset,

Things will still fit on one line if you use PWM_CTRL_ADDR(i) in place
above, so I don't think you gain anything by adding the temporary
variable.

> +				PWM_KEEP_MASK, (0x1 << PWM_KEEP_SHIFT));
> +	}
> +
> +	platform_set_drvdata(pdev, pwm_chip);
> +
> +	return 0;
> +}
> +
> +static int hibvt_pwm_remove(struct platform_device *pdev)
> +{
> +	struct hibvt_pwm_chip *pwm_chip;
> +
> +	pwm_chip =3D platform_get_drvdata(pdev);
> +	if (pwm_chip =3D=3D NULL)
> +		return -ENODEV;

There's no way this will ever happen.

> +
> +	clk_disable_unprepare(pwm_chip->clk);

What about the reset?

> +
> +	return pwmchip_remove(&pwm_chip->chip);
> +}
> +
> +static const struct of_device_id hibvt_pwm_of_match[] =3D {
> +	{.compatible =3D "hisilicon,hibvt-pwm", .data =3D &pwm_num_array[0]},
> +	{.compatible =3D "hisilicon,hi3516cv300-pwm", .data =3D &pwm_num_array[=
1]},

Spaces after { and before }, please.

> +	{  }
> +};
> +MODULE_DEVICE_TABLE(of, hibvt_pwm_of_match);
> +
> +static struct platform_driver hibvt_pwm_driver =3D {
> +	.driver		=3D {
> +		.name	=3D "hibvt-pwm",
> +		.of_match_table =3D hibvt_pwm_of_match,
> +	},
> +	.probe		=3D hibvt_pwm_probe,
> +	.remove		=3D hibvt_pwm_remove,
> +};

No need for the artificial padding, it's not working correctly for the
=2Eof_match_table field anyway.

> +
> +module_platform_driver(hibvt_pwm_driver);

No blank line between the "};" and "module_platform_driver(...);" line,
please.

> +
> +MODULE_AUTHOR("yuanjian12@hisilicon.com");

It's customary to put your real name here.

> +MODULE_DESCRIPTION("Hisilicon BVT SOCs PWM driver");

Again, please use consistent spelling for HiSilicon.

> +MODULE_LICENSE("GPL v2");

The header comment says "GPL v2 or later", but "GPL v2" here means GPL
v2 only.

Thierry

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXvZuoAAoJEN0jrNd/PrOh7ikQALmIN7d/4rUrJfTIuJIPo06h
Rs51wuGK+qUTl+BhzeSjNgoNEGvOx8eoY1vzIaNPZTOArjs6MWiGUiuqbpaO1vXb
8WcA/Sd2ePHcgZwPwutZ/rzSVplodUkIymFEz7+S7cubrQBuU20dsgN9rMx9gw+1
JDlW/gSEVge+poD6k6io4edyrf+g20h+as+vmfJeAfZaD1DrsVzzVUNNNHH7MpFi
ymfJQSpB0qBVHFpiGHzy/awMaAH9mmBQ95JVxo4GMLQiwcdCCoVi91tzNOoMXzZ4
APbkM6Jj19sPzK8klY0jbPSDXbYe1Q9BYtRAaqK2kKC3509dHUPlQBKIfocp52BX
5+mPVEZY7yC3O3mJKW0lV6Fj/m7n7PKLLiiR8R33e+C00HL0QjNTYjDm83z4sPII
PCRyyo+iSFNOwCCnX1kwPsS9naAcV+jxpjA4uP7WyD3H7mMvJI/2gnY/Dtcdd4OO
UwFMDB8Ynqpg4rartqLHSUNQaeuUEnFNUt5Zo4n5kAfBEXUpUGP02ZUWFwyB5osH
0m3Hrul3m548a0czAE1yAjBVrD2rkLOtDjc3ZxlWChZCp0Es+LJim+4R7EiA2fvh
2mHL2lHwftFZbnYSFDPEaxOEDBjGqAzHDQxgPsW3Ep568UiEkg1h3fy/NMA36M7j
LyvpHjzb3wldgbnXf4h1
=ZJQe
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
