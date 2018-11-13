From: Ryder Lee <ryder.lee@mediatek.com>
Subject: [resend PATCH 1/3] pwm: mediatek: drop flag 'has_clks'
Date: Tue, 13 Nov 2018 10:08:22 +0800
Message-ID: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, Weijie Gao <weijie.gao@mediatek.com>, Roy Luo <cheng-hao.luo@mediatek.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>
List-Id: linux-pwm@vger.kernel.org

The flag 'has_clks' and related checks are superfluous as the CCF
subsystem does this for you.

Cc: John Crispin <john@phrozen.org>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index eb6674c..9400c41 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -57,7 +57,6 @@ enum {
 struct mtk_pwm_platform_data {
 	unsigned int num_pwms;
 	bool pwm45_fixup;
-	bool has_clks;
 };
 
 /**
@@ -87,9 +86,6 @@ static int mtk_pwm_clk_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
 	int ret;
 
-	if (!pc->soc->has_clks)
-		return 0;
-
 	ret = clk_prepare_enable(pc->clks[MTK_CLK_TOP]);
 	if (ret < 0)
 		return ret;
@@ -116,9 +112,6 @@ static void mtk_pwm_clk_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
 
-	if (!pc->soc->has_clks)
-		return;
-
 	clk_disable_unprepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
 	clk_disable_unprepare(pc->clks[MTK_CLK_MAIN]);
 	clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
@@ -246,12 +239,13 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->regs))
 		return PTR_ERR(pc->regs);
 
-	for (i = 0; i < data->num_pwms + 2 && pc->soc->has_clks; i++) {
+	for (i = 0; i < data->num_pwms + 2; i++) {
 		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
 		if (IS_ERR(pc->clks[i])) {
-			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
-				mtk_pwm_clk_name[i], PTR_ERR(pc->clks[i]));
-			return PTR_ERR(pc->clks[i]);
+			if (PTR_ERR(pc->clks[i]) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+
+			pc->clks[i] = NULL;
 		}
 	}
 
@@ -281,25 +275,21 @@ static int mtk_pwm_remove(struct platform_device *pdev)
 static const struct mtk_pwm_platform_data mt2712_pwm_data = {
 	.num_pwms = 8,
 	.pwm45_fixup = false,
-	.has_clks = true,
 };
 
 static const struct mtk_pwm_platform_data mt7622_pwm_data = {
 	.num_pwms = 6,
 	.pwm45_fixup = false,
-	.has_clks = true,
 };
 
 static const struct mtk_pwm_platform_data mt7623_pwm_data = {
 	.num_pwms = 5,
 	.pwm45_fixup = true,
-	.has_clks = true,
 };
 
 static const struct mtk_pwm_platform_data mt7628_pwm_data = {
 	.num_pwms = 4,
 	.pwm45_fixup = true,
-	.has_clks = false,
 };
 
 static const struct of_device_id mtk_pwm_of_match[] = {
-- 
1.9.1
