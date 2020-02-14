From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 418/542] pwm: Remove set but not set variable 'pwm'
Date: Fri, 14 Feb 2020 10:46:50 -0500
Message-ID: <20200214154854.6746-418-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: yu kuai <yukuai3@huawei.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

From: yu kuai <yukuai3@huawei.com>

[ Upstream commit 9871abffc81048e20f02e15d6aa4558a44ad53ea ]

Fixes gcc '-Wunused-but-set-variable' warning:

	drivers/pwm/pwm-pca9685.c: In function ‘pca9685_pwm_gpio_free’:
	drivers/pwm/pwm-pca9685.c:162:21: warning: variable ‘pwm’ set but not used [-Wunused-but-set-variable]

It is never used, and so can be removed. In that case, hold and release
the lock 'pca->lock' can be removed since nothing will be done between
them.

Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()")
Signed-off-by: yu kuai <yukuai3@huawei.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-pca9685.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 168684b02ebce..b07bdca3d510d 100644
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
2.20.1
