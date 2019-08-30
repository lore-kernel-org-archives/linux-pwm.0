Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:48333 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfH3S0o (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 30 Aug 2019 14:26:44 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 30 Aug 2019 21:26:41 +0300
Message-Id: <20190830182641.81502-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH v1] pwm: pca9685: Fix regression for GPIO use
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>

The commit e926b12c611c ("pwm: Clear chip_data in pwm_put()") breaks GPIO usage
by actually removing a crucial call to pwm_set_chip_data(), which is being used
as a flag to understand the mode (GPIO vs. PWM) in which pin is currently
working. Now, if once I requested GPIO, I may not be able to free and request
it again.

Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()") breaks GPIO usage
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-pca9685.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 168684b02ebc..7cdec56ab3ec 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -165,6 +165,7 @@ static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
 	pm_runtime_put(pca->chip.dev);
 	mutex_lock(&pca->lock);
 	pwm = &pca->chip.pwms[offset];
+	pwm_set_chip_data(pwm, NULL);
 	mutex_unlock(&pca->lock);
 }
 
-- 
2.23.0.rc1
