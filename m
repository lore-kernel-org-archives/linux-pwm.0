From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3] pwm: add CSR SiRFSoC PWM driver
Date: Wed, 26 Feb 2014 15:10:41 +0100
Message-ID: <20140226141039.GD29779@ulmo.nvidia.com>
References: <1391855002-26098-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:64583 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbaBZOKq (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2014 09:10:46 -0500
Received: by mail-ea0-f182.google.com with SMTP id b10so19818eae.41
        for <linux-pwm@vger.kernel.org>; Wed, 26 Feb 2014 06:10:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1391855002-26098-1-git-send-email-21cnbao@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, arnd@arndb.de, Rongjun Ying <Rongjun.ying@csr.com>, Huayi Li <Huayi.Li@csr.com>, Barry Song <Baohua.Song@csr.com>


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2014 at 06:23:22PM +0800, Barry Song wrote:
> From: Rongjun Ying <Rongjun.ying@csr.com>
>=20
> PWM controller of CSR SiRFSoC can generate 7 independent outputs. Each ou=
tput

"The PWM controller of the CSR SiRFSoC..." and "Each output's..."

> duty cycle can be adjusted by setting the corresponding wait & hold regis=
ters.
>=20
> Supports 7 independent channel output: 6 for external(channel0-5) and 1 f=
or
> internal(channel6).

This repeats part of the first sentence. Perhaps:

	There are 6 external channels (0 to 5) and 1 internal channel (6).

?

> Supports wide frequency range: divide by 2 to 65536*2 of source clock.

"Supports a wide frequency range: the source clock divider can be from 2
up to 65536*2".

>  Documentation/devicetree/bindings/pwm/pwm-sirf.txt |   17 +
>  arch/arm/boot/dts/atlas6.dtsi                      |    3 +-
>  arch/arm/boot/dts/prima2.dtsi                      |    3 +-
>  drivers/pwm/Kconfig                                |    9 +
>  drivers/pwm/Makefile                               |    1 +
>  drivers/pwm/pwm-sirf.c                             |  308 ++++++++++++++=
++++++
>  6 files changed, 339 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sirf.txt
>  create mode 100644 drivers/pwm/pwm-sirf.c
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sirf.txt b/Documen=
tation/devicetree/bindings/pwm/pwm-sirf.txt
> new file mode 100644
> index 0000000..4b10109
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sirf.txt
> @@ -0,0 +1,17 @@
> +SiRF prima2 & atlas6 PWM drivers
> +
> +Required properties:
> +- compatible: "sirf,prima2-pwm"
> +- reg: physical base address and length of the controller's registers
> +- #pwm-cells: should be 2.  The first cell specifies the per-chip index
> +  of the PWM to use and the second cell is the period in nanoseconds.
> +- clocks: from common clock binding: the 1st clock is for PWM controller
> +  the 2nd clock is the source to generate PWM waves
> +
> +Example:
> +pwm: pwm@b0130000 {
> +	compatible =3D "sirf,prima2-pwm";
> +	#pwm-cells =3D <2>;
> +	reg =3D <0xb0130000 0x10000>;
> +	clocks =3D <&clks 21>, <&clks 1>;
> +};

Please move this into a separate patch and Cc the device tree bindings
maintainers. There's nothing non-standard in this binding as far as I
can tell, but I'd still like to give them an opportunity to object.

Also you should be documenting the clock-names property here as well.

> diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
> index f8674bc..5a09815 100644
> --- a/arch/arm/boot/dts/atlas6.dtsi
> +++ b/arch/arm/boot/dts/atlas6.dtsi
> @@ -614,8 +614,9 @@
> =20
>  			pwm@b0130000 {
>  				compatible =3D "sirf,prima2-pwm";
> +				#pwm-cells =3D <2>;
>  				reg =3D <0xb0130000 0x10000>;
> -				clocks =3D <&clks 21>;
> +				clocks =3D <&clks 21>, <&clks 1>;
>  			};
> =20
>  			efusesys@b0140000 {
> diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
> index 0e21993..3439e48 100644
> --- a/arch/arm/boot/dts/prima2.dtsi
> +++ b/arch/arm/boot/dts/prima2.dtsi
> @@ -642,8 +642,9 @@
> =20
>  			pwm@b0130000 {
>  				compatible =3D "sirf,prima2-pwm";
> +				#pwm-cells =3D <2>;
>  				reg =3D <0xb0130000 0x10000>;
> -				clocks =3D <&clks 21>;
> +				clocks =3D <&clks 21>, <&clks 1>;
>  			};
> =20
>  			efusesys@b0140000 {

These changes need to go into separate patches and go in through the
arm-soc tree.

> diff --git a/drivers/pwm/pwm-sirf.c b/drivers/pwm/pwm-sirf.c
> new file mode 100644
> index 0000000..b717de0
> --- /dev/null
> +++ b/drivers/pwm/pwm-sirf.c
> @@ -0,0 +1,308 @@
> +/*
> + * SIRF serial SoC PWM device core driver
> + *
> + * Copyright (c) 2014 Cambridge Silicon Radio Limited, a CSR plc group c=
ompany.
> + *
> + * Licensed under GPLv2 or later.
> + */
[...]
> +#define SIRF_PWM_CHL_NUM			7

This is only used in a single location with a well-known meaning, so no
need to use a symbolic name.

> +#define SIRF_PWM_BLS_GRP_NUM			16

This isn't used as far as I can tell.

> +struct sirf_pwm {
> +	void __iomem		*base;
> +	struct clk		*clk;
> +	struct pwm_chip		chip;
> +	unsigned long		src_clk_rate;
> +};

Please drop the alignment of the structure field. Also perhaps move the
chip field to be the first, so that the upcasting below can be turned
into a noop.

> +#define to_sirf_chip(chip)	container_of(chip, struct sirf_pwm, chip)

Please make this a static inline function.

> +
> +static unsigned int sirf_pwm_ns_to_cycles(struct pwm_chip *chip, unsigne=
d int time_ns)

Please wrap this to go on a single line.

> +{
> +	struct sirf_pwm *spwm =3D to_sirf_chip(chip);
> +	u64 dividend;
> +	unsigned int cycle;
> +
> +	dividend =3D spwm->src_clk_rate * time_ns + NSEC_PER_SEC / 2;
> +	do_div(dividend, NSEC_PER_SEC);
> +
> +	cycle =3D dividend & 0xFFFFFFFFUL;

I don't think you need the mask, since you're casting to a 32-bit
unsigned integer anyway.

> +
> +	return cycle > 1 ? cycle : 1;
> +}
> +
> +static int sirf_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +		int duty_ns, int period_ns)

Please align arguments on subsequent lines with those of the first.

> +{
> +	unsigned int period_cycles, high_cycles, low_cycles;
> +	unsigned int val;

u32 please.

> +	struct sirf_pwm *spwm =3D to_sirf_chip(chip);
> +
> +	period_cycles =3D sirf_pwm_ns_to_cycles(chip, period_ns);
> +
> +	high_cycles =3D sirf_pwm_ns_to_cycles(chip, duty_ns);

No need for the blank line above, since there's no blank line below
either.

> +	low_cycles =3D period_cycles - high_cycles;

> +
> +	if (period_cycles =3D=3D 1) {
> +		/* bypass mode */
> +		val =3D readl(spwm->base + SIRF_PWM_SELECT_PRECLK);
> +		val |=3D 0x1 << (BYPASS_MODE_BIT + pwm->hwpwm);
> +		writel(val, spwm->base + SIRF_PWM_SELECT_PRECLK);
> +		dev_warn(chip->dev, "period is too short!\n");

What does the bypass mode do? Would it perhaps be better to make this an
outright error rather than only warning about it?

> +	} else {
> +		/* divider mode */
> +		val =3D readl(spwm->base + SIRF_PWM_SELECT_PRECLK);
> +		val &=3D ~(0x1 << (BYPASS_MODE_BIT + pwm->hwpwm));
> +		writel(val, spwm->base + SIRF_PWM_SELECT_PRECLK);
> +
> +		if (high_cycles =3D=3D period_cycles) {
> +			high_cycles--;
> +			low_cycles =3D 1;
> +		}
> +
> +		writel(high_cycles, spwm->base + SIRF_PWM_GET_WAIT_OFFSET(pwm->hwpwm));
> +		writel(low_cycles, spwm->base + SIRF_PWM_GET_HOLD_OFFSET(pwm->hwpwm));
> +	}
> +
> +	return 0;
> +}
> +
> +static int sirf_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct sirf_pwm *spwm =3D to_sirf_chip(chip);
> +	unsigned int val;

The type used by readl() and writel() is u32.

> +	/* disable preclock */
> +	val =3D readl(spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
> +	val &=3D ~(1 << pwm->hwpwm);
> +	writel(val, spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
> +
> +	/* select preclock source must after disable preclk*/
> +	val =3D readl(spwm->base + SIRF_PWM_SELECT_PRECLK);
> +	val &=3D ~(0x7 << (SRC_FIELD_SIZE * pwm->hwpwm));
> +	writel(val, spwm->base + SIRF_PWM_SELECT_PRECLK);
> +	/* wait for some time */
> +	udelay(100);

usleep_range() perhaps?

> +static void sirf_pwm_disable(struct pwm_chip *chip, struct pwm_device *p=
wm)
> +{
> +	unsigned int val;

u32 again.

> +	struct sirf_pwm *spwm =3D to_sirf_chip(chip);
> +	/* disable output */

Blank line between the above two, please.

> +	val =3D readl(spwm->base + SIRF_PWM_OE);
> +	val &=3D ~(1 << pwm->hwpwm);
> +	writel(val, spwm->base + SIRF_PWM_OE);
> +
> +	/* disable postclock */
> +	val =3D readl(spwm->base + SIRF_PWM_ENABLE_POSTCLOCK);
> +	val &=3D ~(1 << pwm->hwpwm);
> +	writel(val, spwm->base + SIRF_PWM_ENABLE_POSTCLOCK);
> +
> +	/* disable preclock */
> +	val =3D readl(spwm->base + SIRF_PWM_ENABLE_PRECLOCK);
> +	val &=3D ~(1 << pwm->hwpwm);
> +	writel(val, spwm->base + SIRF_PWM_ENABLE_PRECLOCK);

I think you need a lock to synchronize accesses to these registers.

> +}
> +
> +static struct pwm_ops sirf_pwm_ops =3D {

static const please.

> +	.enable =3D sirf_pwm_enable,
> +	.disable =3D sirf_pwm_disable,
> +	.config =3D sirf_pwm_config,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int sirf_pwm_probe(struct platform_device *pdev)
> +{
> +	struct sirf_pwm *spwm;
> +	struct resource *mem_res;
> +	struct clk *clk_pwm_src;
> +	int ret;
> +
> +	spwm =3D devm_kzalloc(&pdev->dev, sizeof(struct sirf_pwm),
> +			GFP_KERNEL);

"sizeof(*spwm)", please. And the above fits on a single line, no need to
wrap them.

> +	if (!spwm)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, spwm);
> +
> +	mem_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	spwm->base =3D devm_ioremap_resource(&pdev->dev, mem_res);
> +	if (!spwm->base)
> +		return -ENOMEM;
> +
> +	/*
> +	 * the 1st clock is for PWM controller
> +	 */
> +	spwm->clk =3D of_clk_get(pdev->dev.of_node, 0);

Use a clock-names property and devm_clk_get() here, please.

> +	if (IS_ERR(spwm->clk)) {
> +		dev_err(&pdev->dev, "Get PWM controller clock failed.\n");

"failed to get PWM controller clock"?

> +		return PTR_ERR(spwm->clk);
> +	}
> +	clk_prepare_enable(spwm->clk);

Space between the above two. Also you need to check the return value of
clk_prepare_enable().

> +
> +	/*
> +	 * the 2nd clock is the source to generate PWM waves

I'd prefer "signals" over "waves".

> +	 * it is the OSC on SiRFSoC

The clock is configurable via DT, so this isn't necessarily true. Even
if all hardware in existence currently works that way, it isn't a given
to remain like that forever.

> +	 */
> +	clk_pwm_src =3D of_clk_get(pdev->dev.of_node, 1);
> +	if (IS_ERR(clk_pwm_src)) {
> +		dev_err(&pdev->dev, "Get PWM source clock failed.\n");

"failed to get PWM source clock"?

> +		return PTR_ERR(clk_pwm_src);
> +	}
> +	spwm->src_clk_rate =3D clk_get_rate(clk_pwm_src);

Space between the above two please.

> +	clk_put(clk_pwm_src);

Why drop the reference to it here? Shouldn't you keep it around and even
call clk_prepare_enable() on it to make sure it's actually on?

> +
> +	spwm->chip.dev =3D &pdev->dev;
> +	spwm->chip.ops =3D &sirf_pwm_ops;
> +	spwm->chip.base =3D 0;
> +	spwm->chip.npwm =3D SIRF_PWM_CHL_NUM;
> +
> +	ret =3D pwmchip_add(&spwm->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to register pwm\n");

"PWM" please.

> +		clk_disable_unprepare(spwm->clk);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sirf_pwm_remove(struct platform_device *pdev)
> +{
> +	struct sirf_pwm *spwm =3D platform_get_drvdata(pdev);
> +	clk_disable_unprepare(spwm->clk);

I'd prefer a blank line between the two above.

> +	clk_put(spwm->clk);
> +
> +	pwmchip_remove(&spwm->chip);
> +	return 0;

This should be "return pwmchip_remove(...);".

> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int sirf_pwm_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct sirf_pwm *spwm =3D platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(spwm->clk);
> +
> +	return 0;
> +}
> +
> +static void sirf_pwm_config_restore(struct sirf_pwm *spwm)
> +{
> +	struct pwm_device *pwm;
> +	int i;
> +
> +	for (i =3D 0; i < spwm->chip.npwm; i++) {
> +		pwm =3D &spwm->chip.pwms[i];
> +		/*
> +		 * while restoring from hibernation, state of pwm is enabled,
> +		 * but PWM hardware is not re-enabled
> +		 */
> +		if (test_bit(PWMF_REQUESTED, &pwm->flags) &&
> +		     test_bit(PWMF_ENABLED, &pwm->flags))

Indentation is off by one space here.

> +			sirf_pwm_enable(&spwm->chip, pwm);
> +	}
> +}
> +
> +static int sirf_pwm_resume(struct device *dev)
> +{
> +	struct sirf_pwm *spwm =3D dev_get_drvdata(dev);
> +
> +	clk_prepare_enable(spwm->clk);
> +
> +	sirf_pwm_config_restore(spwm);
> +
> +	return 0;
> +}
> +
> +static int sirf_pwm_restore(struct device *dev)
> +{
> +	struct sirf_pwm *spwm =3D dev_get_drvdata(dev);
> +
> +	/* back from hibernation, clock is already enabled */
> +	sirf_pwm_config_restore(spwm);

Why is the clock already enabled? Shouldn't it be off until this driver
enables it?

> +
> +	return 0;
> +}
> +
> +#else
> +#define sirf_pwm_resume NULL
> +#define sirf_pwm_suspend NULL
> +#define sirf_pwm_restore NULL
> +#endif
> +
> +static const struct dev_pm_ops sirf_pwm_pm_ops =3D {
> +	.suspend =3D sirf_pwm_suspend,
> +	.resume =3D sirf_pwm_resume,
> +	.restore =3D sirf_pwm_restore,
> +};

Because if you can unify _resume and _restore, this could all be
simplified using SIMPLE_DEV_PM_OPS().

> +
> +static const struct of_device_id sirf_pwm_of_match[] =3D {
> +	{ .compatible =3D "sirf,prima2-pwm", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sirf_pwm_of_match);
> +
> +static struct platform_driver sirf_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "prima2-pwm",

"sirf-pwm"?

> +		.owner =3D THIS_MODULE,

This is no longer necessary.

> +		.pm =3D &sirf_pwm_pm_ops,
> +		.of_match_table =3D sirf_pwm_of_match,
> +	},
> +	.probe =3D sirf_pwm_probe,
> +	.remove =3D sirf_pwm_remove,
> +};
> +
> +module_platform_driver(sirf_pwm_driver);
> +
> +MODULE_DESCRIPTION("SIRF serial SoC PWM device core driver");
> +MODULE_AUTHOR("RongJun Ying <Rongjun.Ying@csr.com>, "
> +	"Huayi Li <huayi.li@csr.com>");

These could simply be two separate MODULE_AUTHOR() entries.

> +MODULE_LICENSE("GPL v2");

The file header says GPL v2 or later, which would be "GPL". "GPL v2" is
GPL v2 only.


--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDfXfAAoJEN0jrNd/PrOh7TcQAL9Xeb/oECJDAKLfZW3zMIi9
4FIZtI62HjGAjafy9z56t69al7WKtY8bjlAzxcRiP3UuUcXeYWESJkhc4L/StZtw
NbSD5A5oF1TM8Cyi0zeL1EwYfDLtpiCFQvdMd37L1Sf/CnHy3Vhl4uscROYcln38
rN56vuBksCs7ObvkS5JFsv26bvcsC8Zq5fA2Up7+seeq91cShlfR8eqkt7D3yHKS
ivrtFhXMIEyEUDkUntsYsQi7gW23OPvlj2aACXNHh5PXwqbFKr3nrWiijd004Ag2
H1Hmeiw/VWVeYKCEzrMbA5SwyIYJi/OjSig4i+pkCABrRkcjDyeG6rV8Q9brZ2Xs
U2D4RGDE3km1wWkOORSPq4HtL707WuFjzU4Ufb/wdy4uFs9QF2QGMHOkWJRMV7J3
Nwv3GsXGLnxYJkwH1yt9gDJlCoqvMMiwLBuoxSTed1i16+eZXQvoTGov4m+0Z/vl
7Zy9ue1t8Du8YETu5Zd60aWud8lzrvkzE/UZD9N9lcjY1OXwMAwovPy8GBTyoKHB
AjtGGpLIU+DiODxQP2jKGqatsZaNy8Ngh71/DXCCAxpX7TSsUZIreuLX9VVuhK5e
7EeJ0Yaaa79NkCKfYyYsrIPpImkVDty6ABNbU4ezbESvr/d6VzmD9RXHzZkd191Z
CUrkTVPqhSoduIjq68DZ
=9JvL
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
