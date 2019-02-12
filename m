From: Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH 2/2] pwm: hibvt: Add hi3559v100 support
Date: Tue, 12 Feb 2019 10:49:27 +0100
Message-ID: <20190212094927.5900-2-m.othacehe@gmail.com>
References: <20190212094927.5900-1-m.othacehe@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212094927.5900-1-m.othacehe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mathieu Othacehe <m.othacehe@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Add support for hi3559v100-shub-pwm and hisilicon,hi3559v100-pwm
platforms. They require a special quirk: pwm has to be enabled again
to force duty_cycle refresh.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/pwm/pwm-hibvt.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index 27c107e78d59..bf33aa24433c 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -49,6 +49,7 @@ struct hibvt_pwm_chip {
 	struct clk *clk;
 	void __iomem *base;
 	struct reset_control *rstc;
+	bool quirk_force_enable;
 };
 
 struct hibvt_pwm_soc {
@@ -56,6 +57,7 @@ struct hibvt_pwm_soc {
 };
 
 static const struct hibvt_pwm_soc pwm_soc[2] = {
+	{ .num_pwms = 2 },
 	{ .num_pwms = 4 },
 	{ .num_pwms = 8 },
 };
@@ -148,13 +150,19 @@ static void hibvt_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 static int hibvt_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 				struct pwm_state *state)
 {
+	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
+
 	if (state->polarity != pwm->state.polarity)
 		hibvt_pwm_set_polarity(chip, pwm, state->polarity);
 
 	if (state->period != pwm->state.period ||
-		state->duty_cycle != pwm->state.duty_cycle)
+		state->duty_cycle != pwm->state.duty_cycle) {
 		hibvt_pwm_config(chip, pwm, state->duty_cycle, state->period);
 
+		if (hi_pwm_chip->quirk_force_enable && state->enabled)
+			hibvt_pwm_enable(chip, pwm);
+	}
+
 	if (state->enabled != pwm->state.enabled) {
 		if (state->enabled)
 			hibvt_pwm_enable(chip, pwm);
@@ -176,6 +184,7 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 {
 	const struct hibvt_pwm_soc *soc =
 				of_device_get_match_data(&pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
 	struct hibvt_pwm_chip *pwm_chip;
 	struct resource *res;
 	int ret;
@@ -199,6 +208,15 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 	pwm_chip->chip.of_xlate = of_pwm_xlate_with_flags;
 	pwm_chip->chip.of_pwm_n_cells = 3;
 
+	/*
+	 * On those platforms, it is required to enable the
+	 * pwm again each time we want to refresh the duty
+	 * cycle.
+	 */
+	if (of_device_is_compatible(np, "hisilicon,hi3559v100-shub-pwm") ||
+		of_device_is_compatible(np, "hisilicon,hi3559v100-pwm"))
+		pwm_chip->quirk_force_enable = true;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pwm_chip->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(pwm_chip->base))
@@ -250,8 +268,10 @@ static int hibvt_pwm_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id hibvt_pwm_of_match[] = {
-	{ .compatible = "hisilicon,hi3516cv300-pwm", .data = &pwm_soc[0] },
-	{ .compatible = "hisilicon,hi3519v100-pwm", .data = &pwm_soc[1] },
+	{ .compatible = "hisilicon,hi3516cv300-pwm", .data = &pwm_soc[1] },
+	{ .compatible = "hisilicon,hi3519v100-pwm", .data = &pwm_soc[2] },
+	{ .compatible = "hisilicon,hi3559v100-shub-pwm", .data = &pwm_soc[2] },
+	{ .compatible = "hisilicon,hi3559v100-pwm", .data = &pwm_soc[0] },
 	{  }
 };
 MODULE_DEVICE_TABLE(of, hibvt_pwm_of_match);
-- 
2.17.1
