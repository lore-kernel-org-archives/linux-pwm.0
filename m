Return-Path: <sachin.kamat@linaro.org>
Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/4] pwm: twl-led: Include linux/of.h header
Date: Fri, 27 Sep 2013 16:53:25 +0530
Message-Id: <1380281006-3614-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380281006-3614-1-git-send-email-sachin.kamat@linaro.org>
References: <1380281006-3614-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com, sachin.kamat@linaro.org

'of_match_ptr' is defined in linux/of.h. Include it explicitly.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/pwm/pwm-twl-led.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-twl-led.c b/drivers/pwm/pwm-twl-led.c
index 29d1bba..b964470 100644
--- a/drivers/pwm/pwm-twl-led.c
+++ b/drivers/pwm/pwm-twl-led.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/i2c/twl.h>
-- 
1.7.9.5
