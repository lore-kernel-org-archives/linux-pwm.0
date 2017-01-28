From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 6/6] pwm: lpss: Add Intel Gemini Lake PCI ID
Date: Sat, 28 Jan 2017 17:10:44 +0200
Message-ID: <20170128151044.87572-7-andriy.shevchenko@linux.intel.com>
References: <20170128151044.87572-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4342 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752073AbdA1PO3 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 28 Jan 2017 10:14:29 -0500
In-Reply-To: <20170128151044.87572-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Ilkka Koskinen <ilkka.koskinen@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Intel Gemini Lake PWM is pretty much same as used in Intel Broxton. Add
this new PCI ID to the list of supported devices.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index 2e7a9a48060d..053088b9b66e 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -101,6 +101,7 @@ static const struct pci_device_id pwm_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x1ac8), (unsigned long)&pwm_lpss_bxt_info},
 	{ PCI_VDEVICE(INTEL, 0x2288), (unsigned long)&pwm_lpss_bsw_info},
 	{ PCI_VDEVICE(INTEL, 0x2289), (unsigned long)&pwm_lpss_bsw_info},
+	{ PCI_VDEVICE(INTEL, 0x31c8), (unsigned long)&pwm_lpss_bxt_info},
 	{ PCI_VDEVICE(INTEL, 0x5ac8), (unsigned long)&pwm_lpss_bxt_info},
 	{ },
 };
-- 
2.11.0
