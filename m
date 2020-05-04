From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [RESEND PATCH v14 04/11] pwm: clps711x: Cast period to u32 before use as divisor
Date: Mon,  4 May 2020 11:50:10 -0700
Message-ID: <1d6918c3fc2976bdbdb687bf54a2ef09fc1558db.1588616856.git.gurus@codeaurora.org>
References: <cover.1588616856.git.gurus@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1588616856.git.gurus@codeaurora.org>
In-Reply-To: <cover.1588616856.git.gurus@codeaurora.org>
References: <cover.1588616856.git.gurus@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Subbaraman Narayanamurthy <subbaram@codeaurora.org>, David Collins <collinsd@codeaurora.org>, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Guenter Roeck <linux@roeck-us.net>, Daniel Thompson <daniel.thompson@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, Guru Das Srinagesh <gurus@codeaurora.org>
List-Id: linux-pwm@vger.kernel.org

Since the PWM framework is switching struct pwm_args.period's datatype
to u64, prepare for this transition by typecasting it to u32.

Also, since the dividend is still a 32-bit number, any divisor greater
than the numerator will cause the quotient to be zero, so return 0 in
that case to efficiently skip the division.

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/pwm/pwm-clps711x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 924d39a..da771b1 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -43,7 +43,10 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
 static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
 {
 	/* Duty cycle 0..15 max */
-	return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
+	if (pwm->args.period > (v * 0xf))
+		return 0;
+
+	return DIV_ROUND_CLOSEST(v * 0xf, (u32)pwm->args.period);
 }
 
 static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
