Return-Path: <Milo.Kim@ti.com>
From: "Kim, Milo" <Milo.Kim@ti.com>
Subject: [PATCH 2/3] gpio: add LP3943 I2C GPIO expander driver
Date: Tue, 16 Jul 2013 02:38:39 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F82E815CE@DQHE06.ent.ti.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-pwm.vger.kernel.org>
To: "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Cc: "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>

This is a part of LP3943 MFD driver.
LP3943 is configurable as a GPIO expander, up to 16 GPIOs.

* Application note: how to configure LP3943 as a GPIO expander
  http://www.ti.com/lit/an/snva287a/snva287a.pdf

* Supported GPIO controller operations
  direction_input, direction_output, get, set

* GPIO direction register not supported
  LP3943 doesn't have the GPIO direction register. It only provides input a=
nd
  output status registers.
  So, private data for the direction should be handled manually.
  This variable is updated whenever the direction is changed and
  used in 'get' operation.

* Register access through exported LP3943 MFD functions

Signed-off-by: Milo Kim <milo.kim@ti.com>
---
 drivers/gpio/Kconfig       |    6 ++
 drivers/gpio/Makefile      |    1 +
 drivers/gpio/gpio-lp3943.c |  224 ++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 231 insertions(+)
 create mode 100644 drivers/gpio/gpio-lp3943.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 573c449..d80801f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -325,6 +325,12 @@ config GPIO_ARIZONA
 	help
 	  Support for GPIOs on Wolfson Arizona class devices.
=20
+config GPIO_LP3943
+	tristate "TI/National Semiconductor LP3943 GPIO expander"
+	depends on MFD_LP3943
+	help
+	  GPIO driver for LP3943 MFD.
+
 config GPIO_MAX7300
 	tristate "Maxim MAX7300 GPIO expander"
 	depends on I2C
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 0cb2d65..ff580ac 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_GPIO_IT8761E)	+=3D gpio-it8761e.o
 obj-$(CONFIG_GPIO_JANZ_TTL)	+=3D gpio-janz-ttl.o
 obj-$(CONFIG_ARCH_KS8695)	+=3D gpio-ks8695.o
 obj-$(CONFIG_GPIO_LANGWELL)	+=3D gpio-langwell.o
+obj-$(CONFIG_GPIO_LP3943)	+=3D gpio-lp3943.o
 obj-$(CONFIG_ARCH_LPC32XX)	+=3D gpio-lpc32xx.o
 obj-$(CONFIG_GPIO_LYNXPOINT)	+=3D gpio-lynxpoint.o
 obj-$(CONFIG_GPIO_MAX730X)	+=3D gpio-max730x.o
diff --git a/drivers/gpio/gpio-lp3943.c b/drivers/gpio/gpio-lp3943.c
new file mode 100644
index 0000000..dc74ca4
--- /dev/null
+++ b/drivers/gpio/gpio-lp3943.c
@@ -0,0 +1,224 @@
+/*
+ * TI/National Semiconductor LP3943 GPIO driver
+ *
+ *			Copyright (C) 2013 Texas Instruments
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2.
+ */
+
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/mfd/lp3943.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define to_lp3943_gpio(_chip)	container_of(_chip, struct lp3943_gpio, chip=
)
+
+enum lp3943_gpios {
+	LP3943_GPIO1,
+	LP3943_GPIO2,
+	LP3943_GPIO3,
+	LP3943_GPIO4,
+	LP3943_GPIO5,
+	LP3943_GPIO6,
+	LP3943_GPIO7,
+	LP3943_GPIO8,
+	LP3943_GPIO9,
+	LP3943_GPIO10,
+	LP3943_GPIO11,
+	LP3943_GPIO12,
+	LP3943_GPIO13,
+	LP3943_GPIO14,
+	LP3943_GPIO15,
+	LP3943_GPIO16,
+	LP3943_MAX_GPIO,
+};
+
+struct lp3943_gpio {
+	struct gpio_chip chip;
+	struct lp3943 *l;
+	bool is_input[LP3943_MAX_GPIO];
+};
+
+static int lp3943_gpio_direction_input(struct gpio_chip *chip, unsigned of=
fset)
+{
+	struct lp3943_gpio *lg =3D to_lp3943_gpio(chip);
+	const struct lp3943_reg_cfg *mux =3D lg->l->mux_cfg;
+	u8 addr;
+	u8 mask;
+	u8 shift;
+
+	lg->is_input[offset] =3D true;
+
+	addr  =3D mux[offset].reg;
+	mask  =3D mux[offset].mask;
+	shift =3D mux[offset].shift;
+
+	return lp3943_update_bits(lg->l, addr, mask, LP3943_GPIO_IN << shift);
+}
+
+static int lp3943_get_gpio_in_status(struct lp3943_gpio *lg,
+				struct gpio_chip *chip, unsigned offset)
+{
+	u8 addr;
+	u8 read;
+	int err;
+
+	switch (offset) {
+	case LP3943_GPIO1 ... LP3943_GPIO8:
+		addr =3D LP3943_REG_GPIO_A;
+		break;
+	case LP3943_GPIO9 ... LP3943_GPIO16:
+		addr =3D LP3943_REG_GPIO_B;
+		offset =3D offset - 8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	err =3D lp3943_read_byte(lg->l, addr, &read);
+	if (err)
+		return err;
+
+	if (read & (1 << offset))
+		return 1;
+	else
+		return 0;
+}
+
+static int lp3943_get_gpio_out_status(struct lp3943_gpio *lg,
+				struct gpio_chip *chip, unsigned offset)
+{
+	const struct lp3943_reg_cfg *mux =3D lg->l->mux_cfg;
+	u8 addr  =3D mux[offset].reg;
+	u8 mask  =3D mux[offset].mask;
+	u8 shift =3D mux[offset].shift;
+	u8 read;
+	int err;
+
+	err =3D lp3943_read_byte(lg->l, addr, &read);
+	if (err)
+		return err;
+
+	read =3D (read & mask) >> shift;
+
+	if (read =3D=3D LP3943_GPIO_OUT_HIGH)
+		return 1;
+	else if (read =3D=3D LP3943_GPIO_OUT_LOW)
+		return 0;
+	else
+		return -EINVAL;
+}
+
+static int lp3943_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct lp3943_gpio *lg =3D to_lp3943_gpio(chip);
+
+	/*
+	 * Limitation:
+	 *   LP3943 doesn't have the GPIO direction register. It provides
+	 *   only input and output status registers.
+	 *   So, direction info is required to handle the 'get' operation.
+	 *   This variable is updated whenever the direction is changed and
+	 *   it is used here.
+	 */
+
+	if (lg->is_input[offset])
+		return lp3943_get_gpio_in_status(lg, chip, offset);
+	else
+		return lp3943_get_gpio_out_status(lg, chip, offset);
+}
+
+static void lp3943_gpio_set(struct gpio_chip *chip, unsigned offset, int v=
alue)
+{
+	struct lp3943_gpio *lg =3D to_lp3943_gpio(chip);
+	const struct lp3943_reg_cfg *mux =3D lg->l->mux_cfg;
+	u8 addr;
+	u8 mask;
+	u8 shift;
+	u8 data;
+
+	addr  =3D mux[offset].reg;
+	mask  =3D mux[offset].mask;
+	shift =3D mux[offset].shift;
+
+	if (value)
+		data =3D LP3943_GPIO_OUT_HIGH;
+	else
+		data =3D LP3943_GPIO_OUT_LOW;
+
+	lp3943_update_bits(lg->l, addr, mask, data << shift);
+}
+
+static int lp3943_gpio_direction_output(struct gpio_chip *chip, unsigned o=
ffset,
+					int value)
+{
+	struct lp3943_gpio *lg =3D to_lp3943_gpio(chip);
+
+	lp3943_gpio_set(chip, offset, value);
+	lg->is_input[offset] =3D false;
+
+	return 0;
+}
+
+static const struct gpio_chip lp3943_gpio_chip =3D {
+	.label			=3D "lp3943",
+	.owner			=3D THIS_MODULE,
+	.direction_input	=3D lp3943_gpio_direction_input,
+	.get			=3D lp3943_gpio_get,
+	.direction_output	=3D lp3943_gpio_direction_output,
+	.set			=3D lp3943_gpio_set,
+	.base			=3D -1,
+	.ngpio			=3D LP3943_MAX_GPIO,
+	.can_sleep		=3D 1,
+};
+
+static int lp3943_gpio_probe(struct platform_device *pdev)
+{
+	struct lp3943 *l =3D dev_get_drvdata(pdev->dev.parent);
+	struct lp3943_gpio *lg;
+	int ret;
+
+	lg =3D devm_kzalloc(&pdev->dev, sizeof(struct lp3943_gpio), GFP_KERNEL);
+	if (!lg)
+		return -ENOMEM;
+
+	lg->l =3D l;
+	lg->chip =3D lp3943_gpio_chip;
+	lg->chip.dev =3D &pdev->dev;
+
+	platform_set_drvdata(pdev, lg);
+
+	ret =3D gpiochip_add(&lg->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to add GPIO chip, err:%d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int lp3943_gpio_remove(struct platform_device *pdev)
+{
+	struct lp3943_gpio *lg =3D platform_get_drvdata(pdev);
+	return gpiochip_remove(&lg->chip);
+}
+
+static struct platform_driver lp3943_gpio_driver =3D {
+	.probe =3D lp3943_gpio_probe,
+	.remove =3D lp3943_gpio_remove,
+	.driver =3D {
+		.name =3D "lp3943-gpio",
+		.owner =3D THIS_MODULE,
+	},
+};
+module_platform_driver(lp3943_gpio_driver);
+
+MODULE_DESCRIPTION("LP3943 GPIO driver");
+MODULE_AUTHOR("Milo Kim");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:lp3943-gpio");
--=20
1.7.9.5


Best Regards,
Milo
