From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 2/4] pwm: bcm-kona: Remove impossible comparison when validating duty cycle
Date: Mon, 29 Jun 2020 13:47:50 +0100
Message-ID: <20200629124752.1018358-3-lee.jones@linaro.org>
References: <20200629124752.1018358-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200629124752.1018358-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-pwm@vger.kernel.org

'dc' here is an unsigned long, thus checking for <0 will always
evaluate to false.

Fixes the following W=1 warning:

 drivers/pwm/pwm-bcm-kona.c:141:35: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-pwm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-bcm-kona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 81da91df2529a..16c5898b934a8 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -138,7 +138,7 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		dc = div64_u64(val, div);
 
 		/* If duty_ns or period_ns are not achievable then return */
-		if (pc < PERIOD_COUNT_MIN || dc < DUTY_CYCLE_HIGH_MIN)
+		if (pc < PERIOD_COUNT_MIN)
 			return -EINVAL;
 
 		/* If pc and dc are in bounds, the calculation is done */
-- 
2.25.1
