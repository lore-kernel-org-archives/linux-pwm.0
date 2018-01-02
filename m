From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH v3 RESEND] pwm: imx: Let PWM be active during suspend
Date: Tue, 2 Jan 2018 11:01:59 -0200
Message-ID: <1514898119-19632-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-co1nam03on0089.outbound.protection.outlook.com ([104.47.40.89]:15088
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751682AbeABNCG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 2 Jan 2018 08:02:06 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: festevam@gmail.com, linux@arm.linux.org.uk, lw@karo-electronics.de, linux-pwm@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

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
Hi Thierry,

Resending it in the hope we can still get this in for 4.16.

Please not that STOPEN is also unconditionally set in vendor's kernel:
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch/arm/plat-mxc/pwm.c?h=imx_3.0.35_4.1.0#n106

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
