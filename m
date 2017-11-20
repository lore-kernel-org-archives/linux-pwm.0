From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3] pwm: imx: Let PWM be active during suspend
Date: Mon, 20 Nov 2017 21:27:23 -0200
Message-ID: <1511220443-26629-1-git-send-email-festevam@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:41913 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbdKTX1i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Nov 2017 18:27:38 -0500
Received: by mail-qk0-f194.google.com with SMTP id f63so9677713qke.8
        for <linux-pwm@vger.kernel.org>; Mon, 20 Nov 2017 15:27:38 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, robh@kernel.org, linux@arm.linux.org.uk, Fabio Estevam <fabio.estevam@nxp.com>

From: Fabio Estevam <fabio.estevam@nxp.com>

On a imx6q-cubox-i board, which has an LED driven by PWM, when the system
goes into suspend the PWM block is disabled by default, then the PWM pin
goes to logic level zero and turn on the LED during suspend, which is not
really the behaviour we want to see.

By keeping the PWM enabled during suspend via STOPEN bit, the pwm-leds
driver sets the brightness to zero in suspend and then the LED is
turned off as expected.

So always set the STOPEN to fix the PWM behaviour in suspend.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v2:
- Remove the optional dt property and set the STOPEN bit unconditionally (Rob)

 drivers/pwm/pwm-imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 2ba5c3a..08cbe81 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -35,6 +35,7 @@
 #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
 #define MX3_PWMPR			0x10    /* PWM Period Register */
 #define MX3_PWMCR_PRESCALER(x)		((((x) - 1) & 0xFFF) << 4)
+#define MX3_PWMCR_STOPEN		(1 << 25)
 #define MX3_PWMCR_DOZEEN		(1 << 24)
 #define MX3_PWMCR_WAITEN		(1 << 23)
 #define MX3_PWMCR_DBGEN			(1 << 22)
@@ -210,7 +211,7 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
 		cr = MX3_PWMCR_PRESCALER(prescale) |
-		     MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
+		     MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
 		     MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH |
 		     MX3_PWMCR_EN;
 
-- 
2.7.4
