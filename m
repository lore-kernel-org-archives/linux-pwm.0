Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:18986 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726030AbeLGIcF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Dec 2018 03:32:05 -0500
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri,  7 Dec 2018 17:29:32 +0900
Message-Id: <1544171373-29618-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH 4/5] pwm: rcar: remove legacy APIs
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch removes legacy APIs. Since rcar_pwm_{en,dis}able()
functions are reused on "atomic" API, this patch changes
the arguments of these functions. No change in behavior.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pwm/pwm-rcar.c | 45 ++++-----------------------------------------
 1 file changed, 4 insertions(+), 41 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 1bcb662..e479b6a 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -146,40 +146,8 @@ static void rcar_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	pm_runtime_put(chip->dev);
 }
 
-static int rcar_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			   int duty_ns, int period_ns)
+static int rcar_pwm_enable(struct rcar_pwm_chip *rp)
 {
-	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
-	int div, ret;
-
-	div = rcar_pwm_get_clock_division(rp, period_ns);
-	if (div < 0)
-		return div;
-
-	/*
-	 * Let the core driver set pwm->period if disabled and duty_ns == 0.
-	 * But, this driver should prevent to set the new duty_ns if current
-	 * duty_cycle is not set
-	 */
-	if (!pwm_is_enabled(pwm) && !duty_ns && !pwm->state.duty_cycle)
-		return 0;
-
-	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
-
-	rcar_pwm_calc_counter(rp, div, duty_ns, period_ns);
-	ret = rcar_pwm_set_counter(rp);
-	if (!ret)
-		rcar_pwm_set_clock_control(rp, div);
-
-	/* The SYNC should be set to 0 even if rcar_pwm_set_counter failed */
-	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, 0, RCAR_PWMCR);
-
-	return ret;
-}
-
-static int rcar_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
 	u32 value;
 
 	/* Don't enable the PWM device if CYC0 or PH0 is 0 */
@@ -193,10 +161,8 @@ static int rcar_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	return 0;
 }
 
-static void rcar_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+static void rcar_pwm_disable(struct rcar_pwm_chip *rp)
 {
-	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
-
 	rcar_pwm_update(rp, RCAR_PWMCR_EN0, 0, RCAR_PWMCR);
 }
 
@@ -221,10 +187,10 @@ static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, 0, RCAR_PWMCR);
 
 	if (!ret && state->enabled)
-		ret = rcar_pwm_enable(chip, pwm);
+		ret = rcar_pwm_enable(rp);
 
 	if (!state->enabled) {
-		rcar_pwm_disable(chip, pwm);
+		rcar_pwm_disable(rp);
 		ret = 0;
 	}
 
@@ -234,9 +200,6 @@ static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 static const struct pwm_ops rcar_pwm_ops = {
 	.request = rcar_pwm_request,
 	.free = rcar_pwm_free,
-	.config = rcar_pwm_config,
-	.enable = rcar_pwm_enable,
-	.disable = rcar_pwm_disable,
 	.apply = rcar_pwm_apply,
 	.owner = THIS_MODULE,
 };
-- 
1.9.1
