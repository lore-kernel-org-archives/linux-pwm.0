From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH] pwm: Fix kerneldoc for apply operation
Date: Sat,  5 Oct 2019 21:43:26 -0700
Message-ID: <20191006044326.12043-1-bjorn.andersson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

As the @state passed to apply() is now const the comment in the
kerneldoc about drivers being expected to adjust the parameters is no
longer valid. Update it to reflect the API change.

Fixes: 71523d1812ac ("pwm: Ensure pwm_apply_state() doesn't modify the state argument")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 include/linux/pwm.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index b2c9c460947d..8bc86f645d0d 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -243,10 +243,7 @@ pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int duty_cycle,
  * @request: optional hook for requesting a PWM
  * @free: optional hook for freeing a PWM
  * @capture: capture and report PWM signal
- * @apply: atomically apply a new PWM config. The state argument
- *	   should be adjusted with the real hardware config (if the
- *	   approximate the period or duty_cycle value, state should
- *	   reflect it)
+ * @apply: atomically apply a new PWM config.
  * @get_state: get the current PWM state. This function is only
  *	       called once per PWM device when the PWM chip is
  *	       registered.
-- 
2.18.0
