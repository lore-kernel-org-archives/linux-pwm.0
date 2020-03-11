From: Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH 1/1] pwm: pca9685: replace CONFIG_PM with __maybe_unused to prevent build issues
Date: Wed, 11 Mar 2020 21:13:49 +0530
Message-ID: <1583941429-10921-1-git-send-email-gupt21@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, s.trumtrar@pengutronix.de
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
List-Id: linux-pwm@vger.kernel.org

The __maybe_unused attribute is preferred over CONFIG_PM
to prevent build time issues. This commit replaces CONFIG_PM
with this attribute.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
 drivers/pwm/pwm-pca9685.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index b07bdca..b2a9e77 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -512,8 +512,7 @@ static int pca9685_pwm_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int pca9685_pwm_runtime_suspend(struct device *dev)
+static int __maybe_unused pca9685_pwm_runtime_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pca9685 *pca = i2c_get_clientdata(client);
@@ -522,7 +521,7 @@ static int pca9685_pwm_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int pca9685_pwm_runtime_resume(struct device *dev)
+static int __maybe_unused pca9685_pwm_runtime_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pca9685 *pca = i2c_get_clientdata(client);
@@ -530,7 +529,6 @@ static int pca9685_pwm_runtime_resume(struct device *dev)
 	pca9685_set_sleep_mode(pca, false);
 	return 0;
 }
-#endif
 
 static const struct i2c_device_id pca9685_id[] = {
 	{ "pca9685", 0 },
-- 
2.7.4
