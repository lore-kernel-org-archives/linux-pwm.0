From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH RESEND 2/9] pwm: i.MX: Remove unnecessary OOM messages
Date: Wed, 23 Apr 2014 18:39:49 +0900
Message-ID: <000c01cf5ed7$f89c34c0$e9d49e40$%han@samsung.com>
References: <000a01cf5ed7$bd178ad0$3746a070$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:8802 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbaDWJjv (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Apr 2014 05:39:51 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N4H00HW49IEFC90@mailout1.samsung.com> for
 linux-pwm@vger.kernel.org; Wed, 23 Apr 2014 18:39:50 +0900 (KST)
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


