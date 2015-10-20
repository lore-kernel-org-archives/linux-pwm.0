From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 3/3] pwm: lpss: Add more Intel Broxton IDs
Date: Tue, 20 Oct 2015 16:53:07 +0300
Message-ID: <1445349187-114759-3-git-send-email-mika.westerberg@linux.intel.com>
References: <1445349187-114759-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61107 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846AbbJTNxL (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 20 Oct 2015 09:53:11 -0400
In-Reply-To: <1445349187-114759-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, Huiquan Zhong <huiquan.zhong@intel.com>, linux-kernel@vger.kernel.org

Add more Intel Broxton ACPI and PCI IDs to the driver supported devices
list.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pwm/pwm-lpss-pci.c      | 1 +
 drivers/pwm/pwm-lpss-platform.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index 6432a0b97701..c15bc6d00f1a 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -50,6 +50,7 @@ static const struct pci_device_id pwm_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x1ac8), (unsigned long)&pwm_lpss_bxt_info},
 	{ PCI_VDEVICE(INTEL, 0x2288), (unsigned long)&pwm_lpss_bsw_info},
 	{ PCI_VDEVICE(INTEL, 0x2289), (unsigned long)&pwm_lpss_bsw_info},
+	{ PCI_VDEVICE(INTEL, 0x5ac8), (unsigned long)&pwm_lpss_bxt_info},
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, pwm_lpss_pci_ids);
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 18a9c880a76d..a914aacf6757 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -49,6 +49,7 @@ static int pwm_lpss_remove_platform(struct platform_device *pdev)
 static const struct acpi_device_id pwm_lpss_acpi_match[] = {
 	{ "80860F09", (unsigned long)&pwm_lpss_byt_info },
 	{ "80862288", (unsigned long)&pwm_lpss_bsw_info },
+	{ "80865AC8", (unsigned long)&pwm_lpss_bxt_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, pwm_lpss_acpi_match);
-- 
2.6.1
