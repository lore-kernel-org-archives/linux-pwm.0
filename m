Return-Path: <sachin.kamat@linaro.org>
Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] Documentation/pwm: Fix trivial typos
Date: Thu, 24 Oct 2013 14:13:47 +0530
Message-Id: <1382604227-3551-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-pwm@vger.kernel.org
Cc: linux-doc@vger.kernel.org, thierry.reding@gmail.com, rob@landley.net, trivial@kernel.org, sachin.kamat@linaro.org

Fixes some trivial typos to improve readability.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 Documentation/pwm.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 1039b68..93cb979 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -39,7 +39,7 @@ New users should use the pwm_get() function and pass to it the consumer
 device or a consumer name. pwm_put() is used to free the PWM device. Managed
 variants of these functions, devm_pwm_get() and devm_pwm_put(), also exist.
 
-After being requested a PWM has to be configured using:
+After being requested, a PWM has to be configured using:
 
 int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns);
 
@@ -94,7 +94,7 @@ for new drivers to use the generic PWM framework.
 A new PWM controller/chip can be added using pwmchip_add() and removed
 again with pwmchip_remove(). pwmchip_add() takes a filled in struct
 pwm_chip as argument which provides a description of the PWM chip, the
-number of PWM devices provider by the chip and the chip-specific
+number of PWM devices provided by the chip and the chip-specific
 implementation of the supported PWM operations to the framework.
 
 Locking
-- 
1.7.9.5
