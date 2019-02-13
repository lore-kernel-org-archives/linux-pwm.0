From: Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v2 3/3] pwm: hibvt: Add hi3559v100 support
Date: Wed, 13 Feb 2019 16:05:08 +0100
Message-ID: <20190213150508.11499-3-m.othacehe@gmail.com>
References: <20190213150508.11499-1-m.othacehe@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213150508.11499-1-m.othacehe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mathieu Othacehe <m.othacehe@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Add support for hi3559v100-shub-pwm and hisilicon,hi3559v100-pwm
platforms. They require a special quirk: pwm has to be enabled again
to force duty_cycle refresh.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/pwm/pwm-hibvt.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index ffc803818c3c..b6a7942b3367 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -54,6 +54,7 @@ struct hibvt_pwm_chip {
 
 struct hibvt_pwm_soc {
 	u32 num_pwms;
+	bool quirk_force_enable;
 };
 
 static const struct hibvt_pwm_soc hi3516cv300_soc_info = {
@@ -64,6 +65,16 @@ static const struct hibvt_pwm_soc hi3519v100_soc_info = {
 	.num_pwms = 8,
 };
 
+static const struct hibvt_pwm_soc hi3559v100_shub_soc_info = {
+	.num_pwms = 8,
+	.quirk_force_enable = true,
+};
+
+static const struct hibvt_pwm_soc hi3559v100_soc_info = {
+	.num_pwms = 2,
+	.quirk_force_enable = true,
+};
+
 static inline struct hibvt_pwm_chip *to_hibvt_pwm_chip(struct pwm_chip *chip)
 {
 	return container_of(chip, struct hibvt_pwm_chip, chip);
@@ -152,13 +163,24 @@ static void hibvt_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
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
 
+		/*
+		 * On those platforms, it is required to enable the
+		 * pwm again each time we want to refresh the duty
+		 * cycle.
+		 */
+		if (hi_pwm_chip->soc->quirk_force_enable && state->enabled)
+			hibvt_pwm_enable(chip, pwm);
+	}
+
 	if (state->enabled != pwm->state.enabled) {
 		if (state->enabled)
 			hibvt_pwm_enable(chip, pwm);
@@ -259,6 +281,10 @@ static const struct of_device_id hibvt_pwm_of_match[] = {
 	  .data = &hi3516cv300_soc_info },
 	{ .compatible = "hisilicon,hi3519v100-pwm",
 	  .data = &hi3519v100_soc_info },
+	{ .compatible = "hisilicon,hi3559v100-shub-pwm",
+	  .data = &hi3559v100_shub_soc_info },
+	{ .compatible = "hisilicon,hi3559v100-pwm",
+	  .data = &hi3559v100_soc_info },
 	{  }
 };
 MODULE_DEVICE_TABLE(of, hibvt_pwm_of_match);
-- 
2.17.1
