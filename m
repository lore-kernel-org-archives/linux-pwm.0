From: <sean.wang@mediatek.com>
Subject: [PATCH v3] pwm: mediatek: fix up PWM4 and PWM5 malfunction on MT7623
Date: Thu, 1 Mar 2018 16:19:12 +0800
Message-ID: <051f401bcca48ece188023ccf10b2cedc7a25a64.1519891948.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: thierry.reding@gmail.com, matthias.bgg@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>, stable@vger.kernel.org, Zhi Mao <zhi.mao@mediatek.com>, John Crispin <john@phrozen.org>
List-Id: linux-pwm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Since the offset for both registers, PWMDWIDTH and PWMTHRES, used to
control PWM4 or PWM5 are distinct from the other PWMs, whose wrong
programming on PWM hardware causes waveform cannot be output as expected.
Thus, the patch adds the extra condition for fixing up the weird case to
let PWM4 or PWM5 able to work on MT7623.

v1 -> v2: use pwm45_fixup naming instead of pwm45_quirk
v2 -> v3: add more tags for Reviewed-by, Fixes, and Cc stable

Cc: stable@vger.kernel.org
Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Zhi Mao <zhi.mao@mediatek.com>
Cc: John Crispin <john@phrozen.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/pwm/pwm-mediatek.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index f5d97e0..796baea 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -29,7 +29,9 @@
 #define PWMGDUR			0x0c
 #define PWMWAVENUM		0x28
 #define PWMDWIDTH		0x2c
+#define PWM45DWIDTH_FIXUP	0x30
 #define PWMTHRES		0x30
+#define PWM45THRES_FIXUP	0x34
 
 #define PWM_CLK_DIV_MAX		7
 
@@ -54,6 +56,7 @@ static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] = {
 
 struct mtk_pwm_platform_data {
 	unsigned int num_pwms;
+	bool pwm45_fixup;
 };
 
 /**
@@ -66,6 +69,7 @@ struct mtk_pwm_chip {
 	struct pwm_chip chip;
 	void __iomem *regs;
 	struct clk *clks[MTK_CLK_MAX];
+	const struct mtk_pwm_platform_data *soc;
 };
 
 static const unsigned int mtk_pwm_reg_offset[] = {
@@ -131,7 +135,8 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
 	struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
-	u32 resolution, clkdiv = 0;
+	u32 resolution, clkdiv = 0, reg_width = PWMDWIDTH,
+	    reg_thres = PWMTHRES;
 	int ret;
 
 	ret = mtk_pwm_clk_enable(chip, pwm);
@@ -151,9 +156,18 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;
 	}
 
+	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
+		/*
+		 * PWM[4,5] has distinct offset for PWMDWIDTH and PWMTHRES
+		 * from the other PWMs on MT7623.
+		 */
+		reg_width = PWM45DWIDTH_FIXUP;
+		reg_thres = PWM45THRES_FIXUP;
+	}
+
 	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
-	mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / resolution);
-	mtk_pwm_writel(pc, pwm->hwpwm, PWMTHRES, duty_ns / resolution);
+	mtk_pwm_writel(pc, pwm->hwpwm, reg_width, period_ns / resolution);
+	mtk_pwm_writel(pc, pwm->hwpwm, reg_thres, duty_ns / resolution);
 
 	mtk_pwm_clk_disable(chip, pwm);
 
@@ -211,6 +225,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	data = of_device_get_match_data(&pdev->dev);
 	if (data == NULL)
 		return -EINVAL;
+	pc->soc = data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pc->regs = devm_ioremap_resource(&pdev->dev, res);
@@ -251,14 +266,17 @@ static int mtk_pwm_remove(struct platform_device *pdev)
 
 static const struct mtk_pwm_platform_data mt2712_pwm_data = {
 	.num_pwms = 8,
+	.pwm45_fixup = false,
 };
 
 static const struct mtk_pwm_platform_data mt7622_pwm_data = {
 	.num_pwms = 6,
+	.pwm45_fixup = false,
 };
 
 static const struct mtk_pwm_platform_data mt7623_pwm_data = {
 	.num_pwms = 5,
+	.pwm45_fixup = true,
 };
 
 static const struct of_device_id mtk_pwm_of_match[] = {
-- 
2.7.4
