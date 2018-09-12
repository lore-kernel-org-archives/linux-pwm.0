From: Aditya Prayoga <aditya@kobol.io>
Subject: [PATCH v2 1/1] gpio: mvebu: Add support for multiple PWM lines per GPIO chip
Date: Wed, 12 Sep 2018 12:51:55 +0800
Message-ID: <1536727915-113932-2-git-send-email-aditya@kobol.io>
References: <1536727915-113932-1-git-send-email-aditya@kobol.io>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536727915-113932-1-git-send-email-aditya@kobol.io>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Richard Genoud <richard.genoud@gmail.com>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Gauthier Provost <gauthier@kobol.io>, Dennis Gilmore <dennis@ausil.us>, Aditya Prayoga <aditya@kobol.io>
List-Id: linux-pwm@vger.kernel.org

Allow more than 1 PWM request (eg. PWM fan) on the same GPIO chip. If
the other PWM counter is unused, allocate it to next PWM request.
The priority would be:
1. Default counter assigned to the bank
2. Unused counter that is assigned to other bank

Since there are only two PWM counters, only two PWMs supported.

Signed-off-by: Aditya Prayoga <aditya@kobol.io>
---
 drivers/gpio/gpio-mvebu.c | 73 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 60 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 6e02148..2d46b87 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -92,9 +92,16 @@
 
 #define MVEBU_MAX_GPIO_PER_BANK		32
 
+enum mvebu_pwm_counter {
+	MVEBU_PWM_CTRL_SET_A = 0,
+	MVEBU_PWM_CTRL_SET_B,
+	MVEBU_PWM_CTRL_MAX
+};
+
 struct mvebu_pwm {
 	void __iomem		*membase;
 	unsigned long		 clk_rate;
+	enum mvebu_pwm_counter   id;
 	struct gpio_desc	*gpiod;
 	struct pwm_chip		 chip;
 	spinlock_t		 lock;
@@ -128,6 +135,8 @@ struct mvebu_gpio_chip {
 	u32		   level_mask_regs[4];
 };
 
+static struct mvebu_pwm	*mvebu_pwm_list[MVEBU_PWM_CTRL_MAX];
+
 /*
  * Functions returning addresses of individual registers for a given
  * GPIO controller.
@@ -594,34 +603,59 @@ static struct mvebu_pwm *to_mvebu_pwm(struct pwm_chip *chip)
 	return container_of(chip, struct mvebu_pwm, chip);
 }
 
+static struct mvebu_pwm *mvebu_pwm_get_avail_counter(void)
+{
+	enum mvebu_pwm_counter i;
+
+	for (i = MVEBU_PWM_CTRL_SET_A; i < MVEBU_PWM_CTRL_MAX; i++) {
+		if (!mvebu_pwm_list[i]->gpiod)
+			return mvebu_pwm_list[i];
+	}
+	return NULL;
+}
+
 static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
 	struct mvebu_gpio_chip *mvchip = mvpwm->mvchip;
 	struct gpio_desc *desc;
+	struct mvebu_pwm *counter;
 	unsigned long flags;
 	int ret = 0;
 
 	spin_lock_irqsave(&mvpwm->lock, flags);
 
-	if (mvpwm->gpiod) {
-		ret = -EBUSY;
-	} else {
-		desc = gpiochip_request_own_desc(&mvchip->chip,
-						 pwm->hwpwm, "mvebu-pwm");
-		if (IS_ERR(desc)) {
-			ret = PTR_ERR(desc);
+	counter = mvpwm;
+	if (counter->gpiod) {
+		counter = mvebu_pwm_get_avail_counter();
+		if (!counter) {
+			ret = -EBUSY;
 			goto out;
 		}
 
-		ret = gpiod_direction_output(desc, 0);
-		if (ret) {
-			gpiochip_free_own_desc(desc);
-			goto out;
-		}
+		pwm->chip_data = counter;
+	}
 
-		mvpwm->gpiod = desc;
+	desc = gpiochip_request_own_desc(&mvchip->chip,
+					 pwm->hwpwm, "mvebu-pwm");
+	if (IS_ERR(desc)) {
+		ret = PTR_ERR(desc);
+		goto out;
 	}
+
+	ret = gpiod_direction_output(desc, 0);
+	if (ret) {
+		gpiochip_free_own_desc(desc);
+		goto out;
+	}
+
+	regmap_update_bits(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF +
+			   mvchip->offset, BIT(pwm->hwpwm),
+			   counter->id ? BIT(pwm->hwpwm) : 0);
+	regmap_read(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF +
+		    mvchip->offset, &counter->blink_select);
+
+	counter->gpiod = desc;
 out:
 	spin_unlock_irqrestore(&mvpwm->lock, flags);
 	return ret;
@@ -632,6 +666,11 @@ static void mvebu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
 	unsigned long flags;
 
+	if (pwm->chip_data) {
+		mvpwm = (struct mvebu_pwm *) pwm->chip_data;
+		pwm->chip_data = NULL;
+	}
+
 	spin_lock_irqsave(&mvpwm->lock, flags);
 	gpiochip_free_own_desc(mvpwm->gpiod);
 	mvpwm->gpiod = NULL;
@@ -648,6 +687,9 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
 	unsigned long flags;
 	u32 u;
 
+	if (pwm->chip_data)
+		mvpwm = (struct mvebu_pwm *) pwm->chip_data;
+
 	spin_lock_irqsave(&mvpwm->lock, flags);
 
 	val = (unsigned long long)
@@ -695,6 +737,9 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long flags;
 	unsigned int on, off;
 
+	if (pwm->chip_data)
+		mvpwm = (struct mvebu_pwm *) pwm->chip_data;
+
 	val = (unsigned long long) mvpwm->clk_rate * state->duty_cycle;
 	do_div(val, NSEC_PER_SEC);
 	if (val > UINT_MAX)
@@ -804,6 +849,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 		return -ENOMEM;
 	mvchip->mvpwm = mvpwm;
 	mvpwm->mvchip = mvchip;
+	mvpwm->id = id;
 
 	mvpwm->membase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(mvpwm->membase))
@@ -825,6 +871,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	 * region.
 	 */
 	mvpwm->chip.base = -1;
+	mvebu_pwm_list[id] = mvpwm;
 
 	spin_lock_init(&mvpwm->lock);
 
-- 
2.7.4
