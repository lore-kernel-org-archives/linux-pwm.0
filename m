From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pwm: lpss: pci: enable PWM module on Intel Edison
Date: Mon, 13 Jun 2016 21:52:19 +0300
Message-ID: <1465843939-1221-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14298 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422864AbcFMSwY (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 13 Jun 2016 14:52:24 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Intel Edison has 4 PWM channels on the die with the same IP as in Broxton.
Enable it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index 7160e8a..3622f09 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -76,6 +76,7 @@ static const struct pci_device_id pwm_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x0ac8), (unsigned long)&pwm_lpss_bxt_info},
 	{ PCI_VDEVICE(INTEL, 0x0f08), (unsigned long)&pwm_lpss_byt_info},
 	{ PCI_VDEVICE(INTEL, 0x0f09), (unsigned long)&pwm_lpss_byt_info},
+	{ PCI_VDEVICE(INTEL, 0x11a5), (unsigned long)&pwm_lpss_bxt_info},
 	{ PCI_VDEVICE(INTEL, 0x1ac8), (unsigned long)&pwm_lpss_bxt_info},
 	{ PCI_VDEVICE(INTEL, 0x2288), (unsigned long)&pwm_lpss_bsw_info},
 	{ PCI_VDEVICE(INTEL, 0x2289), (unsigned long)&pwm_lpss_bsw_info},
-- 
2.8.1
