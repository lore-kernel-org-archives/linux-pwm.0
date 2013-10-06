Return-Path: <21cnbao@gmail.com>
Return-Path: <21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] pwm_backlight: avoid short blank screen while doing hibernation
Date: Sun,  6 Oct 2013 17:06:38 +0800
Message-Id: <1381050398-12565-1-git-send-email-Baohua.Song@csr.com>
List-ID: <linux-pwm.vger.kernel.org>
To: rpurdie@rpsys.net, jg1.han@samsung.com, thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, workgroup.linux@csr.com, Huayi Li <huayi.li@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Huayi Li <huayi.li@csr.com>

Use SIMPLE_DEV_PM_OPS macro will initialize the member "freeze"
and "thaw" of pwm_backlight_pm_ops as below,
	.freeze = suspend_fn,
	.thaw = resume_fn,
then during the process of making hibernation snapshot, screen
will be blank at the moment of freezing, and then light at the
moment of thawing.
this is not the right user experience for suspending to disk.

so this patch drops freeze and thaw callback, make the LCD is
always lighting before the final shutdown.

Signed-off-by: Huayi Li <huayi.li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/video/backlight/pwm_bl.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 1fea627..f3b76cb 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -296,16 +296,23 @@ static int pwm_backlight_resume(struct device *dev)
 	backlight_update_status(bl);
 	return 0;
 }
+
+static const struct dev_pm_ops pwm_backlight_pm_ops = {
+	.suspend = pwm_backlight_suspend,
+	.resume = pwm_backlight_resume,
+	.poweroff = pwm_backlight_suspend,
+	.restore = pwm_backlight_resume,
+};
 #endif
 
-static SIMPLE_DEV_PM_OPS(pwm_backlight_pm_ops, pwm_backlight_suspend,
-			 pwm_backlight_resume);
 
 static struct platform_driver pwm_backlight_driver = {
 	.driver		= {
 		.name		= "pwm-backlight",
 		.owner		= THIS_MODULE,
+#ifdef CONFIG_PM_SLEEP
 		.pm		= &pwm_backlight_pm_ops,
+#endif
 		.of_match_table	= of_match_ptr(pwm_backlight_of_match),
 	},
 	.probe		= pwm_backlight_probe,
-- 
1.8.2.3
