From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2] pwm: sun4i: Move pwm_calculate() out of spin_lock()
Date: Mon, 13 Jan 2020 10:23:13 +0100
Message-ID: <20200113092313.30382-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44241 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgAMJXZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Jan 2020 04:23:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id q10so7718127wrm.11
        for <linux-pwm@vger.kernel.org>; Mon, 13 Jan 2020 01:23:24 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>, Alexander Finger <alex.mobigo@gmail.com>, Vasily Khoruzhick <anarsoul@gmail.com>

pwm_calculate() calls clk_get_rate() while holding a spin_lock().

This create an issue as clk_get_rate() may sleep.

Move pwm_calculate() out of this spin_lock().

Fixes: c32c5c50d4fe ("pwm: sun4i: Switch to atomic PWM")
Reported-by: Alexander Finger <alex.mobigo@gmail.com>
Sugested-by: Vasily Khoruzhick <anarsoul@gmail.com>
Tested-by: Alexander Finger <alex.mobigo@gmail.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---

Changes since v1:
 - Fix Alexander in Reported-by tag
 - Add Uwe reviewed tag and Alex Tested-by tag 

 drivers/pwm/pwm-sun4i.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 1afd41ebd3fd..6b230029dc49 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -248,19 +248,18 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		}
 	}
 
-	spin_lock(&sun4i_pwm->ctrl_lock);
-	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-
 	ret = sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescaler,
 				  &bypass);
 	if (ret) {
 		dev_err(chip->dev, "period exceeds the maximum value\n");
-		spin_unlock(&sun4i_pwm->ctrl_lock);
 		if (!cstate.enabled)
 			clk_disable_unprepare(sun4i_pwm->clk);
 		return ret;
 	}
 
+	spin_lock(&sun4i_pwm->ctrl_lock);
+	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+
 	if (sun4i_pwm->data->has_direct_mod_clk_output) {
 		if (bypass) {
 			ctrl |= BIT_CH(PWM_BYPASS, pwm->hwpwm);
-- 
2.20.1
