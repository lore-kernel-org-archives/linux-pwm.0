From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 3/3] pwm: imx: Implement get_state() function for hardware readout
Date: Mon,  1 Oct 2018 16:19:48 +0200
Message-ID: <1538403588-68850-3-git-send-email-michal.vokac@ysoft.com>
References: <1538403588-68850-1-git-send-email-michal.vokac@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538403588-68850-1-git-send-email-michal.vokac@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
List-Id: linux-pwm@vger.kernel.org

Implement the get_state() function and set the initial state to reflect
real state of the hardware. This allows to keep the PWM running if it was
enabled in bootloader. It is very similar to the GPIO behavior. GPIO pin
set as output in bootloader keep the same setting in Linux unless it is
reconfigured.

If we find the PWM block enabled we need to prepare and enable its source
clock otherwise the clock will be disabled late in the boot as unused.
That will leave the PWM in enabled state but with disabled clock. That has
a side effect that the PWM output is left at its current level at which
the clock was disabled. It is totally non-deterministic and it may be LOW
or HIGH.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 drivers/pwm/pwm-imx.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 7a4907b..6cd3b72 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -83,6 +83,9 @@
 
 #define MX3_PWM_SWR_LOOP		5
 
+/* PWMPR register value of 0xffff has the same effect as 0xfffe */
+#define MX3_PWMPR_MAX			0xfffe
+
 struct imx_chip {
 	struct clk	*clk_per;
 
@@ -93,6 +96,55 @@ struct imx_chip {
 
 #define to_imx_chip(chip)	container_of(chip, struct imx_chip, chip)
 
+static void imx_pwm_get_state(struct pwm_chip *chip,
+		struct pwm_device *pwm, struct pwm_state *state)
+{
+	struct imx_chip *imx = to_imx_chip(chip);
+	u32 period, prescaler, pwm_clk, ret, val;
+	u64 tmp;
+
+	val = readl(imx->mmio_base + MX3_PWMCR);
+
+	if (val & MX3_PWMCR_EN) {
+		state->enabled = true;
+		ret = clk_prepare_enable(imx->clk_per);
+		if (ret)
+			return;
+	} else {
+		state->enabled = false;
+	}
+
+	switch (FIELD_GET(MX3_PWMCR_POUTC, val)) {
+	case MX3_PWMCR_POUTC_NORMAL:
+		state->polarity = PWM_POLARITY_NORMAL;
+		break;
+	case MX3_PWMCR_POUTC_INVERTED:
+		state->polarity = PWM_POLARITY_INVERSED;
+		break;
+	default:
+		dev_warn(chip->dev, "can't set polarity, output disconnected");
+	}
+
+	prescaler = MX3_PWMCR_PRESCALER_GET(val);
+	pwm_clk = clk_get_rate(imx->clk_per);
+	pwm_clk = DIV_ROUND_CLOSEST_ULL(pwm_clk, prescaler);
+	val = readl(imx->mmio_base + MX3_PWMPR);
+	period = val >= MX3_PWMPR_MAX ? MX3_PWMPR_MAX : val;
+
+	/* PWMOUT (Hz) = PWMCLK / (PWMPR + 2) */
+	tmp = NSEC_PER_SEC * (u64)(period + 2);
+	state->period = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
+
+	/* PWMSAR can be read only if PWM is enabled */
+	if (state->enabled) {
+		val = readl(imx->mmio_base + MX3_PWMSAR);
+		tmp = NSEC_PER_SEC * (u64)(val);
+		state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
+	} else {
+		state->duty_cycle = 0;
+	}
+}
+
 static int imx_pwm_config_v1(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns)
 {
@@ -272,6 +324,7 @@ static const struct pwm_ops imx_pwm_ops_v1 = {
 
 static const struct pwm_ops imx_pwm_ops_v2 = {
 	.apply = imx_pwm_apply_v2,
+	.get_state = imx_pwm_get_state,
 	.owner = THIS_MODULE,
 };
 
-- 
2.1.4
