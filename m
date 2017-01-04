From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] pwm: lpss: Add Intel Gemini Lake PCI ID
Date: Wed,  4 Jan 2017 18:43:34 +0300
Message-ID: <20170104154334.29046-1-mika.westerberg@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:59615 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757626AbdADPnj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 4 Jan 2017 10:43:39 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Intel Gemini Lake PWM is pretty much same as used in Intel Broxton. Add
this new PCI ID to the list of supported devices.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Hi, this is on top of Andy's series here:

https://patchwork.ozlabs.org/patch/710104/
https://patchwork.ozlabs.org/patch/710107/
https://patchwork.ozlabs.org/patch/710105/
https://patchwork.ozlabs.org/patch/710106/

 drivers/pwm/pwm-lpss-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index dfe0a2e8e4de..2c2ca370dc26 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -78,6 +78,7 @@ static const struct pci_device_id pwm_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x1ac8), PWM_LPSS_BXT },
 	{ PCI_VDEVICE(INTEL, 0x2288), PWM_LPSS_BSW },
 	{ PCI_VDEVICE(INTEL, 0x2289), PWM_LPSS_BSW },
+	{ PCI_VDEVICE(INTEL, 0x31c8), PWM_LPSS_BXT },
 	{ PCI_VDEVICE(INTEL, 0x5ac8), PWM_LPSS_BXT },
 	{ },
 };
-- 
2.11.0
