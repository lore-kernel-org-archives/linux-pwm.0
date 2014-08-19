From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv4 1/3] pwm: ftm-pwm: Clean up the code.
Date: Tue, 19 Aug 2014 12:38:01 +0800
Message-ID: <1408423083-19827-2-git-send-email-Li.Xiubo@freescale.com>
References: <1408423083-19827-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1408423083-19827-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: thierry.reding@gmail.com, mark.rutland@arm.com, linux-pwm@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, rdunlap@infradead.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: linux-pwm@vger.kernel.org

This patch intends to prepare for converting to direct regmap
API usage.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index a18bc8f..96982da 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -21,11 +21,10 @@
 #include <linux/slab.h>
 
 #define FTM_SC		0x00
-#define FTM_SC_CLK_MASK	0x3
-#define FTM_SC_CLK_SHIFT	3
-#define FTM_SC_CLK(c)	(((c) + 1) << FTM_SC_CLK_SHIFT)
+#define FTM_SC_CLK_MASK_SHIFT	3
+#define FTM_SC_CLK_MASK	(3 << FTM_SC_CLK_MASK_SHIFT)
+#define FTM_SC_CLK(c)	(((c) + 1) << FTM_SC_CLK_MASK_SHIFT)
 #define FTM_SC_PS_MASK	0x7
-#define FTM_SC_PS_SHIFT	0
 
 #define FTM_CNT		0x04
 #define FTM_MOD		0x08
@@ -258,7 +257,7 @@ static int fsl_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		}
 
 		val = readl(fpc->base + FTM_SC);
-		val &= ~(FTM_SC_PS_MASK << FTM_SC_PS_SHIFT);
+		val &= ~FTM_SC_PS_MASK;
 		val |= fpc->clk_ps;
 		writel(val, fpc->base + FTM_SC);
 		writel(period - 1, fpc->base + FTM_MOD);
@@ -305,7 +304,7 @@ static int fsl_counter_clock_enable(struct fsl_pwm_chip *fpc)
 
 	/* select counter clock source */
 	val = readl(fpc->base + FTM_SC);
-	val &= ~(FTM_SC_CLK_MASK << FTM_SC_CLK_SHIFT);
+	val &= ~FTM_SC_CLK_MASK;
 	val |= FTM_SC_CLK(fpc->cnt_select);
 	writel(val, fpc->base + FTM_SC);
 
@@ -357,7 +356,7 @@ static void fsl_counter_clock_disable(struct fsl_pwm_chip *fpc)
 
 	/* no users left, disable PWM counter clock */
 	val = readl(fpc->base + FTM_SC);
-	val &= ~(FTM_SC_CLK_MASK << FTM_SC_CLK_SHIFT);
+	val &= ~FTM_SC_CLK_MASK;
 	writel(val, fpc->base + FTM_SC);
 
 	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_CNTEN]);
-- 
1.8.5

