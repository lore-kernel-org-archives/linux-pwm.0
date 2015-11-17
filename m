From: Qipeng Zha <qipeng.zha@intel.com>
Subject: [PATCH v5] pwm:lpss: update pwm setting for Broxton
Date: Tue, 17 Nov 2015 17:20:15 +0800
Message-ID: <1447752015-55339-1-git-send-email-qipeng.zha@intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:43805 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbbKQBPz (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 16 Nov 2015 20:15:55 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com, mika.westerberg@intel.com, qipeng.zha@intel.com

For Broxton PWM controller, base unit is defined as 8bit integer
and 14bit fraction, so need to update base unit setting to output
wave with right frequency.

Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>

---
change in v5
 fix one code style issue in block comments.

change in v4
 fix one code style issue, exceed 80 characters.

change in v3
 use BIT macro to calculate base_unit_range;
 mask base_unit with "base_unit_range - 1".
---
 drivers/pwm/pwm-lpss.c | 33 +++++++++++++++++++--------------
 drivers/pwm/pwm-lpss.h |  1 +
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 2504410..320dbf2 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/time.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
@@ -24,11 +25,8 @@
 #define PWM_ENABLE			BIT(31)
 #define PWM_SW_UPDATE			BIT(30)
 #define PWM_BASE_UNIT_SHIFT		8
-#define PWM_BASE_UNIT_MASK		0x00ffff00
 #define PWM_ON_TIME_DIV_MASK		0x000000ff
 #define PWM_DIVISION_CORRECTION		0x2
-#define PWM_LIMIT			(0x8000 + PWM_DIVISION_CORRECTION)
-#define NSECS_PER_SEC			1000000000UL
 
 /* Size of each PWM register space if multiple */
 #define PWM_SIZE			0x400
@@ -36,13 +34,14 @@
 struct pwm_lpss_chip {
 	struct pwm_chip chip;
 	void __iomem *regs;
-	unsigned long clk_rate;
+	const struct pwm_lpss_boardinfo *info;
 };
 
 /* BayTrail */
 const struct pwm_lpss_boardinfo pwm_lpss_byt_info = {
 	.clk_rate = 25000000,
 	.npwm = 1,
+	.base_unit_bits = 16,
 };
 EXPORT_SYMBOL_GPL(pwm_lpss_byt_info);
 
@@ -50,6 +49,7 @@ EXPORT_SYMBOL_GPL(pwm_lpss_byt_info);
 const struct pwm_lpss_boardinfo pwm_lpss_bsw_info = {
 	.clk_rate = 19200000,
 	.npwm = 1,
+	.base_unit_bits = 16,
 };
 EXPORT_SYMBOL_GPL(pwm_lpss_bsw_info);
 
@@ -57,6 +57,7 @@ EXPORT_SYMBOL_GPL(pwm_lpss_bsw_info);
 const struct pwm_lpss_boardinfo pwm_lpss_bxt_info = {
 	.clk_rate = 19200000,
 	.npwm = 4,
+	.base_unit_bits = 22,
 };
 EXPORT_SYMBOL_GPL(pwm_lpss_bxt_info);
 
@@ -84,23 +85,25 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
 	u8 on_time_div;
-	unsigned long c;
-	unsigned long long base_unit, freq = NSECS_PER_SEC;
+	unsigned long c, base_unit_range;
+	unsigned long long base_unit, freq = NSEC_PER_SEC;
 	u32 ctrl;
 
 	do_div(freq, period_ns);
 
-	/* The equation is: base_unit = ((freq / c) * 65536) + correction */
-	base_unit = freq * 65536;
+	/*
+	 * The equation is:
+	 * base_unit = ((freq / c) * base_unit_range) + correction
+	 */
+	base_unit_range = BIT(lpwm->info->base_unit_bits);
+	base_unit = freq * base_unit_range;
 
-	c = lpwm->clk_rate;
+	c = lpwm->info->clk_rate;
 	if (!c)
 		return -EINVAL;
 
 	do_div(base_unit, c);
 	base_unit += PWM_DIVISION_CORRECTION;
-	if (base_unit > PWM_LIMIT)
-		return -EINVAL;
 
 	if (duty_ns <= 0)
 		duty_ns = 1;
@@ -109,8 +112,10 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pm_runtime_get_sync(chip->dev);
 
 	ctrl = pwm_lpss_read(pwm);
-	ctrl &= ~(PWM_BASE_UNIT_MASK | PWM_ON_TIME_DIV_MASK);
-	ctrl |= (u16) base_unit << PWM_BASE_UNIT_SHIFT;
+	ctrl &= ~PWM_ON_TIME_DIV_MASK;
+	ctrl &= ~((base_unit_range - 1) << PWM_BASE_UNIT_SHIFT);
+	base_unit &= (base_unit_range - 1);
+	ctrl |= (u32) base_unit << PWM_BASE_UNIT_SHIFT;
 	ctrl |= on_time_div;
 	/* request PWM to update on next cycle */
 	ctrl |= PWM_SW_UPDATE;
@@ -156,7 +161,7 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 	if (IS_ERR(lpwm->regs))
 		return ERR_CAST(lpwm->regs);
 
-	lpwm->clk_rate = info->clk_rate;
+	lpwm->info = info;
 	lpwm->chip.dev = dev;
 	lpwm->chip.ops = &pwm_lpss_ops;
 	lpwm->chip.base = -1;
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index e8cf337..04766e0 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -21,6 +21,7 @@ struct pwm_lpss_chip;
 struct pwm_lpss_boardinfo {
 	unsigned long clk_rate;
 	unsigned int npwm;
+	unsigned long base_unit_bits;
 };
 
 extern const struct pwm_lpss_boardinfo pwm_lpss_byt_info;
-- 
1.8.3.2
