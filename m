Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45132 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfJUK5q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 06:57:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id q13so8436523wrs.12
        for <linux-pwm@vger.kernel.org>; Mon, 21 Oct 2019 03:57:44 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 21 Oct 2019 12:57:37 +0200
Message-Id: <20191021105739.1357629-2-thierry.reding@gmail.com>
In-Reply-To: <20191021105739.1357629-1-thierry.reding@gmail.com>
References: <20191021105739.1357629-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH 2/4] pwm: cros-ec: Cache duty cycle value
To: Thierry Reding <thierry.reding@gmail.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pwm@vger.kernel.org

The ChromeOS embedded controller doesn't differentiate between disabled
and duty cycle being 0. In order not to potentially confuse consumers,
cache the duty cycle and return the cached value instead of the real
value when the PWM is disabled.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-cros-ec.c | 58 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 89497448d217..09c08dee099e 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -25,11 +25,39 @@ struct cros_ec_pwm_device {
 	struct pwm_chip chip;
 };
 
+/**
+ * struct cros_ec_pwm - per-PWM driver data
+ * @duty_cycle: cached duty cycle
+ */
+struct cros_ec_pwm {
+	u16 duty_cycle;
+};
+
 static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *c)
 {
 	return container_of(c, struct cros_ec_pwm_device, chip);
 }
 
+static int cros_ec_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct cros_ec_pwm *channel;
+
+	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
+	if (!channel)
+		return -ENOMEM;
+
+	pwm_set_chip_data(pwm, channel);
+
+	return 0;
+}
+
+static void cros_ec_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
+
+	kfree(channel);
+}
+
 static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
 {
 	struct {
@@ -96,7 +124,9 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			     const struct pwm_state *state)
 {
 	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
-	int duty_cycle;
+	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
+	u16 duty_cycle;
+	int ret;
 
 	/* The EC won't let us change the period */
 	if (state->period != EC_PWM_MAX_DUTY)
@@ -108,13 +138,20 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	duty_cycle = state->enabled ? state->duty_cycle : 0;
 
-	return cros_ec_pwm_set_duty(ec_pwm->ec, pwm->hwpwm, duty_cycle);
+	ret = cros_ec_pwm_set_duty(ec_pwm->ec, pwm->hwpwm, duty_cycle);
+	if (ret < 0)
+		return ret;
+
+	channel->duty_cycle = state->duty_cycle;
+
+	return 0;
 }
 
 static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 				  struct pwm_state *state)
 {
 	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
+	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
 	int ret;
 
 	ret = cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
@@ -126,8 +163,19 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	state->enabled = (ret > 0);
 	state->period = EC_PWM_MAX_DUTY;
 
-	/* Note that "disabled" and "duty cycle == 0" are treated the same */
-	state->duty_cycle = ret;
+	/*
+	 * Note that "disabled" and "duty cycle == 0" are treated the same. If
+	 * the cached duty cycle is not zero, used the cached duty cycle. This
+	 * ensures that the configured duty cycle is kept across a disable and
+	 * enable operation and avoids potentially confusing consumers.
+	 *
+	 * For the case of the initial hardware readout, channel->duty_cycle
+	 * will be 0 and the actual duty cycle read from the EC is used.
+	 */
+	if (ret == 0 && channel->duty_cycle > 0)
+		state->duty_cycle = channel->duty_cycle;
+	else
+		state->duty_cycle = ret;
 }
 
 static struct pwm_device *
@@ -149,6 +197,8 @@ cros_ec_pwm_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 }
 
 static const struct pwm_ops cros_ec_pwm_ops = {
+	.request = cros_ec_pwm_request,
+	.free = cros_ec_pwm_free,
 	.get_state	= cros_ec_pwm_get_state,
 	.apply		= cros_ec_pwm_apply,
 	.owner		= THIS_MODULE,
-- 
2.23.0
