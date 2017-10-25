From: Zhi Mao <zhi.mao@mediatek.com>
Subject: [PATCH v6 1/1] pwm: mediatek: add MT2712/MT7622 support
Date: Wed, 25 Oct 2017 14:55:04 +0800
Message-ID: <1508914504-19253-1-git-send-email-zhi.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:48698 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751328AbdJYGzR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Oct 2017 02:55:17 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: john@phrozen.org, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org
Cc: srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, zhi.mao@mediatek.com, yingjoe.chen@mediatek.com, yt.shen@mediatek.com, sean.wang@mediatek.com, zhenbao.liu@mediatek.com

Add support to MT2712 and MT7622.
Due to register offset address of pwm7 for MT2712 is not fixed 0x40,
add mtk_pwm_reg_offset array for pwm register offset.
Add NULL pointer checking for "data",
and remove "struct mtk_pwm_platform_data" member from "mtk_pwm_chip".


Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c |   53 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 1d78ab1..cdd4d31 100644
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
+	"main", "top", "pwm1", "pwm2", "pwm3", "pwm4", "pwm5", "pwm6", "pwm7",
+	"pwm8"
+};
+
+struct mtk_pwm_platform_data {
+	unsigned int num_pwms;
 };
 
 /**
@@ -59,6 +68,10 @@ struct mtk_pwm_chip {
 	struct clk *clks[MTK_CLK_MAX];
 };
 
+static const unsigned int mtk_pwm_reg_offset[] = {
+	0x0010, 0x0050, 0x0090, 0x00d0, 0x0110, 0x0150, 0x0190, 0x0220
+};
+
 static inline struct mtk_pwm_chip *to_mtk_pwm_chip(struct pwm_chip *chip)
 {
 	return container_of(chip, struct mtk_pwm_chip, chip);
@@ -103,14 +116,14 @@ static void mtk_pwm_clk_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 static inline u32 mtk_pwm_readl(struct mtk_pwm_chip *chip, unsigned int num,
 				unsigned int offset)
 {
-	return readl(chip->regs + 0x10 + (num * 0x40) + offset);
+	return readl(chip->regs + mtk_pwm_reg_offset[num] + offset);
 }
 
 static inline void mtk_pwm_writel(struct mtk_pwm_chip *chip,
 				  unsigned int num, unsigned int offset,
 				  u32 value)
 {
-	writel(value, chip->regs + 0x10 + (num * 0x40) + offset);
+	writel(value, chip->regs + mtk_pwm_reg_offset[num] + offset);
 }
 
 static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -185,6 +198,7 @@ static void mtk_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 static int mtk_pwm_probe(struct platform_device *pdev)
 {
+	const struct mtk_pwm_platform_data *data;
 	struct mtk_pwm_chip *pc;
 	struct resource *res;
 	unsigned int i;
@@ -194,15 +208,22 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	if (!pc)
 		return -ENOMEM;
 
+	data = of_device_get_match_data(&pdev->dev);
+	if (data == NULL)
+		return -EINVAL;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pc->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(pc->regs))
 		return PTR_ERR(pc->regs);
 
-	for (i = 0; i < MTK_CLK_MAX; i++) {
+	for (i = 0; i < data->num_pwms + 2; i++) {
 		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
-		if (IS_ERR(pc->clks[i]))
+		if (IS_ERR(pc->clks[i])) {
+			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
+				mtk_pwm_clk_name[i], PTR_ERR(pc->clks[i]));
 			return PTR_ERR(pc->clks[i]);
+		}
 	}
 
 	platform_set_drvdata(pdev, pc);
@@ -210,7 +231,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &mtk_pwm_ops;
 	pc->chip.base = -1;
-	pc->chip.npwm = 5;
+	pc->chip.npwm = data->num_pwms;
 
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
@@ -228,9 +249,23 @@ static int mtk_pwm_remove(struct platform_device *pdev)
 	return pwmchip_remove(&pc->chip);
 }
 
+static const struct mtk_pwm_platform_data mt2712_pwm_data = {
+	.num_pwms = 8,
+};
+
+static const struct mtk_pwm_platform_data mt7622_pwm_data = {
+	.num_pwms = 6,
+};
+
+static const struct mtk_pwm_platform_data mt7623_pwm_data = {
+	.num_pwms = 5,
+};
+
 static const struct of_device_id mtk_pwm_of_match[] = {
-	{ .compatible = "mediatek,mt7623-pwm" },
-	{ }
+	{ .compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data },
+	{ .compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data },
+	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
+	{ },
 };
 MODULE_DEVICE_TABLE(of, mtk_pwm_of_match);
 
-- 
1.7.9.5
