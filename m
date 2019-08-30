From: Sam Shih <sam.shih-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v7 03/11] pwm: mediatek: remove a property "has-clks"
Date: Fri, 30 Aug 2019 11:57:09 +0800
Message-ID: <1567137437-10041-4-git-send-email-sam.shih@mediatek.com>
References: <1567137437-10041-1-git-send-email-sam.shih@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1567137437-10041-1-git-send-email-sam.shih-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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

We can use fixed-clock to repair mt7628 pwm during configure from
userspace. The SoC is legacy MIPS and has no complex clock tree.
Due to we can get clock frequency for period calculation from DT
fixed-clock, so we can remove has-clock property, and directly
use devm_clk_get and clk_get_rate.

Signed-off-by: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Sam Shih <sam.shih-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

---
Changes since v6:
Based on fixed-clock in DT, we can remove has-clks property

Changes since v5:
1. Follow reviewer's comments
Make the changes of fix mt7628 pwm as a single patch

Changes since v4:
- Follow reviewers's comments
1. use pc->soc->has_clks to check clocks exist or not.
2. Add error message when probe() unable to get clks
- Fixes bug when SoC is old mips which has no complex clock tree.
if clocks not exist, use the new property from DT to apply period caculation;
otherwise, use clk_get_rate to get clock frequency and apply period caculation.
---
 drivers/pwm/pwm-mediatek.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index ebd62629e3fe..07e843aeddb1 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -57,7 +57,6 @@ static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] = {
 struct mtk_pwm_platform_data {
 	unsigned int fallback_npwms;
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
@@ -262,11 +255,13 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 		npwms = MTK_CLK_MAX - 2;
 	}
 
-	for (i = 0; i < npwms + 2 && pc->soc->has_clks; i++) {
-		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
+	for (i = 0; i < npwms + 2 ; i++) {
+		pc->clks[i] = devm_clk_get(&pdev->dev,
+					  mtk_pwm_clk_name[i]);
 		if (IS_ERR(pc->clks[i])) {
 			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
-				mtk_pwm_clk_name[i], PTR_ERR(pc->clks[i]));
+				mtk_pwm_clk_name[i],
+				PTR_ERR(pc->clks[i]));
 			return PTR_ERR(pc->clks[i]);
 		}
 	}
@@ -297,25 +292,21 @@ static int mtk_pwm_remove(struct platform_device *pdev)
 static const struct mtk_pwm_platform_data mt2712_pwm_data = {
 	.fallback_npwms = 8,
 	.pwm45_fixup = false,
-	.has_clks = true,
 };
 
 static const struct mtk_pwm_platform_data mt7622_pwm_data = {
 	.fallback_npwms = 6,
 	.pwm45_fixup = false,
-	.has_clks = true,
 };
 
 static const struct mtk_pwm_platform_data mt7623_pwm_data = {
 	.fallback_npwms = 5,
 	.pwm45_fixup = true,
-	.has_clks = true,
 };
 
 static const struct mtk_pwm_platform_data mt7628_pwm_data = {
 	.fallback_npwms = 4,
 	.pwm45_fixup = true,
-	.has_clks = false,
 };
 
 static const struct of_device_id mtk_pwm_of_match[] = {
-- 
2.17.1
