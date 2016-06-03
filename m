From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 13/14] regulator: pwm: Support extra continuous mode cases
Date: Fri,  3 Jun 2016 10:23:11 +0200
Message-ID: <1464942192-25967-14-git-send-email-boris.brezillon@free-electrons.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Brian Norris <briannorris@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

The continuous mode allows one to declare a PWM regulator without having
to declare the voltage <-> dutycycle association table. It works fine as
long as your voltage(dutycycle) function is linear, but also has the
following constraints:

- dutycycle for min_uV = 0%
- dutycycle for max_uV = 100%
- dutycycle for min_uV < dutycycle for max_uV

While the linearity constraint is acceptable for now, we sometimes need to
restrict of the PWM range (to limit the maximum/minimum voltage for
example) or have a min_uV_dutycycle > max_uV_dutycycle (this could be
tweaked with PWM polarity, but not all PWMs support inverted polarity).

Add the pwm-dutycycle-range and pwm-dutycycle-unit DT properties to define
such constraints. If those properties are not defined, the PWM regulator
use the default pwm-dutycycle-range = <0 100> and
pwm-dutycycle-unit = <100> values (existing behavior).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/regulator/pwm-regulator.c | 80 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 71 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index c39ecd1..2e70eb1 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -21,6 +21,12 @@
 #include <linux/of_device.h>
 #include <linux/pwm.h>
 
+struct pwm_continuous_reg_data {
+	unsigned int min_uV_dutycycle;
+	unsigned int max_uV_dutycycle;
+	unsigned int dutycycle_unit;
+};
+
 struct pwm_regulator_data {
 	/*  Shared */
 	struct pwm_device *pwm;
@@ -28,6 +34,9 @@ struct pwm_regulator_data {
 	/* Voltage table */
 	struct pwm_voltages *duty_cycle_table;
 
+	/* Continuous mode info */
+	struct pwm_continuous_reg_data continuous;
+
 	/* regulator descriptor */
 	struct regulator_desc desc;
 
@@ -132,31 +141,67 @@ static int pwm_regulator_is_enabled(struct regulator_dev *dev)
 static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
+	unsigned int min_uV_duty = drvdata->continuous.min_uV_dutycycle;
+	unsigned int max_uV_duty = drvdata->continuous.max_uV_dutycycle;
+	unsigned int duty_unit = drvdata->continuous.dutycycle_unit;
 	int min_uV = rdev->constraints->min_uV;
-	int diff = rdev->constraints->max_uV - min_uV;
+	int max_uV = rdev->constraints->max_uV;
+	int diff_uV = max_uV - min_uV;
 	struct pwm_state pstate;
+	unsigned int diff_duty;
+	unsigned int voltage;
 
 	pwm_get_state(drvdata->pwm, &pstate);
 
-	return min_uV + pwm_get_relative_duty_cycle(&pstate, diff);
+	voltage = pwm_get_relative_duty_cycle(&pstate, duty_unit);
+
+	if (max_uV_duty < min_uV_duty) {
+		voltage = min_uV_duty - voltage;
+		diff_duty = min_uV_duty - max_uV_duty;
+	} else {
+		voltage = voltage - min_uV_duty;
+		diff_duty = max_uV_duty - min_uV_duty;
+	}
+
+	voltage = DIV_ROUND_CLOSEST_ULL((u64)voltage * diff_uV, diff_duty);
+
+	return voltage + min_uV;
 }
 
 static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
-					int min_uV, int max_uV,
-					unsigned *selector)
+				     int req_min_uV, int req_max_uV,
+				     unsigned int *selector)
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
+	unsigned int min_uV_duty = drvdata->continuous.min_uV_dutycycle;
+	unsigned int max_uV_duty = drvdata->continuous.max_uV_dutycycle;
+	unsigned int duty_unit = drvdata->continuous.dutycycle_unit;
 	unsigned int ramp_delay = rdev->constraints->ramp_delay;
-	unsigned int req_diff = min_uV - rdev->constraints->min_uV;
+	int min_uV = rdev->constraints->min_uV;
+	int max_uV = rdev->constraints->max_uV;
+	int diff_uV = max_uV - min_uV;
 	struct pwm_state pstate;
-	unsigned int diff;
+	unsigned int diff_duty;
+	unsigned int dutycycle;
 	int ret;
 
 	pwm_prepare_new_state(drvdata->pwm, &pstate);
-	diff = rdev->constraints->max_uV - rdev->constraints->min_uV;
 
-	/* We pass diff as the scale to get a uV precision. */
-	pwm_set_relative_duty_cycle(&pstate, req_diff, diff);
+	if (max_uV_duty < min_uV_duty)
+		diff_duty = min_uV_duty - max_uV_duty;
+	else
+		diff_duty = max_uV_duty - min_uV_duty;
+
+	dutycycle = DIV_ROUND_CLOSEST_ULL((u64)(req_min_uV - min_uV) *
+					  diff_duty,
+					  diff_uV);
+
+	if (max_uV_duty < min_uV_duty)
+		dutycycle = min_uV_duty - dutycycle;
+	else
+		dutycycle = min_uV_duty + dutycycle;
+
+	pwm_set_relative_duty_cycle(&pstate, dutycycle, duty_unit);
 
 	ret = pwm_apply_state(drvdata->pwm, &pstate);
 	if (ret) {
@@ -237,11 +282,28 @@ static int pwm_regulator_init_table(struct platform_device *pdev,
 static int pwm_regulator_init_continuous(struct platform_device *pdev,
 					 struct pwm_regulator_data *drvdata)
 {
+	u32 dutycycle_range[2] = { 0, 100 };
+	u32 dutycycle_unit = 100;
+
 	memcpy(&drvdata->ops, &pwm_regulator_voltage_continuous_ops,
 	       sizeof(drvdata->ops));
 	drvdata->desc.ops = &drvdata->ops;
 	drvdata->desc.continuous_voltage_range = true;
 
+	of_property_read_u32_array(pdev->dev.of_node,
+				   "pwm-dutycycle-range",
+				   dutycycle_range, 2);
+	of_property_read_u32(pdev->dev.of_node, "pwm-dutycycle-unit",
+			     &dutycycle_unit);
+
+	if (dutycycle_range[0] > dutycycle_unit ||
+	    dutycycle_range[1] > dutycycle_unit)
+		return -EINVAL;
+
+	drvdata->continuous.dutycycle_unit = dutycycle_unit;
+	drvdata->continuous.min_uV_dutycycle = dutycycle_range[0];
+	drvdata->continuous.max_uV_dutycycle = dutycycle_range[1];
+
 	return 0;
 }
 
-- 
2.7.4
