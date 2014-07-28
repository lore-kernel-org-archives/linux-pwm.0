From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] pwm: lpss: pci: move to use pcim_enable_device()
Date: Mon, 28 Jul 2014 17:27:27 +0300
Message-ID: <1406557647-23891-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1406557647-23891-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46484 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752866AbaG1O1a (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 28 Jul 2014 10:27:30 -0400
In-Reply-To: <1406557647-23891-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Let's use managed functions for this driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pwm/pwm-lpss-pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index 48b88dd..974f4c8 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -28,7 +28,7 @@ static int pwm_lpss_probe_pci(struct pci_dev *pdev,
 	struct pwm_lpss_chip *lpwm;
 	int err;
 
-	err = pci_enable_device(pdev);
+	err = pcim_enable_device(pdev);
 	if (err < 0)
 		return err;
 
@@ -46,7 +46,6 @@ static void pwm_lpss_remove_pci(struct pci_dev *pdev)
 	struct pwm_lpss_chip *lpwm = pci_get_drvdata(pdev);
 
 	pwm_lpss_remove(lpwm);
-	pci_disable_device(pdev);
 }
 
 static struct pci_device_id pwm_lpss_pci_ids[] = {
-- 
2.0.1

