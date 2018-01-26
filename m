From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v2 6/8] pwm: stm32: improve capture by tuning counter prescaler
Date: Fri, 26 Jan 2018 16:11:37 +0100
Message-ID: <1516979499-3665-7-git-send-email-fabrice.gasnier@st.com>
References: <1516979499-3665-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516979499-3665-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, thierry.reding@gmail.com, robh+dt@kernel.org, alexandre.torgue@st.com, benjamin.gaignard@linaro.org
Cc: mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, benjamin.gaignard@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Currently, capture is based on timeout window to configure prescaler.
PWM capture framework provides 1s window at the time of writing.

There's place for improvement, after input signal has been captured once:
- Finer tune counter clock prescaler, by using 1st capture result (with
arbitrary margin).
- Do a 2nd capture, with scaled capture window.
This increases accuracy, especially at high rates.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- Adopt DMA read from MFD core.
---
 drivers/pwm/pwm-stm32.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index f3a92fc..5dfb296 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -169,7 +169,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
 	unsigned long long prd, div, dty;
 	unsigned long rate;
-	unsigned int psc = 0;
+	unsigned int psc = 0, scale;
 	u32 raw_prd, raw_dty;
 	int ret = 0;
 
@@ -220,6 +220,28 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (ret)
 		goto stop;
 
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
+		psc /= scale;
+		regmap_write(priv->regmap, TIM_PSC, psc);
+		ret = stm32_pwm_raw_capture(priv, pwm, tmo_ms, &raw_prd,
+					    &raw_dty);
+		if (ret)
+			goto stop;
+	}
+
 	prd = (unsigned long long)raw_prd * (psc + 1) * NSEC_PER_SEC;
 	result->period = DIV_ROUND_UP_ULL(prd, rate);
 	dty = (unsigned long long)raw_dty * (psc + 1) * NSEC_PER_SEC;
-- 
1.9.1
