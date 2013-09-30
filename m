Return-Path: <sachin.kamat@linaro.org>
Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/3] pwm: mxs: Remove redundant of_match_ptr
Date: Mon, 30 Sep 2013 08:56:39 +0530
Message-Id: <1380511601-20977-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com, sachin.kamat@linaro.org, Shawn Guo <shawn.guo@linaro.org>

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/pwm/pwm-mxs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index c2c5a4f..9475bc7 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -189,7 +189,7 @@ static struct platform_driver mxs_pwm_driver = {
 	.driver = {
 		.name = "mxs-pwm",
 		.owner = THIS_MODULE,
-		.of_match_table = of_match_ptr(mxs_pwm_dt_ids),
+		.of_match_table = mxs_pwm_dt_ids,
 	},
 	.probe = mxs_pwm_probe,
 	.remove = mxs_pwm_remove,
-- 
1.7.9.5
