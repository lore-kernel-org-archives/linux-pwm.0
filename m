Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:20914 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727535AbfAHDbG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Jan 2019 22:31:06 -0500
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue,  8 Jan 2019 12:28:11 +0900
Message-Id: <1546918094-13960-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1546918094-13960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1546918094-13960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH v2 1/4] pwm: rcar: Add support "atomic" API
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds support for "atomic" API. Behavior is the same as
when using legacy APIs.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pwm/pwm-rcar.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index a41812f..ba70e83 100644
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
+	/* This HW doesn't support changing polarity */
+	pwm_get_state(pwm, &cur_state);
+	if (state->polarity != cur_state.polarity)
+		return -ENOTSUPP;
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
+	if (!state->enabled) {
+		rcar_pwm_disable(chip, pwm);
+		ret = 0;
+	}
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
