From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 6/8] iio: trigger: Add STM32 LPTimer trigger driver
Date: Fri, 16 Jun 2017 17:58:44 +0200
Message-ID: <1497628726-7563-7-git-send-email-fabrice.gasnier@st.com>
References: <1497628726-7563-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1497628726-7563-1-git-send-email-fabrice.gasnier@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lee.jones@linaro.org, benjamin.gaignard@linaro.org, jic23@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: linux-pwm@vger.kernel.org

Add support for LPTIMx_OUT triggers that can be found on some STM32
devices. These triggers can be used then by ADC or DAC.
Typical usage is to configure LPTimer as PWM output (via pwm-stm32-lp)
and have synchronised analog conversions with these triggers.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/trigger/Kconfig                   |  11 +++
 drivers/iio/trigger/Makefile                  |   1 +
 drivers/iio/trigger/stm32-lptimer-trigger.c   | 110 ++++++++++++++++++++++++++
 include/linux/iio/timer/stm32-lptim-trigger.h |  24 ++++++
 4 files changed, 146 insertions(+)
 create mode 100644 drivers/iio/trigger/stm32-lptimer-trigger.c
 create mode 100644 include/linux/iio/timer/stm32-lptim-trigger.h

diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
index e4d4e63..66823bd 100644
--- a/drivers/iio/trigger/Kconfig
+++ b/drivers/iio/trigger/Kconfig
@@ -24,6 +24,17 @@ config IIO_INTERRUPT_TRIGGER
 	  To compile this driver as a module, choose M here: the
 	  module will be called iio-trig-interrupt.
 
+config IIO_STM32_LPTIMER_TRIGGER
+	tristate "STM32 LP Timer Trigger"
+	depends on MFD_STM32_LPTIMER || COMPILE_TEST
+	help
+	  Select this option to enable STM32 Low Power Timer Trigger.
+	  This can be used as trigger source for STM32 internal ADC
+	  and/or DAC.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called stm32-lptimer-trigger.
+
 config IIO_STM32_TIMER_TRIGGER
 	tristate "STM32 Timer Trigger"
 	depends on (ARCH_STM32 && OF && MFD_STM32_TIMERS) || COMPILE_TEST
diff --git a/drivers/iio/trigger/Makefile b/drivers/iio/trigger/Makefile
index 5c4ecd3..0a72a2a 100644
--- a/drivers/iio/trigger/Makefile
+++ b/drivers/iio/trigger/Makefile
@@ -6,6 +6,7 @@
 
 obj-$(CONFIG_IIO_HRTIMER_TRIGGER) += iio-trig-hrtimer.o
 obj-$(CONFIG_IIO_INTERRUPT_TRIGGER) += iio-trig-interrupt.o
+obj-$(CONFIG_IIO_STM32_LPTIMER_TRIGGER) += stm32-lptimer-trigger.o
 obj-$(CONFIG_IIO_STM32_TIMER_TRIGGER) += stm32-timer-trigger.o
 obj-$(CONFIG_IIO_SYSFS_TRIGGER) += iio-trig-sysfs.o
 obj-$(CONFIG_IIO_TIGHTLOOP_TRIGGER) += iio-trig-loop.o
diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/trigger/stm32-lptimer-trigger.c
new file mode 100644
index 0000000..75bbaf2
--- /dev/null
+++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
@@ -0,0 +1,110 @@
+/*
+ * This file is part of STM32 low-power timer driver
+ *
+ * Copyright (C) STMicroelectronics 2017
+ *
+ * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
+ *
+ * License terms:  GNU General Public License (GPL), version 2
+ *
+ * Inspired by stm32-timer-trigger.c from Benjamin Gaignard
+ */
+
+#include <linux/iio/iio.h>
+#include <linux/iio/timer/stm32-lptim-trigger.h>
+#include <linux/iio/trigger.h>
+#include <linux/mfd/stm32-lptimer.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+/* List the triggers created by each low-power timer */
+static const char * const stm32_lptim_triggers[] = {
+	LPTIM1_OUT,
+	LPTIM2_OUT,
+	LPTIM3_OUT,
+};
+
+struct stm32_lptim_trigger {
+	struct device *dev;
+	const char *trg;
+};
+
+static const struct iio_trigger_ops stm32_lptim_trigger_ops = {
+	.owner = THIS_MODULE,
+};
+
+/**
+ * is_stm32_lptim_trigger
+ * @trig: trigger to be checked
+ *
+ * return true if the trigger is a valid stm32 iio low-power timer trigger
+ * either return false
+ */
+bool is_stm32_lptim_trigger(struct iio_trigger *trig)
+{
+	return (trig->ops == &stm32_lptim_trigger_ops);
+}
+EXPORT_SYMBOL(is_stm32_lptim_trigger);
+
+static int stm32_lptim_setup_trig(struct stm32_lptim_trigger *priv)
+{
+	struct iio_trigger *trig;
+
+	trig = devm_iio_trigger_alloc(priv->dev, "%s", priv->trg);
+	if  (!trig)
+		return -ENOMEM;
+
+	trig->dev.parent = priv->dev->parent;
+	trig->ops = &stm32_lptim_trigger_ops;
+	iio_trigger_set_drvdata(trig, priv);
+
+	return devm_iio_trigger_register(priv->dev, trig);
+}
+
+static int stm32_lptim_trigger_probe(struct platform_device *pdev)
+{
+	struct stm32_lptim_trigger *priv;
+	u32 index;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	if (of_property_read_u32(pdev->dev.of_node, "reg", &index))
+		return -EINVAL;
+
+	if (index >= ARRAY_SIZE(stm32_lptim_triggers))
+		return -EINVAL;
+
+	priv->dev = &pdev->dev;
+	priv->trg = stm32_lptim_triggers[index];
+
+	ret = stm32_lptim_setup_trig(priv);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static const struct of_device_id stm32_lptim_trig_of_match[] = {
+	{ .compatible = "st,stm32-lptimer-trigger", },
+	{ /* end node */ },
+};
+MODULE_DEVICE_TABLE(of, stm32_lptim_trig_of_match);
+
+static struct platform_driver stm32_lptim_trigger_driver = {
+	.probe = stm32_lptim_trigger_probe,
+	.driver = {
+		.name = "stm32-lptimer-trigger",
+		.of_match_table = stm32_lptim_trig_of_match,
+	},
+};
+module_platform_driver(stm32_lptim_trigger_driver);
+
+MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
+MODULE_ALIAS("platform:stm32-lptimer-trigger");
+MODULE_DESCRIPTION("STMicroelectronics STM32 LPTIM trigger driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/iio/timer/stm32-lptim-trigger.h b/include/linux/iio/timer/stm32-lptim-trigger.h
new file mode 100644
index 0000000..cb795b1
--- /dev/null
+++ b/include/linux/iio/timer/stm32-lptim-trigger.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) STMicroelectronics 2017
+ *
+ * Author: Fabrice Gasnier <fabrice.gasnier@st.com>
+ *
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#ifndef _STM32_LPTIM_TRIGGER_H_
+#define _STM32_LPTIM_TRIGGER_H_
+
+#define LPTIM1_OUT	"lptim1_out"
+#define LPTIM2_OUT	"lptim2_out"
+#define LPTIM3_OUT	"lptim3_out"
+
+#if IS_ENABLED(CONFIG_IIO_STM32_LPTIMER_TRIGGER)
+bool is_stm32_lptim_trigger(struct iio_trigger *trig);
+#else
+static inline bool is_stm32_lptim_trigger(struct iio_trigger *trig)
+{
+	return false;
+}
+#endif
+#endif
-- 
1.9.1
