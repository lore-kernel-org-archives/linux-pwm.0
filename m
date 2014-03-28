From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCHv3 2/3] pwm: imx: indentation cleanup
Date: Fri, 28 Mar 2014 09:48:59 +0100
Message-ID: <1395996540-10999-3-git-send-email-LW@KARO-electronics.de>
References: <1395235375-12925-1-git-send-email-LW@KARO-electronics.de>
 <1395996540-10999-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395996540-10999-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pwm@vger.kernel.org


Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/pwm/pwm-imx.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index cc47733..52aac5e 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -25,20 +25,21 @@
 #define MX1_PWMS    0x04   /* PWM Sample Register */
 #define MX1_PWMP    0x08   /* PWM Period Register */
=20
-#define MX1_PWMC_EN		(1 << 4)
+#define MX1_PWMC_EN			(1 << 4)
=20
 /* i.MX27, i.MX31, i.MX35 share the same PWM function block: */
=20
-#define MX3_PWMCR                 0x00    /* PWM Control Register */
-#define MX3_PWMSAR                0x0C    /* PWM Sample Register */
-#define MX3_PWMPR                 0x10    /* PWM Period Register */
-#define MX3_PWMCR_PRESCALER(x)    (((x - 1) & 0xFFF) << 4)
-#define MX3_PWMCR_DOZEEN                (1 << 24)
-#define MX3_PWMCR_WAITEN                (1 << 23)
+#define MX3_PWMCR			0x00	  /* PWM Control Register */
+#define MX3_PWMSAR			0x0C	  /* PWM Sample Register */
+#define MX3_PWMPR			0x10	  /* PWM Period Register */
+#define MX3_PWMCR_PRESCALER(x)		((((x) - 1) & 0xFFF) << 4)
+#define MX3_PWMCR_DOZEEN		(1 << 24)
+#define MX3_PWMCR_WAITEN		(1 << 23)
 #define MX3_PWMCR_DBGEN			(1 << 22)
-#define MX3_PWMCR_CLKSRC_IPG_HIGH (2 << 16)
-#define MX3_PWMCR_CLKSRC_IPG      (1 << 16)
-#define MX3_PWMCR_EN              (1 << 0)
+#define MX3_PWMCR_POUTC			(1 << 18)
+#define MX3_PWMCR_CLKSRC_IPG_HIGH	(2 << 16)
+#define MX3_PWMCR_CLKSRC_IPG		(1 << 16)
+#define MX3_PWMCR_EN			(1 << 0)
=20
 struct imx_chip {
 	struct clk	*clk_per;
--=20
1.7.10.4
