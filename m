From: Ajay Kumar <ajaykumar.rs@samsung.com>
Subject: [PATCH] pwm: samsung: do not set manual update bit in
 pwm_samsung_config
Date: Mon, 12 May 2014 20:26:21 +0530
Message-ID: <1399906581-29298-1-git-send-email-ajaykumar.rs@samsung.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:45362 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758634AbaELO5z (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 12 May 2014 10:57:55 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, ajaynumb@gmail.com, thierry.reding@gmail.com, tomasz.figa@gmail.com, abrestic@chromium.org, jg1.han@samsung.com, sachin.kamat@linaro.org, joshi@samsung.com, prashanth.g@samsung.com, Ajay Kumar <ajaykumar.rs@samsung.com>

pwm_samsung_config sets manual update bit via call to
pwm_samsung_enable even when the channel is already running.
This causes noticable flickers on display if we try to change
the backlight value from 0 to MAX, continiously.

So, we remove the call to pwm_samsung_enable from
pwm_samsung_config to avoid the flicker and this change doesn't
harm normal working since the pwm_bl core already takes care of
calling pwm_samsung_enable whenever needed.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 drivers/pwm/pwm-samsung.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index d66529a..ba6b650 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -335,9 +335,6 @@ static int pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	writel(tcnt, our_chip->base + REG_TCNTB(pwm->hwpwm));
 	writel(tcmp, our_chip->base + REG_TCMPB(pwm->hwpwm));
 
-	if (test_bit(PWMF_ENABLED, &pwm->flags))
-		pwm_samsung_enable(chip, pwm);
-
 	chan->period_ns = period_ns;
 	chan->tin_ns = tin_ns;
 	chan->duty_ns = duty_ns;
-- 
1.8.3.2

