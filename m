From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH RESEND 9/9] pwm: vt8500: Remove unnecessary OOM messages
Date: Wed, 23 Apr 2014 18:42:10 +0900
Message-ID: <001301cf5ed8$4c29fa00$e47dee00$%han@samsung.com>
References: <000a01cf5ed7$bd178ad0$3746a070$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:34364 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbaDWJmT (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Apr 2014 05:42:19 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N4H007FZ9MGWF00@mailout3.samsung.com> for
 linux-pwm@vger.kernel.org; Wed, 23 Apr 2014 18:42:17 +0900 (KST)
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
 drivers/pwm/pwm-vt8500.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 323125a..652e6b5 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -211,10 +211,8 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 	}
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL) {
-		dev_err(&pdev->dev, "failed to allocate memory\n");
+	if (chip == NULL)
 		return -ENOMEM;
-	}
 
 	chip->chip.dev = &pdev->dev;
 	chip->chip.ops = &vt8500_pwm_ops;
-- 
1.7.10.4


