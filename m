From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 5/6] pwm: lpss: Do not export board infos for different PWM types
Date: Sat, 28 Jan 2017 17:10:43 +0200
Message-ID: <20170128151044.87572-6-andriy.shevchenko@linux.intel.com>
References: <20170128151044.87572-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37255 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751673AbdA1PSh (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 28 Jan 2017 10:18:37 -0500
In-Reply-To: <20170128151044.87572-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Ilkka Koskinen <ilkka.koskinen@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The PWM LPSS probe drivers just pass a pointer to the exported board
info structures to pwm_lpss_probe() based on device PCI or ACPI ID.

In order to remove the knowledge of specific devices from library part of
the driver and reduce noise in exported namespace just duplicate the
board info structures and stop exporting them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss-pci.c      | 21 +++++++++++++++++++++
 drivers/pwm/pwm-lpss-platform.c | 21 +++++++++++++++++++++
 drivers/pwm/pwm-lpss.c          | 24 ------------------------
 drivers/pwm/pwm-lpss.h          |  4 ----
 4 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index 3622f093490e..2e7a9a48060d 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -17,6 +17,27 @@
 
 #include "pwm-lpss.h"
 
+/* BayTrail */
+static const struct pwm_lpss_boardinfo pwm_lpss_byt_info = {
+	.clk_rate = 25000000,
+	.npwm = 1,
+	.base_unit_bits = 16,
+};
+
+/* Braswell */
+static const struct pwm_lpss_boardinfo pwm_lpss_bsw_info = {
+	.clk_rate = 19200000,
+	.npwm = 1,
+	.base_unit_bits = 16,
+};
+
+/* Broxton */
+static const struct pwm_lpss_boardinfo pwm_lpss_bxt_info = {
+	.clk_rate = 19200000,
+	.npwm = 4,
+	.base_unit_bits = 22,
+};
+
 static int pwm_lpss_probe_pci(struct pci_dev *pdev,
 			      const struct pci_device_id *id)
 {
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 54433fc6d1a4..b22b6fdadb9a 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -18,6 +18,27 @@
 
 #include "pwm-lpss.h"
 
+/* BayTrail */
+static const struct pwm_lpss_boardinfo pwm_lpss_byt_info = {
+	.clk_rate = 25000000,
+	.npwm = 1,
+	.base_unit_bits = 16,
+};
+
+/* Braswell */
+static const struct pwm_lpss_boardinfo pwm_lpss_bsw_info = {
+	.clk_rate = 19200000,
+	.npwm = 1,
+	.base_unit_bits = 16,
+};
+
+/* Broxton */
+static const struct pwm_lpss_boardinfo pwm_lpss_bxt_info = {
+	.clk_rate = 19200000,
+	.npwm = 4,
+	.base_unit_bits = 22,
+};
+
 static int pwm_lpss_probe_platform(struct platform_device *pdev)
 {
 	const struct pwm_lpss_boardinfo *info;
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 46670276690d..689d2c1cbead 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -38,30 +38,6 @@ struct pwm_lpss_chip {
 	const struct pwm_lpss_boardinfo *info;
 };
 
-/* BayTrail */
-const struct pwm_lpss_boardinfo pwm_lpss_byt_info = {
-	.clk_rate = 25000000,
-	.npwm = 1,
-	.base_unit_bits = 16,
-};
-EXPORT_SYMBOL_GPL(pwm_lpss_byt_info);
-
-/* Braswell */
-const struct pwm_lpss_boardinfo pwm_lpss_bsw_info = {
-	.clk_rate = 19200000,
-	.npwm = 1,
-	.base_unit_bits = 16,
-};
-EXPORT_SYMBOL_GPL(pwm_lpss_bsw_info);
-
-/* Broxton */
-const struct pwm_lpss_boardinfo pwm_lpss_bxt_info = {
-	.clk_rate = 19200000,
-	.npwm = 4,
-	.base_unit_bits = 22,
-};
-EXPORT_SYMBOL_GPL(pwm_lpss_bxt_info);
-
 static inline struct pwm_lpss_chip *to_lpwm(struct pwm_chip *chip)
 {
 	return container_of(chip, struct pwm_lpss_chip, chip);
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 04766e0d41aa..c94cd7c2695d 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -24,10 +24,6 @@ struct pwm_lpss_boardinfo {
 	unsigned long base_unit_bits;
 };
 
-extern const struct pwm_lpss_boardinfo pwm_lpss_byt_info;
-extern const struct pwm_lpss_boardinfo pwm_lpss_bsw_info;
-extern const struct pwm_lpss_boardinfo pwm_lpss_bxt_info;
-
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 				     const struct pwm_lpss_boardinfo *info);
 int pwm_lpss_remove(struct pwm_lpss_chip *lpwm);
-- 
2.11.0
