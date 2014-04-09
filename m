From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RESEND] PWM: ab8500: Fix wrong value shift for
 disable/enable PWM
Date: Wed, 09 Apr 2014 21:19:54 +0800
Message-ID: <1397049594.5246.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:41692 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932748AbaDINUA (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Apr 2014 09:20:00 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so2462643pde.1
        for <linux-pwm@vger.kernel.org>; Wed, 09 Apr 2014 06:19:59 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre BOURDIOL <alexandre.bourdiol@st.com>, Philippe Begnic <philippe.begnic@st.com>, linux-pwm@vger.kernel.org

Current code only works when pdev->id is 1. Fix it by passing correct bitvalues
argument to abx500_mask_and_set_register_interruptible.

Having DISABLE_PWM/ENABLE_PWM does not make the code better in readability
because the bitvalues depends on pdev->id.
Thus drop defines for DISABLE_PWM/ENABLE_PWM.

This patch also removes a unnecessary return in ab8500_pwm_disable.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Alexandre BOURDIOL <alexandre.bourdiol@st.com>
Acked-by: Philippe Begnic <philippe.begnic@st.com>
---
 drivers/pwm/pwm-ab8500.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index 1d07a6f..d51dc15 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -20,10 +20,6 @@
 #define AB8500_PWM_OUT_CTRL2_REG	0x61
 #define AB8500_PWM_OUT_CTRL7_REG	0x66
 
-/* backlight driver constants */
-#define ENABLE_PWM			1
-#define DISABLE_PWM			0
-
 struct ab8500_pwm_chip {
 	struct pwm_chip chip;
 };
@@ -64,7 +60,7 @@ static int ab8500_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = abx500_mask_and_set_register_interruptible(chip->dev,
 				AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
-				1 << (chip->base - 1), ENABLE_PWM);
+				1 << (chip->base - 1), 1 << (chip->base - 1));
 	if (ret < 0)
 		dev_err(chip->dev, "%s: Failed to enable PWM, Error %d\n",
 							pwm->label, ret);
@@ -77,11 +73,10 @@ static void ab8500_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = abx500_mask_and_set_register_interruptible(chip->dev,
 				AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
-				1 << (chip->base - 1), DISABLE_PWM);
+				1 << (chip->base - 1), 0);
 	if (ret < 0)
 		dev_err(chip->dev, "%s: Failed to disable PWM, Error %d\n",
 							pwm->label, ret);
-	return;
 }
 
 static const struct pwm_ops ab8500_pwm_ops = {
-- 
1.8.1.2



