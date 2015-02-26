From: huang lin <hl@rock-chips.com>
Subject: [PATCH 2/2] backlight: pwm: Add backlight-boot-off property
Date: Thu, 26 Feb 2015 11:39:14 +0800
Message-ID: <1424921954-8621-1-git-send-email-hl@rock-chips.com>
References: <1424920366-7626-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:37360 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbbBZDzJ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Feb 2015 22:55:09 -0500
In-Reply-To: <1424920366-7626-1-git-send-email-hl@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: djkurtz@chromium.org
Cc: thierry.reding@gmail.com, jg1.han@samsung.com, lee.jones@linaro.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, huang lin <hl@rock-chips.com>

Add backlight-boot-off property, so we can keeping the
backlight disabled at boot until it is enabled implicitly
by a panel driver, or explicitly by userspace

Signed-off-by: huang lin <hl@rock-chips.com>

---

 drivers/video/backlight/pwm_bl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 3a145a6..dece351 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -319,6 +319,10 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	}
 
 	bl->props.brightness = data->dft_brightness;
+
+	if (of_find_property(pdev->dev.of_node, "backlight-boot-off", NULL))
+		bl->props.power = FB_BLANK_POWERDOWN;
+
 	backlight_update_status(bl);
 
 	platform_set_drvdata(pdev, bl);
-- 
1.9.1


