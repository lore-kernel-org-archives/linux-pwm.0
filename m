Return-Path: <sachin.kamat@linaro.org>
Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/3] pwm: imx: Remove redundant of_match_ptr
Date: Mon, 30 Sep 2013 08:56:41 +0530
Message-Id: <1380511601-20977-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380511601-20977-1-git-send-email-sachin.kamat@linaro.org>
References: <1380511601-20977-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com, sachin.kamat@linaro.org, Sascha Hauer <s.hauer@pengutronix.de>

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/pwm/pwm-imx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index aa6e5c6..cc47733 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -297,7 +297,7 @@ static struct platform_driver imx_pwm_driver = {
 	.driver		= {
 		.name	= "imx-pwm",
 		.owner = THIS_MODULE,
-		.of_match_table = of_match_ptr(imx_pwm_dt_ids),
+		.of_match_table = imx_pwm_dt_ids,
 	},
 	.probe		= imx_pwm_probe,
 	.remove		= imx_pwm_remove,
-- 
1.7.9.5
