From: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v5 2/7] MFD: add STM32 General Purpose Timer driver
Date: Thu,  8 Dec 2016 13:20:45 +0100
Message-ID: <1481199650-22484-3-git-send-email-benjamin.gaignard@st.com>
References: <1481199650-22484-1-git-send-email-benjamin.gaignard@st.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1481199650-22484-1-git-send-email-benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: fabrice.gasnier-qxv4g6HH51o@public.gmane.org, gerald.baeza-qxv4g6HH51o@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

This hardware block could at used at same time for PWM generation
and IIO timers.
PWM and IIO timer configuration are mixed in the same registers
so we need a multi fonction driver to be able to share those registers.

version 5:
- fix Lee comments about detect function
- add missing dependency on REGMAP_MMIO

version 4:
- add a function to detect Auto Reload Register (ARR) size
- rename the structure shared with other drivers

version 2:
- rename driver "stm32-gptimer" to be align with SoC documentation
- only keep one compatible
- use of_platform_populate() instead of devm_mfd_add_devices()

Signed-off-by: Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
---
 drivers/mfd/Kconfig               | 11 ++++++
 drivers/mfd/Makefile              |  2 +
 drivers/mfd/stm32-gptimer.c       | 80 +++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/stm32-gptimer.h | 64 +++++++++++++++++++++++++++++++
 4 files changed, 157 insertions(+)
 create mode 100644 drivers/mfd/stm32-gptimer.c
 create mode 100644 include/linux/mfd/stm32-gptimer.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index c6df644..b797312 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1607,6 +1607,17 @@ config MFD_STW481X
 	  in various ST Microelectronics and ST-Ericsson embedded
 	  Nomadik series.
 
+config MFD_STM32_GP_TIMER
+	tristate "Support for STM32 General Purpose Timer"
+	depends on (ARCH_STM32 && OF) || COMPILE_TEST
+	select MFD_CORE
+	select REGMAP
+	select REGMAP_MMIO
+	help
+	  Select this option to enable STM32 general purpose timer
+	  driver used for PWM and IIO Timer. This driver allow to
+	  share the registers between the others drivers.
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 9834e66..86353b9 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -211,3 +211,5 @@ obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
 obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
 
 obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
+
+obj-$(CONFIG_MFD_STM32_GP_TIMER) 	+= stm32-gptimer.o
diff --git a/drivers/mfd/stm32-gptimer.c b/drivers/mfd/stm32-gptimer.c
new file mode 100644
index 0000000..0642f1a
--- /dev/null
+++ b/drivers/mfd/stm32-gptimer.c
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) STMicroelectronics 2016
+ *
+ * Author: Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
+ *
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#include <linux/mfd/stm32-gptimer.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/reset.h>
+
+static const struct regmap_config stm32_gptimer_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = sizeof(u32),
+	.max_register = 0x400,
+};
+
+static void stm32_gptimer_get_arr_size(struct stm32_gptimer *ddata)
+{
+	/*
+	 * Only the available bits will be written so when readback
+	 * we get the maximum value of auto reload register
+	 */
+	regmap_write(ddata->regmap, TIM_ARR, ~0L);
+	regmap_read(ddata->regmap, TIM_ARR, &ddata->max_arr);
+	regmap_write(ddata->regmap, TIM_ARR, 0x0);
+}
+
+static int stm32_gptimer_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct stm32_gptimer *ddata;
+	struct resource *res;
+	void __iomem *mmio;
+
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mmio = devm_ioremap_resource(dev, res);
+	if (IS_ERR(mmio))
+		return PTR_ERR(mmio);
+
+	ddata->regmap = devm_regmap_init_mmio_clk(dev, "clk_int", mmio,
+						  &stm32_gptimer_regmap_cfg);
+	if (IS_ERR(ddata->regmap))
+		return PTR_ERR(ddata->regmap);
+
+	ddata->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(ddata->clk))
+		return PTR_ERR(ddata->clk);
+
+	stm32_gptimer_get_arr_size(ddata);
+
+	platform_set_drvdata(pdev, ddata);
+
+	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
+}
+
+static const struct of_device_id stm32_gptimer_of_match[] = {
+	{ .compatible = "st,stm32-gptimer", },
+	{ /* sentinelle */ },
+};
+MODULE_DEVICE_TABLE(of, stm32_gptimer_of_match);
+
+static struct platform_driver stm32_gptimer_driver = {
+	.probe = stm32_gptimer_probe,
+	.driver	= {
+		.name = "stm32-gptimer",
+		.of_match_table = stm32_gptimer_of_match,
+	},
+};
+module_platform_driver(stm32_gptimer_driver);
+
+MODULE_DESCRIPTION("STMicroelectronics STM32 General Purpose Timer");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/stm32-gptimer.h b/include/linux/mfd/stm32-gptimer.h
new file mode 100644
index 0000000..567a15e
--- /dev/null
+++ b/include/linux/mfd/stm32-gptimer.h
@@ -0,0 +1,64 @@
+/*
+ * Copyright (C) STMicroelectronics 2016
+ *
+ * Author: Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
+ *
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#ifndef _LINUX_STM32_GPTIMER_H_
+#define _LINUX_STM32_GPTIMER_H_
+
+#include <linux/clk.h>
+#include <linux/regmap.h>
+
+#define TIM_CR1		0x00	/* Control Register 1      */
+#define TIM_CR2		0x04	/* Control Register 2      */
+#define TIM_SMCR	0x08	/* Slave mode control reg  */
+#define TIM_DIER	0x0C	/* DMA/interrupt register  */
+#define TIM_SR		0x10	/* Status register	   */
+#define TIM_EGR		0x14	/* Event Generation Reg    */
+#define TIM_CCMR1	0x18	/* Capt/Comp 1 Mode Reg    */
+#define TIM_CCMR2	0x1C	/* Capt/Comp 2 Mode Reg    */
+#define TIM_CCER	0x20	/* Capt/Comp Enable Reg    */
+#define TIM_PSC		0x28	/* Prescaler               */
+#define TIM_ARR		0x2c	/* Auto-Reload Register    */
+#define TIM_CCR1	0x34	/* Capt/Comp Register 1    */
+#define TIM_CCR2	0x38	/* Capt/Comp Register 2    */
+#define TIM_CCR3	0x3C	/* Capt/Comp Register 3    */
+#define TIM_CCR4	0x40	/* Capt/Comp Register 4    */
+#define TIM_BDTR	0x44	/* Break and Dead-Time Reg */
+
+#define TIM_CR1_CEN	BIT(0)	/* Counter Enable	   */
+#define TIM_CR1_ARPE	BIT(7)	/* Auto-reload Preload Ena */
+#define TIM_CR2_MMS	(BIT(4) | BIT(5) | BIT(6)) /* Master mode selection */
+#define TIM_SMCR_SMS	(BIT(0) | BIT(1) | BIT(2)) /* Slave mode selection */
+#define TIM_SMCR_TS	(BIT(4) | BIT(5) | BIT(6)) /* Trigger selection */
+#define TIM_DIER_UIE	BIT(0)	/* Update interrupt	   */
+#define TIM_SR_UIF	BIT(0)	/* Update interrupt flag   */
+#define TIM_EGR_UG	BIT(0)	/* Update Generation       */
+#define TIM_CCMR_PE	BIT(3)	/* Channel Preload Enable  */
+#define TIM_CCMR_M1	(BIT(6) | BIT(5))  /* Channel PWM Mode 1 */
+#define TIM_CCER_CC1E	BIT(0)	/* Capt/Comp 1  out Ena    */
+#define TIM_CCER_CC1P	BIT(1)	/* Capt/Comp 1  Polarity   */
+#define TIM_CCER_CC1NE	BIT(2)	/* Capt/Comp 1N out Ena    */
+#define TIM_CCER_CC1NP	BIT(3)	/* Capt/Comp 1N Polarity   */
+#define TIM_CCER_CC2E	BIT(4)	/* Capt/Comp 2  out Ena    */
+#define TIM_CCER_CC3E	BIT(8)	/* Capt/Comp 3  out Ena    */
+#define TIM_CCER_CC4E	BIT(12)	/* Capt/Comp 4  out Ena    */
+#define TIM_CCER_CCXE	(BIT(0) | BIT(4) | BIT(8) | BIT(12))
+#define TIM_BDTR_BKE	BIT(12) /* Break input enable	   */
+#define TIM_BDTR_BKP	BIT(13) /* Break input polarity	   */
+#define TIM_BDTR_AOE	BIT(14)	/* Automatic Output Enable */
+#define TIM_BDTR_MOE	BIT(15)	/* Main Output Enable      */
+
+#define MAX_TIM_PSC		0xFFFF
+#define TIM_CR2_MMS_SHIFT	4
+#define TIM_SMCR_TS_SHIFT	4
+
+struct stm32_gptimer {
+	struct clk *clk;
+	struct regmap *regmap;
+	u32 max_arr;
+};
+#endif
-- 
1.9.1
