From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/2] pwm: lpss: Rework the sequence of programming PWM_SW_UPDATE
Date: Wed, 18 Nov 2015 13:25:18 +0200
Message-ID: <1447845918-66691-2-git-send-email-mika.westerberg@linux.intel.com>
References: <1447845918-66691-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20400 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754864AbbKRLZY (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 18 Nov 2015 06:25:24 -0500
In-Reply-To: <1447845918-66691-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-pwm@vger.kernel.org

Setting of PWM_SW_UPDATE is bit different in Intel Broxton compared to the
previous generation SoCs. Previously it was OK to set the bit many times
(from userspace via sysfs for example) before the PWM is actually enabled.

Starting from Intel Broxton it seems that we must set PWM_SW_UPDATE only
once before the PWM is enabled. Otherwise it is possible that the PWM does
not start properly.

Change the sequence of how PWM_SW_UPDATE is programmed so that we only set
it in pwm_lpss_config() when the PWM is already enabled. The initial
setting of PWM_SW_UPDATE will be done when PWM gets enabled. This should
make the driver work with the previous generation Intel SoCs and Broxton.

Add also small delay after the bit is set to let the hardware propagate it
properly.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Applies on top of Qipeng's patch here:

https://patchwork.ozlabs.org/patch/545313/

 drivers/pwm/pwm-lpss.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 320dbf250cc5..6063c3dcbd46 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -13,6 +13,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
@@ -80,6 +81,13 @@ static inline void pwm_lpss_write(const struct pwm_device *pwm, u32 value)
 	writel(value, lpwm->regs + pwm->hwpwm * PWM_SIZE + PWM);
 }
 
+static void pwm_lpss_update(struct pwm_device *pwm)
+{
+	pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_SW_UPDATE);
+	/* Give it some time to propagate */
+	usleep_range(10, 50);
+}
+
 static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			   int duty_ns, int period_ns)
 {
@@ -117,10 +125,15 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	base_unit &= (base_unit_range - 1);
 	ctrl |= (u32) base_unit << PWM_BASE_UNIT_SHIFT;
 	ctrl |= on_time_div;
-	/* request PWM to update on next cycle */
-	ctrl |= PWM_SW_UPDATE;
 	pwm_lpss_write(pwm, ctrl);
 
+	/*
+	 * If the PWM is already enabled we need to notify the hardware
+	 * about the change by setting PWM_SW_UPDATE.
+	 */
+	if (pwm_is_enabled(pwm))
+		pwm_lpss_update(pwm);
+
 	pm_runtime_put(chip->dev);
 
 	return 0;
@@ -129,6 +142,12 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 static int pwm_lpss_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	pm_runtime_get_sync(chip->dev);
+
+	/*
+	 * Hardware must first see PWM_SW_UPDATE before the PWM can be
+	 * enabled.
+	 */
+	pwm_lpss_update(pwm);
 	pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
 	return 0;
 }
-- 
2.6.2
