From: "qipeng.zha" <qipeng.zha@intel.com>
Subject: [PATCH] pwm: update lpss pwm driver to support Broxton platform
Date: Thu, 12 Mar 2015 22:28:28 +0800
Message-ID: <1426170508-8273-1-git-send-email-qipeng.zha@intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43353 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbbCLGZy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 12 Mar 2015 02:25:54 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com, mika.westerberg@intel.com, "qipeng.zha" <qipeng.zha@intel.com>

From: "qipeng.zha" <qipeng.zha@intel.com>

Add pci device id for Broxton platform.

Signed-off-by: qipeng.zha <qipeng.zha@intel.com>
---
 drivers/pwm/pwm-lpss-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index cf20d2b..45042c1 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -44,8 +44,10 @@ static void pwm_lpss_remove_pci(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id pwm_lpss_pci_ids[] = {
+	{ PCI_VDEVICE(INTEL, 0x0ac8), (unsigned long)&pwm_lpss_bsw_info},
 	{ PCI_VDEVICE(INTEL, 0x0f08), (unsigned long)&pwm_lpss_byt_info},
 	{ PCI_VDEVICE(INTEL, 0x0f09), (unsigned long)&pwm_lpss_byt_info},
+	{ PCI_VDEVICE(INTEL, 0x1ac8), (unsigned long)&pwm_lpss_bsw_info},
 	{ PCI_VDEVICE(INTEL, 0x2288), (unsigned long)&pwm_lpss_bsw_info},
 	{ PCI_VDEVICE(INTEL, 0x2289), (unsigned long)&pwm_lpss_bsw_info},
 	{ },
-- 
1.8.3.2

