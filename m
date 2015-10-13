From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 1/4] pwm: lpc32xx: correct number of PWM channels from 2 to 1
Date: Tue, 13 Oct 2015 03:20:50 +0300
Message-ID: <1444695653-23491-2-git-send-email-vz@mleia.com>
References: <1444695653-23491-1-git-send-email-vz@mleia.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from li271-223.members.linode.com ([178.79.152.223]:39543 "EHLO
	mail.mleia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800AbbJMAVC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 12 Oct 2015 20:21:02 -0400
In-Reply-To: <1444695653-23491-1-git-send-email-vz@mleia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Cc: linux-pwm@vger.kernel.org

LPC32xx SoC has two independent PWM controllers, they have different
clock parents, clock gates and even slightly different controls, and
each of these two PWM controllers has one output channel. Due to
almost similar controls arranged in a row it is incorrectly set that
there is one PWM controller with two channels, fix this problem, which
at the moment prevents separate configuration of different clock
parents and gates for both PWM controllers.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/pwm/pwm-lpc32xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index 9fde60c..ce8ab20 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -134,7 +134,7 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 
 	lpc32xx->chip.dev = &pdev->dev;
 	lpc32xx->chip.ops = &lpc32xx_pwm_ops;
-	lpc32xx->chip.npwm = 2;
+	lpc32xx->chip.npwm = 1;
 	lpc32xx->chip.base = -1;
 
 	ret = pwmchip_add(&lpc32xx->chip);
-- 
2.1.4
