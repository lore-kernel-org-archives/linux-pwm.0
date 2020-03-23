From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/2] pwm: bcm-iproc: handle clk_get_rate() return
Date: Mon, 23 Mar 2020 12:23:17 +0530
Message-ID: <20200323065318.16533-2-rayagonda.kokatanur@broadcom.com>
References: <20200323065318.16533-1-rayagonda.kokatanur@broadcom.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40879 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgCWGxl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 02:53:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id a81so7646956wmf.5
        for <linux-pwm@vger.kernel.org>; Sun, 22 Mar 2020 23:53:40 -0700 (PDT)
In-Reply-To: <20200323065318.16533-1-rayagonda.kokatanur@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Handle clk_get_rate() returning <= 0 condition to avoid
possible division by zero.

Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/pwm/pwm-bcm-iproc.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 1f829edd8ee7..8bbd2a04fead 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -99,19 +99,25 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		state->polarity = PWM_POLARITY_INVERSED;
 
-	value = readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
-	prescale = value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm);
-	prescale &= IPROC_PWM_PRESCALE_MAX;
-
-	multi = NSEC_PER_SEC * (prescale + 1);
-
-	value = readl(ip->base + IPROC_PWM_PERIOD_OFFSET(pwm->hwpwm));
-	tmp = (value & IPROC_PWM_PERIOD_MAX) * multi;
-	state->period = div64_u64(tmp, rate);
-
-	value = readl(ip->base + IPROC_PWM_DUTY_CYCLE_OFFSET(pwm->hwpwm));
-	tmp = (value & IPROC_PWM_PERIOD_MAX) * multi;
-	state->duty_cycle = div64_u64(tmp, rate);
+	if (rate == 0) {
+		state->period = 0;
+		state->duty_cycle = 0;
+	} else {
+		value = readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
+		prescale = value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm);
+		prescale &= IPROC_PWM_PRESCALE_MAX;
+
+		multi = NSEC_PER_SEC * (prescale + 1);
+
+		value = readl(ip->base + IPROC_PWM_PERIOD_OFFSET(pwm->hwpwm));
+		tmp = (value & IPROC_PWM_PERIOD_MAX) * multi;
+		state->period = div64_u64(tmp, rate);
+
+		value = readl(ip->base +
+			      IPROC_PWM_DUTY_CYCLE_OFFSET(pwm->hwpwm));
+		tmp = (value & IPROC_PWM_PERIOD_MAX) * multi;
+		state->duty_cycle = div64_u64(tmp, rate);
+	}
 }
 
 static int iproc_pwmc_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.17.1
