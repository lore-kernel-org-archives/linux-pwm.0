From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 6/8] pwm: stm32: improve capture by tuning counter prescaler
Date: Tue, 16 Jan 2018 13:43:49 +0100
Message-ID: <1516106631-18722-7-git-send-email-fabrice.gasnier@st.com>
References: <1516106631-18722-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:31567 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750790AbeAPMpV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 16 Jan 2018 07:45:21 -0500
In-Reply-To: <1516106631-18722-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: lee.jones@linaro.org, thierry.reding@gmail.com, robh+dt@kernel.org, alexandre.torgue@st.com, benjamin.gaignard@linaro.org
Cc: mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, benjamin.gaignard@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

Currently, capture is based on timeout window to configure prescaler.
PWM capture framework provides 1s window at the time of writing.

There's place for improvement, after input signal has been captured once:
- Finer tune counter clock prescaler, by using 1st capture result (with
arbitrary margin).
- Do a 2nd capture, with scaled capture window.
This increases accuracy, especially at high rates.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pwm/pwm-stm32.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index b9c7e878..c890404 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -257,7 +257,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
 	unsigned long long prd, div, dty;
 	unsigned long rate;
-	unsigned int psc = 0;
+	unsigned int psc = 0, scale;
 	u32 raw_prd, raw_dty;
 	int ret = 0;
 
@@ -311,6 +311,30 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 	raw_prd = priv->capture[0];
 	raw_dty = priv->capture[1];
 
+	/*
+	 * Got a capture. Try to improve accuracy at high rates:
+	 * - decrease counter clock prescaler, scale up to max rate.
+	 */
+	if (raw_prd) {
+		u32 max_arr = priv->max_arr - 0x1000; /* arbitrary margin */
+
+		scale = max_arr / min(max_arr, raw_prd);
+	} else {
+		scale = priv->max_arr; /* bellow resolution, use max scale */
+	}
+
+	if (psc && scale > 1) {
+		/* 2nd measure with new scale */
+		regmap_write(priv->regmap, TIM_PSC, psc / scale);
+		ret = stm32_pwm_do_capture(priv, pwm, tmo_ms);
+		if (ret)
+			goto stop;
+
+		psc /= scale;
+		raw_prd = priv->capture[0];
+		raw_dty = priv->capture[1];
+	}
+
 	prd = (unsigned long long)raw_prd * (psc + 1) * NSEC_PER_SEC;
 	result->period = DIV_ROUND_UP_ULL(prd, rate);
 	dty = (unsigned long long)raw_dty * (psc + 1) * NSEC_PER_SEC;
-- 
1.9.1
