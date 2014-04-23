From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH RESEND 7/9] pwm: pwm-tiecap: Remove unnecessary OOM messages
Date: Wed, 23 Apr 2014 18:41:27 +0900
Message-ID: <001101cf5ed8$32fe30a0$98fa91e0$%han@samsung.com>
References: <000a01cf5ed7$bd178ad0$3746a070$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:45035 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755588AbaDWJl3 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Apr 2014 05:41:29 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N4H00BFT9L5JR20@mailout4.samsung.com> for
 linux-pwm@vger.kernel.org; Wed, 23 Apr 2014 18:41:29 +0900 (KST)
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
 drivers/pwm/pwm-tiecap.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 032092c..74efbe7 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -209,10 +209,8 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 	u16 status;
 
 	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc) {
-		dev_err(&pdev->dev, "failed to allocate memory\n");
+	if (!pc)
 		return -ENOMEM;
-	}
 
 	clk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(clk)) {
-- 
1.7.10.4


