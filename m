From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 11/13] regulator: pwm: Retrieve correct voltage
Date: Wed,  8 Jun 2016 18:34:46 +0200
Message-ID: <1465403688-17098-12-git-send-email-boris.brezillon@free-electrons.com>
References: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Brian Norris <briannorris@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com, Laxman Dewangan <ldewangan@nvidia.com>, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

The continuous PWM voltage regulator is caching the voltage value in
the ->volt_uV field. While most of the time this value should reflect the
real voltage, sometime it can be sightly different if the PWM device
rounded the set_duty_cycle request.
Moreover, this value is not valid until someone has modified the regulator
output.

Remove the ->volt_uV field and always rely on the PWM state to calculate
the regulator output.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>
---
Mark,

I know you already added your Tested-by/Acked-by tags on this patch
but this version has slightly change and is now making use of the
pwm_get_relative_duty_cycle() helper instead of manually converting
the absolute duty_cycle value into a relative one.
---
 drivers/regulator/pwm-regulator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 8c56e16..c39ecd1 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -35,9 +35,6 @@ struct pwm_regulator_data {
 	struct regulator_ops ops;
 
 	int state;
-
-	/* Continuous voltage */
-	int volt_uV;
 };
 
 struct pwm_voltages {
@@ -135,8 +132,13 @@ static int pwm_regulator_is_enabled(struct regulator_dev *dev)
 static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
+	int min_uV = rdev->constraints->min_uV;
+	int diff = rdev->constraints->max_uV - min_uV;
+	struct pwm_state pstate;
 
-	return drvdata->volt_uV;
+	pwm_get_state(drvdata->pwm, &pstate);
+
+	return min_uV + pwm_get_relative_duty_cycle(&pstate, diff);
 }
 
 static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
@@ -162,8 +164,6 @@ static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
 		return ret;
 	}
 
-	drvdata->volt_uV = min_uV;
-
 	/* Delay required by PWM regulator to settle to the new voltage */
 	usleep_range(ramp_delay, ramp_delay + 1000);
 
-- 
2.7.4
