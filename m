From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] pwm: lpss: properly split driver to parts
Date: Fri, 25 Jul 2014 17:29:33 +0300
Message-ID: <1406298574-15857-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15079 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964AbaGYO3i (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Fri, 25 Jul 2014 10:29:38 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The driver consists core, PCI, and platform parts. It would better to split
them into separate files.

While here, move to use macros module_pci_driver() and
module_platform_driver().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/Kconfig         |  18 ++++++
 drivers/pwm/Makefile        |   2 +
 drivers/pwm/pwm-lpss-pci.c  |  69 +++++++++++++++++++++++
 drivers/pwm/pwm-lpss-plat.c |  61 ++++++++++++++++++++
 drivers/pwm/pwm-lpss.c      | 133 ++------------------------------------------
 drivers/pwm/pwm-lpss.h      |  35 ++++++++++++
 6 files changed, 191 insertions(+), 127 deletions(-)
 create mode 100644 drivers/pwm/pwm-lpss-pci.c
 create mode 100644 drivers/pwm/pwm-lpss-plat.c
 create mode 100644 drivers/pwm/pwm-lpss.h

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 936010a..425f6fe 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -157,6 +157,24 @@ config PWM_LPSS
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-lpss.
 
+config PWM_LPSS_PCI
+	tristate "Intel LPSS PWM PCI driver"
+	select PWN_LPSS_CORE
+	help
+	  The PCI driver for Intel Low Power Subsystem PWM controller.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-lpss.
+
+config PWM_LPSS_PLAT
+	tristate "Intel LPSS PWM platform driver"
+	select PWN_LPSS_CORE
+	help
+	  The platform driver for Intel Low Power Subsystem PWM controller.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-lpss.
+
 config PWM_MXS
 	tristate "Freescale MXS PWM support"
 	depends on ARCH_MXS && OF
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index e03e2ae..e84dfa4 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -13,6 +13,8 @@ obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
 obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
 obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
 obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
+obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
+obj-$(CONFIG_PWM_LPSS_PLAT)	+= pwm-lpss-plat.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
 obj-$(CONFIG_PWM_PUV3)		+= pwm-puv3.o
diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
new file mode 100644
index 0000000..48b88dd
--- /dev/null
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -0,0 +1,69 @@
+/*
+ * Intel Low Power Subsystem PWM controller PCI driver
+ *
+ * Copyright (C) 2014, Intel Corporation
+ *
+ * Derived from the original pwm-lpss.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "pwm-lpss.h"
+
+/* BayTrail */
+static const struct pwm_lpss_boardinfo byt_info = {
+	25000000,
+};
+
+static int pwm_lpss_probe_pci(struct pci_dev *pdev,
+			      const struct pci_device_id *id)
+{
+	const struct pwm_lpss_boardinfo *info;
+	struct pwm_lpss_chip *lpwm;
+	int err;
+
+	err = pci_enable_device(pdev);
+	if (err < 0)
+		return err;
+
+	info = (struct pwm_lpss_boardinfo *)id->driver_data;
+	lpwm = pwm_lpss_probe(&pdev->dev, &pdev->resource[0], info);
+	if (IS_ERR(lpwm))
+		return PTR_ERR(lpwm);
+
+	pci_set_drvdata(pdev, lpwm);
+	return 0;
+}
+
+static void pwm_lpss_remove_pci(struct pci_dev *pdev)
+{
+	struct pwm_lpss_chip *lpwm = pci_get_drvdata(pdev);
+
+	pwm_lpss_remove(lpwm);
+	pci_disable_device(pdev);
+}
+
+static struct pci_device_id pwm_lpss_pci_ids[] = {
+	{ PCI_VDEVICE(INTEL, 0x0f08), (unsigned long)&byt_info},
+	{ PCI_VDEVICE(INTEL, 0x0f09), (unsigned long)&byt_info},
+	{ },
+};
+MODULE_DEVICE_TABLE(pci, pwm_lpss_pci_ids);
+
+static struct pci_driver pwm_lpss_driver_pci = {
+	.name = "pwm-lpss",
+	.id_table = pwm_lpss_pci_ids,
+	.probe = pwm_lpss_probe_pci,
+	.remove = pwm_lpss_remove_pci,
+};
+
+module_pci_driver(pwm_lpss_driver_pci);
+
+MODULE_DESCRIPTION("PWM PCI driver for Intel LPSS");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pwm/pwm-lpss-plat.c b/drivers/pwm/pwm-lpss-plat.c
new file mode 100644
index 0000000..fbecc7a
--- /dev/null
+++ b/drivers/pwm/pwm-lpss-plat.c
@@ -0,0 +1,61 @@
+/*
+ * Intel Low Power Subsystem PWM controller driver
+ *
+ * Copyright (C) 2014, Intel Corporation
+ *
+ * Derived from the original pwm-lpss.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "pwm-lpss.h"
+
+static int pwm_lpss_probe_platform(struct platform_device *pdev)
+{
+	struct pwm_lpss_chip *lpwm;
+	struct resource *r;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	lpwm = pwm_lpss_probe(&pdev->dev, r, NULL);
+	if (IS_ERR(lpwm))
+		return PTR_ERR(lpwm);
+
+	platform_set_drvdata(pdev, lpwm);
+	return 0;
+}
+
+static int pwm_lpss_remove_platform(struct platform_device *pdev)
+{
+	struct pwm_lpss_chip *lpwm = platform_get_drvdata(pdev);
+
+	return pwm_lpss_remove(lpwm);
+}
+
+static const struct acpi_device_id pwm_lpss_acpi_match[] = {
+	{ "80860F09", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, pwm_lpss_acpi_match);
+
+static struct platform_driver pwm_lpss_driver_platform = {
+	.driver = {
+		.name = "pwm-lpss",
+		.acpi_match_table = pwm_lpss_acpi_match,
+	},
+	.probe = pwm_lpss_probe_platform,
+	.remove = pwm_lpss_remove_platform,
+};
+
+module_platform_driver(pwm_lpss_driver_platform);
+
+MODULE_DESCRIPTION("PWM platform driver for Intel LPSS");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:pwm-lpss");
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 44ce6c6..3ad055b 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -13,16 +13,10 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/acpi.h>
-#include <linux/clk.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/pwm.h>
-#include <linux/platform_device.h>
-#include <linux/pci.h>
 
-static int pci_drv, plat_drv;	/* So we know which drivers registered */
+#include "pwm-lpss.h"
 
 #define PWM				0x00000000
 #define PWM_ENABLE			BIT(31)
@@ -34,22 +28,6 @@ static int pci_drv, plat_drv;	/* So we know which drivers registered */
 #define PWM_LIMIT			(0x8000 + PWM_DIVISION_CORRECTION)
 #define NSECS_PER_SEC			1000000000UL
 
-struct pwm_lpss_chip {
-	struct pwm_chip chip;
-	void __iomem *regs;
-	struct clk *clk;
-	unsigned long clk_rate;
-};
-
-struct pwm_lpss_boardinfo {
-	unsigned long clk_rate;
-};
-
-/* BayTrail */
-static const struct pwm_lpss_boardinfo byt_info = {
-	25000000
-};
-
 static inline struct pwm_lpss_chip *to_lpwm(struct pwm_chip *chip)
 {
 	return container_of(chip, struct pwm_lpss_chip, chip);
@@ -127,9 +105,8 @@ static const struct pwm_ops pwm_lpss_ops = {
 	.owner = THIS_MODULE,
 };
 
-static struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev,
-					    struct resource *r,
-					    const struct pwm_lpss_boardinfo *info)
+struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
+				     const struct pwm_lpss_boardinfo *info)
 {
 	struct pwm_lpss_chip *lpwm;
 	int ret;
@@ -166,8 +143,9 @@ static struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev,
 
 	return lpwm;
 }
+EXPORT_SYMBOL_GPL(pwm_lpss_probe);
 
-static int pwm_lpss_remove(struct pwm_lpss_chip *lpwm)
+int pwm_lpss_remove(struct pwm_lpss_chip *lpwm)
 {
 	u32 ctrl;
 
@@ -176,107 +154,8 @@ static int pwm_lpss_remove(struct pwm_lpss_chip *lpwm)
 
 	return pwmchip_remove(&lpwm->chip);
 }
-
-static int pwm_lpss_probe_pci(struct pci_dev *pdev,
-			      const struct pci_device_id *id)
-{
-	const struct pwm_lpss_boardinfo *info;
-	struct pwm_lpss_chip *lpwm;
-	int err;
-
-	err = pci_enable_device(pdev);
-	if (err < 0)
-		return err;
-
-	info = (struct pwm_lpss_boardinfo *)id->driver_data;
-	lpwm = pwm_lpss_probe(&pdev->dev, &pdev->resource[0], info);
-	if (IS_ERR(lpwm))
-		return PTR_ERR(lpwm);
-
-	pci_set_drvdata(pdev, lpwm);
-	return 0;
-}
-
-static void pwm_lpss_remove_pci(struct pci_dev *pdev)
-{
-	struct pwm_lpss_chip *lpwm = pci_get_drvdata(pdev);
-
-	pwm_lpss_remove(lpwm);
-	pci_disable_device(pdev);
-}
-
-static struct pci_device_id pwm_lpss_pci_ids[] = {
-	{ PCI_VDEVICE(INTEL, 0x0f08), (unsigned long)&byt_info},
-	{ PCI_VDEVICE(INTEL, 0x0f09), (unsigned long)&byt_info},
-	{ },
-};
-MODULE_DEVICE_TABLE(pci, pwm_lpss_pci_ids);
-
-static struct pci_driver pwm_lpss_driver_pci = {
-	.name = "pwm-lpss",
-	.id_table = pwm_lpss_pci_ids,
-	.probe = pwm_lpss_probe_pci,
-	.remove = pwm_lpss_remove_pci,
-};
-
-static int pwm_lpss_probe_platform(struct platform_device *pdev)
-{
-	struct pwm_lpss_chip *lpwm;
-	struct resource *r;
-
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	lpwm = pwm_lpss_probe(&pdev->dev, r, NULL);
-	if (IS_ERR(lpwm))
-		return PTR_ERR(lpwm);
-
-	platform_set_drvdata(pdev, lpwm);
-	return 0;
-}
-
-static int pwm_lpss_remove_platform(struct platform_device *pdev)
-{
-	struct pwm_lpss_chip *lpwm = platform_get_drvdata(pdev);
-
-	return pwm_lpss_remove(lpwm);
-}
-
-static const struct acpi_device_id pwm_lpss_acpi_match[] = {
-	{ "80860F09", 0 },
-	{ },
-};
-MODULE_DEVICE_TABLE(acpi, pwm_lpss_acpi_match);
-
-static struct platform_driver pwm_lpss_driver_platform = {
-	.driver = {
-		.name = "pwm-lpss",
-		.acpi_match_table = pwm_lpss_acpi_match,
-	},
-	.probe = pwm_lpss_probe_platform,
-	.remove = pwm_lpss_remove_platform,
-};
-
-static int __init pwm_init(void)
-{
-	pci_drv = pci_register_driver(&pwm_lpss_driver_pci);
-	plat_drv = platform_driver_register(&pwm_lpss_driver_platform);
-	if (pci_drv && plat_drv)
-		return pci_drv;
-
-	return 0;
-}
-module_init(pwm_init);
-
-static void __exit pwm_exit(void)
-{
-	if (!pci_drv)
-		pci_unregister_driver(&pwm_lpss_driver_pci);
-	if (!plat_drv)
-		platform_driver_unregister(&pwm_lpss_driver_platform);
-}
-module_exit(pwm_exit);
+EXPORT_SYMBOL_GPL(pwm_lpss_remove);
 
 MODULE_DESCRIPTION("PWM driver for Intel LPSS");
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:pwm-lpss");
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
new file mode 100644
index 0000000..90e70af
--- /dev/null
+++ b/drivers/pwm/pwm-lpss.h
@@ -0,0 +1,35 @@
+/*
+ * Intel Low Power Subsystem PWM controller driver
+ *
+ * Copyright (C) 2014, Intel Corporation
+ *
+ * Derived from the original pwm-lpss.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __PWM_LPSS_H
+#define __PWM_LPSS_H
+
+#include <linux/pwm.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+
+struct pwm_lpss_chip {
+	struct pwm_chip chip;
+	void __iomem *regs;
+	struct clk *clk;
+	unsigned long clk_rate;
+};
+
+struct pwm_lpss_boardinfo {
+	unsigned long clk_rate;
+};
+
+extern struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev,
+		struct resource *r, const struct pwm_lpss_boardinfo *info);
+extern int pwm_lpss_remove(struct pwm_lpss_chip *lpwm);
+
+#endif	/* __PWM_LPSS_H */
-- 
2.0.1

