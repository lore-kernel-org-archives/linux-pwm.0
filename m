From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] PWM: lp3943: Set pwm_chip can_sleep flag
Date: Wed, 16 Apr 2014 00:38:10 +0800
Message-ID: <1397579890.10787.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:57989 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaDOQib (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Apr 2014 12:38:31 -0400
Received: by mail-pb0-f51.google.com with SMTP id uo5so9677004pbc.24
        for <linux-pwm@vger.kernel.org>; Tue, 15 Apr 2014 09:38:31 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Milo Kim <milo.kim@ti.com>, linux-pwm@vger.kernel.org

Read/write through I2C can sleep, thus set pwm_chip can_sleep flag.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/pwm/pwm-lp3943.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index a40b9c3..2c39b0e 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -278,6 +278,7 @@ static int lp3943_pwm_probe(struct platform_device *pdev)
 	lp3943_pwm->chip.dev = &pdev->dev;
 	lp3943_pwm->chip.ops = &lp3943_pwm_ops;
 	lp3943_pwm->chip.npwm = LP3943_NUM_PWMS;
+	lp3943_pwm->chip.can_sleep = true;
 
 	platform_set_drvdata(pdev, lp3943_pwm);
 
-- 
1.8.3.2



