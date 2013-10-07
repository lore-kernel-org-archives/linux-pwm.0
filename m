Return-Path: <thierry.reding@gmail.com>
From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 01/12] pwm-backlight: Improve readability
Date: Mon,  7 Oct 2013 13:37:35 +0200
Message-Id: <1381145866-445-2-git-send-email-treding@nvidia.com>
In-Reply-To: <1381145866-445-1-git-send-email-treding@nvidia.com>
References: <1381145866-445-1-git-send-email-treding@nvidia.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Add more blank lines to increase readability. While at it, remove a
trailing blank line at the end of the file.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/video/backlight/pwm_bl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 1fea627..774bce3 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -269,8 +269,10 @@ static int pwm_backlight_remove(struct platform_device *pdev)
 	backlight_device_unregister(bl);
 	pwm_config(pb->pwm, 0, pb->period);
 	pwm_disable(pb->pwm);
+
 	if (pb->exit)
 		pb->exit(&pdev->dev);
+
 	return 0;
 }
 
@@ -282,10 +284,13 @@ static int pwm_backlight_suspend(struct device *dev)
 
 	if (pb->notify)
 		pb->notify(pb->dev, 0);
+
 	pwm_config(pb->pwm, 0, pb->period);
 	pwm_disable(pb->pwm);
+
 	if (pb->notify_after)
 		pb->notify_after(pb->dev, 0);
+
 	return 0;
 }
 
@@ -294,6 +299,7 @@ static int pwm_backlight_resume(struct device *dev)
 	struct backlight_device *bl = dev_get_drvdata(dev);
 
 	backlight_update_status(bl);
+
 	return 0;
 }
 #endif
@@ -317,4 +323,3 @@ module_platform_driver(pwm_backlight_driver);
 MODULE_DESCRIPTION("PWM based Backlight Driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:pwm-backlight");
-
-- 
1.8.4
