Return-Path: <festevam@gmail.com>
Return-Path: <festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] pwm: pwm-mxs: Check the return value from stmp_reset_block()
Date: Tue,  9 Jul 2013 23:25:37 -0300
Message-Id: <1373423137-31612-1-git-send-email-festevam@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com
Cc: shawn.guo@linaro.org, linux-pwm@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

stmp_reset_block() may fail, so let's check its return value and propagate it in
the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/pwm/pwm-mxs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index 2c77b81..c2c5a4f 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -161,9 +161,15 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mxs);
 
-	stmp_reset_block(mxs->base);
+	ret = stmp_reset_block(mxs->base);
+	if (ret)
+		goto pwm_remove;
 
 	return 0;
+
+pwm_remove:
+	pwmchip_remove(&mxs->chip);
+	return ret;
 }
 
 static int mxs_pwm_remove(struct platform_device *pdev)
-- 
1.8.1.2
