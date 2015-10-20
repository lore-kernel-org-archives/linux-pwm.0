From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/3] pwm: lpss: Add support for multiple PWMs
Date: Tue, 20 Oct 2015 16:53:05 +0300
Message-ID: <1445349187-114759-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61107 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbbJTNxM (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 20 Oct 2015 09:53:12 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, Huiquan Zhong <huiquan.zhong@intel.com>, linux-kernel@vger.kernel.org

New Intel SoCs such as Broxton will have four PWMs per PCI (or ACPI)
device. Each PWM has 1k of register space allocated from the parent device.
Add support for this.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pwm/pwm-lpss.c | 48 +++++++++++++++++++++++++++---------------------
 drivers/pwm/pwm-lpss.h |  1 +
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index e9798253a16f..e7392bdfdd18 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -29,6 +29,9 @@
 #define PWM_LIMIT			(0x8000 + PWM_DIVISION_CORRECTION)
 #define NSECS_PER_SEC			1000000000UL
 
+/* Size of each PWM register space if multiple */
+#define PWM_SIZE			0x400
+
 struct pwm_lpss_chip {
 	struct pwm_chip chip;
 	void __iomem *regs;
@@ -37,13 +40,15 @@ struct pwm_lpss_chip {
 
 /* BayTrail */
 const struct pwm_lpss_boardinfo pwm_lpss_byt_info = {
-	.clk_rate = 25000000
+	.clk_rate = 25000000,
+	.npwm = 1,
 };
 EXPORT_SYMBOL_GPL(pwm_lpss_byt_info);
 
 /* Braswell */
 const struct pwm_lpss_boardinfo pwm_lpss_bsw_info = {
-	.clk_rate = 19200000
+	.clk_rate = 19200000,
+	.npwm = 1,
 };
 EXPORT_SYMBOL_GPL(pwm_lpss_bsw_info);
 
@@ -52,6 +57,20 @@ static inline struct pwm_lpss_chip *to_lpwm(struct pwm_chip *chip)
 	return container_of(chip, struct pwm_lpss_chip, chip);
 }
 
+static inline u32 pwm_lpss_read(const struct pwm_device *pwm)
+{
+	struct pwm_lpss_chip *lpwm = to_lpwm(pwm->chip);
+
+	return readl(lpwm->regs + pwm->hwpwm * PWM_SIZE + PWM);
+}
+
+static inline void pwm_lpss_write(const struct pwm_device *pwm, u32 value)
+{
+	struct pwm_lpss_chip *lpwm = to_lpwm(pwm->chip);
+
+	writel(value, lpwm->regs + pwm->hwpwm * PWM_SIZE + PWM);
+}
+
 static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			   int duty_ns, int period_ns)
 {
@@ -79,38 +98,30 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		duty_ns = 1;
 	on_time_div = 255 - (255 * duty_ns / period_ns);
 
-	ctrl = readl(lpwm->regs + PWM);
+	ctrl = pwm_lpss_read(pwm);
 	ctrl &= ~(PWM_BASE_UNIT_MASK | PWM_ON_TIME_DIV_MASK);
 	ctrl |= (u16) base_unit << PWM_BASE_UNIT_SHIFT;
 	ctrl |= on_time_div;
 	/* request PWM to update on next cycle */
 	ctrl |= PWM_SW_UPDATE;
-	writel(ctrl, lpwm->regs + PWM);
+	pwm_lpss_write(pwm, ctrl);
 
 	return 0;
 }
 
 static int pwm_lpss_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
-	u32 ctrl;
-
-	ctrl = readl(lpwm->regs + PWM);
-	writel(ctrl | PWM_ENABLE, lpwm->regs + PWM);
-
+	pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
 	return 0;
 }
 
 static void pwm_lpss_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
-	u32 ctrl;
-
-	ctrl = readl(lpwm->regs + PWM);
-	writel(ctrl & ~PWM_ENABLE, lpwm->regs + PWM);
+	pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
 }
 
 static const struct pwm_ops pwm_lpss_ops = {
+	.free = pwm_lpss_disable,
 	.config = pwm_lpss_config,
 	.enable = pwm_lpss_enable,
 	.disable = pwm_lpss_disable,
@@ -135,7 +146,7 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 	lpwm->chip.dev = dev;
 	lpwm->chip.ops = &pwm_lpss_ops;
 	lpwm->chip.base = -1;
-	lpwm->chip.npwm = 1;
+	lpwm->chip.npwm = info->npwm;
 
 	ret = pwmchip_add(&lpwm->chip);
 	if (ret) {
@@ -149,11 +160,6 @@ EXPORT_SYMBOL_GPL(pwm_lpss_probe);
 
 int pwm_lpss_remove(struct pwm_lpss_chip *lpwm)
 {
-	u32 ctrl;
-
-	ctrl = readl(lpwm->regs + PWM);
-	writel(ctrl & ~PWM_ENABLE, lpwm->regs + PWM);
-
 	return pwmchip_remove(&lpwm->chip);
 }
 EXPORT_SYMBOL_GPL(pwm_lpss_remove);
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index aa041bb1b67d..ef2419f47c57 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -20,6 +20,7 @@ struct pwm_lpss_chip;
 
 struct pwm_lpss_boardinfo {
 	unsigned long clk_rate;
+	size_t npwm;
 };
 
 extern const struct pwm_lpss_boardinfo pwm_lpss_byt_info;
-- 
2.6.1
