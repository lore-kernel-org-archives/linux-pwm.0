From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] backlight: pwm_bl: make of_device_ids const
Date: Tue, 20 Jun 2017 13:22:15 +0530
Message-ID: <b9daeb15d40f6682803d8dafde3bc3dcb63909ff.1497940816.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33309 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdFTHwz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Jun 2017 03:52:55 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

of_device_ids are not supposed to change at runtime. All functions
working with of_device_ids provided by <linux/of.h> work with const
of_device_ids. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/backlight/pwm_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 002f1ce..9bd1768 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -178,7 +178,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
 	return 0;
 }
 
-static struct of_device_id pwm_backlight_of_match[] = {
+static const struct of_device_id pwm_backlight_of_match[] = {
 	{ .compatible = "pwm-backlight" },
 	{ }
 };
-- 
1.9.1
