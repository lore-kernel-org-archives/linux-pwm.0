From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 2/3] pwm: imx: Use bitops and bitfield macros to define register values
Date: Mon,  1 Oct 2018 16:19:47 +0200
Message-ID: <1538403588-68850-2-git-send-email-michal.vokac@ysoft.com>
References: <1538403588-68850-1-git-send-email-michal.vokac@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538403588-68850-1-git-send-email-michal.vokac@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
List-Id: linux-pwm@vger.kernel.org

Use existing macros to define register fields instead of manually shifting
the bit masks. Also define some more register bits.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 drivers/pwm/pwm-imx.c | 78 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index bcbcac4..7a4907b 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -5,6 +5,8 @@
  * Derived from pxa PWM driver by eric miao <eric.miao@marvell.com>
  */
 
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -23,7 +25,7 @@
 #define MX1_PWMS			0x04   /* PWM Sample Register */
 #define MX1_PWMP			0x08   /* PWM Period Register */
 
-#define MX1_PWMC_EN			(1 << 4)
+#define MX1_PWMC_EN			BIT(4)
 
 /* i.MX27, i.MX31, i.MX35 share the same PWM function block: */
 
@@ -31,18 +33,53 @@
 #define MX3_PWMSR			0x04    /* PWM Status Register */
 #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
 #define MX3_PWMPR			0x10    /* PWM Period Register */
-#define MX3_PWMCR_PRESCALER(x)		((((x) - 1) & 0xFFF) << 4)
-#define MX3_PWMCR_STOPEN		(1 << 25)
-#define MX3_PWMCR_DOZEEN		(1 << 24)
-#define MX3_PWMCR_WAITEN		(1 << 23)
-#define MX3_PWMCR_DBGEN			(1 << 22)
-#define MX3_PWMCR_POUTC			(1 << 18)
-#define MX3_PWMCR_CLKSRC_IPG_HIGH	(2 << 16)
-#define MX3_PWMCR_CLKSRC_IPG		(1 << 16)
-#define MX3_PWMCR_SWR			(1 << 3)
-#define MX3_PWMCR_EN			(1 << 0)
-#define MX3_PWMSR_FIFOAV_4WORDS		0x4
-#define MX3_PWMSR_FIFOAV_MASK		0x7
+
+#define MX3_PWMCR_FWM			GENMASK(27, 26)
+#define MX3_PWMCR_STOPEN		BIT(25)
+#define MX3_PWMCR_DOZEN			BIT(24)
+#define MX3_PWMCR_WAITEN		BIT(23)
+#define MX3_PWMCR_DBGEN			BIT(22)
+#define MX3_PWMCR_BCTR			BIT(21)
+#define MX3_PWMCR_HCTR			BIT(20)
+
+#define MX3_PWMCR_POUTC			GENMASK(19, 18)
+#define MX3_PWMCR_POUTC_NORMAL		0
+#define MX3_PWMCR_POUTC_INVERTED	1
+#define MX3_PWMCR_POUTC_OFF		2
+
+#define MX3_PWMCR_CLKSRC		GENMASK(17, 16)
+#define MX3_PWMCR_CLKSRC_OFF		0
+#define MX3_PWMCR_CLKSRC_IPG		1
+#define MX3_PWMCR_CLKSRC_IPG_HIGH	2
+#define MX3_PWMCR_CLKSRC_IPG_32K	3
+
+#define MX3_PWMCR_PRESCALER		GENMASK(15, 4)
+
+#define MX3_PWMCR_SWR			BIT(3)
+
+#define MX3_PWMCR_REPEAT		GENMASK(2, 1)
+#define MX3_PWMCR_REPEAT_1X		0
+#define MX3_PWMCR_REPEAT_2X		1
+#define MX3_PWMCR_REPEAT_4X		2
+#define MX3_PWMCR_REPEAT_8X		3
+
+#define MX3_PWMCR_EN			BIT(0)
+
+#define MX3_PWMSR_FWE			BIT(6)
+#define MX3_PWMSR_CMP			BIT(5)
+#define MX3_PWMSR_ROV			BIT(4)
+#define MX3_PWMSR_FE			BIT(3)
+
+#define MX3_PWMSR_FIFOAV		GENMASK(2, 0)
+#define MX3_PWMSR_FIFOAV_EMPTY		0
+#define MX3_PWMSR_FIFOAV_1WORD		1
+#define MX3_PWMSR_FIFOAV_2WORDS		2
+#define MX3_PWMSR_FIFOAV_3WORDS		3
+#define MX3_PWMSR_FIFOAV_4WORDS		4
+
+#define MX3_PWMCR_PRESCALER_SET(x)	FIELD_PREP(MX3_PWMCR_PRESCALER, (x) - 1)
+#define MX3_PWMCR_PRESCALER_GET(x)	(FIELD_GET(MX3_PWMCR_PRESCALER, \
+						   (x)) + 1)
 
 #define MX3_PWM_SWR_LOOP		5
 
@@ -142,14 +179,14 @@ static void imx_pwm_wait_fifo_slot(struct pwm_chip *chip,
 	u32 sr;
 
 	sr = readl(imx->mmio_base + MX3_PWMSR);
-	fifoav = sr & MX3_PWMSR_FIFOAV_MASK;
+	fifoav = FIELD_GET(MX3_PWMSR_FIFOAV, sr);
 	if (fifoav == MX3_PWMSR_FIFOAV_4WORDS) {
 		period_ms = DIV_ROUND_UP(pwm_get_period(pwm),
 					 NSEC_PER_MSEC);
 		msleep(period_ms);
 
 		sr = readl(imx->mmio_base + MX3_PWMSR);
-		if (fifoav == (sr & MX3_PWMSR_FIFOAV_MASK))
+		if (fifoav == FIELD_GET(MX3_PWMSR_FIFOAV, sr))
 			dev_warn(dev, "there is no free FIFO slot\n");
 	}
 }
@@ -207,13 +244,14 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
 		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
-		cr = MX3_PWMCR_PRESCALER(prescale) |
-		     MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
-		     MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH |
-		     MX3_PWMCR_EN;
+		cr = MX3_PWMCR_PRESCALER_SET(prescale) |
+		     MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
+		     FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
+		     MX3_PWMCR_DBGEN | MX3_PWMCR_EN;
 
 		if (state->polarity == PWM_POLARITY_INVERSED)
-			cr |= MX3_PWMCR_POUTC;
+			cr |= FIELD_PREP(MX3_PWMCR_POUTC,
+					MX3_PWMCR_POUTC_INVERTED);
 
 		writel(cr, imx->mmio_base + MX3_PWMCR);
 	} else if (cstate.enabled) {
-- 
2.1.4
