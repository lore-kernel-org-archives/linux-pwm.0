From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] pwm: pwm-tipwmss: remove unnecessary OOM messages
Date: Wed, 18 Jun 2014 14:50:08 +0900
Message-ID: <000001cf8ab9$294b0940$7be11bc0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:32090 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756586AbaFRFuK (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Jun 2014 01:50:10 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N7C009KPO7KCC20@mailout1.samsung.com> for
 linux-pwm@vger.kernel.org; Wed, 18 Jun 2014 14:50:08 +0900 (KST)
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Thierry Reding' <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Philip Avinash' <avinashphilip@ti.com>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message. The following
checkpatch warning is also removed.

  WARNING: Possible unnecessary 'out of memory' message

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pwm/pwm-tipwmss.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-tipwmss.c b/drivers/pwm/pwm-tipwmss.c
index 3b119bc..67481dc 100644
--- a/drivers/pwm/pwm-tipwmss.c
+++ b/drivers/pwm/pwm-tipwmss.c
@@ -62,10 +62,8 @@ static int pwmss_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
-	if (!info) {
-		dev_err(&pdev->dev, "failed to allocate memory\n");
+	if (!info)
 		return -ENOMEM;
-	}
 
 	mutex_init(&info->pwmss_lock);
 
-- 
1.7.10.4


