From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCHv2 2/2] PWM: atmel: fix incorrect CDTY value after disabling
Date: Mon, 25 May 2015 18:11:49 +0200
Message-ID: <1432570309-17819-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1432559996-4415-2-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432559996-4415-2-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

pwm-leds calls .config() and .disable() in a row. This exhibits that it may
happen that the channel gets disabled before CDTY has been updated with CUPD.
The issue gets quite worse with long periods.
So, ensure that at least one period has past before disabling the channel by
polling ISR.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
I had the previous patch tested on a multicolor LED and unfortunately, the delay
is not nice in that case. I wanted to avoid a mutex.
This version uses a variable to store the state of the update of the pwm. This
is reset everytime is gets a new configuration and updated when it is disabled
or another pwm is configured.
When disabling a multicolor LED, we only wait for the first pwm to update then
we remember that we already seen the other one having their period expire and it
looks much better.

 drivers/pwm/pwm-atmel.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)


diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 89f9ca41d9af..a947c9095d9d 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -8,9 +8,11 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -21,6 +23,7 @@
 #define PWM_ENA			0x04
 #define PWM_DIS			0x08
 #define PWM_SR			0x0C
+#define PWM_ISR			0x1C
 /* Bit field in SR */
 #define PWM_SR_ALL_CH_ON	0x0F
 
@@ -60,6 +63,9 @@ struct atmel_pwm_chip {
 	struct clk *clk;
 	void __iomem *base;
 
+	unsigned int updated_pwms;
+	struct mutex isr_lock; /* ISR is cleared when read, ensure only one thread does that */
+
 	void (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
 		       unsigned long dty, unsigned long prd);
 };
@@ -144,6 +150,10 @@ static int atmel_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	val = (val & ~PWM_CMR_CPRE_MSK) | (pres & PWM_CMR_CPRE_MSK);
 	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
 	atmel_pwm->config(chip, pwm, dty, prd);
+	mutex_lock(&atmel_pwm->isr_lock);
+	atmel_pwm->updated_pwms |= atmel_pwm_readl(atmel_pwm, PWM_ISR);
+	atmel_pwm->updated_pwms &= ~(1 << pwm->hwpwm);
+	mutex_unlock(&atmel_pwm->isr_lock);
 
 	clk_disable(atmel_pwm->clk);
 	return ret;
@@ -243,7 +253,22 @@ static int atmel_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
+	unsigned long timeout = jiffies + 2 * HZ;
+
+	/*
+	 * Wait for at least a complete period to have passed before disabling a
+	 * channel to be sure that CDTY has been updated
+	 */
+	mutex_lock(&atmel_pwm->isr_lock);
+	atmel_pwm->updated_pwms |= atmel_pwm_readl(atmel_pwm, PWM_ISR);
+
+	while (!(atmel_pwm->updated_pwms & (1 << pwm->hwpwm)) &&
+	       time_before(jiffies, timeout)) {
+		usleep_range(10, 100);
+		atmel_pwm->updated_pwms |= atmel_pwm_readl(atmel_pwm, PWM_ISR);
+	}
 
+	mutex_unlock(&atmel_pwm->isr_lock);
 	atmel_pwm_writel(atmel_pwm, PWM_DIS, 1 << pwm->hwpwm);
 
 	clk_disable(atmel_pwm->clk);
@@ -358,6 +383,8 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	atmel_pwm->chip.npwm = 4;
 	atmel_pwm->chip.can_sleep = true;
 	atmel_pwm->config = data->config;
+	atmel_pwm->updated_pwms = 0;
+	mutex_init(&atmel_pwm->isr_lock);
 
 	ret = pwmchip_add(&atmel_pwm->chip);
 	if (ret < 0) {
@@ -379,6 +406,7 @@ static int atmel_pwm_remove(struct platform_device *pdev)
 	struct atmel_pwm_chip *atmel_pwm = platform_get_drvdata(pdev);
 
 	clk_unprepare(atmel_pwm->clk);
+	mutex_destroy(&atmel_pwm->isr_lock);
 
 	return pwmchip_remove(&atmel_pwm->chip);
 }
-- 
2.1.4
