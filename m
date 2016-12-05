From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 3/3] pwm: lpc32xx: remove handling of PWM channels
Date: Mon,  5 Dec 2016 03:43:08 +0200
Message-ID: <20161205014308.1741-2-vz@mleia.com>
References: <20161205014237.1689-1-vz@mleia.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:42368 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbcLEBnM (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 4 Dec 2016 20:43:12 -0500
In-Reply-To: <20161205014237.1689-1-vz@mleia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Because LPC32xx PWM controllers have single output which is registered as
the only PWM device/channel per controller, it is known in advance that
pwm->hwpwm value is always 0. On basis of this fact simplify the code
by removing operations with pwm->hwpwm, there is no controls which require
channel number as input.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/pwm/pwm-lpc32xx.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index ce84181..786c887 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -55,10 +55,10 @@ static int lpc32xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (duty_cycles > 255)
 		duty_cycles = 255;
 
-	val = readl(lpc32xx->base + (pwm->hwpwm << 2));
+	val = readl(lpc32xx->base);
 	val &= ~0xFFFF;
 	val |= (period_cycles << 8) | duty_cycles;
-	writel(val, lpc32xx->base + (pwm->hwpwm << 2));
+	writel(val, lpc32xx->base);
 
 	return 0;
 }
@@ -73,9 +73,9 @@ static int lpc32xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (ret)
 		return ret;
 
-	val = readl(lpc32xx->base + (pwm->hwpwm << 2));
+	val = readl(lpc32xx->base);
 	val |= PWM_ENABLE;
-	writel(val, lpc32xx->base + (pwm->hwpwm << 2));
+	writel(val, lpc32xx->base);
 
 	return 0;
 }
@@ -85,9 +85,9 @@ static void lpc32xx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct lpc32xx_pwm_chip *lpc32xx = to_lpc32xx_pwm_chip(chip);
 	u32 val;
 
-	val = readl(lpc32xx->base + (pwm->hwpwm << 2));
+	val = readl(lpc32xx->base);
 	val &= ~PWM_ENABLE;
-	writel(val, lpc32xx->base + (pwm->hwpwm << 2));
+	writel(val, lpc32xx->base);
 
 	clk_disable_unprepare(lpc32xx->clk);
 }
@@ -147,9 +147,9 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 	}
 
 	/* When PWM is disable, configure the output to the default value */
-	val = readl(lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
+	val = readl(lpc32xx->base);
 	val &= ~PWM_PIN_LEVEL;
-	writel(val, lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
+	writel(val, lpc32xx->base);
 
 	platform_set_drvdata(pdev, lpc32xx);
 
@@ -159,10 +159,8 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 static int lpc32xx_pwm_remove(struct platform_device *pdev)
 {
 	struct lpc32xx_pwm_chip *lpc32xx = platform_get_drvdata(pdev);
-	unsigned int i;
 
-	for (i = 0; i < lpc32xx->chip.npwm; i++)
-		pwm_disable(&lpc32xx->chip.pwms[i]);
+	pwm_disable(&lpc32xx->chip.pwms[0]);
 
 	return pwmchip_remove(&lpc32xx->chip);
 }
-- 
2.10.2
