From: Qipeng Zha <qipeng.zha@intel.com>
Subject: [PATCH] pwm: lpss: add PM support for LPSS PWM
Date: Tue, 15 Sep 2015 18:40:26 +0800
Message-ID: <1442313626-63022-1-git-send-email-qipeng.zha@intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23793 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbbIOCgc (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 14 Sep 2015 22:36:32 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com, mika.westerberg@intel.com, Huiquan Zhong <huiquan.zhong@intel.com>

Signed-off-by: Huiquan Zhong <huiquan.zhong@intel.com>
Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>
---
 drivers/pwm/pwm-lpss-pci.c      | 11 +++++++++++
 drivers/pwm/pwm-lpss-platform.c | 11 +++++++++++
 drivers/pwm/pwm-lpss.c          | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/pwm/pwm-lpss.h          |  1 +
 4 files changed, 64 insertions(+)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index 45042c1..e8c31d6 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 
 #include "pwm-lpss.h"
 
@@ -33,6 +34,12 @@ static int pwm_lpss_probe_pci(struct pci_dev *pdev,
 		return PTR_ERR(lpwm);
 
 	pci_set_drvdata(pdev, lpwm);
+
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 5);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
+
 	return 0;
 }
 
@@ -40,6 +47,7 @@ static void pwm_lpss_remove_pci(struct pci_dev *pdev)
 {
 	struct pwm_lpss_chip *lpwm = pci_get_drvdata(pdev);
 
+	pm_runtime_forbid(&pdev->dev);
 	pwm_lpss_remove(lpwm);
 }
 
@@ -59,6 +67,9 @@ static struct pci_driver pwm_lpss_driver_pci = {
 	.id_table = pwm_lpss_pci_ids,
 	.probe = pwm_lpss_probe_pci,
 	.remove = pwm_lpss_remove_pci,
+	.driver = {
+		.pm = &pwm_lpss_pm,
+	},
 };
 module_pci_driver(pwm_lpss_driver_pci);
 
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 18a9c88..09a7d99 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include "pwm-lpss.h"
 
@@ -36,6 +37,12 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
 		return PTR_ERR(lpwm);
 
 	platform_set_drvdata(pdev, lpwm);
+
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 5);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
+
 	return 0;
 }
 
@@ -43,6 +50,7 @@ static int pwm_lpss_remove_platform(struct platform_device *pdev)
 {
 	struct pwm_lpss_chip *lpwm = platform_get_drvdata(pdev);
 
+	pm_runtime_forbid(&pdev->dev);
 	return pwm_lpss_remove(lpwm);
 }
 
@@ -60,6 +68,9 @@ static struct platform_driver pwm_lpss_driver_platform = {
 	},
 	.probe = pwm_lpss_probe_platform,
 	.remove = pwm_lpss_remove_platform,
+	.driver = {
+		.pm = &pwm_lpss_pm,
+	},
 };
 module_platform_driver(pwm_lpss_driver_platform);
 
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index e979825..fed95cc 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 
 #include "pwm-lpss.h"
 
@@ -75,6 +76,8 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (base_unit > PWM_LIMIT)
 		return -EINVAL;
 
+	pm_runtime_get_sync(lpwm->chip.dev);
+
 	if (duty_ns <= 0)
 		duty_ns = 1;
 	on_time_div = 255 - (255 * duty_ns / period_ns);
@@ -87,6 +90,9 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	ctrl |= PWM_SW_UPDATE;
 	writel(ctrl, lpwm->regs + PWM);
 
+	pm_runtime_mark_last_busy(lpwm->chip.dev);
+	pm_runtime_put_autosuspend(lpwm->chip.dev);
+
 	return 0;
 }
 
@@ -95,9 +101,14 @@ static int pwm_lpss_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
 	u32 ctrl;
 
+	pm_runtime_get_sync(lpwm->chip.dev);
+
 	ctrl = readl(lpwm->regs + PWM);
 	writel(ctrl | PWM_ENABLE, lpwm->regs + PWM);
 
+	pm_runtime_mark_last_busy(lpwm->chip.dev);
+	pm_runtime_put_autosuspend(lpwm->chip.dev);
+
 	return 0;
 }
 
@@ -106,8 +117,13 @@ static void pwm_lpss_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
 	u32 ctrl;
 
+	pm_runtime_get_sync(lpwm->chip.dev);
+
 	ctrl = readl(lpwm->regs + PWM);
 	writel(ctrl & ~PWM_ENABLE, lpwm->regs + PWM);
+
+	pm_runtime_mark_last_busy(lpwm->chip.dev);
+	pm_runtime_put_autosuspend(lpwm->chip.dev);
 }
 
 static const struct pwm_ops pwm_lpss_ops = {
@@ -158,6 +174,31 @@ int pwm_lpss_remove(struct pwm_lpss_chip *lpwm)
 }
 EXPORT_SYMBOL_GPL(pwm_lpss_remove);
 
+static int pwm_lpss_suspend(struct device *dev)
+{
+	struct pwm_lpss_chip *lpwm = dev_get_drvdata(dev);
+	u32 ctrl;
+	int ret;
+
+	ctrl = readl(lpwm->regs + PWM);
+	ret = (ctrl & PWM_ENABLE) ? -EAGAIN : 0;
+
+	return ret;
+}
+
+static int pwm_lpss_resume(struct device *dev)
+{
+	return 0;
+}
+
+const struct dev_pm_ops pwm_lpss_pm = {
+	.suspend_late = pwm_lpss_suspend,
+	.resume_early = pwm_lpss_resume,
+	SET_RUNTIME_PM_OPS(pwm_lpss_suspend,
+			pwm_lpss_resume, NULL)
+};
+EXPORT_SYMBOL(pwm_lpss_pm);
+
 MODULE_DESCRIPTION("PWM driver for Intel LPSS");
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index aa041bb..0b42983 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -28,5 +28,6 @@ extern const struct pwm_lpss_boardinfo pwm_lpss_bsw_info;
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 				     const struct pwm_lpss_boardinfo *info);
 int pwm_lpss_remove(struct pwm_lpss_chip *lpwm);
+extern const struct dev_pm_ops pwm_lpss_pm;
 
 #endif	/* __PWM_LPSS_H */
-- 
1.8.3.2
