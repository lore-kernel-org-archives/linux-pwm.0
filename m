From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 09/13] regulator: pwm: Switch to the atomic PWM API
Date: Wed,  8 Jun 2016 18:34:44 +0200
Message-ID: <1465403688-17098-10-git-send-email-boris.brezillon@free-electrons.com>
References: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Brian Norris <briannorris@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com, Laxman Dewangan <ldewangan@nvidia.com>, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

Use the atomic API wherever appropriate and get rid of pwm_apply_args()
call (the reference period and polarity are now explicitly set when
calling pwm_apply_state()).

We also make use of the pwm_set_relative_duty_cycle() helper to ease
relative to absolute duty_cycle conversion.

Note that changes introduced by commit fd786fb0276a ("regulator: pwm:
Try to avoid voltage error in duty cycle calculation") are no longer
needed because pwm_set_relative_duty_cycle() takes care of all rounding
approximation for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>
Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/regulator/pwm-regulator.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 524b43f..bf033fd 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -59,16 +59,14 @@ static int pwm_regulator_set_voltage_sel(struct regulator_dev *rdev,
 					 unsigned selector)
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
-	struct pwm_args pargs;
-	int dutycycle;
+	struct pwm_state pstate;
 	int ret;
 
-	pwm_get_args(drvdata->pwm, &pargs);
+	pwm_prepare_new_state(drvdata->pwm, &pstate);
+	pwm_set_relative_duty_cycle(&pstate,
+			drvdata->duty_cycle_table[selector].dutycycle, 100);
 
-	dutycycle = (pargs.period *
-		    drvdata->duty_cycle_table[selector].dutycycle) / 100;
-
-	ret = pwm_config(drvdata->pwm, dutycycle, pargs.period);
+	ret = pwm_apply_state(drvdata->pwm, &pstate);
 	if (ret) {
 		dev_err(&rdev->dev, "Failed to configure PWM: %d\n", ret);
 		return ret;
@@ -126,34 +124,18 @@ static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
 	unsigned int ramp_delay = rdev->constraints->ramp_delay;
-	struct pwm_args pargs;
 	unsigned int req_diff = min_uV - rdev->constraints->min_uV;
+	struct pwm_state pstate;
 	unsigned int diff;
-	unsigned int duty_pulse;
-	u64 req_period;
-	u32 rem;
 	int ret;
 
-	pwm_get_args(drvdata->pwm, &pargs);
+	pwm_prepare_new_state(drvdata->pwm, &pstate);
 	diff = rdev->constraints->max_uV - rdev->constraints->min_uV;
 
-	/* First try to find out if we get the iduty cycle time which is
-	 * factor of PWM period time. If (request_diff_to_min * pwm_period)
-	 * is perfect divided by voltage_range_diff then it is possible to
-	 * get duty cycle time which is factor of PWM period. This will help
-	 * to get output voltage nearer to requested value as there is no
-	 * calculation loss.
-	 */
-	req_period = req_diff * pargs.period;
-	div_u64_rem(req_period, diff, &rem);
-	if (!rem) {
-		do_div(req_period, diff);
-		duty_pulse = (unsigned int)req_period;
-	} else {
-		duty_pulse = (pargs.period / 100) * ((req_diff * 100) / diff);
-	}
+	/* We pass diff as the scale to get a uV precision. */
+	pwm_set_relative_duty_cycle(&pstate, req_diff, diff);
 
-	ret = pwm_config(drvdata->pwm, duty_pulse, pargs.period);
+	ret = pwm_apply_state(drvdata->pwm, &pstate);
 	if (ret) {
 		dev_err(&rdev->dev, "Failed to configure PWM: %d\n", ret);
 		return ret;
-- 
2.7.4
