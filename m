From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH v2 3/6] pwm: lpc32xx: correct number of PWM channels from 2 to 1
Date: Sun,  6 Dec 2015 13:31:59 +0200
Message-ID: <1449401522-22590-4-git-send-email-vz@mleia.com>
References: <1449401522-22590-1-git-send-email-vz@mleia.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:51876 "EHLO mail.mleia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754051AbbLFLcJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Sun, 6 Dec 2015 06:32:09 -0500
In-Reply-To: <1449401522-22590-1-git-send-email-vz@mleia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Roland Stigge <stigge@antcom.de>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org

LPC32xx SoC has two independent PWM controllers, they have different
clock parents, clock gates and even slightly different controls, and
each of these two PWM controllers has one output channel. Due to
almost similar controls arranged in a row it is incorrectly set that
there is one PWM controller with two channels, fix this problem, which
at the moment prevents separate configuration of different clock
parents and gates for both PWM controllers.

The change makes previous PWM device node description incompatible
with this update.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v1 to v2:
- improved commit message

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
