From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v15 08/11] pwm: sun4i: Use nsecs_to_jiffies to avoid a division
Date: Tue, 26 May 2020 10:35:08 -0700
Message-ID: <73a3e90f5a5a4fe4fb0f0412c7425effc338036b.1590514331.git.gurus@codeaurora.org>
References: <cover.1590514331.git.gurus@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1590514331.git.gurus@codeaurora.org>
In-Reply-To: <cover.1590514331.git.gurus@codeaurora.org>
References: <cover.1590514331.git.gurus@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Subbaraman Narayanamurthy <subbaram@codeaurora.org>, David Collins <collinsd@codeaurora.org>, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Guenter Roeck <linux@roeck-us.net>, Daniel Thompson <daniel.thompson@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, linux-arm-kernel@lists.infradead.org, Guru Das Srinagesh <gurus@codeaurora.org>
List-Id: linux-pwm@vger.kernel.org

Since the PWM framework is switching struct pwm_state.period's datatype
to u64, prepare for this transition by using nsecs_to_jiffies() which
does away with the need for a division operation.

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/pwm/pwm-sun4i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 5c677c5..1694e69 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -285,7 +285,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	val = (duty & PWM_DTY_MASK) | PWM_PRD(period);
 	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
 	sun4i_pwm->next_period[pwm->hwpwm] = jiffies +
-		usecs_to_jiffies(cstate.period / 1000 + 1);
+		nsecs_to_jiffies(cstate.period + 1000);
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		ctrl &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
