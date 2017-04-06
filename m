From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/2] pwm: lpss: Set enable-bit before waiting for update-bit to go low
Date: Thu,  6 Apr 2017 14:54:01 +0300
Message-ID: <20170406115401.29172-2-andriy.shevchenko@linux.intel.com>
References: <20170406115401.29172-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45475 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753543AbdDFLyF (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 6 Apr 2017 07:54:05 -0400
In-Reply-To: <20170406115401.29172-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Ilkka Koskinen <ilkka.koskinen@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

From: Hans de Goede <hdegoede@redhat.com>

At least on cherrytrail, the update bit will never go low when the
enabled bit is not set.

This causes the backlight on my cube iwork8 air tablet to never turn on
again after being turned off because in the pwm_lpss_apply enable path
pwm_lpss_update will fail causing an error exit and the enable-bit to
never get set. Any following pwm_lpss_apply calls will fail the
pwm_lpss_is_updating check.

Since the docs say that the update bit should be set before the
enable-bit, split pwm_lpss_update into setting the update-bit and
pwm_lpss_wait_for_update, and move the pwm_lpss_wait_for_update call
in the enable path to after setting the enable-bit.

Fixes: 10d56a4 ("pwm: lpss: Avoid reconfiguring while UPDATE bit...")
Cc: Ilkka Koskinen <ilkka.koskinen@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss-pci.c      |  1 +
 drivers/pwm/pwm-lpss-platform.c |  1 +
 drivers/pwm/pwm-lpss.c          | 19 +++++++++++++------
 drivers/pwm/pwm-lpss.h          |  1 +
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index 073dfb2337e0..c1527cb645be 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -36,6 +36,7 @@ static const struct pwm_lpss_boardinfo pwm_lpss_bxt_info = {
 	.clk_rate = 19200000,
 	.npwm = 4,
 	.base_unit_bits = 22,
+	.bypass = true,
 };
 
 /* Tangier */
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index b22b6fdadb9a..5d6ed1507d29 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -37,6 +37,7 @@ static const struct pwm_lpss_boardinfo pwm_lpss_bxt_info = {
 	.clk_rate = 19200000,
 	.npwm = 4,
 	.base_unit_bits = 22,
+	.bypass = true,
 };
 
 static int pwm_lpss_probe_platform(struct platform_device *pdev)
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 689d2c1cbead..8db0d40ccacd 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -57,7 +57,7 @@ static inline void pwm_lpss_write(const struct pwm_device *pwm, u32 value)
 	writel(value, lpwm->regs + pwm->hwpwm * PWM_SIZE + PWM);
 }
 
-static int pwm_lpss_update(struct pwm_device *pwm)
+static int pwm_lpss_wait_for_update(struct pwm_device *pwm)
 {
 	struct pwm_lpss_chip *lpwm = to_lpwm(pwm->chip);
 	const void __iomem *addr = lpwm->regs + pwm->hwpwm * PWM_SIZE + PWM;
@@ -65,8 +65,6 @@ static int pwm_lpss_update(struct pwm_device *pwm)
 	u32 val;
 	int err;
 
-	pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_SW_UPDATE);
-
 	/*
 	 * PWM Configuration register has SW_UPDATE bit that is set when a new
 	 * configuration is written to the register. The bit is automatically
@@ -122,6 +120,12 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
 	pwm_lpss_write(pwm, ctrl);
 }
 
+static inline void pwm_lpss_cond_enable(struct pwm_device *pwm, bool cond)
+{
+	if (cond)
+		pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
+}
+
 static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			  struct pwm_state *state)
 {
@@ -137,18 +141,21 @@ static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 				return ret;
 			}
 			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
-			ret = pwm_lpss_update(pwm);
+			pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_SW_UPDATE);
+			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == false);
+			ret = pwm_lpss_wait_for_update(pwm);
 			if (ret) {
 				pm_runtime_put(chip->dev);
 				return ret;
 			}
-			pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
+			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == true);
 		} else {
 			ret = pwm_lpss_is_updating(pwm);
 			if (ret)
 				return ret;
 			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
-			return pwm_lpss_update(pwm);
+			pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_SW_UPDATE);
+			return pwm_lpss_wait_for_update(pwm);
 		}
 	} else if (pwm_is_enabled(pwm)) {
 		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index c94cd7c2695d..98306bb02cfe 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -22,6 +22,7 @@ struct pwm_lpss_boardinfo {
 	unsigned long clk_rate;
 	unsigned int npwm;
 	unsigned long base_unit_bits;
+	bool bypass;
 };
 
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
-- 
2.11.0
