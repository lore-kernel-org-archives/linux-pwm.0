From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v10 04/12] pwm: clps711x: Cast period to u32 before use as divisor
Date: Thu, 19 Mar 2020 13:50:07 -0700
Message-ID: <8822fc43463039744581398be844f4417f62abcd.1584650604.git.gurus@codeaurora.org>
References: <cover.1584650604.git.gurus@codeaurora.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:27920 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgCSUuT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Mar 2020 16:50:19 -0400
In-Reply-To: <cover.1584650604.git.gurus@codeaurora.org>
In-Reply-To: <cover.1584650604.git.gurus@codeaurora.org>
References: <cover.1584650604.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Guru Das Srinagesh <gurus@codeaurora.org>, Alexander Shiyan <shc_work@mail.ru>, Arnd Bergmann <arnd@arndb.de>

Since the PWM framework is switching struct pwm_args.period's datatype
to u64, prepare for this transition by typecasting it to u32.

Also, since the dividend is still a 32-bit number, any divisor greater
than UINT_MAX will cause the quotient to be zero, so return 0 in that
case to efficiently skip the division.

Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Arnd Bergmann <arnd@arndb.de>

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/pwm/pwm-clps711x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 924d39a..f34f1f3 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -43,7 +43,10 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
 static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
 {
 	/* Duty cycle 0..15 max */
-	return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
+	if (pwm->args.period > UINT_MAX)
+		return 0;
+
+	return DIV_ROUND_CLOSEST(v * 0xf, (u32)pwm->args.period);
 }
 
 static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
