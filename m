From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/9] pwm: i.MX: Remove unnecessary OOM messages
Date: Wed, 26 Feb 2014 10:04:39 +0900
Message-ID: <000a01cf328e$b95f0230$2c1d0690$%han@samsung.com>
References: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:37254 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbaBZBEk (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2014 20:04:40 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1K004F0WBRZ0A0@mailout3.samsung.com> for
 linux-pwm@vger.kernel.org; Wed, 26 Feb 2014 10:04:39 +0900 (KST)
In-reply-to: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Thierry Reding' <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Sascha Hauer' <s.hauer@pengutronix.de>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pwm/pwm-imx.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index cc47733..d797c7b 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -241,10 +241,8 @@ static int imx_pwm_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
-	if (imx == NULL) {
-		dev_err(&pdev->dev, "failed to allocate memory\n");
+	if (imx == NULL)
 		return -ENOMEM;
-	}
 
 	imx->clk_per = devm_clk_get(&pdev->dev, "per");
 	if (IS_ERR(imx->clk_per)) {
-- 
1.7.10.4


