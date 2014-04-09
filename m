From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] PWM: twl: actually disable twl6030 PWMs
Date: Wed, 09 Apr 2014 17:21:26 +0800
Message-ID: <1397035286.1002.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:46053 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247AbaDIJVd (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Apr 2014 05:21:33 -0400
Received: by mail-pd0-f179.google.com with SMTP id w10so2223054pde.10
        for <linux-pwm@vger.kernel.org>; Wed, 09 Apr 2014 02:21:32 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-pwm@vger.kernel.org

Current twl6030_pwm_disable() implementation writes TWL6030_TOGGLE3_REG twice,
the second write sets TWL6030_PWMXEN bits so the PWM clock does not disable.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Peter,
I don't have this h/w handy to test.
I'd appreciate if you can review and test this patch.

Regards,
Axel
 drivers/pwm/pwm-twl.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
index b99a50e..04f7672 100644
--- a/drivers/pwm/pwm-twl.c
+++ b/drivers/pwm/pwm-twl.c
@@ -265,14 +265,6 @@ static void twl6030_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read TOGGLE3\n", pwm->label);
-		goto out;
-	}
-
-	val |= TWL6030_PWM_TOGGLE(pwm->hwpwm, TWL6030_PWMXS | TWL6030_PWMXEN);
-
-	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_REG);
-	if (ret < 0) {
 		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
 		goto out;
 	}
-- 
1.8.3.2



