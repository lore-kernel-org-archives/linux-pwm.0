From: Aditya Prayoga <aditya@kobol.io>
Subject: [PATCH RESEND 1/2] gpio: mvebu: Add support for multiple PWM lines per GPIO chip
Date: Mon,  6 Aug 2018 10:29:15 +0800
Message-ID: <1533522556-55055-2-git-send-email-aditya@kobol.io>
References: <1533522556-55055-1-git-send-email-aditya@kobol.io>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533522556-55055-1-git-send-email-aditya@kobol.io>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: Richard Genoud <richard.genoud@gmail.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Gauthier Provost <gauthier@kobol.io>, Alban Browaeys <alban.browaeys@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Aditya Prayoga <aditya@kobol.io>
List-Id: linux-pwm@vger.kernel.org

Allow more than 1 PWM request (eg. PWM fan) on the same GPIO chip.

based on initial work on LK4.4 by Alban Browaeys.
URL: https://github.com/helios-4/linux-marvell/commit/743ae97
[Aditya Prayoga: forward port, cleanup]
Signed-off-by: Aditya Prayoga <aditya@kobol.io>
---
 drivers/gpio/gpio-mvebu.c | 63 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 6e02148..0617e66 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -92,10 +92,17 @@
 
 #define MVEBU_MAX_GPIO_PER_BANK		32
 
+struct mvebu_pwm_item {
+	struct gpio_desc	*gpiod;
+	struct pwm_device	*device;
+	struct list_head	 node;
+};
+
 struct mvebu_pwm {
 	void __iomem		*membase;
 	unsigned long		 clk_rate;
-	struct gpio_desc	*gpiod;
+	int	 id;
+	struct list_head	 pwms;
 	struct pwm_chip		 chip;
 	spinlock_t		 lock;
 	struct mvebu_gpio_chip	*mvchip;
@@ -599,29 +606,31 @@ static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
 	struct mvebu_gpio_chip *mvchip = mvpwm->mvchip;
 	struct gpio_desc *desc;
+	struct mvebu_pwm_item *item;
 	unsigned long flags;
 	int ret = 0;
 
-	spin_lock_irqsave(&mvpwm->lock, flags);
-
-	if (mvpwm->gpiod) {
-		ret = -EBUSY;
-	} else {
-		desc = gpiochip_request_own_desc(&mvchip->chip,
-						 pwm->hwpwm, "mvebu-pwm");
-		if (IS_ERR(desc)) {
-			ret = PTR_ERR(desc);
-			goto out;
-		}
+	item = kzalloc(sizeof(*item), GFP_KERNEL);
+	if (!item)
+		return -ENODEV;
 
-		ret = gpiod_direction_output(desc, 0);
-		if (ret) {
-			gpiochip_free_own_desc(desc);
-			goto out;
-		}
+	spin_lock_irqsave(&mvpwm->lock, flags);
+	desc = gpiochip_request_own_desc(&mvchip->chip,
+					 pwm->hwpwm, "mvebu-pwm");
+	if (IS_ERR(desc)) {
+		ret = PTR_ERR(desc);
+		goto out;
+	}
 
-		mvpwm->gpiod = desc;
+	ret = gpiod_direction_output(desc, 0);
+	if (ret) {
+		gpiochip_free_own_desc(desc);
+		goto out;
 	}
+	item->gpiod = desc;
+	item->device = pwm;
+	INIT_LIST_HEAD(&item->node);
+	list_add_tail(&item->node, &mvpwm->pwms);
 out:
 	spin_unlock_irqrestore(&mvpwm->lock, flags);
 	return ret;
@@ -630,12 +639,20 @@ static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 static void mvebu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
+	struct mvebu_pwm_item *item, *tmp;
 	unsigned long flags;
 
-	spin_lock_irqsave(&mvpwm->lock, flags);
-	gpiochip_free_own_desc(mvpwm->gpiod);
-	mvpwm->gpiod = NULL;
-	spin_unlock_irqrestore(&mvpwm->lock, flags);
+	list_for_each_entry_safe(item, tmp, &mvpwm->pwms, node) {
+		if (item->device == pwm) {
+			spin_lock_irqsave(&mvpwm->lock, flags);
+			gpiochip_free_own_desc(item->gpiod);
+			item->gpiod = NULL;
+			item->device = NULL;
+			list_del(&item->node);
+			spin_unlock_irqrestore(&mvpwm->lock, flags);
+			kfree(item);
+		}
+	}
 }
 
 static void mvebu_pwm_get_state(struct pwm_chip *chip,
@@ -804,6 +821,8 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 		return -ENOMEM;
 	mvchip->mvpwm = mvpwm;
 	mvpwm->mvchip = mvchip;
+	mvpwm->id     = id;
+	INIT_LIST_HEAD(&mvpwm->pwms);
 
 	mvpwm->membase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(mvpwm->membase))
-- 
2.7.4
