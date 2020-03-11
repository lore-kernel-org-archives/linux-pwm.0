From: Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH 1/1] pwm: pca9685: use gpio core provided macro GPIO_LINE_DIRECTION_OUT
Date: Wed, 11 Mar 2020 21:22:20 +0530
Message-ID: <1583941940-17194-1-git-send-email-gupt21@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41642 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbgCKPwe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2020 11:52:34 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, s.trumtrar@pengutronix.de
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>

GPIO core recently added macro to uniformly specify direction
of a GPIO Line, so use it.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
 drivers/pwm/pwm-pca9685.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index b2a9e77..e2bac1e 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -168,7 +168,7 @@ static int pca9685_pwm_gpio_get_direction(struct gpio_chip *chip,
 					  unsigned int offset)
 {
 	/* Always out */
-	return 0;
+	return GPIO_LINE_DIRECTION_OUT;
 }
 
 static int pca9685_pwm_gpio_direction_input(struct gpio_chip *gpio,
-- 
2.7.4
