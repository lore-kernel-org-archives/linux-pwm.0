From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 1/2] PWM: atmel: fix incorrect CDTY value after enabling
Date: Mon, 25 May 2015 15:19:55 +0200
Message-ID: <1432559996-4415-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:32925 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750800AbbEYNUN (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 25 May 2015 09:20:13 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

CUPD is not flushed before enabling the channel so it will update CDTY/CPRD just
after one period. So we always set CUPD, even when the channel is not enabled.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/pwm/pwm-atmel.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index d3c22de9ee47..89f9ca41d9af 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -155,24 +155,25 @@ static void atmel_pwm_config_v1(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 	unsigned int val;
 
-	if (test_bit(PWMF_ENABLED, &pwm->flags)) {
-		/*
-		 * If the PWM channel is enabled, using the update register,
-		 * it needs to set bit 10 of CMR to 0
-		 */
-		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CUPD, dty);
 
-		val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
-		val &= ~PWM_CMR_UPD_CDTY;
-		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
-	} else {
-		/*
-		 * If the PWM channel is disabled, write value to duty and
-		 * period registers directly.
-		 */
-		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CDTY, dty);
-		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CPRD, prd);
-	}
+	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CUPD, dty);
+
+	val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
+	val &= ~PWM_CMR_UPD_CDTY;
+	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
+
+	/*
+	 * If the PWM channel is enabled, only update CDTY by using the update
+	 * register, it needs to set bit 10 of CMR to 0
+	 */
+	if (test_bit(PWMF_ENABLED, &pwm->flags))
+		return;
+	/*
+	 * If the PWM channel is disabled, write value to duty and period
+	 * registers directly.
+	 */
+	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CDTY, dty);
+	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CPRD, prd);
 }
 
 static void atmel_pwm_config_v2(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.1.4
