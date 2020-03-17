From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v9 04/11] pwm: clps711x: Use 64-bit division macro
Date: Tue, 17 Mar 2020 13:05:19 -0700
Message-ID: <587f9ccae68ad7e1ce97fa8da6037292af1a5095.1584473399.git.gurus@codeaurora.org>
References: <cover.1584473399.git.gurus@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1584473399.git.gurus@codeaurora.org>
In-Reply-To: <cover.1584473399.git.gurus@codeaurora.org>
References: <cover.1584473399.git.gurus@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Guru Das Srinagesh <gurus@codeaurora.org>, Alexander Shiyan <shc_work@mail.ru>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pwm@vger.kernel.org

Since the PWM framework is switching struct pwm_args.period's datatype
to u64, prepare for this transition by using DIV64_U64_ROUND_CLOSEST to
handle a 64-bit divisor.

Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Arnd Bergmann <arnd@arndb.de>

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
