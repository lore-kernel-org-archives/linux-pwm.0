From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] pwm: samsung: Use SIMPLE_DEV_PM_OPS macro
Date: Wed, 26 Feb 2014 10:17:53 +0900
Message-ID: <002d01cf3290$92feb840$b8fc28c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:40663 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbaBZBRz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2014 20:17:55 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1K00LEIWXUMZD0@mailout3.samsung.com> for
 linux-pwm@vger.kernel.org; Wed, 26 Feb 2014 10:17:54 +0900 (KST)
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Thierry Reding' <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Use SIMPLE_DEV_PM_OPS macro in order to make the code simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pwm/pwm-samsung.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index b59639e..d66529a 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -598,9 +598,8 @@ static int pwm_samsung_resume(struct device *dev)
 }
 #endif
 
-static const struct dev_pm_ops pwm_samsung_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pwm_samsung_suspend, pwm_samsung_resume)
-};
+static SIMPLE_DEV_PM_OPS(pwm_samsung_pm_ops, pwm_samsung_suspend,
+			 pwm_samsung_resume);
 
 static struct platform_driver pwm_samsung_driver = {
 	.driver		= {
-- 
1.7.10.4


