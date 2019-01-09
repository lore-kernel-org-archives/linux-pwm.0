Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:5297 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729334AbfAIIWA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Jan 2019 03:22:00 -0500
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed,  9 Jan 2019 17:19:05 +0900
Message-Id: <1547021948-7664-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1547021948-7664-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1547021948-7664-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH v3 1/4] pwm: rcar: Add support "atomic" API
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds support for "atomic" API. This behavior differs with
legacy APIs a little.

 Legacy APIs:
  The PWMCNT register will be updated in rcar_pwm_config() even if
  the PWM state is disabled.

 Atomic API:
  The PWMCNT register will be updated in rcar_pwm_apply() only if
  the PWM state is enabled. Otherwize, if a PWM runs with 30% duty
  cycles and the pwm_apply_state() is called with state->enabled = 0,
  ->duty_cycle = 60 and ->period = 100, this is possible to output
  a 60% duty cycle.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pwm/pwm-rcar.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index a41812f..e3ab663 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -192,12 +192,49 @@ static void rcar_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	rcar_pwm_update(rp, RCAR_PWMCR_EN0, 0, RCAR_PWMCR);
 }
 
+static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			  struct pwm_state *state)
+{
+	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
+	struct pwm_state cur_state;
+	int div, ret;
+
+	/* This HW/driver only supports normal polarity */
+	pwm_get_state(pwm, &cur_state);
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -ENOTSUPP;
+
+	if (!state->enabled) {
+		rcar_pwm_disable(chip, pwm);
+		return 0;
+	}
+
+	div = rcar_pwm_get_clock_division(rp, state->period);
+	if (div < 0)
+		return div;
+
+	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
+
+	ret = rcar_pwm_set_counter(rp, div, state->duty_cycle, state->period);
+	if (!ret)
+		rcar_pwm_set_clock_control(rp, div);
+
+	/* The SYNC should be set to 0 even if rcar_pwm_set_counter failed */
+	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, 0, RCAR_PWMCR);
+
+	if (!ret && state->enabled)
+		ret = rcar_pwm_enable(chip, pwm);
+
+	return ret;
+}
+
 static const struct pwm_ops rcar_pwm_ops = {
 	.request = rcar_pwm_request,
 	.free = rcar_pwm_free,
 	.config = rcar_pwm_config,
 	.enable = rcar_pwm_enable,
 	.disable = rcar_pwm_disable,
+	.apply = rcar_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
-- 
1.9.1
