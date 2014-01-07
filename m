From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v2] pwm: core: Use devm_kcalloc instead of kzalloc
Date: Tue, 7 Jan 2014 14:45:47 +0800
Message-ID: <1389077147-15487-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from [207.46.163.27] ([207.46.163.27]:43910 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754732AbaAGHoK (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jan 2014 02:44:10 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: joe@perches.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>

Use devm_kcalloc instead of kzalloc to free automatically and make
the cleanup paths simpler and the code slightly shorter.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---

Changed in v2:
- Use devm_kcalloc instead of devm_kzalloc.

Changed in v1:
- Use devm_kzalloc instead of kzalloc.




 drivers/pwm/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 2ca9504..75220e8 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -80,7 +80,6 @@ static void free_pwms(struct pwm_chip *chip)
 
 	bitmap_clear(allocated_pwms, chip->base, chip->npwm);
 
-	kfree(chip->pwms);
 	chip->pwms = NULL;
 }
 
@@ -245,7 +244,8 @@ int pwmchip_add(struct pwm_chip *chip)
 	if (ret < 0)
 		goto out;
 
-	chip->pwms = kzalloc(chip->npwm * sizeof(*pwm), GFP_KERNEL);
+	chip->pwms = devm_kcalloc(chip->dev, chip->npwm,
+				  sizeof(*pwm), GFP_KERNEL);
 	if (!chip->pwms) {
 		ret = -ENOMEM;
 		goto out;
-- 
1.8.4


