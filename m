From: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Subject: [RESEND PATCH v2 7/8] pwm: stm32: use input prescaler to improve period capture
Date: Wed, 14 Feb 2018 11:04:38 +0100
Message-ID: <1518602679-3064-8-git-send-email-fabrice.gasnier@st.com>
References: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1518602679-3064-1-git-send-email-fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org
Cc: benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, fabrice.gasnier-qxv4g6HH51o@public.gmane.org, benjamin.gaignard-qxv4g6HH51o@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Using input prescaler, capture unit will trigger DMA once every
configurable /2, /4 or /8 events (rising edge). This helps improve
period (only) capture accuracy at high rates.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
Changes in v2:
- Adopt DMA read from MFD core.
---
 drivers/pwm/pwm-stm32.c          | 63 ++++++++++++++++++++++++++++++++++++++--
 include/linux/mfd/stm32-timers.h |  1 +
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 5dfb296..67964f5 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -9,6 +9,7 @@
  *             pwm-atmel.c from Bo Shen
  */
 
+#include <linux/bitfield.h>
 #include <linux/mfd/stm32-timers.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -169,7 +170,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
 	unsigned long long prd, div, dty;
 	unsigned long rate;
-	unsigned int psc = 0, scale;
+	unsigned int psc = 0, icpsc, scale;
 	u32 raw_prd, raw_dty;
 	int ret = 0;
 
@@ -223,6 +224,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 	/*
 	 * Got a capture. Try to improve accuracy at high rates:
 	 * - decrease counter clock prescaler, scale up to max rate.
+	 * - use input prescaler, capture once every /2 /4 or /8 edges.
 	 */
 	if (raw_prd) {
 		u32 max_arr = priv->max_arr - 0x1000; /* arbitrary margin */
@@ -242,8 +244,65 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 			goto stop;
 	}
 
+	/* Compute intermediate period not to exceed timeout at low rates */
 	prd = (unsigned long long)raw_prd * (psc + 1) * NSEC_PER_SEC;
-	result->period = DIV_ROUND_UP_ULL(prd, rate);
+	do_div(prd, rate);
+
+	for (icpsc = 0; icpsc < MAX_TIM_ICPSC ; icpsc++) {
+		/* input prescaler: also keep arbitrary margin */
+		if (raw_prd >= (priv->max_arr - 0x1000) >> (icpsc + 1))
+			break;
+		if (prd >= (tmo_ms * NSEC_PER_MSEC) >> (icpsc + 2))
+			break;
+	}
+
+	if (!icpsc)
+		goto done;
+
+	/* Last chance to improve period accuracy, using input prescaler */
+	regmap_update_bits(priv->regmap,
+			   pwm->hwpwm < 2 ? TIM_CCMR1 : TIM_CCMR2,
+			   TIM_CCMR_IC1PSC | TIM_CCMR_IC2PSC,
+			   FIELD_PREP(TIM_CCMR_IC1PSC, icpsc) |
+			   FIELD_PREP(TIM_CCMR_IC2PSC, icpsc));
+
+	ret = stm32_pwm_raw_capture(priv, pwm, tmo_ms, &raw_prd, &raw_dty);
+	if (ret)
+		goto stop;
+
+	if (raw_dty >= (raw_prd >> icpsc)) {
+		/*
+		 * We may fall here using input prescaler, when input
+		 * capture starts on high side (before falling edge).
+		 * Example with icpsc to capture on each 4 events:
+		 *
+		 *       start   1st capture                     2nd capture
+		 *         v     v                               v
+		 *         ___   _____   _____   _____   _____   ____
+		 * TI1..4     |__|    |__|    |__|    |__|    |__|
+		 *            v  v    .  .    .  .    .       v  v
+		 * icpsc1/3:  .  0    .  1    .  2    .  3    .  0
+		 * icpsc2/4:  0       1       2       3       0
+		 *            v  v                            v  v
+		 * CCR1/3  ......t0..............................t2
+		 * CCR2/4  ..t1..............................t1'...
+		 *               .                            .  .
+		 * Capture0:     .<----------------------------->.
+		 * Capture1:     .<-------------------------->.  .
+		 *               .                            .  .
+		 * Period:       .<------>                    .  .
+		 * Low side:                                  .<>.
+		 *
+		 * Result:
+		 * - Period = Capture0 / icpsc
+		 * - Duty = Period - Low side = Period - (Capture0 - Capture1)
+		 */
+		raw_dty = (raw_prd >> icpsc) - (raw_prd - raw_dty);
+	}
+
+done:
+	prd = (unsigned long long)raw_prd * (psc + 1) * NSEC_PER_SEC;
+	result->period = DIV_ROUND_UP_ULL(prd, rate << icpsc);
 	dty = (unsigned long long)raw_dty * (psc + 1) * NSEC_PER_SEC;
 	result->duty_cycle = DIV_ROUND_UP_ULL(dty, rate);
 stop:
diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index 3abfa04..734cbca 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -82,6 +82,7 @@
 #define TIM_DCR_DBL	GENMASK(12, 8)	/* DMA burst len */
 
 #define MAX_TIM_PSC		0xFFFF
+#define MAX_TIM_ICPSC		0x3
 #define TIM_CR2_MMS_SHIFT	4
 #define TIM_CR2_MMS2_SHIFT	20
 #define TIM_SMCR_TS_SHIFT	4
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
