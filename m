From: Lynn Lei <lynnl.yet@gmail.com>
Subject: [PATCH] video: backlight: pwm_bl.c: make of_device_id structure to
 const
Date: Wed, 5 Jul 2017 23:55:09 +0800
Message-ID: <20170705155406.GA22144@lynnl.yet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34739 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdGEPzW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Jul 2017 11:55:22 -0400
Content-Disposition: inline
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Fixed a of_device_id structure normally be const warning issue which
checked by scripts/checkpatch.pl:
  WARNING: struct of_device_id should normally be const

Signed-off-by: Lynn Lei <lynnl.wit@gmail.com>
---
 drivers/video/backlight/pwm_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 002f1ce22bd0..9bd17682655a 100644
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
2.13.2
