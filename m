From: "qipeng.zha" <qipeng.zha@intel.com>
Subject: [PATCH] pwm: update lpss pwm driver to support Broxton platform
Date: Thu, 12 Mar 2015 01:17:31 +0800
Message-ID: <1426094251-126816-1-git-send-email-qipeng.zha@intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32493 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118AbbCKJPG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 11 Mar 2015 05:15:06 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com, mika.westerberg@intel.com, jason.cj.chen@intel.com, "qipeng.zha" <qipeng.zha@intel.com>

From: "qipeng.zha" <qipeng.zha@intel.com>

Add pci device id for Broxton platform.

Signed-off-by: qipeng.zha <qipeng.zha@intel.com>
---
 drivers/pwm/pwm-lpss-pci.c | 2 ++
 drivers/pwm/pwm-lpss.c     | 6 ++++++
 drivers/pwm/pwm-lpss.h     | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index cf20d2b..ab6c84e 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -48,6 +48,8 @@ static const struct pci_device_id pwm_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x0f09), (unsigned long)&pwm_lpss_byt_info},
 	{ PCI_VDEVICE(INTEL, 0x2288), (unsigned long)&pwm_lpss_bsw_info},
 	{ PCI_VDEVICE(INTEL, 0x2289), (unsigned long)&pwm_lpss_bsw_info},
+	{ PCI_VDEVICE(INTEL, 0x0AC8), (unsigned long)&pwm_lpss_bxt_info},
+	{ PCI_VDEVICE(INTEL, 0x1AC8), (unsigned long)&pwm_lpss_bxt_info},
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, pwm_lpss_pci_ids);
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index e979825..0d37592 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -47,6 +47,12 @@ const struct pwm_lpss_boardinfo pwm_lpss_bsw_info = {
 };
 EXPORT_SYMBOL_GPL(pwm_lpss_bsw_info);
 
+/* Broxton */
+const struct pwm_lpss_boardinfo pwm_lpss_bxt_info = {
+	.clk_rate = 19200000
+};
+EXPORT_SYMBOL_GPL(pwm_lpss_bxt_info);
+
 static inline struct pwm_lpss_chip *to_lpwm(struct pwm_chip *chip)
 {
 	return container_of(chip, struct pwm_lpss_chip, chip);
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index aa041bb..af78137 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -24,6 +24,7 @@ struct pwm_lpss_boardinfo {
 
 extern const struct pwm_lpss_boardinfo pwm_lpss_byt_info;
 extern const struct pwm_lpss_boardinfo pwm_lpss_bsw_info;
+extern const struct pwm_lpss_boardinfo pwm_lpss_bxt_info;
 
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 				     const struct pwm_lpss_boardinfo *info);
-- 
1.8.3.2

