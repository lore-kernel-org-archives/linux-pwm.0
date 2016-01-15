From: Xiubo Li <lixiubo@cmss.chinamobile.com>
Subject: [PATCH] pwm: replace kzalloc with kcalloc
Date: Fri, 15 Jan 2016 12:45:58 +0800
Message-ID: <1452833158-28029-1-git-send-email-lixiubo@cmss.chinamobile.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:4111 "EHLO
	cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbcAOEyQ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Jan 2016 23:54:16 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, Xiubo Li <lixiubo@cmss.chinamobile.com>

Replace kzalloc with specialized function kcalloc when the size is
a multiplication of : number * sizeof

Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index d24ca5f..1714149 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -254,7 +254,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 	if (ret < 0)
 		goto out;
 
-	chip->pwms = kzalloc(chip->npwm * sizeof(*pwm), GFP_KERNEL);
+	chip->pwms = kcalloc(chip->npwm, sizeof(*pwm), GFP_KERNEL);
 	if (!chip->pwms) {
 		ret = -ENOMEM;
 		goto out;
-- 
1.8.3.1
