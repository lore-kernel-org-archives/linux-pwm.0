From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: Add MC34708 PWM driver support.
Date: Fri, 27 Jun 2014 08:04:22 +0200
Message-ID: <20140627060421.GC9258@ulmo>
References: <1403525405-5336-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:36583 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbaF0GE0 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 27 Jun 2014 02:04:26 -0400
Received: by mail-wg0-f42.google.com with SMTP id z12so4663182wgg.25
        for <linux-pwm@vger.kernel.org>; Thu, 26 Jun 2014 23:04:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1403525405-5336-1-git-send-email-denis@eukrea.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Denis Carikli <denis@eukrea.com>
Cc: Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>, linux-pwm@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Philippe =?utf-8?B?UsOpdG9ybmF6?= <philippe.retornaz@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2014 at 02:10:05PM +0200, Denis Carikli wrote:
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> Changelog v1->v2:
>=20
> - The driver now uses retrives mc13xxx without having to export it
>   trough a globally exported function.
> - The .enable() and .disable() are now handled.
> - The registers calculations have been reworked.
> - Defines have been reworked to be more readable.
> - The driver only supports the mc34708, so now we don't claim to support
>   other devices anymore, and the prefix has been changed from mc13xxx
>   to mc34708. The documentation was also updated to reflect that.
> - Spelling errors have been fixed.
> - There is now less code thanks to the use of mc13xxx_reg_rmw and
>   range checking functions.
> - Many other cosmetics fixes and code cleanups.
> ---
>  Documentation/devicetree/bindings/mfd/mc13xxx.txt |    3 +
>  drivers/mfd/mc13xxx-core.c                        |   16 ++
>  drivers/pwm/Kconfig                               |    6 +
>  drivers/pwm/Makefile                              |    1 +
>  drivers/pwm/pwm-mc34708.c                         |  224 +++++++++++++++=
++++++
>  5 files changed, 250 insertions(+)
>  create mode 100644 drivers/pwm/pwm-mc34708.c
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/mc13xxx.txt b/Document=
ation/devicetree/bindings/mfd/mc13xxx.txt
> index 8aba488..464a663 100644
> --- a/Documentation/devicetree/bindings/mfd/mc13xxx.txt
> +++ b/Documentation/devicetree/bindings/mfd/mc13xxx.txt
> @@ -22,6 +22,9 @@ Sub-nodes:
>    Each led node should contain "reg", which used as LED ID (described be=
low).
>    Optional properties "label" and "linux,default-trigger" is described in
>    Documentation/devicetree/bindings/leds/common.txt.
> +- pwm: For MC34708, contain the PWM controller:
> +  - compatible: must be "fsl,mc34708-pwm".

Shouldn't this be "MC34708" and "fsl,mc134708-pwm"?

> +  - #pwm-cells: must be 2.
>  - regulators : Contain the regulator nodes. The regulators are bound usi=
ng
>    their names as listed below with their registers and bits for enabling.
> =20
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index acf5dd7..71b7d84c 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -599,6 +599,20 @@ static int mc13xxx_add_subdevice_pdata(struct mc13xx=
x *mc13xxx,
>  	if (!cell.name)
>  		return -ENOMEM;
> =20
> +	/* mfd_add_devices won't adds a .of_node to the child's dev if the

"won't add"

> +	 * cell's .off_compatible is NULL, which result in

".of_compatible", "results in"

> +	 * of_node_to_pwmchip beeing unable to find the pwm device.

"being", "PWM device"

Also I would prefer to remove the reference to of_node_to_pwmchip in the
above description. It's a non-exported API and if it were to be renamed
this comment would likely become stale.

Perhaps: "... results in the PWM core being unable to find the PWM
device."?

> +	 */
> +	if (!strncmp(format, "%s-pwm", sizeof("%s-pwm"))) {

Why special-case the PWM subdevice? Doesn't the comment really apply to
all of the subdevices? Even if the subsystems don't rely on the OF node
I think it would still be useful to set it up properly.

> +		if (snprintf(buf, sizeof(buf),
> +			     "fsl,%s", cell.name) > sizeof(buf))
> +			return -E2BIG;
> +
> +		cell.of_compatible =3D kmemdup(buf, strlen(buf) + 1, GFP_KERNEL);
> +		if (!cell.of_compatible)
> +			return -ENOMEM;

Can't the above simply be:

	cell.of_compatible =3D kasprintf(GFP_KERNEL, "fsl,%s", cell.name);

?

> +	}
> +
>  	return mfd_add_devices(mc13xxx->dev, -1, &cell, 1, NULL, 0, NULL);
>  }
> =20
> @@ -681,6 +695,7 @@ int mc13xxx_common_init(struct device *dev)
>  			&pdata->regulators, sizeof(pdata->regulators));
>  		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led",
>  				pdata->leds, sizeof(*pdata->leds));
> +		mc13xxx_add_subdevice(mc13xxx, "%s-pwm");
>  		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-pwrbutton",
>  				pdata->buttons, sizeof(*pdata->buttons));
>  		if (mc13xxx->flags & MC13XXX_USE_CODEC)
> @@ -692,6 +707,7 @@ int mc13xxx_common_init(struct device *dev)
>  	} else {
>  		mc13xxx_add_subdevice(mc13xxx, "%s-regulator");
>  		mc13xxx_add_subdevice(mc13xxx, "%s-led");
> +		mc13xxx_add_subdevice(mc13xxx, "%s-pwm");
>  		mc13xxx_add_subdevice(mc13xxx, "%s-pwrbutton");
>  		if (mc13xxx->flags & MC13XXX_USE_CODEC)
>  			mc13xxx_add_subdevice(mc13xxx, "%s-codec");

All of the above should be a separate patch that can be applied to the
MFD tree.

> diff --git a/drivers/pwm/pwm-mc34708.c b/drivers/pwm/pwm-mc34708.c
[...]
> +/*
> + * Copyright 2014 Eukr=C3=A9a Electromatique <denis@eukrea.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +

One blank line is enough.

> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +
> +#include <linux/mfd/mc13783.h>
> +
> +/* PWM register address */
> +#define MC134708_PWM		0x37
> +
> +/* PWM register fields:
> + * Bit #    RegisterName Description
> + *  [0->5]  PWM1DUTY:   PWM1 duty cycle
> + *  [6->11] PWM1CLKDIV: PWM1 duty cycle
> + * [12->17] PWM2DUTY:   PWM2 clock divide setting
> + * [18->23] PWM2CLKDIV: PWM2 clock divide setting
> + */

Block comments should be of this format:

	/*
	 * ...
	 */

> +#define MC134708_PWM_MASK			0x3f
> +#define MC134708_PWM_NUM_OFFSET			0x0c
> +
> +#define MC134708_PWM_DUTY_OFFSET(pwm_id)	(pwm_id * MC134708_PWM_NUM_OFFS=
ET)
> +#define MC134708_PWM_PERIOD_OFFSET(pwm_id)	((pwm_id * MC134708_PWM_NUM_O=
FFSET) + 0x06)

You'll need to wrap pwm_id in parentheses to make sure the expansion
does what it's supposed to.

> +
> +/* MC34708 PWM Constraints */
> +#define MC13708_BASE_CLK_FREQ	2000000

Is this really a fixed constant or is there a struct clk that can be
used to obtain this at runtime?

> +#define MC13708_PWM_MAX_DUTY	32
> +#define MC13708_PWM_MAX_CLKDIV	64
> +
> +#define MC13708_MIN_PWM_PERIOD	(NSEC_PER_SEC / MC13708_BASE_CLK_FREQ)
> +#define MC13708_MAX_PWM_PERIOD	(MC13708_MIN_PWM_PERIOD * MC13708_PWM_MAX=
_CLKDIV)
> +
> +#define MC134708_PWMS_NUM	2

This is really only needed in one place (see other comments later), so
you can use the literal when assigning it to pwm_chip's .npwm field.

> +
> +struct mc34708_pwm_regs {

_regs isn't really suitable here. These aren't really registers or
register contents.

There's also the mc34708 vs. mc134708 inconsistency here.

> +	int enabled;

bool

> +	int pwm_duty;

unsigned

> +};
> +
> +struct mc34708_pwm_chip {
> +	struct pwm_chip pwm_chip;
> +	struct mc13xxx *mc13xxx;
> +	struct mc34708_pwm_regs *pwms[MC134708_PWMS_NUM];

You don't need this. Please use the PWM subsystem's pwm_set_chip_data()
to set this data for each PWM device. You can look at the pwm-samsung,
pwm-renesas-tpu, pwm-lp3943, pwm-bfin or pwm-atmel-tcb drivers for
reference.

> +};
> +
> +static inline
> +struct mc34708_pwm_chip *to_mc34708_chip(struct pwm_chip *chip)

There's no need to wrap this, it fits on a single line just fine.

> +{
> +	return container_of(chip, struct mc34708_pwm_chip, pwm_chip);
> +}
> +
> +static int
> +pwm_mc34708_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			      int duty_ns, int period_ns)

Similarly here. This should be:

static int pwm_mc34708_config(struct pwm_chip *chip, struct pwm_device *pwm,
			      int duty_ns, int period_ns)

> +{
> +	struct mc34708_pwm_chip *mc34708_chip =3D to_mc34708_chip(chip);
> +	struct mc34708_pwm_regs *pwmr =3D mc34708_chip->pwms[pwm->hwpwm];

If you properly set up chip data, then this becomes:

	struct mc34708_pwm_regs *pwmr =3D pwm_get_chip_data(pwm);

> +	struct mc13xxx *mc13xxx =3D mc34708_chip->mc13xxx;
> +
> +	int duty_offset =3D MC134708_PWM_DUTY_OFFSET(pwm->hwpwm);
> +	int period_offset =3D MC134708_PWM_PERIOD_OFFSET(pwm->hwpwm);

These should be unsigned.

> +
> +	int pwm_clkdiv, pwm_duty, ret =3D 0;

The first two of these can also be unsigned. And there's no need for the
blank lines above.

> +
> +	/* Period */
> +	period_ns =3D clamp(period_ns, (int)MC13708_MIN_PWM_PERIOD,
> +			  (int)MC13708_MAX_PWM_PERIOD);

Rather than clamping the value here, shouldn't this be considered an
error?

> +	pwm_clkdiv =3D DIV_ROUND_UP(NSEC_PER_SEC, period_ns); /* Frequency (Hz)=
 */
> +	pwm_clkdiv =3D DIV_ROUND_UP(MC13708_BASE_CLK_FREQ,
> +				  pwm_clkdiv) - 1; /* Clock divisor */
> +
> +	/* Duty cycle */
> +	pwm_duty =3D DIV_ROUND_UP(MC13708_PWM_MAX_DUTY * duty_ns, period_ns);
> +
> +	/* Actual write to the registers */
> +	mc13xxx_lock(mc13xxx);
> +
> +	ret =3D mc13xxx_reg_rmw(mc13xxx, MC134708_PWM,
> +					MC134708_PWM_MASK << period_offset,
> +					pwm_clkdiv << period_offset);

For readability I'd prefer this to be broken out, somewhat like this:

	mask =3D MC134708_PWM_MASK << period_offset;
	value =3D pwm_clkdiv << period_offset;

	ret =3D mc13xxx_reg_rmw(mc13xx, MC134708_PWM, mask, value);
	...

> +	if (ret) {
> +		mc13xxx_unlock(mc13xxx);
> +		return ret;
> +	}
> +
> +	/* The MC34708 doesn't have an enable bit for its PWM unit,
> +	 * so we cache the pwm duty value for the .enable()
> +	 */
> +	pwmr->pwm_duty =3D pwm_duty;
> +
> +	if (pwmr->enabled) {
> +		ret =3D mc13xxx_reg_rmw(mc13xxx, MC134708_PWM,
> +				MC134708_PWM_MASK << duty_offset,
> +				pwm_duty << duty_offset);

Similarily here.

> +	}
> +	mc13xxx_unlock(mc13xxx);

There should be a blank line between the above two.

> +
> +	return ret;
> +}
> +
> +static int pwm_mc34708_enable(struct pwm_chip *chip, struct pwm_device *=
pwm)
> +{
> +	struct mc34708_pwm_chip *mc34708_chip =3D to_mc34708_chip(chip);
> +	struct mc34708_pwm_regs *pwmr =3D mc34708_chip->pwms[pwm->hwpwm];
> +	struct mc13xxx *mc13xxx =3D mc34708_chip->mc13xxx;
> +	int duty_offset =3D MC134708_PWM_DUTY_OFFSET(pwm->hwpwm);

unsigned. And perhaps since there's no period being written here this
could be simply "offset"?

> +	int ret;
> +
> +	mc13xxx_lock(mc13xxx);
> +
> +	ret =3D mc13xxx_reg_rmw(mc13xxx, MC134708_PWM,
> +			MC134708_PWM_MASK << duty_offset,
> +			pwmr->pwm_duty << duty_offset);

Similarly this could be broken out for readability.

> +	pwmr->enabled =3D 1;
> +
> +	mc13xxx_unlock(mc13xxx);
> +
> +	return ret;
> +}
> +
> +static void pwm_mc34708_disable(struct pwm_chip *chip, struct pwm_device=
 *pwm)
> +{
> +	struct mc34708_pwm_chip *mc34708_chip =3D to_mc34708_chip(chip);
> +	struct mc34708_pwm_regs *pwmr =3D mc34708_chip->pwms[pwm->hwpwm];
> +	struct mc13xxx *mc13xxx =3D mc34708_chip->mc13xxx;
> +	int duty_offset =3D MC134708_PWM_DUTY_OFFSET(pwm->hwpwm);
> +
> +	mc13xxx_lock(mc13xxx);
> +
> +	/* To disable the PWM, the duty cycle bits have to be cleared */
> +	mc13xxx_reg_rmw(mc13xxx, MC134708_PWM,
> +			MC134708_PWM_MASK << duty_offset,
> +			0 << duty_offset);
> +	pwmr->enabled =3D 0;
> +
> +	mc13xxx_unlock(mc13xxx);
> +}

Same comments as for .enable()

> +static const struct pwm_ops pwm_mc34708_ops =3D {
> +	.enable		=3D pwm_mc34708_enable,
> +	.disable	=3D pwm_mc34708_disable,
> +	.config		=3D pwm_mc34708_config,
> +	.owner		=3D THIS_MODULE,
> +};

Please don't use artificial padding here. Single spaces around '=3D' will
do just fine.

> +static int pwm_mc34708_probe(struct platform_device *pdev)
> +{
> +	struct mc34708_pwm_chip *chip;
> +	struct mc13xxx *mc13xxx;
> +	int err, i;
> +
> +	mc13xxx =3D dev_get_drvdata(pdev->dev.parent);

You could assign this when initializing to save a few lines.

> +	if (!mc13xxx)
> +		return -EINVAL;

Can this really ever happen?

> +	chip =3D devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +			return -ENOMEM;

There's an extra tab here.

> +
> +	for (i =3D 0; i < MC134708_PWMS_NUM; i++) {
> +		chip->pwms[i] =3D devm_kzalloc(&pdev->dev,
> +			sizeof(struct mc34708_pwm_regs), GFP_KERNEL);
> +	}

When you switch to pwm_{set,get}_chip_data() the typical way to allocate
this is in a separate .request() function (and free it in .free()).

> +MODULE_ALIAS("platform:mc34708-pwm");
> +MODULE_AUTHOR("Denis Carikli <denis@eukrea.com>");
> +MODULE_DESCRIPTION("mc34708 Pulse Width Modulation Driver");

This could probably mention Freescale as the vendor? Or perhaps for
consistency with other MFD subdrivers:

	"PWM Driver for Freescale MC134708 PMIC"

?

Thierry

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTrQllAAoJEN0jrNd/PrOhN1UP/ipzERqI3opQsX/FSFOKcbWx
QFhw26exiCmFDYRKfYc/93Xnh2Pa28IJSvH3opc1ikfN6m/5+1lVHmKjDZg3OB/F
nFlWsjGs/2rIwySI6s54MhbwkNr3FR/XudclKdOBkdqPBffpCYF15El/4Zho4Tsw
rnelv3UW3BraW2o6+9cuvSiqsCNaX8NvdpHuYGqNLPrfKIEY8S9hTDRXSmjpJlkJ
BP+rlJwgl0l30z1al+rsksXvsxLCWX/O91pIocoBfoOItZDAsNsH5KHkbQD35BG9
LJEutn/fiwfNNdzewrFyoZteVZpumRZPctXTFsU4jeJnIBPgtfAdEwTDWyvtMWhB
j+/N91+eSDwvs6PU3BU8/QS5QtVs7fOSCZd0CgOTU/emFoR30a2FSP8j8HNDPhW9
Ai9/uq/7B0JuiN9sgwP58U0xgaKSpjROERGZeNn5ole194VpqGksWYHbFFX5NnPb
O1qb3LmbL/GilRtJg1alw8BentEIBSo0BhXGRQmkhjK2z4JHsl/IK4QYh6uYEYfW
x3onbx3wGIIH0UD3jfH4eu6IlVV3pmrFShshkLdKaVWxBtAXS4XmOjwY5ZEzpggC
gUfovwQrYcdf+Uxb91W2U2f7HDlIHQT3/GXDRq79qtr5irbBGtoZ6gNYgrNyxvAD
5Tq2kIQpfblVX7hAVDY0
=EPsN
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
