From: Qipeng Zha <qipeng.zha@intel.com>
Subject: [PATCH] pwm:lpss: update pwm setting for Broxton
Date: Fri, 13 Nov 2015 00:28:04 +0800
Message-ID: <1447345684-108039-1-git-send-email-qipeng.zha@intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2626 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbbKLIXq (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 12 Nov 2015 03:23:46 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com, mika.westerberg@intel.com, qipeng.zha@intel.com

For Broxton PWM controller, base unit is defined as 8bit integer
and 14bit fraction, so need to update base unit setting to output
wave with right frequency.
a) add scaler for each board setting;
b) remove validity check of base unit for special board, let pwm
user to handle this;

Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>
---
 drivers/pwm/pwm-lpss.c | 20 +++++++++++---------
 drivers/pwm/pwm-lpss.h |  1 +
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 2504410..5a907db 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/time.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
@@ -24,11 +25,9 @@
 #define PWM_ENABLE			BIT(31)
 #define PWM_SW_UPDATE			BIT(30)
 #define PWM_BASE_UNIT_SHIFT		8
-#define PWM_BASE_UNIT_MASK		0x00ffff00
+#define PWM_BASE_UNIT_MASK		0x3fffff00
 #define PWM_ON_TIME_DIV_MASK		0x000000ff
 #define PWM_DIVISION_CORRECTION		0x2
-#define PWM_LIMIT			(0x8000 + PWM_DIVISION_CORRECTION)
-#define NSECS_PER_SEC			1000000000UL
 
 /* Size of each PWM register space if multiple */
 #define PWM_SIZE			0x400
@@ -37,12 +36,14 @@ struct pwm_lpss_chip {
 	struct pwm_chip chip;
 	void __iomem *regs;
 	unsigned long clk_rate;
+	unsigned long scaler;
 };
 
 /* BayTrail */
 const struct pwm_lpss_boardinfo pwm_lpss_byt_info = {
 	.clk_rate = 25000000,
 	.npwm = 1,
+	.scaler = 65536
 };
 EXPORT_SYMBOL_GPL(pwm_lpss_byt_info);
 
@@ -50,6 +51,7 @@ EXPORT_SYMBOL_GPL(pwm_lpss_byt_info);
 const struct pwm_lpss_boardinfo pwm_lpss_bsw_info = {
 	.clk_rate = 19200000,
 	.npwm = 1,
+	.scaler = 65536
 };
 EXPORT_SYMBOL_GPL(pwm_lpss_bsw_info);
 
@@ -57,6 +59,7 @@ EXPORT_SYMBOL_GPL(pwm_lpss_bsw_info);
 const struct pwm_lpss_boardinfo pwm_lpss_bxt_info = {
 	.clk_rate = 19200000,
 	.npwm = 4,
+	.scaler = 4194304
 };
 EXPORT_SYMBOL_GPL(pwm_lpss_bxt_info);
 
@@ -85,13 +88,13 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
 	u8 on_time_div;
 	unsigned long c;
-	unsigned long long base_unit, freq = NSECS_PER_SEC;
+	unsigned long long base_unit, freq = NSEC_PER_SEC;
 	u32 ctrl;
 
 	do_div(freq, period_ns);
 
-	/* The equation is: base_unit = ((freq / c) * 65536) + correction */
-	base_unit = freq * 65536;
+	/* The equation is: base_unit = ((freq / c) * scaler) + correction */
+	base_unit = freq * lpwm->scaler;
 
 	c = lpwm->clk_rate;
 	if (!c)
@@ -99,8 +102,6 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	do_div(base_unit, c);
 	base_unit += PWM_DIVISION_CORRECTION;
-	if (base_unit > PWM_LIMIT)
-		return -EINVAL;
 
 	if (duty_ns <= 0)
 		duty_ns = 1;
@@ -110,7 +111,7 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ctrl = pwm_lpss_read(pwm);
 	ctrl &= ~(PWM_BASE_UNIT_MASK | PWM_ON_TIME_DIV_MASK);
-	ctrl |= (u16) base_unit << PWM_BASE_UNIT_SHIFT;
+	ctrl |= (u32) base_unit << PWM_BASE_UNIT_SHIFT;
 	ctrl |= on_time_div;
 	/* request PWM to update on next cycle */
 	ctrl |= PWM_SW_UPDATE;
@@ -157,6 +158,7 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 		return ERR_CAST(lpwm->regs);
 
 	lpwm->clk_rate = info->clk_rate;
+	lpwm->scaler = info->scaler;
 	lpwm->chip.dev = dev;
 	lpwm->chip.ops = &pwm_lpss_ops;
 	lpwm->chip.base = -1;
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index e8cf337..834be4c 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -21,6 +21,7 @@ struct pwm_lpss_chip;
 struct pwm_lpss_boardinfo {
 	unsigned long clk_rate;
 	unsigned int npwm;
+	unsigned long scaler;
 };
 
 extern const struct pwm_lpss_boardinfo pwm_lpss_byt_info;
-- 
1.8.3.2
