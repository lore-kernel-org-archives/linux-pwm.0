From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] pwm: Fix possible ZERO_SIZE_PTR pointer dereferencing error.
Date: Mon, 18 Aug 2014 17:08:44 +0800
Message-ID: <1408352924-19122-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bl2lp0208.outbound.protection.outlook.com ([207.46.163.208]:23123
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751722AbaHRJNP (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 18 Aug 2014 05:13:15 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Cc: Xiubo Li <Li.Xiubo@freescale.com>

Since we cannot make sure the 'chip->npwm' will always be none zero here,
and then if either equal to zero, the kzalloc() will return ZERO_SIZE_PTR,
which equals to ((void *)16).

So this patch fix this with just doing the zero check before calling kzalloc().

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 4b66bf0..786d0f1 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -236,7 +236,7 @@ int pwmchip_add(struct pwm_chip *chip)
 	int ret;
 
 	if (!chip || !chip->dev || !chip->ops || !chip->ops->config ||
-	    !chip->ops->enable || !chip->ops->disable)
+	    !chip->ops->enable || !chip->ops->disable || !chip->npwm)
 		return -EINVAL;
 
 	mutex_lock(&pwm_lock);
-- 
1.8.5

