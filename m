From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] pwm: pxa: Use of_match_ptr()
Date: Wed, 26 Feb 2014 10:17:13 +0900
Message-ID: <002c01cf3290$7ad36ef0$707a4cd0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:32884 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbaBZBRO (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2014 20:17:14 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1K00CUXWWQA9D0@mailout4.samsung.com> for
 linux-pwm@vger.kernel.org; Wed, 26 Feb 2014 10:17:14 +0900 (KST)
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Thierry Reding' <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Eric Miao' <eric.y.miao@gmail.com>

Use of_match_ptr(), because of_match_ptr() returns NULL pointer
when CONFIG_OF is disabled.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pwm/pwm-pxa.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 8d99573..7eb2c18 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -140,8 +140,6 @@ static struct of_device_id pwm_of_match[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pwm_of_match);
-#else
-#define pwm_of_match NULL
 #endif
 
 static const struct platform_device_id *pxa_pwm_get_id_dt(struct device *dev)
@@ -228,7 +226,7 @@ static struct platform_driver pwm_driver = {
 	.driver		= {
 		.name	= "pxa25x-pwm",
 		.owner	= THIS_MODULE,
-		.of_match_table = pwm_of_match,
+		.of_match_table = of_match_ptr(pwm_of_match),
 	},
 	.probe		= pwm_probe,
 	.remove		= pwm_remove,
-- 
1.7.10.4


