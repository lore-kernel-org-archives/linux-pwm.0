From: Sylvain Lemieux <slemieux.tyco@gmail.com>
Subject: [PATCH] pwm: lpc32xx: Set PWM_PIN_LEVEL bit in lpc32xx_pwm_disable
Date: Fri,  3 Jun 2016 15:37:57 -0400
Message-ID: <1464982677-24883-1-git-send-email-slemieux.tyco@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:33174 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbcFCTiH (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jun 2016 15:38:07 -0400
Received: by mail-io0-f196.google.com with SMTP id p194so11769675iod.0
        for <linux-pwm@vger.kernel.org>; Fri, 03 Jun 2016 12:38:06 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: vz@mleia.com, thierry.reding@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org

From: Sylvain Lemieux <slemieux@tycoint.com>

If the PWM_PIN_LEVEL bit is setup to 1 in the bootloader, when the kernel
disable the PWM, the PWM output is always set as a logic 1.

Prior to commit 08ee77b5a5de27ad63c92262ebcb4efe0da93b58,
the PWM_PIN_LEVEL bit was always clear when the PWM was disable
and a 0 logic level was apply to the output.

According to the LPC32x0 User Manual [1],
the default value for bit 30 (PWM_PIN_LEVEL) is 0.

This change initialize the pin level to 0 (default value) and
update the register value accordingly during the disable process.

[1] http://www.nxp.com/documents/user_manual/UM10326.pdf

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
 drivers/pwm/pwm-lpc32xx.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index 4d470c1..dbf93a1 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -22,9 +22,11 @@ struct lpc32xx_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
+	unsigned int pin_state;
 };
 
 #define PWM_ENABLE	BIT(31)
+#define PWM_PIN_LEVEL	BIT(30)
 
 #define to_lpc32xx_pwm_chip(_chip) \
 	container_of(_chip, struct lpc32xx_pwm_chip, chip)
@@ -85,7 +87,14 @@ static void lpc32xx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	u32 val;
 
 	val = readl(lpc32xx->base + (pwm->hwpwm << 2));
-	val &= ~PWM_ENABLE;
+	val &= ~(PWM_ENABLE | PWM_PIN_LEVEL);
+
+	/*
+	 * When the PWM is disable, we have to ensure the output is configured
+	 * correctly:
+	 */
+	if(lpc32xx->pin_state)
+		val |= PWM_PIN_LEVEL;
 	writel(val, lpc32xx->base + (pwm->hwpwm << 2));
 
 	clk_disable_unprepare(lpc32xx->clk);
@@ -121,6 +130,7 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 	lpc32xx->chip.ops = &lpc32xx_pwm_ops;
 	lpc32xx->chip.npwm = 1;
 	lpc32xx->chip.base = -1;
+	lpc32xx->pin_state = 0;
 
 	ret = pwmchip_add(&lpc32xx->chip);
 	if (ret < 0) {
-- 
1.8.3.1
