From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v3] pwm: lpss: Add support for runtime PM
Date: Mon, 26 Oct 2015 12:58:27 +0200
Message-ID: <1445857107-51808-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Huiquan Zhong <huiquan.zhong@intel.com>, Qipeng Zha <qipeng.zha@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

From: Qipeng Zha <qipeng.zha@intel.com>

To be able to save some power when PWM is not in use, add support for
runtime PM for this driver. This also allows the platform to transition to
low power S0ix states when the system is idle.

Signed-off-by: Huiquan Zhong <huiquan.zhong@intel.com>
Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
The original patch from Qipeng is here:

http://thread.gmane.org/gmane.linux.pwm/2803

I modified it a bit so that it does runtime_pm_get_sync() on enable and
runtime_pm_put() on disable. That allows us to get rid of the autosuspend
thing in v2.

This applies on top of my previous series here:

http://thread.gmane.org/gmane.linux.pwm/2920

 drivers/pwm/pwm-lpss-pci.c      | 32 ++++++++++++++++++++++++++++++++
 drivers/pwm/pwm-lpss-platform.c |  6 ++++++
 drivers/pwm/pwm-lpss.c          |  7 +++++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index c15bc6d00f1a..7160e8ab38a4 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 
 #include "pwm-lpss.h"
 
@@ -33,6 +34,10 @@ static int pwm_lpss_probe_pci(struct pci_dev *pdev,
 		return PTR_ERR(lpwm);
 
 	pci_set_drvdata(pdev, lpwm);
+
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
+
 	return 0;
 }
 
@@ -40,9 +45,33 @@ static void pwm_lpss_remove_pci(struct pci_dev *pdev)
 {
 	struct pwm_lpss_chip *lpwm = pci_get_drvdata(pdev);
 
+	pm_runtime_forbid(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
 	pwm_lpss_remove(lpwm);
 }
 
+#ifdef CONFIG_PM
+static int pwm_lpss_runtime_suspend_pci(struct device *dev)
+{
+	/*
+	 * The PCI core will handle transition to D3 automatically. We only
+	 * need to provide runtime PM hooks for that to happen.
+	 */
+	return 0;
+}
+
+static int pwm_lpss_runtime_resume_pci(struct device *dev)
+{
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops pwm_lpss_pci_pm = {
+	SET_RUNTIME_PM_OPS(pwm_lpss_runtime_suspend_pci,
+			   pwm_lpss_runtime_resume_pci, NULL)
+};
+
 static const struct pci_device_id pwm_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x0ac8), (unsigned long)&pwm_lpss_bxt_info},
 	{ PCI_VDEVICE(INTEL, 0x0f08), (unsigned long)&pwm_lpss_byt_info},
@@ -60,6 +89,9 @@ static struct pci_driver pwm_lpss_driver_pci = {
 	.id_table = pwm_lpss_pci_ids,
 	.probe = pwm_lpss_probe_pci,
 	.remove = pwm_lpss_remove_pci,
+	.driver = {
+		.pm = &pwm_lpss_pci_pm,
+	},
 };
 module_pci_driver(pwm_lpss_driver_pci);
 
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index a914aacf6757..54433fc6d1a4 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include "pwm-lpss.h"
 
@@ -36,6 +37,10 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
 		return PTR_ERR(lpwm);
 
 	platform_set_drvdata(pdev, lpwm);
+
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	return 0;
 }
 
@@ -43,6 +48,7 @@ static int pwm_lpss_remove_platform(struct platform_device *pdev)
 {
 	struct pwm_lpss_chip *lpwm = platform_get_drvdata(pdev);
 
+	pm_runtime_disable(&pdev->dev);
 	return pwm_lpss_remove(lpwm);
 }
 
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index df03b50f20dd..25044104003b 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 
 #include "pwm-lpss.h"
 
@@ -105,6 +106,8 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		duty_ns = 1;
 	on_time_div = 255 - (255 * duty_ns / period_ns);
 
+	pm_runtime_get_sync(chip->dev);
+
 	ctrl = pwm_lpss_read(pwm);
 	ctrl &= ~(PWM_BASE_UNIT_MASK | PWM_ON_TIME_DIV_MASK);
 	ctrl |= (u16) base_unit << PWM_BASE_UNIT_SHIFT;
@@ -113,11 +116,14 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	ctrl |= PWM_SW_UPDATE;
 	pwm_lpss_write(pwm, ctrl);
 
+	pm_runtime_put(chip->dev);
+
 	return 0;
 }
 
 static int pwm_lpss_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	pm_runtime_get_sync(chip->dev);
 	pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
 	return 0;
 }
@@ -125,6 +131,7 @@ static int pwm_lpss_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 static void pwm_lpss_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
+	pm_runtime_put(chip->dev);
 }
 
 static const struct pwm_ops pwm_lpss_ops = {
-- 
2.6.1
