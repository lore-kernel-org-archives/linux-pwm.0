From: "qipeng.zha" <qipeng.zha@intel.com>
Subject: [PATCH] pwm: update lpss pwm driver to support Broxton platform
Date: Thu, 12 Mar 2015 22:27:10 +0800
Message-ID: <1426170430-804-1-git-send-email-qipeng.zha@intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:10241 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718AbbCLGYh (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 12 Mar 2015 02:24:37 -0400
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
index cf20d2b..3ae3e7b1 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -44,8 +44,10 @@ static void pwm_lpss_remove_pci(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id pwm_lpss_pci_ids[] = {
+	{ PCI_VDEVICE(INTEL, 0x0AC8), (unsigned long)&pwm_lpss_bsw_info},
 	{ PCI_VDEVICE(INTEL, 0x0f08), (unsigned long)&pwm_lpss_byt_info},
 	{ PCI_VDEVICE(INTEL, 0x0f09), (unsigned long)&pwm_lpss_byt_info},
+	{ PCI_VDEVICE(INTEL, 0x1AC8), (unsigned long)&pwm_lpss_bsw_info},
 	{ PCI_VDEVICE(INTEL, 0x2288), (unsigned long)&pwm_lpss_bsw_info},
 	{ PCI_VDEVICE(INTEL, 0x2289), (unsigned long)&pwm_lpss_bsw_info},
 	{ },
-- 
1.8.3.2

