From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/3] pwm: pwm-ep93xx: split module author names
Date: Thu, 19 Dec 2013 13:32:45 +0900
Message-ID: <002201cefc73$5d5f7a60$181e6f20$%han@samsung.com>
References: <002101cefc73$2d22ff70$8768fe50$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:17198 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab3LSEdF (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Dec 2013 23:33:05 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MY100H31DYMVJ20@mailout3.samsung.com> for
 linux-pwm@vger.kernel.org; Thu, 19 Dec 2013 13:32:46 +0900 (KST)
In-reply-to: <002101cefc73$2d22ff70$8768fe50$%han@samsung.com>
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Thierry Reding' <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'H Hartley Sweeten' <hsweeten@visionengravers.com>

Split module author names in order to fix the following
checkpatch warning.

  WARNING: quoted string split across lines

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pwm/pwm-ep93xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 33aa446..e593e9c 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -224,7 +224,7 @@ static struct platform_driver ep93xx_pwm_driver = {
 module_platform_driver(ep93xx_pwm_driver);
 
 MODULE_DESCRIPTION("Cirrus Logic EP93xx PWM driver");
-MODULE_AUTHOR("Matthieu Crapet <mcrapet@gmail.com>, "
-	      "H Hartley Sweeten <hsweeten@visionengravers.com>");
+MODULE_AUTHOR("Matthieu Crapet <mcrapet@gmail.com>");
+MODULE_AUTHOR("H Hartley Sweeten <hsweeten@visionengravers.com>");
 MODULE_ALIAS("platform:ep93xx-pwm");
 MODULE_LICENSE("GPL");
-- 
1.7.10.4


