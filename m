From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/2] drivers: pwm: pwm-atmel: implement pwm dead-times
Date: Mon, 8 May 2017 17:24:23 +0300
Message-ID: <1494253463-26993-3-git-send-email-claudiu.beznea@microchip.com>
References: <1494253463-26993-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494253463-26993-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, corbet@lwn.net, alexandre.belloni@free-electrons.com, boris.brezillon@free-electrons.com, linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@microchip.com, claudiu.beznea@microchip.com
List-Id: linux-pwm@vger.kernel.org

Implement PWM dead-times for atmel PWM controllers.
Since this driver is used by PWM controllers which
supports dead-times and PWM controllers which doesn't,
add specific input for dead-time register in atmel
register private data structure.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 62 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 530d7dc..4fba167 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -33,8 +33,9 @@
 
 #define PWM_CMR			0x0
 /* Bit field in CMR */
-#define PWM_CMR_CPOL		(1 << 9)
-#define PWM_CMR_UPD_CDTY	(1 << 10)
+#define PWM_CMR_CPOL		BIT(9)
+#define PWM_CMR_UPD_CDTY	BIT(10)
+#define PWM_CMR_DTE		BIT(16)
 #define PWM_CMR_CPRE_MSK	0xF
 
 /* The following registers for PWM v1 */
@@ -47,6 +48,7 @@
 #define PWMV2_CDTYUPD		0x08
 #define PWMV2_CPRD		0x0C
 #define PWMV2_CPRDUPD		0x10
+#define PWMV2_DT		0x18
 
 /*
  * Max value for duty and period
@@ -63,6 +65,7 @@ struct atmel_pwm_registers {
 	u8 period_upd;
 	u8 duty;
 	u8 duty_upd;
+	u8 dt;
 };
 
 struct atmel_pwm_chip {
@@ -161,6 +164,32 @@ static void atmel_pwm_update_cdty(struct pwm_chip *chip, struct pwm_device *pwm,
 			    atmel_pwm->regs->duty_upd, cdty);
 }
 
+static int atmel_pwm_calculate_deadtime(struct pwm_chip *chip,
+					struct pwm_state *state,
+					unsigned long cprd, unsigned long *dt)
+{
+	unsigned long long cycles;
+
+	if (state->deadtime_fe > state->duty_cycle ||
+	    state->deadtime_re > state->period - state->duty_cycle)
+		return -EINVAL;
+
+	*dt = 0;
+	if (state->deadtime_fe) {
+		cycles = (unsigned long long)state->deadtime_fe * cprd;
+		do_div(cycles, state->period);
+		*dt = (cycles << 16);
+	}
+
+	if (state->deadtime_re) {
+		cycles = (unsigned long long)state->deadtime_re * cprd;
+		do_div(cycles, state->period);
+		*dt |= cycles;
+	}
+
+	return 0;
+}
+
 static void atmel_pwm_set_cprd_cdty(struct pwm_chip *chip,
 				    struct pwm_device *pwm,
 				    unsigned long cprd, unsigned long cdty)
@@ -214,7 +243,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 	struct pwm_state cstate;
-	unsigned long cprd, cdty;
+	unsigned long cprd, cdty, dt;
 	u32 pres, val;
 	int ret;
 
@@ -223,7 +252,9 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->enabled) {
 		if (cstate.enabled &&
 		    cstate.polarity == state->polarity &&
-		    cstate.period == state->period) {
+		    cstate.period == state->period &&
+		    cstate.deadtime_re == state->deadtime_re &&
+		    cstate.deadtime_fe == state->deadtime_fe) {
 			cprd = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
 						  atmel_pwm->regs->period);
 			atmel_pwm_calculate_cdty(state, cprd, &cdty);
@@ -239,6 +270,16 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			return ret;
 		}
 
+		if (atmel_pwm->regs->dt) {
+			ret = atmel_pwm_calculate_deadtime(chip, state, cprd,
+							   &dt);
+			if (ret) {
+				dev_err(chip->dev,
+					"failed to calculate dead-time\n");
+				return ret;
+			}
+		}
+
 		atmel_pwm_calculate_cdty(state, cprd, &cdty);
 
 		if (cstate.enabled) {
@@ -258,8 +299,19 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			val &= ~PWM_CMR_CPOL;
 		else
 			val |= PWM_CMR_CPOL;
+
+		if (atmel_pwm->regs->dt) {
+			if (dt)
+				val |= PWM_CMR_DTE;
+			else
+				val &= ~PWM_CMR_DTE;
+		}
+
 		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
 		atmel_pwm_set_cprd_cdty(chip, pwm, cprd, cdty);
+		if (atmel_pwm->regs->dt)
+			atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm,
+					    atmel_pwm->regs->dt, dt);
 		mutex_lock(&atmel_pwm->isr_lock);
 		atmel_pwm->updated_pwms |= atmel_pwm_readl(atmel_pwm, PWM_ISR);
 		atmel_pwm->updated_pwms &= ~(1 << pwm->hwpwm);
@@ -282,6 +334,7 @@ static const struct atmel_pwm_registers atmel_pwm_regs_v1 = {
 	.period_upd	= PWMV1_CUPD,
 	.duty		= PWMV1_CDTY,
 	.duty_upd	= PWMV1_CUPD,
+	.dt		= 0,
 };
 
 static const struct atmel_pwm_registers atmel_pwm_regs_v2 = {
@@ -289,6 +342,7 @@ static const struct atmel_pwm_registers atmel_pwm_regs_v2 = {
 	.period_upd	= PWMV2_CPRDUPD,
 	.duty		= PWMV2_CDTY,
 	.duty_upd	= PWMV2_CDTYUPD,
+	.dt		= PWMV2_DT,
 };
 
 static const struct platform_device_id atmel_pwm_devtypes[] = {
-- 
2.7.4
