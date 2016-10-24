From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/4] pwm: lpss: Do not export board infos for different PWM types
Date: Mon, 24 Oct 2016 17:43:24 +0300
Message-ID: <20161024144325.130353-4-andriy.shevchenko@linux.intel.com>
References: <20161024144325.130353-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25074 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751708AbcJXOn3 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 24 Oct 2016 10:43:29 -0400
In-Reply-To: <20161024144325.130353-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

From: Mika Westerberg <mika.westerberg@linux.intel.com>

The PWM LPSS probe drivers just pass a pointer to the exported board info
structures to pwm_lpss_probe() based on device PCI or ACPI ID. Since the
core driver knows everything else except mapping between device ID and the
type, just pass the type with pwm_lpss_probe() and stop exporting the board
info structures.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pwm/pwm-lpss-pci.c      | 20 ++++++++---------
 drivers/pwm/pwm-lpss-platform.c | 10 ++++-----
 drivers/pwm/pwm-lpss.c          | 49 ++++++++++++++++++++++-------------------
 drivers/pwm/pwm-lpss.h          | 14 +++++-------
 4 files changed, 44 insertions(+), 49 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index 3622f09..dfe0a2e 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -20,7 +20,6 @@
 static int pwm_lpss_probe_pci(struct pci_dev *pdev,
 			      const struct pci_device_id *id)
 {
-	const struct pwm_lpss_boardinfo *info;
 	struct pwm_lpss_chip *lpwm;
 	int err;
 
@@ -28,8 +27,7 @@ static int pwm_lpss_probe_pci(struct pci_dev *pdev,
 	if (err < 0)
 		return err;
 
-	info = (struct pwm_lpss_boardinfo *)id->driver_data;
-	lpwm = pwm_lpss_probe(&pdev->dev, &pdev->resource[0], info);
+	lpwm = pwm_lpss_probe(&pdev->dev, &pdev->resource[0], id->driver_data);
 	if (IS_ERR(lpwm))
 		return PTR_ERR(lpwm);
 
@@ -73,14 +71,14 @@ static const struct dev_pm_ops pwm_lpss_pci_pm = {
 };
 
 static const struct pci_device_id pwm_lpss_pci_ids[] = {
-	{ PCI_VDEVICE(INTEL, 0x0ac8), (unsigned long)&pwm_lpss_bxt_info},
-	{ PCI_VDEVICE(INTEL, 0x0f08), (unsigned long)&pwm_lpss_byt_info},
-	{ PCI_VDEVICE(INTEL, 0x0f09), (unsigned long)&pwm_lpss_byt_info},
-	{ PCI_VDEVICE(INTEL, 0x11a5), (unsigned long)&pwm_lpss_bxt_info},
-	{ PCI_VDEVICE(INTEL, 0x1ac8), (unsigned long)&pwm_lpss_bxt_info},
-	{ PCI_VDEVICE(INTEL, 0x2288), (unsigned long)&pwm_lpss_bsw_info},
-	{ PCI_VDEVICE(INTEL, 0x2289), (unsigned long)&pwm_lpss_bsw_info},
-	{ PCI_VDEVICE(INTEL, 0x5ac8), (unsigned long)&pwm_lpss_bxt_info},
+	{ PCI_VDEVICE(INTEL, 0x0ac8), PWM_LPSS_BXT },
+	{ PCI_VDEVICE(INTEL, 0x0f08), PWM_LPSS_BYT },
+	{ PCI_VDEVICE(INTEL, 0x0f09), PWM_LPSS_BYT },
+	{ PCI_VDEVICE(INTEL, 0x11a5), PWM_LPSS_BXT },
+	{ PCI_VDEVICE(INTEL, 0x1ac8), PWM_LPSS_BXT },
+	{ PCI_VDEVICE(INTEL, 0x2288), PWM_LPSS_BSW },
+	{ PCI_VDEVICE(INTEL, 0x2289), PWM_LPSS_BSW },
+	{ PCI_VDEVICE(INTEL, 0x5ac8), PWM_LPSS_BXT },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, pwm_lpss_pci_ids);
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 54433fc..4ebcb5a 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -20,7 +20,6 @@
 
 static int pwm_lpss_probe_platform(struct platform_device *pdev)
 {
-	const struct pwm_lpss_boardinfo *info;
 	const struct acpi_device_id *id;
 	struct pwm_lpss_chip *lpwm;
 	struct resource *r;
@@ -29,10 +28,9 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
 	if (!id)
 		return -ENODEV;
 
-	info = (const struct pwm_lpss_boardinfo *)id->driver_data;
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	lpwm = pwm_lpss_probe(&pdev->dev, r, info);
+	lpwm = pwm_lpss_probe(&pdev->dev, r, id->driver_data);
 	if (IS_ERR(lpwm))
 		return PTR_ERR(lpwm);
 
@@ -53,9 +51,9 @@ static int pwm_lpss_remove_platform(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id pwm_lpss_acpi_match[] = {
-	{ "80860F09", (unsigned long)&pwm_lpss_byt_info },
-	{ "80862288", (unsigned long)&pwm_lpss_bsw_info },
-	{ "80865AC8", (unsigned long)&pwm_lpss_bxt_info },
+	{ "80860F09", PWM_LPSS_BYT },
+	{ "80862288", PWM_LPSS_BSW },
+	{ "80865AC8", PWM_LPSS_BXT },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, pwm_lpss_acpi_match);
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index ffa01ab..e7d612e 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -37,29 +37,32 @@ struct pwm_lpss_chip {
 	const struct pwm_lpss_boardinfo *info;
 };
 
-/* BayTrail */
-const struct pwm_lpss_boardinfo pwm_lpss_byt_info = {
-	.clk_rate = 25000000,
-	.npwm = 1,
-	.base_unit_bits = 16,
+struct pwm_lpss_boardinfo {
+	unsigned long clk_rate;
+	unsigned int npwm;
+	unsigned long base_unit_bits;
 };
-EXPORT_SYMBOL_GPL(pwm_lpss_byt_info);
 
-/* Braswell */
-const struct pwm_lpss_boardinfo pwm_lpss_bsw_info = {
-	.clk_rate = 19200000,
-	.npwm = 1,
-	.base_unit_bits = 16,
+static const struct pwm_lpss_boardinfo pwm_lpss_types[] = {
+	/* Baytrail */
+	[PWM_LPSS_BYT] = {
+		.clk_rate = 25000000,
+		.npwm = 1,
+		.base_unit_bits = 16,
+	},
+	/* Braswell */
+	[PWM_LPSS_BSW] = {
+		.clk_rate = 19200000,
+		.npwm = 1,
+		.base_unit_bits = 16,
+	},
+	/* Broxton */
+	[PWM_LPSS_BXT] = {
+		.clk_rate = 19200000,
+		.npwm = 4,
+		.base_unit_bits = 22,
+	},
 };
-EXPORT_SYMBOL_GPL(pwm_lpss_bsw_info);
-
-/* Broxton */
-const struct pwm_lpss_boardinfo pwm_lpss_bxt_info = {
-	.clk_rate = 19200000,
-	.npwm = 4,
-	.base_unit_bits = 22,
-};
-EXPORT_SYMBOL_GPL(pwm_lpss_bxt_info);
 
 static inline struct pwm_lpss_chip *to_lpwm(struct pwm_chip *chip)
 {
@@ -160,7 +163,7 @@ static const struct pwm_ops pwm_lpss_ops = {
 };
 
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
-				     const struct pwm_lpss_boardinfo *info)
+				     enum pwm_lpss_type type)
 {
 	struct pwm_lpss_chip *lpwm;
 	unsigned long c;
@@ -174,7 +177,7 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 	if (IS_ERR(lpwm->regs))
 		return ERR_CAST(lpwm->regs);
 
-	lpwm->info = info;
+	lpwm->info = &pwm_lpss_types[type];
 
 	c = lpwm->info->clk_rate;
 	if (!c)
@@ -183,7 +186,7 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 	lpwm->chip.dev = dev;
 	lpwm->chip.ops = &pwm_lpss_ops;
 	lpwm->chip.base = -1;
-	lpwm->chip.npwm = info->npwm;
+	lpwm->chip.npwm = lpwm->info->npwm;
 
 	ret = pwmchip_add(&lpwm->chip);
 	if (ret) {
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 04766e0..88afc30 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -18,18 +18,14 @@
 
 struct pwm_lpss_chip;
 
-struct pwm_lpss_boardinfo {
-	unsigned long clk_rate;
-	unsigned int npwm;
-	unsigned long base_unit_bits;
+enum pwm_lpss_type {
+	PWM_LPSS_BYT,
+	PWM_LPSS_BSW,
+	PWM_LPSS_BXT,
 };
 
-extern const struct pwm_lpss_boardinfo pwm_lpss_byt_info;
-extern const struct pwm_lpss_boardinfo pwm_lpss_bsw_info;
-extern const struct pwm_lpss_boardinfo pwm_lpss_bxt_info;
-
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
-				     const struct pwm_lpss_boardinfo *info);
+				     enum pwm_lpss_type type);
 int pwm_lpss_remove(struct pwm_lpss_chip *lpwm);
 
 #endif	/* __PWM_LPSS_H */
-- 
2.9.3
