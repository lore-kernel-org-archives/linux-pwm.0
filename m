From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pwm: lpss: Move clk_rate check to ->probe()
Date: Mon,  4 Jul 2016 18:36:27 +0300
Message-ID: <1467646587-6613-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:21616 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932500AbcGDPgc (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 4 Jul 2016 11:36:32 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is no need to check each time if the clk_rate defined or not when we call
pwm_lpss_config(). Move the check to ->probe() instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index be4658b..72c0bce 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -92,7 +92,7 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
 	unsigned long long on_time_div;
-	unsigned long c, base_unit_range;
+	unsigned long c = lpwm->info->clk_rate, base_unit_range;
 	unsigned long long base_unit, freq = NSEC_PER_SEC;
 	u32 ctrl;
 
@@ -105,10 +105,6 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	base_unit_range = BIT(lpwm->info->base_unit_bits);
 	freq *= base_unit_range;
 
-	c = lpwm->info->clk_rate;
-	if (!c)
-		return -EINVAL;
-
 	base_unit = DIV_ROUND_CLOSEST_ULL(freq, c);
 
 	if (duty_ns <= 0)
@@ -169,6 +165,7 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 				     const struct pwm_lpss_boardinfo *info)
 {
 	struct pwm_lpss_chip *lpwm;
+	unsigned long c;
 	int ret;
 
 	lpwm = devm_kzalloc(dev, sizeof(*lpwm), GFP_KERNEL);
@@ -180,6 +177,11 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 		return ERR_CAST(lpwm->regs);
 
 	lpwm->info = info;
+
+	c = lpwm->info->clk_rate;
+	if (!c)
+		return ERR_PTR(-EINVAL);
+
 	lpwm->chip.dev = dev;
 	lpwm->chip.ops = &pwm_lpss_ops;
 	lpwm->chip.base = -1;
-- 
2.8.1
