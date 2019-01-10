Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] pwm: imx27: only enable the clocks once in .get_state
Date: Thu, 10 Jan 2019 20:33:53 +0100
Message-Id: <20190110193353.20767-1-u.kleine-koenig@pengutronix.de>
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
Cc: linux-pwm@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

Currently the function pwm_imx27_get_state() of enables the clocks once
unconditionally at the start, a second time if the PWM is enabled and
disables unconditionally at the end.

Simplify that to enable once at the start and disable conditionally at
the end.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx27.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 8997c4c1bd03..4dc2d62c0e1c 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -125,14 +125,10 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
 
 	val = readl(imx->mmio_base + MX3_PWMCR);
 
-	if (val & MX3_PWMCR_EN) {
+	if (val & MX3_PWMCR_EN)
 		state->enabled = true;
-		ret = pwm_imx27_clk_prepare_enable(chip);
-		if (ret)
-			return;
-	} else {
+	else
 		state->enabled = false;
-	}
 
 	switch (FIELD_GET(MX3_PWMCR_POUTC, val)) {
 	case MX3_PWMCR_POUTC_NORMAL:
@@ -164,7 +160,8 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
 		state->duty_cycle = 0;
 	}
 
-	pwm_imx27_clk_disable_unprepare(chip);
+	if (!state->enabled)
+		pwm_imx27_clk_disable_unprepare(chip);
 }
 
 static void pwm_imx27_sw_reset(struct pwm_chip *chip)
-- 
2.20.1
