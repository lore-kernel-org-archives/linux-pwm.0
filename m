From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 16/16] pwm: atmel: add push-pull mode support
Date: Fri, 12 Jan 2018 16:23:03 +0200
Message-ID: <1515766983-15151-17-git-send-email-claudiu.beznea@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, corbet@lwn.net, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>
List-Id: linux-pwm@vger.kernel.org

Add support for PWM push-pull mode. This is only supported by SAMA5D2 SoCs.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index e879d5459b55..0122f51723f8 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -33,8 +33,11 @@
 
 #define PWM_CMR			0x0
 /* Bit field in CMR */
-#define PWM_CMR_CPOL		(1 << 9)
-#define PWM_CMR_UPD_CDTY	(1 << 10)
+#define PWM_CMR_CPOL		BIT(9)
+#define PWM_CMR_UPD_CDTY	BIT(10)
+#define PWM_CMR_DTHI		BIT(17)
+#define PWM_CMR_DTLI		BIT(18)
+#define PWM_CMR_PPM		BIT(19)
 #define PWM_CMR_CPRE_MSK	0xF
 
 /* The following registers for PWM v1 */
@@ -228,7 +231,8 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->enabled) {
 		if (cstate.enabled &&
 		    cstate.polarity == state->polarity &&
-		    cstate.period == state->period) {
+		    cstate.period == state->period &&
+		    cstate.mode == state->mode) {
 			cprd = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
 						  atmel_pwm->regs->period);
 			atmel_pwm_calculate_cdty(state, cprd, &cdty);
@@ -263,6 +267,18 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			val &= ~PWM_CMR_CPOL;
 		else
 			val |= PWM_CMR_CPOL;
+
+		/* PWM mode. */
+		if (chip->caps->modes & PWM_MODE_PUSH_PULL) {
+			if (state->mode == PWM_MODE_PUSH_PULL) {
+				val |= PWM_CMR_PPM | PWM_CMR_DTHI;
+				val &= ~PWM_CMR_DTLI;
+			} else {
+				val &= ~(PWM_CMR_PPM | PWM_CMR_DTLI |
+					 PWM_CMR_DTHI);
+			}
+		}
+
 		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
 		atmel_pwm_set_cprd_cdty(chip, pwm, cprd, cdty);
 		mutex_lock(&atmel_pwm->isr_lock);
@@ -306,6 +322,20 @@ static const struct atmel_pwm_data atmel_pwm_data_v2 = {
 	},
 };
 
+static const struct atmel_pwm_data atmel_pwm_data_v3 = {
+	.regs = {
+		.period		= PWMV2_CPRD,
+		.period_upd	= PWMV2_CPRDUPD,
+		.duty		= PWMV2_CDTY,
+		.duty_upd	= PWMV2_CDTYUPD,
+	},
+	.caps = {
+		.modes = PWM_MODE_NORMAL |
+			 PWM_MODE_COMPLEMENTARY |
+			 PWM_MODE_PUSH_PULL,
+	},
+};
+
 static const struct platform_device_id atmel_pwm_devtypes[] = {
 	{
 		.name = "at91sam9rl-pwm",
@@ -328,7 +358,7 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
 		.data = &atmel_pwm_data_v2,
 	}, {
 		.compatible = "atmel,sama5d2-pwm",
-		.data = &atmel_pwm_data_v2,
+		.data = &atmel_pwm_data_v3,
 	}, {
 		/* sentinel */
 	},
-- 
2.7.4
