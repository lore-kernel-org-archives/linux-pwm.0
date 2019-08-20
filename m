From: Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH v4 1/10] pwm: mediatek: add a property "num-pwms"
Date: Tue, 20 Aug 2019 09:40:16 +0800
Message-ID: <1566265225-27452-2-git-send-email-sam.shih@mediatek.com>
References: <1566265225-27452-1-git-send-email-sam.shih@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1566265225-27452-1-git-send-email-sam.shih@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, Sam Shih <sam.shih@mediatek.com>
List-Id: linux-pwm@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

This adds a property "num-pwms" to avoid having an endless
list of compatibles with no differences for the same driver.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
Used:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=68207

Changes since v4:
Follow reviewer's comments:
Move the changes of droping the check for of_device_get_match_data
returning non-NULL to next patch
---
 drivers/pwm/pwm-mediatek.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index eb6674ce995f..287fda3674ce 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -55,7 +55,7 @@ static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] = {
 };
 
 struct mtk_pwm_platform_data {
-	unsigned int num_pwms;
+	unsigned int fallback_npwms;
 	bool pwm45_fixup;
 	bool has_clks;
 };
@@ -226,10 +226,10 @@ static const struct pwm_ops mtk_pwm_ops = {
 
 static int mtk_pwm_probe(struct platform_device *pdev)
 {
-	const struct mtk_pwm_platform_data *data;
+	struct device_node *np = pdev->dev.of_node;
 	struct mtk_pwm_chip *pc;
 	struct resource *res;
-	unsigned int i;
+	unsigned int i, npwms;
 	int ret;
 
 	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
@@ -246,7 +246,19 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->regs))
 		return PTR_ERR(pc->regs);
 
-	for (i = 0; i < data->num_pwms + 2 && pc->soc->has_clks; i++) {
+	ret = of_property_read_u32(np, "num-pwms", &npwms);
+	if (ret < 0) {
+		/* It's deprecated, we should specify num_pwms via DT now. */
+		if (pc->soc->fallback_npwms) {
+			npwms = pc->soc->fallback_npwms;
+			dev_warn(&pdev->dev, "DT is outdated, please update it\n");
+		} else {
+			dev_err(&pdev->dev, "failed to get number of PWMs\n");
+			return ret;
+		}
+	}
+
+	for (i = 0; i < npwms + 2 && pc->soc->has_clks; i++) {
 		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
 		if (IS_ERR(pc->clks[i])) {
 			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
@@ -260,7 +272,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &mtk_pwm_ops;
 	pc->chip.base = -1;
-	pc->chip.npwm = data->num_pwms;
+	pc->chip.npwm = npwms;
 
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
@@ -279,25 +291,25 @@ static int mtk_pwm_remove(struct platform_device *pdev)
 }
 
 static const struct mtk_pwm_platform_data mt2712_pwm_data = {
-	.num_pwms = 8,
+	.fallback_npwms = 8,
 	.pwm45_fixup = false,
 	.has_clks = true,
 };
 
 static const struct mtk_pwm_platform_data mt7622_pwm_data = {
-	.num_pwms = 6,
+	.fallback_npwms = 6,
 	.pwm45_fixup = false,
 	.has_clks = true,
 };
 
 static const struct mtk_pwm_platform_data mt7623_pwm_data = {
-	.num_pwms = 5,
+	.fallback_npwms = 5,
 	.pwm45_fixup = true,
 	.has_clks = true,
 };
 
 static const struct mtk_pwm_platform_data mt7628_pwm_data = {
-	.num_pwms = 4,
+	.fallback_npwms = 4,
 	.pwm45_fixup = true,
 	.has_clks = false,
 };
-- 
2.17.1
