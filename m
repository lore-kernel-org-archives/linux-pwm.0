From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/9] pwm: ab8500: Remove unnecessary OOM messages
Date: Wed, 26 Feb 2014 10:02:23 +0900
Message-ID: <000901cf328e$68b79400$3a26bc00$%han@samsung.com>
References: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:36659 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaBZBCZ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2014 20:02:25 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1K00452W80Z0A0@mailout3.samsung.com> for
 linux-pwm@vger.kernel.org; Wed, 26 Feb 2014 10:02:24 +0900 (KST)
In-reply-to: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Thierry Reding' <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Arun Murthy' <arun.murthy@stericsson.com>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pwm/pwm-ab8500.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index 1d07a6f..9d53e8e 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -101,10 +101,8 @@ static int ab8500_pwm_probe(struct platform_device *pdev)
 	 * device which is required for ab8500 read and write
 	 */
 	ab8500 = devm_kzalloc(&pdev->dev, sizeof(*ab8500), GFP_KERNEL);
-	if (ab8500 == NULL) {
-		dev_err(&pdev->dev, "failed to allocate memory\n");
+	if (ab8500 == NULL)
 		return -ENOMEM;
-	}
 
 	ab8500->chip.dev = &pdev->dev;
 	ab8500->chip.ops = &ab8500_pwm_ops;
-- 
1.7.10.4


