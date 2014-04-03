From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH v2] pwm: pxa: Use of_match_ptr()
Date: Thu, 03 Apr 2014 12:44:54 +0900
Message-ID: <000d01cf4eef$13881770$3a984650$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:22630 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758860AbaDCDo5 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Apr 2014 23:44:57 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N3F00I6CRQVYP50@mailout4.samsung.com> for
 linux-pwm@vger.kernel.org; Thu, 03 Apr 2014 12:44:55 +0900 (KST)
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Thierry Reding' <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Eric Miao' <eric.y.miao@gmail.com>

Use of_match_ptr(), because of_match_ptr() returns NULL pointer
when CONFIG_OF is disabled.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
Changes since v1:
- Add of_match_ptr() to of_match_device() in order to fix compile error
  when CONFIG_OF=n.

 drivers/pwm/pwm-pxa.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index cd356d8..024e6a4 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -140,14 +140,13 @@ static const struct of_device_id pwm_of_match[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pwm_of_match);
-#else
-#define pwm_of_match NULL
 #endif
 
 static const struct platform_device_id *pxa_pwm_get_id_dt(struct device *dev)
 {
-	const struct of_device_id *id = of_match_device(pwm_of_match, dev);
+	const struct of_device_id *id;
 
+	id = of_match_device(of_match_ptr(pwm_of_match), dev);
 	return id ? id->data : NULL;
 }
 
@@ -228,7 +227,7 @@ static struct platform_driver pwm_driver = {
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


