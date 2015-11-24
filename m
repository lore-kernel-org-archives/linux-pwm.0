From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RESEND] pwm: brcmstb: Don't set can_sleep flag
Date: Tue, 24 Nov 2015 14:43:12 +0800
Message-ID: <1448347392.17722.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35633 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbbKXGnR (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Nov 2015 01:43:17 -0500
Received: by pacej9 with SMTP id ej9so12016232pac.2
        for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2015 22:43:16 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-pwm@vger.kernel.org

The .can_sleep flag is used for some PWM controllers that can't be used
in atomic context. Not such case for this driver, so don't set the
can_sleep flag.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Brian Norris <computersforpeace@gmail.com>
---
This patch was sent on http://www.spinics.net/lists/linux-pwm/msg03506.html

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
