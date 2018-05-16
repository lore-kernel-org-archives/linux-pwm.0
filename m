From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [RESEND PATCH v5 4/6] pwm: stm32: improve capture by tuning counter
 prescaler
Date: Wed, 16 May 2018 09:35:59 +0200
Message-ID: <1526456161-27865-5-git-send-email-fabrice.gasnier@st.com>
References: <1526456161-27865-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1526456161-27865-1-git-send-email-fabrice.gasnier@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lee.jones@linaro.org, alexandre.torgue@st.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, benjamin.gaignard@linaro.org, linux-pwm@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, thierry.reding@gmail.com, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: linux-pwm@vger.kernel.org

Currently, capture is based on timeout window to configure prescaler.
PWM capture framework provides 1s window at the time of writing.

There's place for improvement, after input signal has been captured once:
- Finer tune counter clock prescaler, by using 1st capture result (with
arbitrary margin).
- Do a 2nd capture, with scaled capture window.
This increases accuracy, especially at high rates.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
---
Changes in v2:
- Adopt DMA read from MFD core.
---
 drivers/pwm/pwm-stm32.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index ed3961b..9a50acd 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -168,7 +168,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
 	unsigned long long prd, div, dty;
 	unsigned long rate;
-	unsigned int psc = 0;
+	unsigned int psc = 0, scale;
 	u32 raw_prd, raw_dty;
 	int ret = 0;
 
@@ -219,6 +219,28 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
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
