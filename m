From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH RESEND 4/9] pwm: renesas-tpu: Remove unnecessary OOM messages
Date: Wed, 23 Apr 2014 18:40:29 +0900
Message-ID: <000e01cf5ed8$104fdd10$30ef9730$%han@samsung.com>
References: <000a01cf5ed7$bd178ad0$3746a070$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:33945 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbaDWJka (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Apr 2014 05:40:30 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N4H007S59JHDF00@mailout3.samsung.com> for
 linux-pwm@vger.kernel.org; Wed, 23 Apr 2014 18:40:29 +0900 (KST)
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
 drivers/pwm/pwm-renesas-tpu.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index aff6ba9..cc13ff4 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -405,10 +405,8 @@ static int tpu_probe(struct platform_device *pdev)
 	int ret;
 
 	tpu = devm_kzalloc(&pdev->dev, sizeof(*tpu), GFP_KERNEL);
-	if (tpu == NULL) {
-		dev_err(&pdev->dev, "failed to allocate driver data\n");
+	if (tpu == NULL)
 		return -ENOMEM;
-	}
 
 	spin_lock_init(&tpu->lock);
 	tpu->pdev = pdev;
-- 
1.7.10.4


