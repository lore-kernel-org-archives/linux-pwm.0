From: Florian Vaussard <florian.vaussard@gmail.com>
Subject: [PATCH] pwm: pca9685: Fix misuse of regmap_update_bits
Date: Tue, 29 Nov 2016 18:02:50 +0100
Message-ID: <1480438970-15317-1-git-send-email-florian.vaussard@heig-vd.ch>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34593 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752046AbcK2RDB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Nov 2016 12:03:01 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, Clemens Gruber <clemens.gruber@pqgruber.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>

Using regmap_update_bits(..., mask, 1) with 'mask' following (1 << k)
and k greater than 0 is wrong. Indeed, _regmap_update_bits will perform
(mask & 1), which results in 0 if LSB of mask is 0. Thus the call
regmap_update_bits(..., mask, 1) is in reality equivalent to
regmap_update_bits(..., mask, 0).

In such a case, the correct use is regmap_update_bits(..., mask, mask).

This driver is performing such a mistake with the MODE1_RESTART mask,
which equals (1 << 6). Fix the driver to make it consistent with the
API. Please note that this change is untested, as I do not have this
piece of hardware. Testers are welcome!

Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
---
 drivers/pwm/pwm-pca9685.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 117fccf..6b9ff6c 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -124,7 +124,8 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			 */
 			if (duty_ns == pca->duty_ns) {
 				regmap_update_bits(pca->regmap, PCA9685_MODE1,
-						   MODE1_RESTART, 0x1);
+						   MODE1_RESTART,
+						   MODE1_RESTART);
 				return 0;
 			}
 		} else {
-- 
2.5.5
