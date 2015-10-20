From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/3] pwm: lpss: Support all four PWMs on Intel Broxton
Date: Tue, 20 Oct 2015 16:53:06 +0300
Message-ID: <1445349187-114759-2-git-send-email-mika.westerberg@linux.intel.com>
References: <1445349187-114759-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445349187-114759-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, Huiquan Zhong <huiquan.zhong@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Intel Broxton has similar PWM than Intel Braswell but instead of one it has
four PWMs included in one PCI/ACPI device. This patch adds support for all
the four PWMs and changes the PCI part of the driver to use
'pwm_lpss_bxt_info' instead.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pwm/pwm-lpss-pci.c | 4 ++--
 drivers/pwm/pwm-lpss.c     | 7 +++++++
 drivers/pwm/pwm-lpss.h     | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index 45042c1b2046..6432a0b97701 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -44,10 +44,10 @@ static void pwm_lpss_remove_pci(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id pwm_lpss_pci_ids[] = {
-	{ PCI_VDEVICE(INTEL, 0x0ac8), (unsigned long)&pwm_lpss_bsw_info},
+	{ PCI_VDEVICE(INTEL, 0x0ac8), (unsigned long)&pwm_lpss_bxt_info},
 	{ PCI_VDEVICE(INTEL, 0x0f08), (unsigned long)&pwm_lpss_byt_info},
 	{ PCI_VDEVICE(INTEL, 0x0f09), (unsigned long)&pwm_lpss_byt_info},
-	{ PCI_VDEVICE(INTEL, 0x1ac8), (unsigned long)&pwm_lpss_bsw_info},
+	{ PCI_VDEVICE(INTEL, 0x1ac8), (unsigned long)&pwm_lpss_bxt_info},
 	{ PCI_VDEVICE(INTEL, 0x2288), (unsigned long)&pwm_lpss_bsw_info},
 	{ PCI_VDEVICE(INTEL, 0x2289), (unsigned long)&pwm_lpss_bsw_info},
 	{ },
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index e7392bdfdd18..df03b50f20dd 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -52,6 +52,13 @@ const struct pwm_lpss_boardinfo pwm_lpss_bsw_info = {
 };
 EXPORT_SYMBOL_GPL(pwm_lpss_bsw_info);
 
+/* Broxton */
+const struct pwm_lpss_boardinfo pwm_lpss_bxt_info = {
+	.clk_rate = 19200000,
+	.npwm = 4,
+};
+EXPORT_SYMBOL_GPL(pwm_lpss_bxt_info);
+
 static inline struct pwm_lpss_chip *to_lpwm(struct pwm_chip *chip)
 {
 	return container_of(chip, struct pwm_lpss_chip, chip);
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index ef2419f47c57..b8001d6a3e00 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -25,6 +25,7 @@ struct pwm_lpss_boardinfo {
 
 extern const struct pwm_lpss_boardinfo pwm_lpss_byt_info;
 extern const struct pwm_lpss_boardinfo pwm_lpss_bsw_info;
+extern const struct pwm_lpss_boardinfo pwm_lpss_bxt_info;
 
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 				     const struct pwm_lpss_boardinfo *info);
-- 
2.6.1
