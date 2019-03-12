Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] pwm: poke users of legacy drivers with a warning
Date: Tue, 12 Mar 2019 10:42:49 +0100
Message-Id: <20190312094249.27806-1-u.kleine-koenig@pengutronix.de>
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

As it is hard to convert a given driver from the legacy functions
(.enable, .disable, .config) to the atomic stuff (.apply) without
testing make users aware that there is something to do with a warning to
eventually get rid of the legacy drivers.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index e547c3217fca..1a871cf8f7ee 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -236,16 +236,20 @@ void *pwm_get_chip_data(struct pwm_device *pwm)
 }
 EXPORT_SYMBOL_GPL(pwm_get_chip_data);
 
-static bool pwm_ops_check(const struct pwm_ops *ops)
+static bool pwm_ops_check(const struct pwm_chip *chip)
 {
-	/* driver supports legacy, non-atomic operation */
-	if (ops->config && ops->enable && ops->disable)
-		return true;
+	const struct pwm_ops *ops = chip->ops;
 
 	/* driver supports atomic operation */
 	if (ops->apply)
 		return true;
 
+	/* driver supports legacy, non-atomic operation */
+	if (ops->config && ops->enable && ops->disable) {
+		dev_warn(chip->dev, "registering PWM driver with legacy API, driver needs updating");
+		return true;
+	}
+
 	return false;
 }
 
@@ -270,7 +274,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
 		return -EINVAL;
 
-	if (!pwm_ops_check(chip->ops))
+	if (!pwm_ops_check(chip))
 		return -EINVAL;
 
 	mutex_lock(&pwm_lock);
-- 
2.20.1
