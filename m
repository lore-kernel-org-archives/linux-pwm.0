Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:12374 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725967AbeLGIcD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Dec 2018 03:32:03 -0500
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri,  7 Dec 2018 17:29:33 +0900
Message-Id: <1544171373-29618-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH 5/5] pwm: rcar: add workaround to output "pseudo" low level
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This PWM Timer cannot output low because setting 0x000 is prohibited
on PWMCNT.PH0 (High-Level Period) bitfields. So, avoiding
the prohibited, this patch adds a workaround function to change
the value from 0 to 1 as pseudo low level.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pwm/pwm-rcar.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index e479b6a..888cb37 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -166,6 +166,20 @@ static void rcar_pwm_disable(struct rcar_pwm_chip *rp)
 	rcar_pwm_update(rp, RCAR_PWMCR_EN0, 0, RCAR_PWMCR);
 }
 
+static void rcar_pwm_workaround_output_low(struct rcar_pwm_chip *rp)
+{
+	/*
+	 * This PWM Timer cannot output low because setting 0x000 is
+	 * prohibited on PWMCNT.PH0 (High-Level Period) bitfields. So, avoiding
+	 * the prohibited, this function changes the value from 0 to 1 as
+	 * pseudo low level.
+	 *
+	 * TODO: Add GPIO handling to output low level.
+	 */
+	if ((rp->pwmcnt & RCAR_PWMCNT_PH0_MASK) == 0)
+		rp->pwmcnt |= 1;
+}
+
 static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			  struct pwm_state *state)
 {
@@ -179,6 +193,7 @@ static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
 
 	rcar_pwm_calc_counter(rp, div, state->duty_cycle, state->period);
+	rcar_pwm_workaround_output_low(rp);
 	ret = rcar_pwm_set_counter(rp);
 	if (!ret)
 		rcar_pwm_set_clock_control(rp, div);
-- 
1.9.1
