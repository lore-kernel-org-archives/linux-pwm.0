From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [RFC PATCH 01/15] pwm: add the pwm_is_enabled() helper
Date: Wed,  1 Jul 2015 10:21:47 +0200
Message-ID: <1435738921-25027-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-leds-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

Some PWM drivers are testing the PWMF_ENABLED flag. Create an helper
function to hide the logic behind enabled test.
This will allow us to smoothly move from the current approach to an atomic
PWM update approach.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/core.c            |  4 ++--
 drivers/pwm/pwm-atmel-tcb.c   |  2 +-
 drivers/pwm/pwm-atmel.c       |  6 +++---
 drivers/pwm/pwm-bcm-kona.c    |  4 ++--
 drivers/pwm/pwm-ep93xx.c      |  4 ++--
 drivers/pwm/pwm-imx.c         |  2 +-
 drivers/pwm/pwm-mxs.c         |  4 ++--
 drivers/pwm/pwm-renesas-tpu.c |  2 +-
 drivers/pwm/pwm-tegra.c       |  6 +++---
 drivers/pwm/pwm-tiecap.c      | 10 +++++-----
 drivers/pwm/pwm-tiehrpwm.c    |  6 +++---
 drivers/pwm/sysfs.c           |  2 +-
 include/linux/pwm.h           |  5 +++++
 13 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3a7769f..f7c11d2 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -455,7 +455,7 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
 	if (!pwm->chip->ops->set_polarity)
 		return -ENOSYS;
 
-	if (test_bit(PWMF_ENABLED, &pwm->flags))
+	if (pwm_is_enabled(pwm))
 		return -EBUSY;
 
 	err = pwm->chip->ops->set_polarity(pwm->chip, pwm, polarity);
@@ -853,7 +853,7 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 		if (test_bit(PWMF_REQUESTED, &pwm->flags))
 			seq_puts(s, " requested");
 
-		if (test_bit(PWMF_ENABLED, &pwm->flags))
+		if (pwm_is_enabled(pwm))
 			seq_puts(s, " enabled");
 
 		seq_puts(s, "\n");
diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index d14e067..6da01b3 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -347,7 +347,7 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	tcbpwm->duty = duty;
 
 	/* If the PWM is enabled, call enable to apply the new conf */
-	if (test_bit(PWMF_ENABLED, &pwm->flags))
+	if (pwm_is_enabled(pwm))
 		atmel_tcb_pwm_enable(chip, pwm);
 
 	return 0;
diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index a947c90..b3b294d 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -114,7 +114,7 @@ static int atmel_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	u32 val;
 	int ret;
 
-	if (test_bit(PWMF_ENABLED, &pwm->flags) && (period_ns != pwm->period)) {
+	if (pwm_is_enabled(pwm) && (period_ns != pwm->period)) {
 		dev_err(chip->dev, "cannot change PWM period while enabled\n");
 		return -EBUSY;
 	}
@@ -176,7 +176,7 @@ static void atmel_pwm_config_v1(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * If the PWM channel is enabled, only update CDTY by using the update
 	 * register, it needs to set bit 10 of CMR to 0
 	 */
-	if (test_bit(PWMF_ENABLED, &pwm->flags))
+	if (pwm_is_enabled(pwm))
 		return;
 	/*
 	 * If the PWM channel is disabled, write value to duty and period
@@ -191,7 +191,7 @@ static void atmel_pwm_config_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 
-	if (test_bit(PWMF_ENABLED, &pwm->flags)) {
+	if (pwm_is_enabled(pwm)) {
 		/*
 		 * If the PWM channel is enabled, using the duty update register
 		 * to update the value.
diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 7af8fea..dfdcf88 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -134,7 +134,7 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	/* If the PWM channel is enabled, write the settings to the HW */
-	if (test_bit(PWMF_ENABLED, &pwm->flags)) {
+	if (pwm_is_enabled(pwm)) {
 		value = readl(kp->base + PRESCALE_OFFSET);
 		value &= ~PRESCALE_MASK(chan);
 		value |= prescale << PRESCALE_SHIFT(chan);
@@ -287,7 +287,7 @@ static int kona_pwmc_remove(struct platform_device *pdev)
 	unsigned int chan;
 
 	for (chan = 0; chan < kp->chip.npwm; chan++)
-		if (test_bit(PWMF_ENABLED, &kp->chip.pwms[chan].flags))
+		if (pwm_is_enabled(&kp->chip.pwms[chan]))
 			clk_disable_unprepare(kp->clk);
 
 	return pwmchip_remove(&kp->chip);
diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index e593e9c..bbf10ae 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -82,7 +82,7 @@ static int ep93xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * The clock needs to be enabled to access the PWM registers.
 	 * Configuration can be changed at any time.
 	 */
-	if (!test_bit(PWMF_ENABLED, &pwm->flags)) {
+	if (!pwm_is_enabled(pwm)) {
 		ret = clk_enable(ep93xx_pwm->clk);
 		if (ret)
 			return ret;
@@ -113,7 +113,7 @@ static int ep93xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		ret = -EINVAL;
 	}
 
-	if (!test_bit(PWMF_ENABLED, &pwm->flags))
+	if (!pwm_is_enabled(pwm))
 		clk_disable(ep93xx_pwm->clk);
 
 	return ret;
diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 66d6f0c..008dc64 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -114,7 +114,7 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 	unsigned long long c;
 	unsigned long period_cycles, duty_cycles, prescale;
 	unsigned int period_ms;
-	bool enable = test_bit(PWMF_ENABLED, &pwm->flags);
+	bool enable = pwm_is_enabled(pwm);
 	int wait_count = 0, fifoav;
 	u32 cr, sr;
 
diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index b430811..9a59632 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -77,7 +77,7 @@ static int mxs_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * If the PWM channel is disabled, make sure to turn on the clock
 	 * before writing the register. Otherwise, keep it enabled.
 	 */
-	if (!test_bit(PWMF_ENABLED, &pwm->flags)) {
+	if (!pwm_is_enabled(pwm)) {
 		ret = clk_prepare_enable(mxs->clk);
 		if (ret)
 			return ret;
@@ -92,7 +92,7 @@ static int mxs_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	/*
 	 * If the PWM is not enabled, turn the clock off again to save power.
 	 */
-	if (!test_bit(PWMF_ENABLED, &pwm->flags))
+	if (!pwm_is_enabled(pwm))
 		clk_disable_unprepare(mxs->clk);
 
 	return 0;
diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index ee63f9e..075c1a7 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -301,7 +301,7 @@ static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *_pwm,
 	pwm->duty = duty;
 
 	/* If the channel is disabled we're done. */
-	if (!test_bit(PWMF_ENABLED, &_pwm->flags))
+	if (!pwm_is_enabled(_pwm))
 		return 0;
 
 	if (duty_only && pwm->timer_on) {
diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index cabd7d8..d4de060 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -112,7 +112,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * If the PWM channel is disabled, make sure to turn on the clock
 	 * before writing the register. Otherwise, keep it enabled.
 	 */
-	if (!test_bit(PWMF_ENABLED, &pwm->flags)) {
+	if (!pwm_is_enabled(pwm)) {
 		err = clk_prepare_enable(pc->clk);
 		if (err < 0)
 			return err;
@@ -124,7 +124,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	/*
 	 * If the PWM is not enabled, turn the clock off again to save power.
 	 */
-	if (!test_bit(PWMF_ENABLED, &pwm->flags))
+	if (!pwm_is_enabled(pwm))
 		clk_disable_unprepare(pc->clk);
 
 	return 0;
@@ -214,7 +214,7 @@ static int tegra_pwm_remove(struct platform_device *pdev)
 	for (i = 0; i < NUM_PWM; i++) {
 		struct pwm_device *pwm = &pc->chip.pwms[i];
 
-		if (!test_bit(PWMF_ENABLED, &pwm->flags))
+		if (!pwm_is_enabled(pwm))
 			if (clk_prepare_enable(pc->clk) < 0)
 				continue;
 
diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index e557bef..616af76 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -97,7 +97,7 @@ static int ecap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	writew(reg_val, pc->mmio_base + ECCTL2);
 
-	if (!test_bit(PWMF_ENABLED, &pwm->flags)) {
+	if (!pwm_is_enabled(pwm)) {
 		/* Update active registers if not running */
 		writel(duty_cycles, pc->mmio_base + CAP2);
 		writel(period_cycles, pc->mmio_base + CAP1);
@@ -111,7 +111,7 @@ static int ecap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		writel(period_cycles, pc->mmio_base + CAP3);
 	}
 
-	if (!test_bit(PWMF_ENABLED, &pwm->flags)) {
+	if (!pwm_is_enabled(pwm)) {
 		reg_val = readw(pc->mmio_base + ECCTL2);
 		/* Disable APWM mode to put APWM output Low */
 		reg_val &= ~ECCTL2_APWM_MODE;
@@ -179,7 +179,7 @@ static void ecap_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 static void ecap_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	if (test_bit(PWMF_ENABLED, &pwm->flags)) {
+	if (pwm_is_enabled(pwm)) {
 		dev_warn(chip->dev, "Removing PWM device without disabling\n");
 		pm_runtime_put_sync(chip->dev);
 	}
@@ -306,7 +306,7 @@ static int ecap_pwm_suspend(struct device *dev)
 	ecap_pwm_save_context(pc);
 
 	/* Disable explicitly if PWM is running */
-	if (test_bit(PWMF_ENABLED, &pwm->flags))
+	if (pwm_is_enabled(pwm))
 		pm_runtime_put_sync(dev);
 
 	return 0;
@@ -318,7 +318,7 @@ static int ecap_pwm_resume(struct device *dev)
 	struct pwm_device *pwm = pc->chip.pwms;
 
 	/* Enable explicitly if PWM was running */
-	if (test_bit(PWMF_ENABLED, &pwm->flags))
+	if (pwm_is_enabled(pwm))
 		pm_runtime_get_sync(dev);
 
 	ecap_pwm_restore_context(pc);
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 694b3cf..6a41e66 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -407,7 +407,7 @@ static void ehrpwm_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
 
-	if (test_bit(PWMF_ENABLED, &pwm->flags)) {
+	if (pwm_is_enabled(pwm)) {
 		dev_warn(chip->dev, "Removing PWM device without disabling\n");
 		pm_runtime_put_sync(chip->dev);
 	}
@@ -565,7 +565,7 @@ static int ehrpwm_pwm_suspend(struct device *dev)
 	for (i = 0; i < pc->chip.npwm; i++) {
 		struct pwm_device *pwm = &pc->chip.pwms[i];
 
-		if (!test_bit(PWMF_ENABLED, &pwm->flags))
+		if (!pwm_is_enabled(pwm))
 			continue;
 
 		/* Disable explicitly if PWM is running */
@@ -582,7 +582,7 @@ static int ehrpwm_pwm_resume(struct device *dev)
 	for (i = 0; i < pc->chip.npwm; i++) {
 		struct pwm_device *pwm = &pc->chip.pwms[i];
 
-		if (!test_bit(PWMF_ENABLED, &pwm->flags))
+		if (!pwm_is_enabled(pwm))
 			continue;
 
 		/* Enable explicitly if PWM was running */
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 4bd0c63..eecf21d 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -97,7 +97,7 @@ static ssize_t pwm_enable_show(struct device *child,
 			       char *buf)
 {
 	const struct pwm_device *pwm = child_to_pwm_device(child);
-	int enabled = test_bit(PWMF_ENABLED, &pwm->flags);
+	int enabled = pwm_is_enabled(pwm);
 
 	return sprintf(buf, "%d\n", enabled);
 }
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 36262d0..ec34f4d 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -92,6 +92,11 @@ struct pwm_device {
 	enum pwm_polarity	polarity;
 };
 
+static inline bool pwm_is_enabled(const struct pwm_device *pwm)
+{
+	return test_bit(PWMF_ENABLED, &pwm->flags);
+}
+
 static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
 {
 	if (pwm)
-- 
1.9.1
