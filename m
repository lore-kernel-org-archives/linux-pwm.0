From: Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH v3 2/10] pwm: mediatek: allocate the clks array dynamically
Date: Fri, 16 Aug 2019 15:21:20 +0800
Message-ID: <1565940088-845-3-git-send-email-sam.shih@mediatek.com>
References: <1565940088-845-1-git-send-email-sam.shih@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565940088-845-1-git-send-email-sam.shih@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, Sam Shih <sam.shih@mediatek.com>
List-Id: linux-pwm@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

Instead of using fixed size of arrays, allocate the memory for them
based on the information we get from the chips.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c | 76 +++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 37 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index f9d67fb66adb..47585b68483d 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -35,25 +35,6 @@
 
 #define PWM_CLK_DIV_MAX		7
 
-enum {
-	MTK_CLK_MAIN = 0,
-	MTK_CLK_TOP,
-	MTK_CLK_PWM1,
-	MTK_CLK_PWM2,
-	MTK_CLK_PWM3,
-	MTK_CLK_PWM4,
-	MTK_CLK_PWM5,
-	MTK_CLK_PWM6,
-	MTK_CLK_PWM7,
-	MTK_CLK_PWM8,
-	MTK_CLK_MAX,
-};
-
-static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] = {
-	"main", "top", "pwm1", "pwm2", "pwm3", "pwm4", "pwm5", "pwm6", "pwm7",
-	"pwm8"
-};
-
 struct mtk_pwm_platform_data {
 	unsigned int fallback_npwms;
 	bool pwm45_fixup;
@@ -64,12 +45,16 @@ struct mtk_pwm_platform_data {
  * struct mtk_pwm_chip - struct representing PWM chip
  * @chip: linux PWM chip representation
  * @regs: base address of PWM chip
- * @clks: list of clocks
+ * @clk_top: the top clock generator
+ * @clk_main: the clock used by PWM core
+ * @clk_pwms: the clock used by each PWM channel
  */
 struct mtk_pwm_chip {
 	struct pwm_chip chip;
 	void __iomem *regs;
-	struct clk *clks[MTK_CLK_MAX];
+	struct clk *clk_top;
+	struct clk *clk_main;
+	struct clk **clk_pwms;
 	const struct mtk_pwm_platform_data *soc;
 };
 
@@ -90,24 +75,24 @@ static int mtk_pwm_clk_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (!pc->soc->has_clks)
 		return 0;
 
-	ret = clk_prepare_enable(pc->clks[MTK_CLK_TOP]);
+	ret = clk_prepare_enable(pc->clk_top);
 	if (ret < 0)
 		return ret;
 
-	ret = clk_prepare_enable(pc->clks[MTK_CLK_MAIN]);
+	ret = clk_prepare_enable(pc->clk_main);
 	if (ret < 0)
 		goto disable_clk_top;
 
-	ret = clk_prepare_enable(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
+	ret = clk_prepare_enable(pc->clk_pwms[pwm->hwpwm]);
 	if (ret < 0)
 		goto disable_clk_main;
 
 	return 0;
 
 disable_clk_main:
-	clk_disable_unprepare(pc->clks[MTK_CLK_MAIN]);
+	clk_disable_unprepare(pc->clk_main);
 disable_clk_top:
-	clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
+	clk_disable_unprepare(pc->clk_top);
 
 	return ret;
 }
@@ -119,9 +104,9 @@ static void mtk_pwm_clk_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (!pc->soc->has_clks)
 		return;
 
-	clk_disable_unprepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
-	clk_disable_unprepare(pc->clks[MTK_CLK_MAIN]);
-	clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
+	clk_disable_unprepare(pc->clk_pwms[pwm->hwpwm]);
+	clk_disable_unprepare(pc->clk_main);
+	clk_disable_unprepare(pc->clk_top);
 }
 
 static inline u32 mtk_pwm_readl(struct mtk_pwm_chip *chip, unsigned int num,
@@ -141,7 +126,7 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			  int duty_ns, int period_ns)
 {
 	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
-	struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
+	struct clk *clk = pc->soc->has_clks ? pc->clk_pwms[pwm->hwpwm] : NULL;
 	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
 	    reg_thres = PWMTHRES;
 	u64 resolution;
@@ -229,7 +214,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct mtk_pwm_chip *pc;
 	struct resource *res;
-	unsigned int i, npwms;
+	unsigned int npwms;
 	int ret;
 
 	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
@@ -255,12 +240,29 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 		}
 	}
 
-	for (i = 0; i < npwms + 2 && pc->soc->has_clks; i++) {
-		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
-		if (IS_ERR(pc->clks[i])) {
-			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
-				mtk_pwm_clk_name[i], PTR_ERR(pc->clks[i]));
-			return PTR_ERR(pc->clks[i]);
+	if (pc->soc->has_clks) {
+		int i;
+
+		pc->clk_pwms = devm_kcalloc(&pdev->dev, npwms,
+					    sizeof(*pc->clk_pwms), GFP_KERNEL);
+		if (!pc->clk_pwms)
+			return -ENOMEM;
+
+		pc->clk_top = devm_clk_get(&pdev->dev, "top");
+		if (IS_ERR(pc->clk_top))
+			return PTR_ERR(pc->clk_top);
+
+		pc->clk_main = devm_clk_get(&pdev->dev, "main");
+		if (IS_ERR(pc->clk_main))
+			return PTR_ERR(pc->clk_main);
+
+		for (i = 0; i < npwms; i++) {
+			char name[8];
+
+			snprintf(name, sizeof(name), "pwm%d", i + 1);
+			pc->clk_pwms[i] = devm_clk_get(&pdev->dev, name);
+			if (IS_ERR(pc->clk_pwms[i]))
+				return PTR_ERR(pc->clk_pwms[i]);
 		}
 	}
 
-- 
2.17.1
