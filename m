From: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Subject: [RESEND PATCH v2 6/8] pwm: stm32: improve capture by tuning counter prescaler
Date: Wed, 14 Feb 2018 11:04:37 +0100
Message-ID: <1518602679-3064-7-git-send-email-fabrice.gasnier@st.com>
References: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1518602679-3064-1-git-send-email-fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org
Cc: benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, fabrice.gasnier-qxv4g6HH51o@public.gmane.org, benjamin.gaignard-qxv4g6HH51o@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Currently, capture is based on timeout window to configure prescaler.
PWM capture framework provides 1s window at the time of writing.

There's place for improvement, after input signal has been captured once:
- Finer tune counter clock prescaler, by using 1st capture result (with
arbitrary margin).
- Do a 2nd capture, with scaled capture window.
This increases accuracy, especially at high rates.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
