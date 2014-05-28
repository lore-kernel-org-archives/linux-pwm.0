From: Liu Ying <Ying.Liu@freescale.com>
Subject: [PATCH v2 2/3] pwm: i.MX: Cleanup indentation for register definitions
Date: Wed, 28 May 2014 18:50:12 +0800
Message-ID: <1401274213-8954-2-git-send-email-Ying.Liu@freescale.com>
References: <1401274213-8954-1-git-send-email-Ying.Liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bl2lp0208.outbound.protection.outlook.com ([207.46.163.208]:9156
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752510AbaE1KsC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 28 May 2014 06:48:02 -0400
In-Reply-To: <1401274213-8954-1-git-send-email-Ying.Liu@freescale.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com, s.hauer@pengutronix.de, shawn.guo@freescale.com, LW@KARO-electronics.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

This patch contains no logic change to cleanup indentation
for register definitions only.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Cc: linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v1->v2:
* Rebase up to the commit(1/3 in this series) which fixes
  the macro MX3_PWMCR_PRESCALER(x) definition.

 drivers/pwm/pwm-imx.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 9835e0b..fc47fab 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -21,24 +21,24 @@
=20
 /* i.MX1 and i.MX21 share the same PWM function block: */
=20
-#define MX1_PWMC    0x00   /* PWM Control Register */
-#define MX1_PWMS    0x04   /* PWM Sample Register */
-#define MX1_PWMP    0x08   /* PWM Period Register */
+#define MX1_PWMC			0x00   /* PWM Control Register */
+#define MX1_PWMS			0x04   /* PWM Sample Register */
+#define MX1_PWMP			0x08   /* PWM Period Register */
=20
-#define MX1_PWMC_EN		(1 << 4)
+#define MX1_PWMC_EN			(1 << 4)
=20
 /* i.MX27, i.MX31, i.MX35 share the same PWM function block: */
=20
-#define MX3_PWMCR                 0x00    /* PWM Control Register */
-#define MX3_PWMSAR                0x0C    /* PWM Sample Register */
-#define MX3_PWMPR                 0x10    /* PWM Period Register */
-#define MX3_PWMCR_PRESCALER(x)    ((((x) - 1) & 0xFFF) << 4)
-#define MX3_PWMCR_DOZEEN                (1 << 24)
-#define MX3_PWMCR_WAITEN                (1 << 23)
+#define MX3_PWMCR			0x00    /* PWM Control Register */
+#define MX3_PWMSAR			0x0C    /* PWM Sample Register */
+#define MX3_PWMPR			0x10    /* PWM Period Register */
+#define MX3_PWMCR_PRESCALER(x)		((((x) - 1) & 0xFFF) << 4)
+#define MX3_PWMCR_DOZEEN		(1 << 24)
+#define MX3_PWMCR_WAITEN		(1 << 23)
 #define MX3_PWMCR_DBGEN			(1 << 22)
-#define MX3_PWMCR_CLKSRC_IPG_HIGH (2 << 16)
-#define MX3_PWMCR_CLKSRC_IPG      (1 << 16)
-#define MX3_PWMCR_EN              (1 << 0)
+#define MX3_PWMCR_CLKSRC_IPG_HIGH	(2 << 16)
+#define MX3_PWMCR_CLKSRC_IPG		(1 << 16)
+#define MX3_PWMCR_EN			(1 << 0)
=20
 struct imx_chip {
 	struct clk	*clk_per;
--=20
1.7.9.5

