Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:61244 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726003AbeLGIcD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Dec 2018 03:32:03 -0500
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri,  7 Dec 2018 17:29:30 +0900
Message-Id: <1544171373-29618-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH 2/5] pwm: rcar: Add support "atomic" API
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds support for "atomic" API. Behavior is the same as
when using legacy APIs.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pwm/pwm-rcar.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 9cf4567..a5ea0f3 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -200,12 +200,44 @@ static void rcar_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	rcar_pwm_update(rp, RCAR_PWMCR_EN0, 0, RCAR_PWMCR);
 }
 
+static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			  struct pwm_state *state)
+{
+	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
+	int div, ret;
+
+	div = rcar_pwm_get_clock_division(rp, state->period);
+	if (div < 0)
+		return div;
+
+	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
+
+	rcar_pwm_calc_counter(rp, div, state->duty_cycle, state->period);
+	ret = rcar_pwm_set_counter(rp);
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
