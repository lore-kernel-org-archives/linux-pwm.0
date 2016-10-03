From: Clifton Barnes <cabarnes@indesign-llc.com>
Subject: [PATCH] pwm: tiehrpwm: fix disabled state of pwm when inverted
Date: Mon, 3 Oct 2016 07:37:02 -0400
Message-ID: <1475494622-43846-1-git-send-email-cabarnes@indesign-llc.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail02.indesign-llc.com ([207.67.30.40]:56848 "EHLO
        mail02.indesign-llc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbcJCLwM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Oct 2016 07:52:12 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

The disable function forces the output to low regardless of whether
the PWM is inverted. Fix this by checking the inverted status of the
PWM and force the output to the proper state when disabled.

Signed-off-by: Clifton Barnes <cabarnes@indesign-llc.com>
---
 drivers/pwm/pwm-tiehrpwm.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index b5c6b06..e47e020 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -372,13 +372,14 @@ static void ehrpwm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
 	unsigned short aqcsfrc_val, aqcsfrc_mask;
+	bool inv = pc->polarity[pwm->hwpwm] == PWM_POLARITY_INVERSED;
 
-	/* Action Qualifier puts PWM output low forcefully */
+	/* Action Qualifier puts PWM output high/low forcefully */
 	if (pwm->hwpwm) {
-		aqcsfrc_val = AQCSFRC_CSFB_FRCLOW;
+		aqcsfrc_val = inv ? AQCSFRC_CSFB_FRCHIGH : AQCSFRC_CSFB_FRCLOW;
 		aqcsfrc_mask = AQCSFRC_CSFB_MASK;
 	} else {
-		aqcsfrc_val = AQCSFRC_CSFA_FRCLOW;
+		aqcsfrc_val = inv ? AQCSFRC_CSFA_FRCHIGH : AQCSFRC_CSFA_FRCLOW;
 		aqcsfrc_mask = AQCSFRC_CSFA_MASK;
 	}
 
-- 
1.7.9.5
