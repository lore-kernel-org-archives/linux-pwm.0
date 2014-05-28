From: Liu Ying <Ying.Liu@freescale.com>
Subject: [PATCH 1/3] pwm: i.MX: Fix the macro MX3_PWMCR_PRESCALER(x) definition
Date: Wed, 28 May 2014 18:50:11 +0800
Message-ID: <1401274213-8954-1-git-send-email-Ying.Liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bl2lp0211.outbound.protection.outlook.com ([207.46.163.211]:7808
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752510AbaE1Krx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 28 May 2014 06:47:53 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com, s.hauer@pengutronix.de, shawn.guo@freescale.com, LW@KARO-electronics.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

This patch adds missing parentheses around the argument
of the macro MX3_PWMCR_PRESCALER(x) to avoid any potential
macro expansion issue.

Reported-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Cc: linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
 drivers/pwm/pwm-imx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index cc47733..9835e0b 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -32,7 +32,7 @@
 #define MX3_PWMCR                 0x00    /* PWM Control Register */
 #define MX3_PWMSAR                0x0C    /* PWM Sample Register */
 #define MX3_PWMPR                 0x10    /* PWM Period Register */
-#define MX3_PWMCR_PRESCALER(x)    (((x - 1) & 0xFFF) << 4)
+#define MX3_PWMCR_PRESCALER(x)    ((((x) - 1) & 0xFFF) << 4)
 #define MX3_PWMCR_DOZEEN                (1 << 24)
 #define MX3_PWMCR_WAITEN                (1 << 23)
 #define MX3_PWMCR_DBGEN			(1 << 22)
--=20
1.7.9.5

