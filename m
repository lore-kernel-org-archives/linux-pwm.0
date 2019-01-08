Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:41637 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727547AbfAHDbH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Jan 2019 22:31:07 -0500
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue,  8 Jan 2019 12:28:12 +0900
Message-Id: <1546918094-13960-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1546918094-13960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1546918094-13960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH v2 2/4] pwm: rcar: Use "atomic" API on rcar_pwm_resume()
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

To remove legacy API related functions in the future, this patch
uses "atomic" related function instead. No change in behavior.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pwm/pwm-rcar.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index ba70e83..4987c12 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -316,18 +316,16 @@ static int rcar_pwm_suspend(struct device *dev)
 static int rcar_pwm_resume(struct device *dev)
 {
 	struct pwm_device *pwm = rcar_pwm_dev_to_pwm_dev(dev);
+	struct pwm_state state;
 
 	if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 		return 0;
 
 	pm_runtime_get_sync(dev);
 
-	rcar_pwm_config(pwm->chip, pwm, pwm->state.duty_cycle,
-			pwm->state.period);
-	if (pwm_is_enabled(pwm))
-		rcar_pwm_enable(pwm->chip, pwm);
+	pwm_get_state(pwm, &state);
 
-	return 0;
+	return rcar_pwm_apply(pwm->chip, pwm, &state);
 }
 #endif /* CONFIG_PM_SLEEP */
 static SIMPLE_DEV_PM_OPS(rcar_pwm_pm_ops, rcar_pwm_suspend, rcar_pwm_resume);
-- 
1.9.1
