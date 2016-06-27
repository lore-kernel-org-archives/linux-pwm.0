From: Sylvain Lemieux <slemieux.tyco@gmail.com>
Subject: [PATCH v2 1/3] pwm: lpc32xx: Set PWM_PIN_LEVEL bit to default value
Date: Mon, 27 Jun 2016 09:09:55 -0400
Message-ID: <1467032997-5340-2-git-send-email-slemieux.tyco@gmail.com>
References: <1467032997-5340-1-git-send-email-slemieux.tyco@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34689 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbcF0NKH (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jun 2016 09:10:07 -0400
Received: by mail-io0-f194.google.com with SMTP id 100so24284602ioh.1
        for <linux-pwm@vger.kernel.org>; Mon, 27 Jun 2016 06:10:07 -0700 (PDT)
In-Reply-To: <1467032997-5340-1-git-send-email-slemieux.tyco@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: vz@mleia.com, thierry.reding@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org

From: Sylvain Lemieux <slemieux@tycoint.com>

The PWM_PIN_LEVEL bit is leave unset by the kernel PWM driver.

Prior to commit 08ee77b5a5de27ad63c92262ebcb4efe0da93b58,
the PWM_PIN_LEVEL bit was always clear when the PWM was disable
and a 0 logic level was apply to the output.

According to the LPC32x0 User Manual [1],
the default value for bit 30 (PWM_PIN_LEVEL) is 0.

This change initialize the pin level to 0 (default value) and
update the register value accordingly.

[1] http://www.nxp.com/documents/user_manual/UM10326.pdf

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Changes from v1 to v2:
* Only setup the "PWMx_PIN_LEVEL" once on probe.

 drivers/pwm/pwm-lpc32xx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index 4d470c1..a9b3cff 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -25,6 +25,7 @@ struct lpc32xx_pwm_chip {
 };
 
 #define PWM_ENABLE	BIT(31)
+#define PWM_PIN_LEVEL	BIT(30)
 
 #define to_lpc32xx_pwm_chip(_chip) \
 	container_of(_chip, struct lpc32xx_pwm_chip, chip)
@@ -103,6 +104,7 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 	struct lpc32xx_pwm_chip *lpc32xx;
 	struct resource *res;
 	int ret;
+	u32 val;
 
 	lpc32xx = devm_kzalloc(&pdev->dev, sizeof(*lpc32xx), GFP_KERNEL);
 	if (!lpc32xx)
@@ -128,6 +130,11 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* When PWM is disable, configure the output to the default value */
+	val = readl(lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
+	val &= ~PWM_PIN_LEVEL;
+	writel(val, lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
+
 	platform_set_drvdata(pdev, lpc32xx);
 
 	return 0;
-- 
1.8.3.1
