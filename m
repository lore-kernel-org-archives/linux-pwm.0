From: Sam Shih <sam.shih-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 1/10] pwm: mediatek: add a property "num-pwms"
Date: Fri, 16 Aug 2019 15:21:19 +0800
Message-ID: <1565940088-845-2-git-send-email-sam.shih@mediatek.com>
References: <1565940088-845-1-git-send-email-sam.shih@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1565940088-845-1-git-send-email-sam.shih-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sam Shih <sam.shih-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, John Crispin <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

From: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

This adds a property "num-pwms" to avoid having an endless
list of compatibles with no differences for the same driver.

Signed-off-by: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Sam Shih <sam.shih-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/pwm/pwm-mediatek.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index eb6674ce995f..f9d67fb66adb 100644
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
@@ -226,27 +226,36 @@ static const struct pwm_ops mtk_pwm_ops = {
 
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
 	if (!pc)
 		return -ENOMEM;
 
-	data = of_device_get_match_data(&pdev->dev);
-	if (data == NULL)
-		return -EINVAL;
-	pc->soc = data;
+	pc->soc = of_device_get_match_data(&pdev->dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pc->regs = devm_ioremap_resource(&pdev->dev, res);
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
@@ -260,7 +269,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &mtk_pwm_ops;
 	pc->chip.base = -1;
-	pc->chip.npwm = data->num_pwms;
+	pc->chip.npwm = npwms;
 
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
@@ -279,25 +288,25 @@ static int mtk_pwm_remove(struct platform_device *pdev)
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
