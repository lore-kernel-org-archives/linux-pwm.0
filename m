From: John Crispin <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 2/2] pwm: mediatek: Add MT7628 support
Date: Wed, 25 Jul 2018 11:52:09 +0200
Message-ID: <20180725095209.10641-2-john@phrozen.org>
References: <20180725095209.10641-1-john@phrozen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20180725095209.10641-1-john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, John Crispin <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Add support for MT7628. The SoC is legacy MIPS and hence has no complex
clock tree. This patch add an extra flag to the SoC specific data
indicating, that no clocks are present.

Signed-off-by: John Crispin <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>
---
 drivers/pwm/Kconfig        |  2 +-
 drivers/pwm/pwm-mediatek.c | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4635cb35008c..3fae66c692c4 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -286,7 +286,7 @@ config PWM_MTK_DISP
 
 config PWM_MEDIATEK
 	tristate "MediaTek PWM support"
-	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on ARCH_MEDIATEK || RALINK || COMPILE_TEST
 	help
 	  Generic PWM framework driver for Mediatek ARM SoC.
 
diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 328c124773b2..eb6674ce995f 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -57,6 +57,7 @@ static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] = {
 struct mtk_pwm_platform_data {
 	unsigned int num_pwms;
 	bool pwm45_fixup;
+	bool has_clks;
 };
 
 /**
@@ -86,6 +87,9 @@ static int mtk_pwm_clk_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
 	int ret;
 
+	if (!pc->soc->has_clks)
+		return 0;
+
 	ret = clk_prepare_enable(pc->clks[MTK_CLK_TOP]);
 	if (ret < 0)
 		return ret;
@@ -112,6 +116,9 @@ static void mtk_pwm_clk_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
 
+	if (!pc->soc->has_clks)
+		return;
+
 	clk_disable_unprepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
 	clk_disable_unprepare(pc->clks[MTK_CLK_MAIN]);
 	clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
@@ -239,7 +246,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->regs))
 		return PTR_ERR(pc->regs);
 
-	for (i = 0; i < data->num_pwms + 2; i++) {
+	for (i = 0; i < data->num_pwms + 2 && pc->soc->has_clks; i++) {
 		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
 		if (IS_ERR(pc->clks[i])) {
 			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
@@ -274,22 +281,32 @@ static int mtk_pwm_remove(struct platform_device *pdev)
 static const struct mtk_pwm_platform_data mt2712_pwm_data = {
 	.num_pwms = 8,
 	.pwm45_fixup = false,
+	.has_clks = true,
 };
 
 static const struct mtk_pwm_platform_data mt7622_pwm_data = {
 	.num_pwms = 6,
 	.pwm45_fixup = false,
+	.has_clks = true,
 };
 
 static const struct mtk_pwm_platform_data mt7623_pwm_data = {
 	.num_pwms = 5,
 	.pwm45_fixup = true,
+	.has_clks = true,
+};
+
+static const struct mtk_pwm_platform_data mt7628_pwm_data = {
+	.num_pwms = 4,
+	.pwm45_fixup = true,
+	.has_clks = false,
 };
 
 static const struct of_device_id mtk_pwm_of_match[] = {
 	{ .compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data },
 	{ .compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data },
 	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
+	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, mtk_pwm_of_match);
-- 
2.11.0
