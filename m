From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/4] pwm: jz4740: Enhance precision in calculation of duty cycle
Date: Mon, 25 May 2020 14:57:20 +0200
Message-ID: <20200525125722.36447-2-paul@crapouillou.net>
References: <20200525125722.36447-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200525125722.36447-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

Calculating the hardware value for the duty from the hardware value of
the period resulted in a precision loss versus calculating it from the
clock rate directly.

(Also remove a cast that doesn't really need to be here)

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: New patch. I don't consider this a fix but an enhancement, since the old
    	behaviour was in place since the driver was born in ~2010, so no Fixes tag.

 drivers/pwm/pwm-jz4740.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 3cd5c054ad9a..4fe9d99ac9a9 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -158,11 +158,11 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* Calculate period value */
 	tmp = (unsigned long long)rate * state->period;
 	do_div(tmp, NSEC_PER_SEC);
-	period = (unsigned long)tmp;
+	period = tmp;
 
 	/* Calculate duty value */
-	tmp = (unsigned long long)period * state->duty_cycle;
-	do_div(tmp, state->period);
+	tmp = (unsigned long long)rate * state->duty_cycle;
+	do_div(tmp, NSEC_PER_SEC);
 	duty = period - tmp;
 
 	if (duty >= period)
-- 
2.26.2
