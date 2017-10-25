From: Zhi Mao <zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v7 1/1] pwm: mediatek: add MT2712/MT7622 support
Date: Wed, 25 Oct 2017 18:11:01 +0800
Message-ID: <1508926261-25015-1-git-send-email-zhi.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, zhenbao.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Add support to MT2712 and MT7622.
Due to register offset address of pwm7 for MT2712 is not fixed 0x40,
add mtk_pwm_reg_offset array for pwm register offset.

Reviewed-by: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Reviewed-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Zhi Mao <zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
changee in v7:
- adjust the commit message

Changes in v6:
- remove "struct mtk_pwm_platform_data" member from "mtk_pwm_chip". 

Changes in v5:
- Add NULL pointer checking for "data"

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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
