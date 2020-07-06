From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: [PATCH v5 06/13] watchdog: add support for sl28cpld watchdog
Date: Mon,  6 Jul 2020 19:53:46 +0200
Message-ID: <20200706175353.16404-7-michael@walle.cc>
References: <20200706175353.16404-1-michael@walle.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200706175353.16404-1-michael-QKn5cuLxLXY@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <maz-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Add support for the watchdog of the sl28cpld board management
controller. This is part of a multi-function device driver.

Signed-off-by: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Acked-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
Changes since v4:
 - update copyright year
 - remove #include <linux/of_device.h>, suggested by Andy.
 - slightly reworked the error code handling (only style), suggested by
   Andy.
 - Don't use "if (ret < 0)", but only "if (ret)", suggested by Andy.
 - remove comma in terminator line of the compatible strings list
 - don't use KBUID_MODNAME
 - remove the platform device table

Changes since v3:
 - see cover letter

 drivers/watchdog/Kconfig        |  11 ++
 drivers/watchdog/Makefile       |   1 +
 drivers/watchdog/sl28cpld_wdt.c | 229 ++++++++++++++++++++++++++++++++
 3 files changed, 241 insertions(+)
 create mode 100644 drivers/watchdog/sl28cpld_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 4f4687c46d38..c4115ea0d3f8 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -340,6 +340,17 @@ config MLX_WDT
 	  To compile this driver as a module, choose M here: the
 	  module will be called mlx-wdt.
 
+config SL28CPLD_WATCHDOG
+	tristate "Kontron sl28cpld Watchdog"
+	select MFD_SIMPLE_MFD_I2C
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include support for the watchdog timer
+	  on the Kontron sl28 CPLD.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sl28cpld_wdt.
+
 # ALPHA Architecture
 
 # ARM Architecture
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 97bed1d3d97c..aa6e41126901 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -225,3 +225,4 @@ obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
 obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
 obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
 obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
+obj-$(CONFIG_SL28CPLD_WATCHDOG) += sl28cpld_wdt.o
diff --git a/drivers/watchdog/sl28cpld_wdt.c b/drivers/watchdog/sl28cpld_wdt.c
new file mode 100644
index 000000000000..a45047d8d9ab
--- /dev/null
+++ b/drivers/watchdog/sl28cpld_wdt.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * sl28cpld watchdog driver
+ *
+ * Copyright 2020 Kontron Europe GmbH
+ */
+
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/watchdog.h>
+
+/*
+ * Watchdog timer block registers.
+ */
+#define WDT_CTRL			0x00
+#define  WDT_CTRL_EN			BIT(0)
+#define  WDT_CTRL_LOCK			BIT(2)
+#define  WDT_CTRL_ASSERT_SYS_RESET	BIT(6)
+#define  WDT_CTRL_ASSERT_WDT_TIMEOUT	BIT(7)
+#define WDT_TIMEOUT			0x01
+#define WDT_KICK			0x02
+#define  WDT_KICK_VALUE			0x6b
+#define WDT_COUNT			0x03
+
+#define WDT_DEFAULT_TIMEOUT		10
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static int timeout;
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout, "Initial watchdog timeout in seconds");
+
+struct sl28cpld_wdt {
+	struct watchdog_device wdd;
+	struct regmap *regmap;
+	u32 offset;
+	bool assert_wdt_timeout;
+};
+
+static int sl28cpld_wdt_ping(struct watchdog_device *wdd)
+{
+	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	return regmap_write(wdt->regmap, wdt->offset + WDT_KICK,
+			    WDT_KICK_VALUE);
+}
+
+static int sl28cpld_wdt_start(struct watchdog_device *wdd)
+{
+	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
+	unsigned int val;
+
+	val = WDT_CTRL_EN | WDT_CTRL_ASSERT_SYS_RESET;
+	if (wdt->assert_wdt_timeout)
+		val |= WDT_CTRL_ASSERT_WDT_TIMEOUT;
+	if (nowayout)
+		val |= WDT_CTRL_LOCK;
+
+	return regmap_update_bits(wdt->regmap, wdt->offset + WDT_CTRL,
+				  val, val);
+}
+
+static int sl28cpld_wdt_stop(struct watchdog_device *wdd)
+{
+	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	return regmap_update_bits(wdt->regmap, wdt->offset + WDT_CTRL,
+				  WDT_CTRL_EN, 0);
+}
+
+static unsigned int sl28cpld_wdt_get_timeleft(struct watchdog_device *wdd)
+{
+	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(wdt->regmap, wdt->offset + WDT_COUNT, &val);
+	if (ret)
+		return 0;
+
+	return val;
+}
+
+static int sl28cpld_wdt_set_timeout(struct watchdog_device *wdd,
+				    unsigned int timeout)
+{
+	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
+	int ret;
+
+	ret = regmap_write(wdt->regmap, wdt->offset + WDT_TIMEOUT, timeout);
+	if (ret)
+		return ret;
+
+	wdd->timeout = timeout;
+
+	return 0;
+}
+
+static const struct watchdog_info sl28cpld_wdt_info = {
+	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity = "sl28cpld watchdog",
+};
+
+static struct watchdog_ops sl28cpld_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = sl28cpld_wdt_start,
+	.stop = sl28cpld_wdt_stop,
+	.ping = sl28cpld_wdt_ping,
+	.set_timeout = sl28cpld_wdt_set_timeout,
+	.get_timeleft = sl28cpld_wdt_get_timeleft,
+};
+
+static int sl28cpld_wdt_probe(struct platform_device *pdev)
+{
+	struct watchdog_device *wdd;
+	struct sl28cpld_wdt *wdt;
+	unsigned int status;
+	unsigned int val;
+	int ret;
+
+	if (!pdev->dev.parent)
+		return -ENODEV;
+
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	wdt->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!wdt->regmap)
+		return -ENODEV;
+
+	ret = device_property_read_u32(&pdev->dev, "reg", &wdt->offset);
+	if (ret)
+		return -EINVAL;
+
+	wdt->assert_wdt_timeout = device_property_read_bool(&pdev->dev,
+							    "kontron,assert-wdt-timeout-pin");
+
+	/* initialize struct watchdog_device */
+	wdd = &wdt->wdd;
+	wdd->parent = &pdev->dev;
+	wdd->info = &sl28cpld_wdt_info;
+	wdd->ops = &sl28cpld_wdt_ops;
+	wdd->min_timeout = 1;
+	wdd->max_timeout = 255;
+
+	watchdog_set_drvdata(wdd, wdt);
+	watchdog_stop_on_reboot(wdd);
+
+	/*
+	 * Read the status early, in case of an error, we haven't modified the
+	 * hardware.
+	 */
+	ret = regmap_read(wdt->regmap, wdt->offset + WDT_CTRL, &status);
+	if (ret)
+		return ret;
+
+	/*
+	 * Initial timeout value, may be overwritten by device tree or module
+	 * parmeter in watchdog_init_timeout().
+	 *
+	 * Reading a zero here means that either the hardware has a default
+	 * value of zero (which is very unlikely and definitely a hardware
+	 * bug) or the bootloader set it to zero. In any case, we handle
+	 * this case gracefully and set out own timeout.
+	 */
+	ret = regmap_read(wdt->regmap, wdt->offset + WDT_TIMEOUT, &val);
+	if (ret)
+		return ret;
+
+	if (val)
+		wdd->timeout = val;
+	else
+		wdd->timeout = WDT_DEFAULT_TIMEOUT;
+
+	watchdog_init_timeout(wdd, timeout, &pdev->dev);
+	sl28cpld_wdt_set_timeout(wdd, wdd->timeout);
+
+	/* if the watchdog is locked, we set nowayout */
+	if (status & WDT_CTRL_LOCK)
+		nowayout = true;
+	watchdog_set_nowayout(wdd, nowayout);
+
+	/*
+	 * If watchdog is already running, keep it enabled, but make
+	 * sure its mode is set correctly.
+	 */
+	if (status & WDT_CTRL_EN) {
+		sl28cpld_wdt_start(wdd);
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
+	}
+
+	ret = devm_watchdog_register_device(&pdev->dev, wdd);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to register watchdog device\n");
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "initial timeout %d sec%s\n",
+		 wdd->timeout, nowayout ? ", nowayout" : "");
+
+	return 0;
+}
+
+static const struct of_device_id sl28cpld_wdt_of_match[] = {
+	{ .compatible = "kontron,sl28cpld-wdt" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sl28cpld_wdt_of_match);
+
+static struct platform_driver sl28cpld_wdt_driver = {
+	.probe = sl28cpld_wdt_probe,
+	.driver = {
+		.name = "sl28cpld-wdt",
+		.of_match_table = sl28cpld_wdt_of_match,
+	},
+};
+module_platform_driver(sl28cpld_wdt_driver);
+
+MODULE_DESCRIPTION("sl28cpld Watchdog Driver");
+MODULE_AUTHOR("Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>");
+MODULE_LICENSE("GPL");
-- 
2.20.1
