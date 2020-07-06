From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: [PATCH v5 02/13] mfd: add simple regmap based I2C driver
Date: Mon,  6 Jul 2020 19:53:42 +0200
Message-ID: <20200706175353.16404-3-michael@walle.cc>
References: <20200706175353.16404-1-michael@walle.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200706175353.16404-1-michael-QKn5cuLxLXY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <maz-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

There are I2C devices which contain several different functions but
doesn't require any special access functions. For these kind of drivers
an I2C regmap should be enough.

Create an I2C driver which creates an I2C regmap and enumerates its
children. If a device wants to use this as its MFD core driver, it has
to add an individual compatible string. It may provide its own regmap
configuration.

Subdevices can use dev_get_regmap() on the parent to get their regmap
instance.

Signed-off-by: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
---
Changes since v4:
 - new patch. Lee, please bear with me. I didn't want to delay the
   new version (where a lot of remarks on the other patches were
   addressed) even more, just because we haven't figured out how
   to deal with the MFD part. So for now, I've included this one.

 drivers/mfd/Kconfig          |  9 +++++++
 drivers/mfd/Makefile         |  1 +
 drivers/mfd/simple-mfd-i2c.c | 50 ++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 drivers/mfd/simple-mfd-i2c.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 33df0837ab41..f1536a710aca 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1162,6 +1162,15 @@ config MFD_SI476X_CORE
 	  To compile this driver as a module, choose M here: the
 	  module will be called si476x-core.
 
+config MFD_SIMPLE_MFD_I2C
+	tristate "Simple regmap based I2C devices"
+	depends on I2C
+	select MFD_CORE
+	select REGMAP_I2C
+	help
+	  This is a consolidated driver for all MFD devices which are
+	  basically just a regmap bus driver.
+
 config MFD_SM501
 	tristate "Silicon Motion SM501"
 	depends on HAS_DMA
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index a60e5f835283..78d24a3e7c9e 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -264,3 +264,4 @@ obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
 
 obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
+obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
new file mode 100644
index 000000000000..1fdca89964b1
--- /dev/null
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/core.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+
+struct simple_mfd_i2c_config {
+	const struct regmap_config *regmap_config;
+};
+
+static const struct regmap_config simple_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int simple_mfd_i2c_probe(struct i2c_client *i2c)
+{
+	const struct regmap_config *regmap_config = &simple_regmap_config;
+	const struct simple_mfd_i2c_config *config;
+	struct regmap *regmap;
+
+	config = device_get_match_data(&i2c->dev);
+
+	if (config && config->regmap_config)
+		regmap_config = config->regmap_config;
+
+	regmap = devm_regmap_init_i2c(i2c, regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return devm_of_platform_populate(&i2c->dev);
+}
+
+static const struct of_device_id simple_mfd_i2c_of_match[] = {
+	{}
+};
+
+static struct i2c_driver simple_mfd_i2c_driver = {
+	.probe_new = simple_mfd_i2c_probe,
+	.driver = {
+		.name = "simple-mfd-i2c",
+		.of_match_table = simple_mfd_i2c_of_match,
+	},
+};
+builtin_i2c_driver(simple_mfd_i2c_driver);
-- 
2.20.1
