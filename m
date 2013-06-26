Return-Path: <robin@protonic.nl>
From: Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH v2] pwm: pwm-mxs: Wait for configuration to apply before disabling PWM.
Date: Wed, 26 Jun 2013 12:26:13 +0200
Message-Id: <1372242373-17962-1-git-send-email-robin@protonic.nl>
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.guo@linaro.org, robin@protonic.nl

We have to be sure that the last configuration has been applied. In most
cases drivers will have set the duty-cycle to 0%. To prevent the PWM
from locking at a 100% duty-cycle, we delay disabling the PWM for a
whole period to make sure any new configuration has been latched.

Signed-off-by: Robin van der Gracht <robin@protonic.nl>
---
 drivers/pwm/pwm-mxs.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index a53d309..7e1fa0a 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -113,6 +114,12 @@ static int mxs_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 static void mxs_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct mxs_pwm_chip *mxs = to_mxs_pwm_chip(chip);
+	unsigned int period;
+
+	/* Ensure latest configuration applied. */
+	period = pwm_get_period(pwm);
+	period = DIV_ROUND_UP(period, NSEC_PER_USEC);
+	usleep_range(period, period + 1000);
 
 	writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + CLR);
 
-- 
1.7.9.5
