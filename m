From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [RFC PATCH 14/15] regulator: pwm: implement ->enable(), ->disable() and ->is_enabled methods
Date: Wed,  1 Jul 2015 10:22:00 +0200
Message-ID: <1435738921-25027-15-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:34437 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753481AbbGAIWe (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Jul 2015 04:22:34 -0400
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>, Boris Brezillon <boris.brezillon@free-electrons.com>

Implement the ->enable(), ->disable() and ->is_enabled methods and remove
the PWM call in ->set_voltage_sel().
This is particularly important for critical regulators tagged as always-on,
because not claiming the PWM (and its dependencies) might lead to
unpredictable behavior (like a system hang because the PWM clk is only
claimed when the PWM device is enabled).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/regulator/pwm-regulator.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 12b4d9d..8159518 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -59,12 +59,6 @@ static int pwm_regulator_set_voltage_sel(struct regulator_dev *rdev,
 
 	drvdata->state = selector;
 
-	ret = pwm_enable(drvdata->pwm);
-	if (ret) {
-		dev_err(&rdev->dev, "Failed to enable PWM\n");
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -79,11 +73,37 @@ static int pwm_regulator_list_voltage(struct regulator_dev *rdev,
 	return drvdata->duty_cycle_table[selector].uV;
 }
 
+static int pwm_regulator_enable(struct regulator_dev *dev)
+{
+	struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
+
+	return pwm_enable(drvdata->pwm);
+}
+
+static int pwm_regulator_disable(struct regulator_dev *dev)
+{
+	struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
+
+	pwm_disable(drvdata->pwm);
+
+	return 0;
+}
+
+static int pwm_regulator_is_enabled(struct regulator_dev *dev)
+{
+       struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
+
+       return pwm_is_enabled(drvdata->pwm);
+}
+
 static struct regulator_ops pwm_regulator_voltage_ops = {
 	.set_voltage_sel = pwm_regulator_set_voltage_sel,
 	.get_voltage_sel = pwm_regulator_get_voltage_sel,
 	.list_voltage    = pwm_regulator_list_voltage,
 	.map_voltage     = regulator_map_voltage_iterate,
+	.enable          = pwm_regulator_enable,
+	.disable         = pwm_regulator_disable,
+	.is_enabled      = pwm_regulator_is_enabled,
 };
 
 static struct regulator_desc pwm_regulator_desc = {
-- 
1.9.1
