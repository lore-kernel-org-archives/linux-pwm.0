From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] pwm: pwm-samsung: switch to new atomic PWM API
Date: Mon, 24 Apr 2017 15:13:18 +0200
Message-ID: <1493039598-25881-2-git-send-email-b.zolnierkie@samsung.com>
References: <1493039598-25881-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170424131346epcas1p4584c5e78edfe5055beaba0ce0f5e5ae7@epcas1p4.samsung.com>
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-reply-to: <1493039598-25881-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-hwmon-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Kamil Debski <kamil@wypas.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pwm@vger.kernel.org

Switch pwm-samsung driver to new atomic PWM API.

This is an initial conversion (based on the PWM core's
pwm_apply_state() implementation) which can be improved
later.

There should be no functional changes caused by this
patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Depends on "[PATCH v2 0/3] pwm: pwm-samsung: fix suspend/resume support"
patchset (https://www.spinics.net/lists/kernel/msg2495209.html).

 drivers/pwm/pwm-samsung.c | 59 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 062f2cf..09868a9 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -241,7 +241,7 @@ static void pwm_samsung_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	pwm_set_chip_data(pwm, NULL);
 }
 
-static int pwm_samsung_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+static void pwm_samsung_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
 	unsigned int tcon_chan = to_tcon_channel(pwm->hwpwm);
@@ -263,8 +263,6 @@ static int pwm_samsung_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	our_chip->disabled_mask &= ~BIT(pwm->hwpwm);
 
 	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
-
-	return 0;
 }
 
 static void pwm_samsung_disable(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -385,12 +383,6 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
-static int pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			      int duty_ns, int period_ns)
-{
-	return __pwm_samsung_config(chip, pwm, duty_ns, period_ns, false);
-}
-
 static void pwm_samsung_set_invert(struct samsung_pwm_chip *chip,
 				   unsigned int channel, bool invert)
 {
@@ -415,7 +407,7 @@ static void pwm_samsung_set_invert(struct samsung_pwm_chip *chip,
 	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
 
-static int pwm_samsung_set_polarity(struct pwm_chip *chip,
+static void pwm_samsung_set_polarity(struct pwm_chip *chip,
 				    struct pwm_device *pwm,
 				    enum pwm_polarity polarity)
 {
@@ -424,6 +416,48 @@ static int pwm_samsung_set_polarity(struct pwm_chip *chip,
 
 	/* Inverted means normal in the hardware. */
 	pwm_samsung_set_invert(our_chip, pwm->hwpwm, invert);
+}
+
+static int pwm_samsung_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     struct pwm_state *state)
+{
+	int err;
+
+	/*
+	 * FIXME: restore the initial state in case of error.
+	 */
+	if (state->polarity != pwm->state.polarity) {
+		if (pwm->state.enabled) {
+			pwm_samsung_disable(pwm->chip, pwm);
+			pwm->state.enabled = false;
+		}
+
+		pwm_samsung_set_polarity(pwm->chip, pwm,
+					 state->polarity);
+
+		pwm->state.polarity = state->polarity;
+	}
+
+	if (state->period != pwm->state.period ||
+	    state->duty_cycle != pwm->state.duty_cycle) {
+		err = __pwm_samsung_config(pwm->chip, pwm,
+					   state->duty_cycle,
+					   state->period, false);
+		if (err)
+			return err;
+
+		pwm->state.duty_cycle = state->duty_cycle;
+		pwm->state.period = state->period;
+	}
+
+	if (state->enabled != pwm->state.enabled) {
+		if (state->enabled)
+			pwm_samsung_enable(pwm->chip, pwm);
+		else
+			pwm_samsung_disable(pwm->chip, pwm);
+
+		pwm->state.enabled = state->enabled;
+	}
 
 	return 0;
 }
@@ -431,10 +465,7 @@ static int pwm_samsung_set_polarity(struct pwm_chip *chip,
 static const struct pwm_ops pwm_samsung_ops = {
 	.request	= pwm_samsung_request,
 	.free		= pwm_samsung_free,
-	.enable		= pwm_samsung_enable,
-	.disable	= pwm_samsung_disable,
-	.config		= pwm_samsung_config,
-	.set_polarity	= pwm_samsung_set_polarity,
+	.apply		= pwm_samsung_apply,
 	.owner		= THIS_MODULE,
 };
 
-- 
1.9.1

