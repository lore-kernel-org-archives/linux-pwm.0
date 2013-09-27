Return-Path: <sachin.kamat@linaro.org>
Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/4] pwm: samsung: Include linux/of.h header
Date: Fri, 27 Sep 2013 16:53:24 +0530
Message-Id: <1380281006-3614-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380281006-3614-1-git-send-email-sachin.kamat@linaro.org>
References: <1380281006-3614-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com, sachin.kamat@linaro.org

'of_match_ptr' is defined in linux/of.h. Include it explicitly.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/pwm/pwm-samsung.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index fcc8b9a..57eb8cb 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
-- 
1.7.9.5
