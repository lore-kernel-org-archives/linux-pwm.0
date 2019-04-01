From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] pwm: meson: don't disable pwm when setting duty repeatedly
Date: Mon,  1 Apr 2019 20:18:17 +0200
Message-ID: <20190401181817.11999-3-martin.blumenstingl@googlemail.com>
References: <20190401181817.11999-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401181817.11999-1-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc: narmstrong@baylibre.com, jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de, bichao.zheng@amlogic.com, Martin Blumenstingl <martin.blumenstingl@googlemail.com>
List-Id: linux-pwm@vger.kernel.org

From: Bichao Zheng <bichao.zheng@amlogic.com>

There is an abnormally low about 20ms,when setting duty repeatedly.
Because setting the duty will disable pwm and then enable. Delete
this operation now.

Fixes: 211ed630753d2f ("pwm: Add support for Meson PWM Controller")
Signed-off-by: Bichao Zheng <bichao.zheng@amlogic.com>
[ Dropped code instead of hiding it behind a comment ]
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pwm/pwm-meson.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 4b708c1fcb1d..e247ab632530 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -325,11 +325,6 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->period != channel->state.period ||
 	    state->duty_cycle != channel->state.duty_cycle ||
 	    state->polarity != channel->state.polarity) {
-		if (channel->state.enabled) {
-			meson_pwm_disable(meson, pwm->hwpwm);
-			channel->state.enabled = false;
-		}
-
 		if (state->polarity != channel->state.polarity) {
 			if (state->polarity == PWM_POLARITY_NORMAL)
 				meson->inverter_mask |= BIT(pwm->hwpwm);
-- 
2.21.0
