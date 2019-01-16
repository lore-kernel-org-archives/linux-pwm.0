From: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: [PATCH] drivers: pwm: pwm-bcm-kona: update macros to remove braces around numbers
Date: Thu, 17 Jan 2019 01:11:22 +0530
Message-ID: <1547667682-5095-1-git-send-email-sheetal.tigadoli@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
List-Id: linux-pwm@vger.kernel.org

update macros to remove braces around numbers

Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
---
 drivers/pwm/pwm-bcm-kona.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 09a95ae..81da91d 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -45,25 +45,25 @@
  *    high or low depending on its state at that exact instant.
  */
 
-#define PWM_CONTROL_OFFSET			(0x00000000)
+#define PWM_CONTROL_OFFSET			0x00000000
 #define PWM_CONTROL_SMOOTH_SHIFT(chan)		(24 + (chan))
 #define PWM_CONTROL_TYPE_SHIFT(chan)		(16 + (chan))
 #define PWM_CONTROL_POLARITY_SHIFT(chan)	(8 + (chan))
 #define PWM_CONTROL_TRIGGER_SHIFT(chan)		(chan)
 
-#define PRESCALE_OFFSET				(0x00000004)
+#define PRESCALE_OFFSET				0x00000004
 #define PRESCALE_SHIFT(chan)			((chan) << 2)
 #define PRESCALE_MASK(chan)			(0x7 << PRESCALE_SHIFT(chan))
-#define PRESCALE_MIN				(0x00000000)
-#define PRESCALE_MAX				(0x00000007)
+#define PRESCALE_MIN				0x00000000
+#define PRESCALE_MAX				0x00000007
 
 #define PERIOD_COUNT_OFFSET(chan)		(0x00000008 + ((chan) << 3))
-#define PERIOD_COUNT_MIN			(0x00000002)
-#define PERIOD_COUNT_MAX			(0x00ffffff)
+#define PERIOD_COUNT_MIN			0x00000002
+#define PERIOD_COUNT_MAX			0x00ffffff
 
 #define DUTY_CYCLE_HIGH_OFFSET(chan)		(0x0000000c + ((chan) << 3))
-#define DUTY_CYCLE_HIGH_MIN			(0x00000000)
-#define DUTY_CYCLE_HIGH_MAX			(0x00ffffff)
+#define DUTY_CYCLE_HIGH_MIN			0x00000000
+#define DUTY_CYCLE_HIGH_MAX			0x00ffffff
 
 struct kona_pwmc {
 	struct pwm_chip chip;
-- 
1.9.1
