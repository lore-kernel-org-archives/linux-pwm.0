From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [RFC PATCH 04/15] pwm: make use of pwm_get_xxx helpers where appropriate
Date: Wed,  1 Jul 2015 10:21:50 +0200
Message-ID: <1435738921-25027-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:34285 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752950AbbGAIWP (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Jul 2015 04:22:15 -0400
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>, Boris Brezillon <boris.brezillon@free-electrons.com>

Use the pwm_get_xxx helpers instead of directly accessing the fields in
pwm_device. This will allow us to smoothly move to the atomic update
approach.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/pwm-atmel.c    |  2 +-
 drivers/pwm/pwm-bcm-kona.c |  3 ++-
 drivers/pwm/pwm-imx.c      |  3 ++-
 drivers/pwm/pwm-rockchip.c |  2 +-
 drivers/pwm/sysfs.c        | 11 ++++++-----
 5 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index b3b294d..0e4bd4e 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -114,7 +114,7 @@ static int atmel_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	u32 val;
 	int ret;
 
-	if (pwm_is_enabled(pwm) && (period_ns != pwm->period)) {
+	if (pwm_is_enabled(pwm) && (period_ns != pwm_get_period(pwm))) {
 		dev_err(chip->dev, "cannot change PWM period while enabled\n");
 		return -EBUSY;
 	}
diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index dfdcf88..920cd1b 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -194,7 +194,8 @@ static int kona_pwmc_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 		return ret;
 	}
 
-	ret = kona_pwmc_config(chip, pwm, pwm->duty_cycle, pwm->period);
+	ret = kona_pwmc_config(chip, pwm, pwm_get_duty_cycle(pwm),
+			       pwm_get_period(pwm));
 	if (ret < 0) {
 		clk_disable_unprepare(kp->clk);
 		return ret;
diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 008dc64..d600fd5 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -129,7 +129,8 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 		sr = readl(imx->mmio_base + MX3_PWMSR);
 		fifoav = sr & MX3_PWMSR_FIFOAV_MASK;
 		if (fifoav == MX3_PWMSR_FIFOAV_4WORDS) {
-			period_ms = DIV_ROUND_UP(pwm->period, NSEC_PER_MSEC);
+			period_ms = DIV_ROUND_UP(pwm_get_period(pwm),
+						 NSEC_PER_MSEC);
 			msleep(period_ms);
 
 			sr = readl(imx->mmio_base + MX3_PWMSR);
diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 9442df2..7d9cc90 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -83,7 +83,7 @@ static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip,
 			  PWM_CONTINUOUS;
 	u32 val;
 
-	if (pwm->polarity == PWM_POLARITY_INVERSED)
+	if (pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED)
 		enable_conf |= PWM_DUTY_NEGATIVE | PWM_INACTIVE_POSITIVE;
 	else
 		enable_conf |= PWM_DUTY_POSITIVE | PWM_INACTIVE_NEGATIVE;
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index eecf21d..ac0abec 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -46,7 +46,7 @@ static ssize_t pwm_period_show(struct device *child,
 {
 	const struct pwm_device *pwm = child_to_pwm_device(child);
 
-	return sprintf(buf, "%u\n", pwm->period);
+	return sprintf(buf, "%u\n", pwm_get_period(pwm));
 }
 
 static ssize_t pwm_period_store(struct device *child,
@@ -61,7 +61,7 @@ static ssize_t pwm_period_store(struct device *child,
 	if (ret)
 		return ret;
 
-	ret = pwm_config(pwm, pwm->duty_cycle, val);
+	ret = pwm_config(pwm, pwm_get_duty_cycle(pwm), val);
 
 	return ret ? : size;
 }
@@ -72,7 +72,7 @@ static ssize_t pwm_duty_cycle_show(struct device *child,
 {
 	const struct pwm_device *pwm = child_to_pwm_device(child);
 
-	return sprintf(buf, "%u\n", pwm->duty_cycle);
+	return sprintf(buf, "%u\n", pwm_get_duty_cycle(pwm));
 }
 
 static ssize_t pwm_duty_cycle_store(struct device *child,
@@ -87,7 +87,7 @@ static ssize_t pwm_duty_cycle_store(struct device *child,
 	if (ret)
 		return ret;
 
-	ret = pwm_config(pwm, val, pwm->period);
+	ret = pwm_config(pwm, val, pwm_get_period(pwm));
 
 	return ret ? : size;
 }
@@ -134,7 +134,8 @@ static ssize_t pwm_polarity_show(struct device *child,
 {
 	const struct pwm_device *pwm = child_to_pwm_device(child);
 
-	return sprintf(buf, "%s\n", pwm->polarity ? "inversed" : "normal");
+	return sprintf(buf, "%s\n",
+		       pwm_get_polarity(pwm) ? "inversed" : "normal");
 }
 
 static ssize_t pwm_polarity_store(struct device *child,
-- 
1.9.1
