From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] pwm: pca9685: Remove set but not used variable 'pwm'
Date: Sat, 1 Jun 2019 03:57:09 +0000
Message-ID: <20190601035709.85379-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, u.kleine-koenig@pengutronix.de, andriy.shevchenko@linux.intel.com, thesven73@gmail.com
Cc: YueHaibing <yuehaibing@huawei.com>, linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/pwm/pwm-pca9685.c: In function 'pca9685_pwm_gpio_free':
drivers/pwm/pwm-pca9685.c:173:21: warning:
 variable 'pwm' set but not used [-Wunused-but-set-variable]

It's not used since commit e926b12c611c ("pwm: Clear chip_data in pwm_put()")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pwm/pwm-pca9685.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 567f5e2771c4..d16215c276bd 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -170,12 +170,10 @@ static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
 static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
 {
 	struct pca9685 *pca = gpiochip_get_data(gpio);
-	struct pwm_device *pwm;
 
 	pca9685_pwm_gpio_set(gpio, offset, 0);
 	pm_runtime_put(pca->chip.dev);
 	mutex_lock(&pca->lock);
-	pwm = &pca->chip.pwms[offset];
 	mutex_unlock(&pca->lock);
 }
