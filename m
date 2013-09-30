Return-Path: <sachin.kamat@linaro.org>
Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/3] pwm: lpc32xx: Remove redundant of_match_ptr
Date: Mon, 30 Sep 2013 08:56:40 +0530
Message-Id: <1380511601-20977-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380511601-20977-1-git-send-email-sachin.kamat@linaro.org>
References: <1380511601-20977-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com, sachin.kamat@linaro.org, Alexandre Pereira da Silva <aletes.xgr@gmail.com>

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
---
 drivers/pwm/pwm-lpc32xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index efac99e0..9dc0f9d 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -169,7 +169,7 @@ static struct platform_driver lpc32xx_pwm_driver = {
 	.driver = {
 		.name = "lpc32xx-pwm",
 		.owner = THIS_MODULE,
-		.of_match_table = of_match_ptr(lpc32xx_pwm_dt_ids),
+		.of_match_table = lpc32xx_pwm_dt_ids,
 	},
 	.probe = lpc32xx_pwm_probe,
 	.remove = lpc32xx_pwm_remove,
-- 
1.7.9.5
