From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH] pwm: bcm7038: fix check of error code returned by devm_ioremap_resource()
Date: Sun,  6 Mar 2016 03:21:46 +0200
Message-ID: <1457227306-3142-1-git-send-email-vz@mleia.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:41531 "EHLO mail.mleia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbcCFBVu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Sat, 5 Mar 2016 20:21:50 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com

The change fixes potential oops while accessing iomem on invalid
address, if devm_ioremap_resource() fails due to some reason.

The devm_ioremap_resource() function returns ERR_PTR() and never
returns NULL, which makes useless a following check for NULL.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Fixes: 3a9f5957020f ("pwm: Add Broadcom BCM7038 PWM controller support")
---
 drivers/pwm/pwm-brcmstb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index 423ce08..5d5adee 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -274,8 +274,8 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	p->base = devm_ioremap_resource(&pdev->dev, res);
-	if (!p->base) {
-		ret = -ENOMEM;
+	if (IS_ERR(p->base)) {
+		ret = PTR_ERR(p->base);
 		goto out_clk;
 	}
 
-- 
2.1.4
