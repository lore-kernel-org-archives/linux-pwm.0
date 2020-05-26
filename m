From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v15 04/11] pwm: clps711x: Use 64-bit division macro
Date: Tue, 26 May 2020 10:35:04 -0700
Message-ID: <dd03cc467ac3fc470826aef523822b32e15dc929.1590514331.git.gurus@codeaurora.org>
References: <cover.1590514331.git.gurus@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1590514331.git.gurus@codeaurora.org>
In-Reply-To: <cover.1590514331.git.gurus@codeaurora.org>
References: <cover.1590514331.git.gurus@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Subbaraman Narayanamurthy <subbaram@codeaurora.org>, David Collins <collinsd@codeaurora.org>, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Guenter Roeck <linux@roeck-us.net>, Daniel Thompson <daniel.thompson@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, linux-arm-kernel@lists.infradead.org, Guru Das Srinagesh <gurus@codeaurora.org>
List-Id: linux-pwm@vger.kernel.org

Since the PWM framework is switching struct pwm_args.period's datatype
to u64, prepare for this transition by using DIV64_U64_ROUND_CLOSEST to
handle a 64-bit divisor.

Cc: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/pwm/pwm-clps711x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 924d39a..ba9500a 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -43,7 +43,7 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
 static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
 {
 	/* Duty cycle 0..15 max */
-	return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
+	return DIV64_U64_ROUND_CLOSEST(v * 0xf, pwm->args.period);
 }
 
 static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
