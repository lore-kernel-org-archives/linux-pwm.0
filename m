From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] pwm: brcmstb: Don't set can_sleep flag
Date: Tue, 03 Nov 2015 18:08:40 +0800
Message-ID: <1446545320.6627.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34114 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752405AbbKCKIp (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Nov 2015 05:08:45 -0500
Received: by padhx2 with SMTP id hx2so6797595pad.1
        for <linux-pwm@vger.kernel.org>; Tue, 03 Nov 2015 02:08:44 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-pwm@vger.kernel.org

The .can_sleep flag is used for some PWM controllers that can't be used
in atomic context. Not such case for this driver, so don't set the
can_sleep flag.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/pwm/pwm-brcmstb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index 423ce08..f58039b 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -270,7 +270,6 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
 	p->chip.ops = &brcmstb_pwm_ops;
 	p->chip.base = -1;
 	p->chip.npwm = 2;
-	p->chip.can_sleep = true;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	p->base = devm_ioremap_resource(&pdev->dev, res);
-- 
2.1.4
