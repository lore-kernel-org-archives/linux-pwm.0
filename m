From: Zhi Mao <zhi.mao@mediatek.com>
Subject: [PATCH v3 6/6] pwm: mediatek: add MT2712/MT7622 support
Date: Fri, 30 Jun 2017 14:05:21 +0800
Message-ID: <1498802721-32455-7-git-send-email-zhi.mao@mediatek.com>
References: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: john@phrozen.org, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org
Cc: srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, zhi.mao@mediatek.com, yingjoe.chen@mediatek.com, yt.shen@mediatek.com, sean.wang@mediatek.com, zhenbao.liu@mediatek.com
List-Id: linux-pwm@vger.kernel.org

1. support multiple chip(MT2712, MT7622, MT7623)
2. add mtk_pwm_com_reg for match the registers of MT2712 pwm8
   the register offset address of pwm8 for MT2712 is not fixed 0x40
   and they are not the same as pwm0~6.

Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c |   55 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 1d78ab1..2c9ce24 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
@@ -40,11 +41,19 @@ enum {
 	MTK_CLK_PWM3,
 	MTK_CLK_PWM4,
 	MTK_CLK_PWM5,
+	MTK_CLK_PWM6,
+	MTK_CLK_PWM7,
+	MTK_CLK_PWM8,
 	MTK_CLK_MAX,
 };
 
-static const char * const mtk_pwm_clk_name[] = {
-	"main", "top", "pwm1", "pwm2", "pwm3", "pwm4", "pwm5"
+static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] = {
+	"main", "top", "pwm1", "pwm2", "pwm3", "pwm4",
+	"pwm5", "pwm6", "pwm7", "pwm8"
+};
+
+struct mtk_com_pwm_data {
+	unsigned int pwm_nums;
 };
 
 /**
@@ -57,6 +66,11 @@ struct mtk_pwm_chip {
 	struct pwm_chip chip;
 	void __iomem *regs;
 	struct clk *clks[MTK_CLK_MAX];
+	const struct mtk_com_pwm_data *data;
+};
+
+static const unsigned long mtk_pwm_com_reg[] = {
+	0x0010, 0x0050, 0x0090, 0x00d0, 0x0110, 0x0150, 0x0190, 0x0220
 };
 
 static inline struct mtk_pwm_chip *to_mtk_pwm_chip(struct pwm_chip *chip)
@@ -103,14 +117,14 @@ static void mtk_pwm_clk_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 static inline u32 mtk_pwm_readl(struct mtk_pwm_chip *chip, unsigned int num,
 				unsigned int offset)
 {
-	return readl(chip->regs + 0x10 + (num * 0x40) + offset);
+	return readl(chip->regs + mtk_pwm_com_reg[num] + offset);
 }
 
 static inline void mtk_pwm_writel(struct mtk_pwm_chip *chip,
 				  unsigned int num, unsigned int offset,
 				  u32 value)
 {
-	writel(value, chip->regs + 0x10 + (num * 0x40) + offset);
+	writel(value, chip->regs + mtk_pwm_com_reg[num] + offset);
 }
 
 static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -194,23 +208,28 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	if (!pc)
 		return -ENOMEM;
 
+	pc->data = of_device_get_match_data(&pdev->dev);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pc->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(pc->regs))
 		return PTR_ERR(pc->regs);
 
-	for (i = 0; i < MTK_CLK_MAX; i++) {
+	for (i = 0; i < pc->data->pwm_nums + 2; i++) {
 		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
-		if (IS_ERR(pc->clks[i]))
+		if (IS_ERR(pc->clks[i])) {
+			dev_err(&pdev->dev, "[PWM] clock: %s fail: %ld\n",
+				mtk_pwm_clk_name[i], PTR_ERR(pc->clks[i]));
 			return PTR_ERR(pc->clks[i]);
+		}
 	}
 
-	platform_set_drvdata(pdev, pc);
-
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &mtk_pwm_ops;
 	pc->chip.base = -1;
-	pc->chip.npwm = 5;
+	pc->chip.npwm = pc->data->pwm_nums;
+
+	platform_set_drvdata(pdev, pc);
 
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
@@ -228,9 +247,23 @@ static int mtk_pwm_remove(struct platform_device *pdev)
 	return pwmchip_remove(&pc->chip);
 }
 
+static const struct mtk_com_pwm_data mt2712_pwm_data = {
+	.pwm_nums = 8,
+};
+
+static const struct mtk_com_pwm_data mt7622_pwm_data = {
+	.pwm_nums = 6,
+};
+
+static const struct mtk_com_pwm_data mt7623_pwm_data = {
+	.pwm_nums = 5,
+};
+
 static const struct of_device_id mtk_pwm_of_match[] = {
-	{ .compatible = "mediatek,mt7623-pwm" },
-	{ }
+	{.compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data},
+	{.compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data},
+	{.compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data},
+	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_pwm_of_match);
 
-- 
1.7.9.5
