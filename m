From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/4] pwm: jz4740: Make disable operation compatible with TCU2 mode
Date: Sat,  6 Jan 2018 17:58:40 +0100
Message-ID: <20180106165843.3461-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Maarten ter Huurne <maarten@treewalker.org>
List-Id: linux-pwm@vger.kernel.org

From: Maarten ter Huurne <maarten@treewalker.org>

On the JZ4750 and later SoCs, channel 1 and 2 operate in a different
way (TCU2 mode) as the other channels. If a TCU2 mode counter is
stopped before its PWM functionality is disabled, the output is not
guaranteed to return to the initial level.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
---
 drivers/pwm/pwm-jz4740.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index a75ff3622450..2e41ba213f39 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -71,9 +71,15 @@ static void jz4740_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	uint32_t ctrl = jz4740_timer_get_ctrl(pwm->hwpwm);
 
+	/* Disable PWM output.
+	 * In TCU2 mode (channel 1/2 on JZ4750+), this must be done before the
+	 * counter is stopped, while in TCU1 mode the order does not matter.
+	 */
 	ctrl &= ~JZ_TIMER_CTRL_PWM_ENABLE;
-	jz4740_timer_disable(pwm->hwpwm);
 	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
+
+	/* Stop counter */
+	jz4740_timer_disable(pwm->hwpwm);
 }
 
 static int jz4740_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.11.0
