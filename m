From: Michael Walle <michael@walle.cc>
Subject: [PATCH v4 04/11] watchdog: add support for sl28cpld watchdog
Date: Thu,  4 Jun 2020 23:10:32 +0200
Message-ID: <20200604211039.12689-5-michael@walle.cc>
References: <20200604211039.12689-1-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200604211039.12689-1-michael@walle.cc>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marc Zyngier <maz@kernel.org>, Jean Delvare <jdelvare@suse.com>, Jason Cooper <jason@lakedaemon.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Li Yang <leoyang.li@nxp.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Michael Walle <michael@walle.cc>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Mark Brown <broonie@kernel.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Lee Jones <lee.jones@linaro.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pwm@vger.kernel.org

Add support for the watchdog of the sl28cpld board management
controller. This is part of a multi-function device driver.

Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/Kconfig        |  11 ++
 drivers/watchdog/Makefile       |   1 +
 drivers/watchdog/sl28cpld_wdt.c | 231 ++++++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+)
 create mode 100644 drivers/watchdog/sl28cpld_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 55b910c453da..2c7b0f10151e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -340,6 +340,17 @@ config MLX_WDT
 	  To compile this driver as a module, choose M here: the
 	  module will be called mlx-wdt.
 
+config SL28CPLD_WATCHDOG
+	tristate "Kontron sl28 watchdog"
+	depends on MFD_SL28CPLD
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
index 000000000000..6c9518dc454a
--- /dev/null
+++ b/drivers/watchdog/sl28cpld_wdt.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * sl28cpld watchdog driver.
+ *
+ * Copyright 2019 Kontron Europe GmbH
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
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
+
+	return (ret < 0) ? 0 : val;
+}
+
+static int sl28cpld_wdt_set_timeout(struct watchdog_device *wdd,
+				    unsigned int timeout)
+{
+	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
+	int ret;
+
+	ret = regmap_write(wdt->regmap, wdt->offset + WDT_TIMEOUT, timeout);
+	if (!ret)
+		wdd->timeout = timeout;
+
+	return ret;
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
+	if (ret < 0)
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
+	if (ret < 0)
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
+	{},
+};
+MODULE_DEVICE_TABLE(of, sl28cpld_wdt_of_match);
+
+static const struct platform_device_id sl28cpld_wdt_id_table[] = {
+	{ "sl28cpld-wdt" },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, sl28cpld_wdt_id_table);
+
+static struct platform_driver sl28cpld_wdt_driver = {
+	.probe = sl28cpld_wdt_probe,
+	.id_table = sl28cpld_wdt_id_table,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = sl28cpld_wdt_of_match,
+	},
+};
+module_platform_driver(sl28cpld_wdt_driver);
+
+MODULE_DESCRIPTION("sl28cpld Watchdog Driver");
+MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
+MODULE_LICENSE("GPL");
-- 
2.20.1
