From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/3] pwm: Add mc13xxx pwm driver.
Date: Thu, 28 Nov 2013 21:10:01 +0100
Message-ID: <20131128201000.GA14689@mithrandir>
References: <1385566771-366-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:33535 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855Ab3K1UKF (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Nov 2013 15:10:05 -0500
Content-Disposition: inline
In-Reply-To: <1385566771-366-1-git-send-email-denis@eukrea.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Denis Carikli <denis@eukrea.com>
Cc: linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, devicetree@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2013 at 04:39:29PM +0100, Denis Carikli wrote:
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-pwm@vger.kernel.org
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  .../devicetree/bindings/pwm/fsl,mc13xxx-pwm.txt    |   19 ++
>  drivers/mfd/mc13xxx-core.c                         |   11 ++
>  drivers/pwm/Kconfig                                |    6 +
>  drivers/pwm/Makefile                               |    1 +
>  drivers/pwm/pwm-mc13xxx.c                          |  205 ++++++++++++++=
++++++
>  include/linux/mfd/mc13783.h                        |    2 +
>  6 files changed, 244 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/fsl,mc13xxx-pwm=
=2Etxt
>  create mode 100644 drivers/pwm/pwm-mc13xxx.c

I'll say the same thing I always say: please use "PWM" in prose instead
of "pwm". It's an abbreviation, so it should be uppercased.

> diff --git a/Documentation/devicetree/bindings/pwm/fsl,mc13xxx-pwm.txt b/=
Documentation/devicetree/bindings/pwm/fsl,mc13xxx-pwm.txt
> new file mode 100644
> index 0000000..a1394d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/fsl,mc13xxx-pwm.txt
> @@ -0,0 +1,19 @@
> +Freescale mc13xxx series PWM drivers.

The binding doesn't describe drivers, so this should be something like:

	Freescale mc13xxx series PWM controllers

> +Supported PWMs:

Similarily this should be: "Supported PWM controllers:"

> +mc13892 series
> +mc34708 series

And since this is a list it would make sense to prefix each item with a
dash.

> +
> +Required properties:
> +- compatible: "fsl,mc13892-pwm" or "fsl,mc34708-pwm"
> +- mfd: phandle to mc13xxx mfd node.

What's that doing here? If this is a function of the mc13xxx device,
then it should be a child node of the mc13xxx node.

> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index dbbf8ee..e250f16 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -133,6 +133,8 @@
> =20
>  #define MC13XXX_ADC2		45
> =20
> +struct mc13xxx *mc13xxx_data;
> +
>  void mc13xxx_lock(struct mc13xxx *mc13xxx)
>  {
>  	if (!mutex_trylock(&mc13xxx->lock)) {
> @@ -639,6 +641,12 @@ static inline int mc13xxx_probe_flags_dt(struct mc13=
xxx *mc13xxx)
>  }
>  #endif
> =20
> +struct mc13xxx *get_mc13xxx(void)
> +{
> +	return mc13xxx_data;
> +}
> +EXPORT_SYMBOL_GPL(get_mc13xxx);

As mentioned elsewhere, this is horrible.

>  int mc13xxx_common_init(struct mc13xxx *mc13xxx,
>  		struct mc13xxx_platform_data *pdata, int irq)
>  {
> @@ -706,6 +714,9 @@ err_revision:
>  		mc13xxx_add_subdevice(mc13xxx, "%s-pwrbutton");
>  	}
> =20
> +	/* Linux will not have to handle more than one mc13xxx pmic. */
> +	mc13xxx_data =3D mc13xxx;

Who says that Linux will never have to handle more than one? Even if you
could guarantee that, it still sets a bad example.

> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index eece329..a959ecd 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -100,6 +100,12 @@ config PWM_LPC32XX
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-lpc32xx.
> =20
> +config PWM_MC13XXX
> +	tristate "MC13XXX PWM support"
> +	depends on MFD_MC13XXX
> +	help
> +	  Generic PWM framework driver for Freescale MC13XXX pmic.

PMIC is an abbreviation too, so should be all uppercase.

> diff --git a/drivers/pwm/pwm-mc13xxx.c b/drivers/pwm/pwm-mc13xxx.c
[...]
> +#include <linux/err.h>
> +#include <linux/mfd/mc13783.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>

Can this please be sorted alphabetically?

> +
> +#define MHz(x) (1000*1000*x)

Please drop this. You use it exactly once, ...

> +#define MC13XXX_REG_PWM_CTL		55
> +#define MC13XXX_BASE_CLK_FREQ		(MHz(2) / 32)

So you can just as well write (2000000 / 32) here.

> +#define MC13XXX_PWM1CLKDIV_SHIFT	6
> +#define MC13XXX_PWM2DUTY_SHIFT		12
> +#define MC13XXX_PWMDUTYDIVISOR		32
> +#define MC13XXX_PWMCLKDIVISOR		64

This list is totally confusing. I can't tell which of these is a
register and which isn't. I would at least expect registers to have
hexadecimal offsets. Better yet, a comment should explain what the
registers look like.

> +#define MC13XXX_PWM_REG_SIZE		0x3f

This doesn't seem to be a size at all. It's used as a mask, so why not
call it MC13XXX_PWM_REG_MASK?

> +static int pwm_mc13xxx_config(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			      int duty_ns, int period_ns)
> +{
> +	struct mc13xxx_pwm_chip *mc13xxx_chip =3D to_mc13xxx_chip(chip);
> +	struct mc13xxx *mcdev =3D mc13xxx_chip->mcdev;
> +	struct device *dev =3D  mc13xxx_chip->pwm_chip.dev;
> +	u32 offset;
> +	u32 mask =3D MC13XXX_PWM_REG_SIZE;
> +	u32 val;
> +	int ret;
> +	int duty_cycle;
> +	int min_duty_cycle;
> +	int period_cycle;
> +	unsigned long period =3D period_ns;

Many of these can go on a single line. Also it looks like you can reuse
some of them and thereby reduce the number of local variables. Having
too many of them makes it very difficult to follow what the code is
doing.

> +
> +	dev_dbg(dev, "requested duty_ns=3D%d and period_ns=3D%d\n",
> +		duty_ns, period_ns);

This can go away.

> +
> +	/* period */
> +	if (period < MC13XXX_MIN_PERIOD_NS) {
> +		dev_warn(dev, "period was under the range.\n");
> +		period =3D MC13XXX_MIN_PERIOD_NS;
> +	}
> +
> +	if (period > MC13XXX_MAX_PERIOD_NS) {
> +		dev_warn(dev, "period was over the range.\n");
> +		period =3D MC13XXX_MAX_PERIOD_NS;
> +	}

Shouldn't both of these be an error instead?

> +
> +	period_cycle =3D DIV_ROUND_UP(NSEC_PER_SEC, period);
> +	period_cycle =3D DIV_ROUND_UP(MC13XXX_BASE_CLK_FREQ, period_cycle);
> +	period_cycle--;

You can save one line here by turning this one into a - 1 appended to
the previous line.

> +
> +	offset =3D MC13XXX_REG_PWM_CTL + pwm->hwpwm * MC13XXX_PWM2DUTY_SHIFT +
> +		MC13XXX_PWM1CLKDIV_SHIFT;

_SHIFT is usually for bitfields, not for register offsets. Perhaps it
would also be a good idea to move this computation into a macro or
static inline function, something like:

	#define MC13XXX_PWM_BASE(pwm) (0x37 + ((pwm) * 0xc))

And then use offsets to the individual registers:

	#define MC13XXX_PWM_CTL 0x00
	#define MC13XXX_PWM_CLKDIV 0x06

Then it becomes much easier to use these:

	unsigned int base =3D MC13XXX_PWM_BASE(pwm->hwpwm);

	ret =3D mc13xxx_reg_read(mcdev, base + MC13XXX_PWM_CTL, &val);

> +
> +	mc13xxx_lock(mcdev);
> +	ret =3D mc13xxx_reg_read(mcdev, offset, &val);
> +	val &=3D ~mask;

Why aren't you using the #define here directly?

> +	val +=3D (period_cycle & mask);
> +	ret =3D mc13xxx_reg_write(mcdev, offset, val);
> +	mc13xxx_unlock(mcdev);
> +
> +	/* duty cycle */
> +	min_duty_cycle =3D DIV_ROUND_UP(period, 32);
> +
> +	if (duty_ns < min_duty_cycle) {
> +		dev_warn(dev, "duty cycle is under the range.\n");
> +		duty_cycle =3D 0;

Again, I think this should be an error and the function should fail when
this happens.

> +	} else if (duty_ns > period) {

The core code already checks for this.

> +		dev_warn(dev, "duty cycle is over the range.\n");
> +		duty_cycle =3D 32;
> +	} else {
> +		duty_cycle =3D 32 * period;
> +		duty_cycle =3D DIV_ROUND_UP(period, duty_ns);

Are you sure this is doing what it's supposed to? The second line
overwrites the first one. Also

Do you have a link to the manual for this controller? I'm very confused
by all these restrictions and the computations.

> +		duty_cycle--;
> +		duty_cycle =3D 32 - duty_cycle;
> +	}
> +
> +	offset =3D MC13XXX_REG_PWM_CTL + pwm->hwpwm * MC13XXX_PWM2DUTY_SHIFT;
> +
> +	mc13xxx_lock(mcdev);
> +	ret =3D mc13xxx_reg_read(mcdev, offset, &val);
> +	val &=3D ~mask;
> +	val +=3D (duty_cycle & mask);

That's odd. The mask here is 0x3f (63), but the maximum value for the
duty-cycle is 32 by the above computations, so masking is completely
unnecessary.

Also, you don't need any parentheses around (duty_cycle & mask). And
since you're modifying a bitfield, the idiomatic way to write it is with
a | instead of a +:

	val &=3D ~mask;
	val |=3D duty_cycle & mask;

> +	ret =3D mc13xxx_reg_write(mcdev, offset, val);
> +	mc13xxx_unlock(mcdev);

Shouldn't the lock protect both register writes as a whole? Otherwise
there's still the potential that two such accesses will be interleaved
and cause undefined behaviour.

> +	return 0;

This returns success no matter what mc13xxx_reg_write() returned.

> +}
> +
> +static int pwm_mc13xxx_enable(struct pwm_chip *chip, struct pwm_device *=
pwm)
> +{
> +	/* The hardware doesn't need an enable */
> +
> +	return 0;
> +}

That's not really compatible with the semantics of the PWM subsystem. It
must be possible to configure the PWM without enabling it. If the
hardware doesn't have a separate bit to do that, then you'll need to put
most of the .config() code into .enable(). You could for example compute
the register values in advance, in .config(), but only write the
registers in .enable().

> +static void pwm_mc13xxx_disable(struct pwm_chip *chip, struct pwm_device=
 *pwm)
> +{
> +	/* The hardware doesn't need a disable */
> +}

That's unfortunate. So the only way to "disable" the PWM is by setting
the duty-cycle to 0? In that case it might be good to do that here.

> +
> +static const struct pwm_ops pwm_mc13xxx_ops =3D {
> +	.enable		=3D pwm_mc13xxx_enable,
> +	.disable	=3D pwm_mc13xxx_disable,
> +	.config		=3D pwm_mc13xxx_config,
> +	.owner		=3D THIS_MODULE,
> +};

No tabs for aligning please, just use a single space on either side of
the assignment operator.

> +static int pwm_mc13xxx_probe(struct platform_device *pdev)
> +{
> +	struct mc13xxx_pwm_chip *chip;
> +	struct mc13xxx *mcdev;
> +	int err;
> +
> +	mcdev =3D get_mc13xxx();

I've mentioned this before, this needs to go away. The usual way to do
that is to make the PWM device a child of the MFD device and refer to
the MFD device via pdev->dev.parent.

> +	if (!mcdev) {
> +		dev_err(&pdev->dev, "failed to find mc13xxx pmic.\n");
> +		return -EINVAL;
> +	}
> +
> +	chip =3D devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +	if (chip =3D=3D NULL) {
> +		dev_err(&pdev->dev, "failed to allocate memory\n");
> +		return -ENOMEM;
> +	}

Don't use error messages for allocation failures. And while at it, can
you change "chip =3D=3D NULL" to "!chip", please?

> +
> +	chip->pwm_chip.dev =3D &pdev->dev;
> +	chip->pwm_chip.ops =3D &pwm_mc13xxx_ops;
> +	chip->pwm_chip.base =3D pdev->id;

No. This should always be -1 for new drivers.

> +static int pwm_mc13xxx_remove(struct platform_device *pdev)
> +{
> +	struct mc13xxx_pwm_chip *chip =3D platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret =3D pwmchip_remove(&chip->pwm_chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;

This can be just:

	return pwmchip_remove(&chip->pwm_chip);

By the way, that pwm_ prefix on the PWM chip field is somewhat redundant
since the driver implements only one chip. I suggest you drop it.

> +#ifdef CONFIG_OF
> +static const struct of_device_id pwm_mc13xxx_of_match[] =3D {
> +	{ .compatible =3D "fsl,mc13892-pwm" },
> +	{ .compatible =3D "fsl,mc34708-pwm" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, pwm_mc13xxx_of_match);
> +#endif
> +
> +static struct platform_driver pwm_mc13xxx_driver =3D {
> +	.driver		=3D {
> +		.name	=3D "mc13xxx-pwm",
> +		.of_match_table =3D of_match_ptr(pwm_mc13xxx_of_match),
> +		.owner	=3D THIS_MODULE,

=2Eowner is assigned automatically by the core, so this can be dropped.

> +	},
> +	.probe		=3D pwm_mc13xxx_probe,
> +	.remove		=3D pwm_mc13xxx_remove,

Please don't use tabs for alignment here. A single space on each side of
the =3D will do just fine. For the whole structure, not just these two
fields.

> +};
> +
> +module_platform_driver(pwm_mc13xxx_driver);

No blank line between the above two lines.

Thierry

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSl6MXAAoJEN0jrNd/PrOh2rsP+wYK+Ha+f9CYULCxHelmp/qg
3aGi0KcWaxJU/lt2goV3V9iz50OpF23HZNnJzHTQLsXuIwzaXCVbw6CsyLKpE0FU
+w8YfUDmPWOX0P+iOJCm5bjufdqABoxHPS/Yy0QhjByhLwFAb0NGy/BLTeIHR43J
IFbyq4ItaV0pmzFp+TE172hFnuo0sQjanuchMTtRGxoH7bADdOXVJLrazTaFZUga
aDtF0owPXKxRGJSmVpXycj9Vh1JDbfTCsjPddb92g6SndSZCf9qAaqsFrsmkfFCI
bCpyHuATC7J25RjX0Vv9ssv5SWxhkYI7GYFnUlDfx91DhRoDVhxxwyS7FTTLj/h1
/oqyVbyCE2d7BL1B1yHJaFMWTQPmgx4JejeVs9tK49adYyXAn6PBNgOborKxkNui
2+Rhqz/LwQrRh8NP2drNQ06m1SA+t7VoDbY2kHFB2f7YQ6ftLhpONWV32dPF8FVP
7SdLSV2zuQ5iVP9NcPQCmrRcTr+h/mmEhvMv6cY33jn3SO7FgiaJlLOuIsjVyhYi
rBkxLGR1WuR37i9WWLUZuUuQzJ3KCKgX/X1LdXDhDez8pcD4YficJ2sOL79UIaMH
E5zqlyjdI0oD0iH8Wbu7zuewxPMMQHHh8NLm04unV3FxCnNPNdv4fBcc2tZfovcs
HBGe03IReAlg/n2pGdGT
=6am9
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
