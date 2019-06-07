From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 5/6] pwm: jz4740: Force TCU2 channels to return to their init level
Date: Fri,  7 Jun 2019 17:44:09 +0200
Message-ID: <20190607154410.10633-6-paul@crapouillou.net>
References: <20190607154410.10633-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190607154410.10633-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

When the PWM mode of TCU2 channels is disabled, their corresponding pin
does not always return to its initial level. Force this by using a small
trick: we set duty > period, which is an invalid configuration for the
hardware, which then correctly resets the pin to the initial level.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: New patch

 drivers/pwm/pwm-jz4740.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 75254360621c..f901e8a0d33d 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -63,7 +63,15 @@ static void jz4740_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	uint32_t ctrl = jz4740_timer_get_ctrl(pwm->hwpwm);
 
-	/* Disable PWM output.
+	/*
+	 * Set duty > period. This trick allows the TCU channels in TCU2 mode to
+	 * properly return to their init level.
+	 */
+	jz4740_timer_set_duty(pwm->hwpwm, 0xffff);
+	jz4740_timer_set_period(pwm->hwpwm, 0x0);
+
+	/*
+	 * Disable PWM output.
 	 * In TCU2 mode (channel 1/2 on JZ4750+), this must be done before the
 	 * counter is stopped, while in TCU1 mode the order does not matter.
 	 */
-- 
2.21.0.593.g511ec345e18
