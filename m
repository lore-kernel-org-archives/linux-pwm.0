From: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: [PATCH RFC 1/6] gpio: mvebu: convert pwm to regmap
Date: Sun, 29 Mar 2020 11:48:04 +0100
Message-ID: <E1jIVU4-0005gx-Mh@rmk-PC.armlinux.org.uk>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200329104549.GX25745-QEMnZ+CodIVURfEZ8mYm6t73F7V6hmMc@public.gmane.org>
Content-Disposition: inline
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gregory Clement <gregory.clement-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe Kleine-Konig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Convert mvebu's pwm support to use regmap to access the registers to
prepare the driver to support the "blink" support on CP110.

Signed-off-by: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
---
 drivers/gpio/gpio-mvebu.c | 69 ++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index e64c40095356..fa5641615db6 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -94,7 +94,8 @@
 #define MVEBU_MAX_GPIO_PER_BANK		32
 
 struct mvebu_pwm {
-	void __iomem		*membase;
+	struct regmap		*regs;
+	u32			 offset;
 	unsigned long		 clk_rate;
 	struct gpio_desc	*gpiod;
 	struct pwm_chip		 chip;
@@ -129,6 +130,13 @@ struct mvebu_gpio_chip {
 	u32		   level_mask_regs[4];
 };
 
+static const struct regmap_config mvebu_gpio_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+};
+
 /*
  * Functions returning addresses of individual registers for a given
  * GPIO controller.
@@ -280,17 +288,17 @@ mvebu_gpio_write_level_mask(struct mvebu_gpio_chip *mvchip, u32 val)
 }
 
 /*
- * Functions returning addresses of individual registers for a given
+ * Functions returning regmap offsets of individual registers for a given
  * PWM controller.
  */
-static void __iomem *mvebu_pwmreg_blink_on_duration(struct mvebu_pwm *mvpwm)
+static u32 mvebu_pwmreg_blink_on_duration(struct mvebu_pwm *mvpwm)
 {
-	return mvpwm->membase + PWM_BLINK_ON_DURATION_OFF;
+	return PWM_BLINK_ON_DURATION_OFF + mvpwm->offset;
 }
 
-static void __iomem *mvebu_pwmreg_blink_off_duration(struct mvebu_pwm *mvpwm)
+static u32 mvebu_pwmreg_blink_off_duration(struct mvebu_pwm *mvpwm)
 {
-	return mvpwm->membase + PWM_BLINK_OFF_DURATION_OFF;
+	return PWM_BLINK_OFF_DURATION_OFF + mvpwm->offset;
 }
 
 /*
@@ -660,8 +668,8 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
 
 	spin_lock_irqsave(&mvpwm->lock, flags);
 
-	val = (unsigned long long)
-		readl_relaxed(mvebu_pwmreg_blink_on_duration(mvpwm));
+	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm), &u);
+	val = (unsigned long long)u;
 	val *= NSEC_PER_SEC;
 	do_div(val, mvpwm->clk_rate);
 	if (val > UINT_MAX)
@@ -671,8 +679,8 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
 	else
 		state->duty_cycle = 1;
 
-	val = (unsigned long long)
-		readl_relaxed(mvebu_pwmreg_blink_off_duration(mvpwm));
+	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm), &u);
+	val = (unsigned long long)u;
 	val *= NSEC_PER_SEC;
 	do_div(val, mvpwm->clk_rate);
 	if (val < state->duty_cycle) {
@@ -726,8 +734,8 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	spin_lock_irqsave(&mvpwm->lock, flags);
 
-	writel_relaxed(on, mvebu_pwmreg_blink_on_duration(mvpwm));
-	writel_relaxed(off, mvebu_pwmreg_blink_off_duration(mvpwm));
+	regmap_write(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm), on);
+	regmap_write(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm), off);
 	if (state->enabled)
 		mvebu_gpio_blink(&mvchip->chip, pwm->hwpwm, 1);
 	else
@@ -752,10 +760,10 @@ static void __maybe_unused mvebu_pwm_suspend(struct mvebu_gpio_chip *mvchip)
 
 	regmap_read(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset,
 		    &mvpwm->blink_select);
-	mvpwm->blink_on_duration =
-		readl_relaxed(mvebu_pwmreg_blink_on_duration(mvpwm));
-	mvpwm->blink_off_duration =
-		readl_relaxed(mvebu_pwmreg_blink_off_duration(mvpwm));
+	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm),
+		    &mvpwm->blink_on_duration);
+	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm),
+		    &mvpwm->blink_off_duration);
 }
 
 static void __maybe_unused mvebu_pwm_resume(struct mvebu_gpio_chip *mvchip)
@@ -764,10 +772,10 @@ static void __maybe_unused mvebu_pwm_resume(struct mvebu_gpio_chip *mvchip)
 
 	regmap_write(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset,
 		     mvpwm->blink_select);
-	writel_relaxed(mvpwm->blink_on_duration,
-		       mvebu_pwmreg_blink_on_duration(mvpwm));
-	writel_relaxed(mvpwm->blink_off_duration,
-		       mvebu_pwmreg_blink_off_duration(mvpwm));
+	regmap_write(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm),
+		     mvpwm->blink_on_duration);
+	regmap_write(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm),
+		     mvpwm->blink_off_duration);
 }
 
 static int mvebu_pwm_probe(struct platform_device *pdev,
@@ -776,6 +784,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct mvebu_pwm *mvpwm;
+	void __iomem *base;
 	u32 set;
 
 	if (!of_device_is_compatible(mvchip->chip.of_node,
@@ -795,12 +804,14 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 		set = U32_MAX;
 	else
 		return -EINVAL;
+
 	regmap_write(mvchip->regs,
 		     GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset, set);
 
 	mvpwm = devm_kzalloc(dev, sizeof(struct mvebu_pwm), GFP_KERNEL);
 	if (!mvpwm)
 		return -ENOMEM;
+
 	mvchip->mvpwm = mvpwm;
 	mvpwm->mvchip = mvchip;
 
@@ -810,9 +821,14 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	 * for the first two GPIO chips. So if the resource is missing
 	 * we can't treat it as an error.
 	 */
-	mvpwm->membase = devm_platform_ioremap_resource_byname(pdev, "pwm");
-	if (IS_ERR(mvpwm->membase))
-		return PTR_ERR(mvpwm->membase);
+	base = devm_platform_ioremap_resource_byname(pdev, "pwm");
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	mvpwm->regs = devm_regmap_init_mmio(&pdev->dev, base,
+					    &mvebu_gpio_regmap_config);
+	if (IS_ERR(mvpwm->regs))
+		return PTR_ERR(mvpwm->regs);
 
 	mvpwm->clk_rate = clk_get_rate(mvchip->clk);
 	if (!mvpwm->clk_rate) {
@@ -1023,13 +1039,6 @@ static int mvebu_gpio_resume(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct regmap_config mvebu_gpio_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.fast_io = true,
-};
-
 static int mvebu_gpio_probe_raw(struct platform_device *pdev,
 				struct mvebu_gpio_chip *mvchip)
 {
-- 
2.20.1
