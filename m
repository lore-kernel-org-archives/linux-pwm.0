From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v1] pwm : pwm-vt8500 - Undo preparation of a clock source.
Date: Fri,  5 May 2017 13:30:14 +0530
Message-ID: <1493971214-3763-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35619 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbdEEIBS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 May 2017 04:01:18 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux@prisktech.co.nz, thierry.reding@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Undo preparation of a clock source, if vt8500_pwm_probe is not
successful.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/pwm/pwm-vt8500.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 8141a49..3a78dd0 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -241,6 +241,7 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 	ret = pwmchip_add(&chip->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip\n");
+		clk_unprepare(chip->clk);
 		return ret;
 	}
 
-- 
1.9.1
