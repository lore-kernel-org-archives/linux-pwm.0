From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 07/10] pwm: gpio: Add a generic gpio based PWM driver
Date: Fri, 6 Nov 2015 16:57:32 +0100
Message-ID: <20151106155732.GE8418@ulmo>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
 <1445895161-2317-8-git-send-email-o.schinagl@ultimaker.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34009 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbbKFP5f (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Nov 2015 10:57:35 -0500
Content-Disposition: inline
In-Reply-To: <1445895161-2317-8-git-send-email-o.schinagl@ultimaker.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: Olliver Schinagl <oliver@schinagl.nl>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Joachim Eastwood <manabian@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Olliver Schinagl <oliver+list@schinagl.nl>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2015 at 10:32:38PM +0100, Olliver Schinagl wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
>=20
> This patch adds a bit-banging gpio PWM driver. It makes use of hrtimers,
> to allow nano-second resolution, though it obviously strongly depends on
> the switching speed of the gpio pins, hrtimer and system load.
>=20
> Each pwm node can have 1 or more "pwm-gpio" entries, which will be
> treated as pwm's as part of a pwm chip.
>=20
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-gpio.txt |  18 ++
>  MAINTAINERS                                        |   5 +
>  drivers/pwm/Kconfig                                |  15 ++
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-gpio.c                             | 253 +++++++++++++++=
++++++
>  5 files changed, 292 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.txt
>  create mode 100644 drivers/pwm/pwm-gpio.c
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-gpio.txt b/Documen=
tation/devicetree/bindings/pwm/pwm-gpio.txt
> new file mode 100644
> index 0000000..336f61f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-gpio.txt
> @@ -0,0 +1,18 @@
> +Generic GPIO bit-banged PWM driver
> +
> +Required properties:
> +  - compatible: should be "pwm-gpio"
> +  - #pwm-cells: should be 3, see pwm.txt in this directory for a general
> +    description of the cells format.
> +  - pwm-gpios: one or more gpios describing the used gpio, see the gpio
> +    bindings for the used gpio driver.

I agree with Rob that a single GPIO per PWM chip would be more
straightforward here. Having multiple GPIOs per chip, and hence a
multi-channel chip, suggests that they are in some fashion grouped
whereas in reality they are really completely separate.

> +Example:
> +#include <dt-bindings/gpio/gpio.h>
> +
> +	pwm: pwm@0 {
> +		compatible =3D "pwm-gpio";
> +		#pwm-cells =3D 3;

I think the correct syntax for this would be: #pwm-cells =3D <3>;

> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0cfaf6b..c0bc296 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -170,6 +170,21 @@ config PWM_IMG
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-img
> =20
> +config PWM_GPIO
> +	tristate "Generic GPIO bit-banged PWM driver"
> +	depends on OF
> +	depends on GPIOLIB
> +	help
> +	  Some platforms do not offer any hardware PWM capabilities but do have
> +	  General Purpose Input Output (GPIO) pins available. Using the kernels
> +	  High-Resolution Timer API this driver tries to toggle GPIO using the
> +	  generic kernel PWM framework. The maximum frequency and/or accuracy
> +	  is dependent on several factors such as system load and the maximum
> +	  speed a pin can be toggled at the hardware.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-gpio.
> +

This is oddly sorted. Entries should be ordered alphabetically.

>  config PWM_IMX
>  	tristate "i.MX PWM support"
>  	depends on ARCH_MXC
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 69b8275..96aa9aa 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_PWM_CLPS711X)	+=3D pwm-clps711x.o
>  obj-$(CONFIG_PWM_CRC)		+=3D pwm-crc.o
>  obj-$(CONFIG_PWM_EP93XX)	+=3D pwm-ep93xx.o
>  obj-$(CONFIG_PWM_FSL_FTM)	+=3D pwm-fsl-ftm.o
> +obj-$(CONFIG_PWM_GPIO)		+=3D pwm-gpio.o
>  obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
>  obj-$(CONFIG_PWM_IMX)		+=3D pwm-imx.o
>  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o

The ordering is correct here. Perhaps just something that got introduced
by oversight in a rebase?

> diff --git a/drivers/pwm/pwm-gpio.c b/drivers/pwm/pwm-gpio.c
> new file mode 100644
> index 0000000..8b588fb
> --- /dev/null
> +++ b/drivers/pwm/pwm-gpio.c
> @@ -0,0 +1,253 @@
> +/*
> + * Copyright (c) 2015 Olliver Schinagl <oliver@schinagl.nl>
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
> + * This driver adds a high-resolution timer based PWM driver. Since this=
 is a
> + * bit-banged driver, accuracy will always depend on a lot of factors, s=
uch as
> + * GPIO toggle speed and system load.

I'm not sure this is helpful. The Kconfig snippet already has this
information.

> + */
> +
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/property.h>
> +#include <linux/pwm.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/device.h>
> +#include <linux/hrtimer.h>
> +#include <linux/ktime.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>

Please keep these sorted alphabetically.

> +
> +#define DRV_NAME "pwm-gpio"

You only have two locations where you use this and it's going to be ABI
immediately, hence you will never be able to change it anyway. So there
is really no need for this define.

> +
> +struct gpio_pwm_data {

In my opinion the _data suffix here is redundant.

> +	struct hrtimer timer;
> +	struct gpio_desc *gpiod;
> +	bool polarity;

I think this should probably be called "invert" judging by how it's
used.

> +	bool pin_on;
> +	int on_time;
> +	int off_time;

These can probably be unsigned.

> +	bool run;

How is this different from pwm_is_enabled()?

> +};
> +
> +struct gpio_pwm_chip {
> +	struct pwm_chip chip;
> +};

If you restrict the driver to a single PWM channel you can merge the
gpio_pwm_data structure into this and vastly simplify the management of
resources.

> +
> +static void gpio_pwm_off(struct gpio_pwm_data *gpio_data)
> +{
> +	gpiod_set_value_cansleep(gpio_data->gpiod, gpio_data->polarity ? 0 : 1);
> +}
> +
> +static void gpio_pwm_on(struct gpio_pwm_data *gpio_data)
> +{
> +	gpiod_set_value_cansleep(gpio_data->gpiod, gpio_data->polarity ? 1 : 0);
> +}

According to this, polarity =3D=3D true means that polarity is normal.

> +static int gpio_pwm_set_polarity(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> +				 enum pwm_polarity polarity)
> +{
> +	struct gpio_pwm_data *gpio_data =3D pwm_get_chip_data(pwm);
> +
> +	gpio_data->polarity =3D (polarity !=3D PWM_POLARITY_NORMAL) ? true : fa=
lse;
> +
> +	return 0;
> +}

But here polarity =3D=3D true only if the PWM is configured for inverse
polarity.

> +static int gpio_pwm_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct gpio_pwm_chip *gpio_chip;
> +	int npwm, i;

i can be unsigned int.

> +	int hrtimer =3D 0;

This can be unsigned int.

> +
> +	npwm =3D of_gpio_named_count(pdev->dev.of_node, "pwm-gpios");
> +	if (npwm < 1)
> +		return -ENODEV;

Don't you want to propagate error codes from of_gpio_named_count()? So
this should probably be:

	if (npwm < 0)
		return npwm;

	if (npwm < 1)
		return -ENODEV;

> +
> +	gpio_chip =3D devm_kzalloc(&pdev->dev, sizeof(*gpio_chip), GFP_KERNEL);
> +	if (!gpio_chip)
> +		return -ENOMEM;
> +
> +	gpio_chip->chip.dev =3D &pdev->dev;
> +	gpio_chip->chip.ops =3D &gpio_pwm_ops;
> +	gpio_chip->chip.base =3D -1;
> +	gpio_chip->chip.npwm =3D npwm;
> +	gpio_chip->chip.of_xlate =3D of_pwm_xlate_with_flags;
> +	gpio_chip->chip.of_pwm_n_cells =3D 3;
> +	gpio_chip->chip.can_sleep =3D true;
> +
> +	ret =3D pwmchip_add(&gpio_chip->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
> +		return ret;
> +	}

You should call pwmchip_add() as late as possible. The pwmchip_add()
will register the device with sysfs and hence make it available to
userspace. Userspace may immediately start using it, but the below can
easily lead to the device going away shortly after it was made
available.

> +	for (i =3D 0; i < npwm; i++) {
> +		struct gpio_desc *gpiod;
> +		struct gpio_pwm_data *gpio_data;
> +
> +		gpiod =3D devm_gpiod_get_index(&pdev->dev, "pwm", i,
> +					     GPIOD_OUT_LOW);
> +		if (IS_ERR(gpiod)) {
> +			int error;
> +
> +			error =3D PTR_ERR(gpiod);
> +			if (error !=3D -EPROBE_DEFER)
> +				dev_err(&pdev->dev,
> +					"failed to get gpio flags, error: %d\n",
> +					error);
> +			return error;
> +		}
> +
> +		gpio_data =3D devm_kzalloc(&pdev->dev, sizeof(*gpio_data),
> +					 GFP_KERNEL);
> +
> +		hrtimer_init(&gpio_data->timer,
> +			     CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +		gpio_data->timer.function =3D &gpio_pwm_timer;
> +		gpio_data->gpiod =3D gpiod;
> +		gpio_data->pin_on =3D false;
> +		gpio_data->run =3D false;
> +
> +		if (hrtimer_is_hres_active(&gpio_data->timer))
> +			hrtimer++;
> +
> +		pwm_set_chip_data(&gpio_chip->chip.pwms[i], gpio_data);
> +	}

It seems that the only reason why you need to call pwmchip_add() early
is so that the PWMs are allocated when you initialize them here. That's
easily avoided if you opt for a single PWM per chip, since you can
simply manage the resources as part of the chip rather than relying on
the per-PWM chip data.

> +	if (!hrtimer)
> +		dev_warn(&pdev->dev, "unable to use High-Resolution timer,");
> +		dev_warn(&pdev->dev, "%s is restricted to low resolution.",
> +			 DRV_NAME);

You'll need curly braces around these two statements, otherwise you'll
always show the second part of the warning. Also in the above there is
no newline. It's also not going to produce the desired output, even if
you use curly braces because dev_warn() will cause KERN_WARNING prefix
to be output and mess up the output. You'd want pr_cont() here, but I
don't think that's necessary. Perhaps shorten this to something like:

	if (!hrtimer)
		dev_warn(&pdev->dev, "HR timer unavailable, restricting to "
			             "low resolution\n");

Also there's no need to include DRV_NAME in the message since it's
already part of the prefix added by dev_warn().

> +	platform_set_drvdata(pdev, gpio_chip);
> +
> +	dev_info(&pdev->dev, "%d gpio pwms loaded\n", npwm);

Please either drop this or make it debug level. No need to brag about
success. We're interested in seeing error messages. Also if you want to
keep this, please replace gpio by GPIO and pwms by PWMs.

> +static int gpio_pwm_remove(struct platform_device *pdev)
> +{
> +	struct gpio_pwm_chip *gpio_chip;
> +	int i;

unsigned int.

> +
> +	gpio_chip =3D platform_get_drvdata(pdev);

Any reason why you put this on the same line where you declare
gpio_chip?

> +	for (i =3D 0; i < gpio_chip->chip.npwm; i++) {
> +		struct gpio_pwm_data *gpio_data;
> +
> +		gpio_data =3D pwm_get_chip_data(&gpio_chip->chip.pwms[i]);
> +
> +		hrtimer_cancel(&gpio_data->timer);
> +	}
> +
> +	return pwmchip_remove(&gpio_chip->chip);
> +}
> +
> +static const struct of_device_id gpio_pwm_of_match[] =3D {
> +	{ .compatible =3D DRV_NAME, },
> +	{/* sentinel */},
> +};
> +MODULE_DEVICE_TABLE(of, gpio_pwm_of_match);
> +
> +static struct platform_driver gpio_pwm_driver =3D {
> +	.probe =3D gpio_pwm_probe,
> +	.remove =3D gpio_pwm_remove,
> +	.driver =3D {
> +		.name =3D DRV_NAME,
> +		.of_match_table =3D of_match_ptr(gpio_pwm_of_match),

No need for this conditional. You're effectively OF-only because of the
call to of_gpio_named_count() in ->probe(). If you drop multiple-GPIO
support you'll get non-OF support for free as far as I can tell, so one
more reason to simplify.

But then if you do support non-OF, you'll need to protect the OF device
table with appropriate #ifdef guards, otherwise the compiler will
complain about it being unused.

Thierry

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWPM3pAAoJEN0jrNd/PrOhVh4QALnSFJsPbTyhikSR9Ak7Mujo
uQrO6cYMsrZ2w8y4fhrI/SlsZQe7K1C2S7iHEr0Kk80K/BCMNRE4WE8uDk8ApVVU
JDuGos0+lDoRJqE3IXko353OKPRZiByPqgfP5ffW5YqA2ZtYp18QcLHMID4BT0yA
k+FrpkAR/UARSFN15D0EBhYtqgsapjX2xrFh7oeGYuR/PFDbhMu/KYNsHfc9mgxK
SCY6em6QXyLDoMLOhkCccCHDpHpI0T/Ww6p0GWU7l59T+wWlQQoc1Ami8EmS7K9j
Q1gH0aGjHtzHoCjCbkl8HN0WIqX/funRT+rBOMCWCnSYQkA8P1cD+WIUETJwE6it
alMQmcGJiS1yIT5k9B/0uNpq7TjfdDOnpb3y4lpAYdL05mBq4dNzuelwBc+Fbc1N
qUhVEiD8tz6OOHFAX8RE5vVHHGk17UCGtenh6iJS3pNDum+jWOZq4OKwdcwUUQ1p
DA4v1IX2RGuINPcY3q1aEZS+zOzsq2amWiePpalNrjXZG+mE8X4tmA/vAnvo8yVf
d5tm2AMkpwVgzA1gpP3sRX1QcsxpzKhEPl0UAwHT98UifLkTG6GxLkl36rj8UODA
4nSyomEU7Q8kkY5pN4HPCO1s3azS0OxtK2SyN9+54s3K7iESwv+A43rMkVXRRvq8
ZdvSrBd0LC5ZAlYrAeS/
=zfFb
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
