From: Jonathan Richardson <jonathar@broadcom.com>
Subject: [PATCH v7 3/5] pwm: kona: Fix incorrect config, disable, and polarity procedures
Date: Tue, 12 May 2015 16:28:14 -0700
Message-ID: <1431473296-13683-4-git-send-email-jonathar@broadcom.com>
References: <1431473296-13683-1-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431473296-13683-1-git-send-email-jonathar@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Scott Branden <sbranden@broadcom.com>, Jonathan Richardson <jonathar@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

The config procedure didn't follow the spec which periodically resulted
in failing to enable the output signal. This happened one in ten or
twenty attempts. Following the spec and adding a 400ns delay in the
appropriate locations resolves this problem.

The disable procedure now also follows the spec. The old disable
procedure would result in no change in signal when called.

The polarity procedure no longer applies the settings to change the
output signal because it can't be called when the pwm is enabled anyway.
The polarity is only updated in the control register. The correct
polarity will be applied on enable. The old method of applying changes
would result in no signal when the polarity was changed. The new
apply_settings function would fix this problem but it isn't required
anyway.

Reviewed-by: Arun Ramamurthy <arunrama@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
Tested-by: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
---
 drivers/pwm/pwm-bcm-kona.c |   47 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 32b3ec6..0654981 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -76,19 +76,36 @@ static inline struct kona_pwmc *to_kona_pwmc(struct pwm_chip *_chip)
 	return container_of(_chip, struct kona_pwmc, chip);
 }
 
-static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
+/*
+ * Clear trigger bit but set smooth bit to maintain old output.
+ */
+static void kona_pwmc_prepare_for_settings(struct kona_pwmc *kp,
+	unsigned int chan)
 {
 	unsigned int value = readl(kp->base + PWM_CONTROL_OFFSET);
 
-	/* Clear trigger bit but set smooth bit to maintain old output */
 	value |= 1 << PWM_CONTROL_SMOOTH_SHIFT(chan);
 	value &= ~(1 << PWM_CONTROL_TRIGGER_SHIFT(chan));
 	writel(value, kp->base + PWM_CONTROL_OFFSET);
 
+	/*
+	 * There must be a min 400ns delay between clearing enable and setting
+	 * it. Failing to do this may result in no PWM signal.
+	 */
+	ndelay(400);
+}
+
+static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
+{
+	unsigned int value = readl(kp->base + PWM_CONTROL_OFFSET);
+
 	/* Set trigger bit and clear smooth bit to apply new settings */
 	value &= ~(1 << PWM_CONTROL_SMOOTH_SHIFT(chan));
 	value |= 1 << PWM_CONTROL_TRIGGER_SHIFT(chan);
 	writel(value, kp->base + PWM_CONTROL_OFFSET);
+
+	/* PWMOUT_ENABLE must be held high for at least 400 ns. */
+	ndelay(400);
 }
 
 static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -133,8 +150,14 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			return -EINVAL;
 	}
 
-	/* If the PWM channel is enabled, write the settings to the HW */
+	/*
+	 * Don't apply settings if disabled. The period and duty cycle are
+	 * always calculated above to ensure the new values are
+	 * validated immediately instead of on enable.
+	 */
 	if (test_bit(PWMF_ENABLED, &pwm->flags)) {
+		kona_pwmc_prepare_for_settings(kp, chan);
+
 		value = readl(kp->base + PRESCALE_OFFSET);
 		value &= ~PRESCALE_MASK(chan);
 		value |= prescale << PRESCALE_SHIFT(chan);
@@ -173,11 +196,6 @@ static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	writel(value, kp->base + PWM_CONTROL_OFFSET);
 
-	kona_pwmc_apply_settings(kp, chan);
-
-	/* Wait for waveform to settle before gating off the clock */
-	ndelay(400);
-
 	clk_disable_unprepare(kp->clk);
 
 	return 0;
@@ -207,13 +225,20 @@ static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct kona_pwmc *kp = to_kona_pwmc(chip);
 	unsigned int chan = pwm->hwpwm;
+	unsigned int value;
+
+	kona_pwmc_prepare_for_settings(kp, chan);
 
 	/* Simulate a disable by configuring for zero duty */
 	writel(0, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
-	kona_pwmc_apply_settings(kp, chan);
+	writel(0, kp->base + PERIOD_COUNT_OFFSET(chan));
 
-	/* Wait for waveform to settle before gating off the clock */
-	ndelay(400);
+	/* Set prescale to 0 for this channel */
+	value = readl(kp->base + PRESCALE_OFFSET);
+	value &= ~PRESCALE_MASK(chan);
+	writel(value, kp->base + PRESCALE_OFFSET);
+
+	kona_pwmc_apply_settings(kp, chan);
 
 	clk_disable_unprepare(kp->clk);
 }
-- 
1.7.9.5
