Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] pwm: clear chip_data in pwm_put
Date: Mon, 25 Mar 2019 10:49:33 +0100
Message-Id: <20190325094934.10221-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

After a PWM is disposed by its user the per chip data becomes invalid.
Clear the data in common code instead of the device drivers to get
consistent behaviour. Before this patch only three of nine drivers cleaned
up here.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c        | 1 +
 drivers/pwm/pwm-berlin.c  | 1 -
 drivers/pwm/pwm-pca9685.c | 1 -
 drivers/pwm/pwm-samsung.c | 1 -
 4 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1a871cf8f7ee..8b247554bf50 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -881,6 +881,7 @@ void pwm_put(struct pwm_device *pwm)
 	if (pwm->chip->ops->free)
 		pwm->chip->ops->free(pwm->chip, pwm);
 
+	pwm_set_chip_data(pwm, NULL);
 	pwm->label = NULL;
 
 	module_put(pwm->chip->ops->owner);
diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index 7c8d6a168ceb..b91c477cc84b 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -84,7 +84,6 @@ static void berlin_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct berlin_pwm_channel *channel = pwm_get_chip_data(pwm);
 
-	pwm_set_chip_data(pwm, NULL);
 	kfree(channel);
 }
 
diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index a7eaf962a95b..567f5e2771c4 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -176,7 +176,6 @@ static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
 	pm_runtime_put(pca->chip.dev);
 	mutex_lock(&pca->lock);
 	pwm = &pca->chip.pwms[offset];
-	pwm_set_chip_data(pwm, NULL);
 	mutex_unlock(&pca->lock);
 }
 
diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 062f2cfc45ec..3762432dd6a7 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -238,7 +238,6 @@ static int pwm_samsung_request(struct pwm_chip *chip, struct pwm_device *pwm)
 static void pwm_samsung_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	devm_kfree(chip->dev, pwm_get_chip_data(pwm));
-	pwm_set_chip_data(pwm, NULL);
 }
 
 static int pwm_samsung_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-- 
2.20.1
