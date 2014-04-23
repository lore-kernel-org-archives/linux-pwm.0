From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH RESEND 5/9] pwm: spear: Remove unnecessary OOM messages
Date: Wed, 23 Apr 2014 18:40:49 +0900
Message-ID: <000f01cf5ed8$1c74d780$555e8680$%han@samsung.com>
References: <000a01cf5ed7$bd178ad0$3746a070$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:8964 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbaDWJkz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Apr 2014 05:40:55 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N4H00HZ69K6FC90@mailout1.samsung.com> for
 linux-pwm@vger.kernel.org; Wed, 23 Apr 2014 18:40:54 +0900 (KST)
In-reply-to: <000a01cf5ed7$bd178ad0$3746a070$%han@samsung.com>
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Thierry Reding' <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pwm/pwm-spear.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-spear.c b/drivers/pwm/pwm-spear.c
index cb2d4f0..2daf3a1 100644
--- a/drivers/pwm/pwm-spear.c
+++ b/drivers/pwm/pwm-spear.c
@@ -179,10 +179,8 @@ static int spear_pwm_probe(struct platform_device *pdev)
 	u32 val;
 
 	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc) {
-		dev_err(&pdev->dev, "failed to allocate memory\n");
+	if (!pc)
 		return -ENOMEM;
-	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pc->mmio_base = devm_ioremap_resource(&pdev->dev, r);
-- 
1.7.10.4


