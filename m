From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 6/6] pwm: update comment on struct pwm_ops::apply
Date: Fri,  4 Oct 2019 15:32:07 +0200
Message-ID: <20191004133207.6663-7-linux@rasmusvillemoes.dk>
References: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Commit 71523d1812ac (pwm: Ensure pwm_apply_state() doesn't modify the
state argument) updated the kernel-doc for pwm_apply_state(), but not
for the ->apply callback in the pwm_ops struct.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/pwm.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index b2c9c460947d..0ef808d925bb 100644
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
+ * @apply: atomically apply a new PWM config
  * @get_state: get the current PWM state. This function is only
  *	       called once per PWM device when the PWM chip is
  *	       registered.
-- 
2.20.1
