From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 4/9] pwm: renesas-tpu: Remove unnecessary OOM messages
Date: Wed, 26 Feb 2014 10:08:10 +0900
Message-ID: <000c01cf328f$376b8860$a6429920$%han@samsung.com>
References: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:38056 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbaBZBIM (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2014 20:08:12 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1K00M0PWHN5IC0@mailout3.samsung.com> for
 linux-pwm@vger.kernel.org; Wed, 26 Feb 2014 10:08:11 +0900 (KST)
In-reply-to: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Thierry Reding' <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Laurent Pinchart' <laurent.pinchart+renesas@ideasonboard.com>, 'Simon Horman' <horms@verge.net.au>

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


