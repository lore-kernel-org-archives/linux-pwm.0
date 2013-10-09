Return-Path: <21cnbao@gmail.com>
Return-Path: <21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH v2] pwm_backlight: avoid short blank screen while doing hibernation
Date: Wed,  9 Oct 2013 10:33:02 +0800
Message-Id: <1381285982-18670-1-git-send-email-Baohua.Song@csr.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-pwm@vger.kernel.org, thierry.reding@gmail.com
Cc: workgroup.linux@csr.com, Huayi Li <huayi.li@csr.com>, Barry Song <Baohua.Song@csr.com>

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
 -v2: move the #ifdef inside of the pwm_backlight_pwm_ops so that we
 don't have to clutter the platform_driver here

 drivers/video/backlight/pwm_bl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 1fea627..8ffd54e 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -298,8 +298,14 @@ static int pwm_backlight_resume(struct device *dev)
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(pwm_backlight_pm_ops, pwm_backlight_suspend,
-			 pwm_backlight_resume);
+static const struct dev_pm_ops pwm_backlight_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend = pwm_backlight_suspend,
+	.resume = pwm_backlight_resume,
+	.poweroff = pwm_backlight_suspend,
+	.restore = pwm_backlight_resume,
+#endif
+};
 
 static struct platform_driver pwm_backlight_driver = {
 	.driver		= {
-- 
1.8.2.3
