From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] pwm: tiehrpwm: use dev_err() instead of pr_err()
Date: Thu, 19 Dec 2013 14:12:05 +0900
Message-ID: <000101cefc78$dbab1320$93013960$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:25102 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab3LSFMG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Dec 2013 00:12:06 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MY100HSXFS5VJ50@mailout3.samsung.com> for
 linux-pwm@vger.kernel.org; Thu, 19 Dec 2013 14:12:05 +0900 (KST)
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Thierry Reding' <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Philip Avinash' <avinashphilip@ti.com>

Use dev_err() instead of pr_err() to provide a better message
to userspace.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pwm/pwm-tiehrpwm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index a4d8f51..aee4471 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -360,8 +360,8 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	/* Enable TBCLK before enabling PWM device */
 	ret = clk_enable(pc->tbclk);
 	if (ret) {
-		pr_err("Failed to enable TBCLK for %s\n",
-				dev_name(pc->chip.dev));
+		dev_err(chip->dev, "Failed to enable TBCLK for %s\n",
+			dev_name(pc->chip.dev));
 		return ret;
 	}
 
-- 
1.7.10.4


