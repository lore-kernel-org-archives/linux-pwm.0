Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:55996 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729844AbfAIIWB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Jan 2019 03:22:01 -0500
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed,  9 Jan 2019 17:19:06 +0900
Message-Id: <1547021948-7664-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1547021948-7664-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1547021948-7664-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH v3 2/4] pwm: rcar: Use "atomic" API on rcar_pwm_resume()
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

To remove legacy API related functions in the future, this patch
uses "atomic" related function instead. No change in behavior.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rcar.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index e3ab663..652a937 100644
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
