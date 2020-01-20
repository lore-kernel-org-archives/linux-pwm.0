From: yu kuai <yukuai3@huawei.com>
Subject: [PATCH V2] pwm: remove set but not set variable 'pwm'
Date: Mon, 20 Jan 2020 19:51:43 +0800
Message-ID: <20200120115143.35571-1-yukuai3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:57310 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726573AbgATLwj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 20 Jan 2020 06:52:39 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, zhengbin13@huawei.com, yi.zhang@huawei.com

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/pwm/pwm-pca9685.c: In function ‘pca9685_pwm_gpio_free’:
drivers/pwm/pwm-pca9685.c:162:21: warning: variable ‘pwm’ set but
not used [-Wunused-but-set-variable]

It is never used, and so can be removed. In that case, hold and release
the lock 'pac->lock' can be removed since nothing will be done between
them.

Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
Changes in V2:
 Add Fixes and some commit message about dropping the lock 'pca->loc'.

 drivers/pwm/pwm-pca9685.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 168684b02ebc..b07bdca3d510 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -159,13 +159,9 @@ static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
 static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
 {
 	struct pca9685 *pca = gpiochip_get_data(gpio);
-	struct pwm_device *pwm;
 
 	pca9685_pwm_gpio_set(gpio, offset, 0);
 	pm_runtime_put(pca->chip.dev);
-	mutex_lock(&pca->lock);
-	pwm = &pca->chip.pwms[offset];
-	mutex_unlock(&pca->lock);
 }
 
 static int pca9685_pwm_gpio_get_direction(struct gpio_chip *chip,
-- 
2.17.2
