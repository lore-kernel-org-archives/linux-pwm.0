From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] pwm: stmpe: Fix wrong register offset for hwpwm=2 case
Date: Tue,  7 Nov 2017 13:18:53 +0800
Message-ID: <20171107051853.14492-1-axel.lin@ingics.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:51663 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752580AbdKGFTH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Nov 2017 00:19:07 -0500
Received: by mail-pg0-f68.google.com with SMTP id p9so10123061pgc.8
        for <linux-pwm@vger.kernel.org>; Mon, 06 Nov 2017 21:19:07 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Axel Lin <axel.lin@ingics.com>

Fix trivial copy/paste bug.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Linus,
I don't have this h/w to test.
Appreciate if you can review and test this patch.

Thanks,
Axel
 drivers/pwm/pwm-stmpe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
index e464582a390a..3439f1e902cb 100644
--- a/drivers/pwm/pwm-stmpe.c
+++ b/drivers/pwm/pwm-stmpe.c
@@ -145,7 +145,7 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		break;
 
 	case 2:
-		offset = STMPE24XX_PWMIC1;
+		offset = STMPE24XX_PWMIC2;
 		break;
 
 	default:
-- 
2.11.0
