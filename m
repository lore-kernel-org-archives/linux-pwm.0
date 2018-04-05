Return-Path: <linux-pwm-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40854 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751259AbeDER0F (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 5 Apr 2018 13:26:05 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] pwm: rcar: simplify getting .drvdata
Date: Thu,  5 Apr 2018 19:25:51 +0200
Message-Id: <20180405172552.8720-1-wsa+renesas@sang-engineering.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
To: linux-pwm@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Only build tested. Fixed numerous times in other drivers, however...

 drivers/pwm/pwm-rcar.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 91d11f2e2fef..748f614d5375 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -261,8 +261,7 @@ MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);
 #ifdef CONFIG_PM_SLEEP
 static struct pwm_device *rcar_pwm_dev_to_pwm_dev(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rcar_pwm_chip *rcar_pwm = platform_get_drvdata(pdev);
+	struct rcar_pwm_chip *rcar_pwm = dev_get_drvdata(dev);
 	struct pwm_chip *chip = &rcar_pwm->chip;
 
 	return &chip->pwms[0];
-- 
2.11.0

