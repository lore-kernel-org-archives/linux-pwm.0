Return-Path: <sangjung.woo@samsung.com>
From: Sangjung Woo <sangjung.woo@samsung.com>
Subject: [PATCH] pwm: samsung: memory leak bugfix in pwm_samsung_free
Date: Tue, 05 Nov 2013 12:02:40 +0900
Message-id: <1383620560-3567-1-git-send-email-sangjung.woo@samsung.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, akpm@linux-foundation.org
Cc: Tomasz Figa <t.figa@samsung.com>, linux-kernel@vger.kernel.org, Jonghwa Lee <jonghwa3.lee@samsung.com>, Sangjung Woo <sangjung.woo@samsung.com>

There is certainly a kind of memory leak since allocated data (i.e.
chip_data) is set NULL before freeing it by calling devm_kfree(). This
patch fixes the memory leak bug by modifying its call order.

Signed-off-by: Sangjung Woo <sangjung.woo@samsung.com>
Reviewed-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
---
 drivers/pwm/pwm-samsung.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index fcc8b9a..07b2d9d 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -224,8 +224,8 @@ static int pwm_samsung_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 static void pwm_samsung_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	pwm_set_chip_data(pwm, NULL);
 	devm_kfree(chip->dev, pwm_get_chip_data(pwm));
+	pwm_set_chip_data(pwm, NULL);
 }
 
 static int pwm_samsung_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-- 
1.7.9.5
