From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 5/5] pwm: tegra: Add support for Tegra186
Date: Wed, 22 Jun 2016 17:17:23 +0530
Message-ID: <1466596043-27262-6-git-send-email-ldewangan@nvidia.com>
References: <1466596043-27262-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1466596043-27262-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Tegra186 has PWM controller with only one output instead of
4 output in earlier generation SoCs.

Add support for Tegra186 and find the number of PWM output
based on driver data.

Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/pwm/pwm-tegra.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 49cefd5..5547e7d 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -26,6 +26,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/pwm.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -37,7 +38,9 @@
 #define PWM_SCALE_WIDTH	13
 #define PWM_SCALE_SHIFT	0
 
-#define NUM_PWM 4
+struct tegra_pwm_hwdata {
+	int num_pwm;
+};
 
 struct tegra_pwm_chip {
 	struct pwm_chip		chip;
@@ -47,6 +50,7 @@ struct tegra_pwm_chip {
 	struct reset_control	*rstc;
 
 	void __iomem		*mmio_base;
+	const struct tegra_pwm_hwdata	*hw;
 };
 
 static inline struct tegra_pwm_chip *to_tegra_pwm_chip(struct pwm_chip *chip)
@@ -172,9 +176,16 @@ static const struct pwm_ops tegra_pwm_ops = {
 static int tegra_pwm_probe(struct platform_device *pdev)
 {
 	struct tegra_pwm_chip *pwm;
+	const struct tegra_pwm_hwdata *hwdata;
 	struct resource *r;
 	int ret;
 
+	hwdata = of_device_get_match_data(&pdev->dev);
+	if (!hwdata) {
+		dev_err(&pdev->dev, "Tegra PWM HW data not found\n");
+		return -ENODEV;
+	}
+
 	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
 	if (!pwm)
 		return -ENOMEM;
@@ -200,10 +211,11 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	}
 	reset_control_reset(pwm->rstc);
 
+	pwm->hw = hwdata;
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &tegra_pwm_ops;
 	pwm->chip.base = -1;
-	pwm->chip.npwm = NUM_PWM;
+	pwm->chip.npwm = pwm->hw->num_pwm;
 
 	ret = pwmchip_add(&pwm->chip);
 	if (ret < 0) {
@@ -222,7 +234,7 @@ static int tegra_pwm_remove(struct platform_device *pdev)
 	if (WARN_ON(!pc))
 		return -ENODEV;
 
-	for (i = 0; i < NUM_PWM; i++) {
+	for (i = 0; i < pc->hw->num_pwm; i++) {
 		struct pwm_device *pwm = &pc->chip.pwms[i];
 
 		if (!pwm_is_enabled(pwm))
@@ -237,9 +249,18 @@ static int tegra_pwm_remove(struct platform_device *pdev)
 	return pwmchip_remove(&pc->chip);
 }
 
+static const struct tegra_pwm_hwdata tegra20_pwm_hw = {
+	.num_pwm = 4,
+};
+
+static const struct tegra_pwm_hwdata tegra186_pwm_hw = {
+	.num_pwm = 1,
+};
+
 static const struct of_device_id tegra_pwm_of_match[] = {
-	{ .compatible = "nvidia,tegra20-pwm" },
-	{ .compatible = "nvidia,tegra30-pwm" },
+	{ .compatible = "nvidia,tegra20-pwm", .data = &tegra20_pwm_hw },
+	{ .compatible = "nvidia,tegra30-pwm", .data = &tegra20_pwm_hw },
+	{ .compatible = "nvidia,tegra186-pwm", .data = &tegra186_pwm_hw, },
 	{ }
 };
 
-- 
2.1.4
