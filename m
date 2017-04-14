From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: [PATCH v6 1/4] gpio: mvebu: Add limited PWM support
Date: Fri, 14 Apr 2017 17:40:52 +0200
Message-ID: <20170414154056.32055-2-ralph.sennhauser@gmail.com>
References: <20170414154056.32055-1-ralph.sennhauser@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170414154056.32055-1-ralph.sennhauser@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

Armada 370/XP devices can 'blink' GPIO lines with a configurable on
and off period. This can be modelled as a PWM.

However, there are only two sets of PWM configuration registers for
all the GPIO lines. This driver simply allows a single GPIO line per
GPIO chip of 32 lines to be used as a PWM. Attempts to use more return
EBUSY.

Due to the interleaving of registers it is not simple to separate the
PWM driver from the GPIO driver. Thus the GPIO driver has been
extended with a PWM driver.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
URL: https://patchwork.ozlabs.org/patch/427287/
URL: https://patchwork.ozlabs.org/patch/427295/
[Ralph Sennhauser:
  * Port forward
  * Merge PWM portion into gpio-mvebu.c
  * Switch to atomic PWM API
  * Add new compatible string marvell,armada-370-xp-gpio
  * Update and merge documentation patch
  * Update MAINTAINERS]
Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/gpio/gpio-mvebu.txt        |  32 ++
 MAINTAINERS                                        |   2 +
 drivers/gpio/gpio-mvebu.c                          | 327 ++++++++++++++++++++-
 3 files changed, 349 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
index a6f3bec..42c3bb2 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
@@ -38,6 +38,24 @@ Required properties:
 - #gpio-cells: Should be two. The first cell is the pin number. The
   second cell is reserved for flags, unused at the moment.
 
+Optional properties:
+
+In order to use the GPIO lines in PWM mode, some additional optional
+properties are required. Only Armada 370 and XP support these properties.
+
+- compatible: Must contain "marvell,armada-370-xp-gpio"
+
+- reg: an additional register set is needed, for the GPIO Blink
+  Counter on/off registers.
+
+- reg-names: Must contain an entry "pwm" corresponding to the
+  additional register range needed for PWM operation.
+
+- #pwm-cells: Should be two. The first cell is the GPIO line number. The
+  second cell is the period in nanoseconds.
+
+- clocks: Must be a phandle to the clock for the GPIO controller.
+
 Example:
 
 		gpio0: gpio@d0018100 {
@@ -51,3 +69,17 @@ Example:
 			#interrupt-cells = <2>;
 			interrupts = <16>, <17>, <18>, <19>;
 		};
+
+		gpio1: gpio@18140 {
+			compatible = "marvell,armada-370-xp-gpio";
+			reg = <0x18140 0x40>, <0x181c8 0x08>;
+			reg-names = "gpio", "pwm";
+			ngpios = <17>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			#pwm-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <87>, <88>, <89>;
+			clocks = <&coreclk 0>;
+		};
diff --git a/MAINTAINERS b/MAINTAINERS
index 58b3a22..19382f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10295,6 +10295,8 @@ F:	include/linux/pwm.h
 F:	drivers/pwm/
 F:	drivers/video/backlight/pwm_bl.c
 F:	include/linux/pwm_backlight.h
+F:	drivers/gpio/gpio-mvebu.c
+F:	Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
 
 PXA2xx/PXA3xx SUPPORT
 M:	Daniel Mack <daniel@zonque.org>
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index fae4db6..19a92ef 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -42,22 +42,34 @@
 #include <linux/io.h>
 #include <linux/of_irq.h>
 #include <linux/of_device.h>
+#include <linux/pwm.h>
 #include <linux/clk.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/platform_device.h>
 #include <linux/bitops.h>
 
+#include "gpiolib.h"
+
 /*
  * GPIO unit register offsets.
  */
-#define GPIO_OUT_OFF		0x0000
-#define GPIO_IO_CONF_OFF	0x0004
-#define GPIO_BLINK_EN_OFF	0x0008
-#define GPIO_IN_POL_OFF		0x000c
-#define GPIO_DATA_IN_OFF	0x0010
-#define GPIO_EDGE_CAUSE_OFF	0x0014
-#define GPIO_EDGE_MASK_OFF	0x0018
-#define GPIO_LEVEL_MASK_OFF	0x001c
+#define GPIO_OUT_OFF			0x0000
+#define GPIO_IO_CONF_OFF		0x0004
+#define GPIO_BLINK_EN_OFF		0x0008
+#define GPIO_IN_POL_OFF			0x000c
+#define GPIO_DATA_IN_OFF		0x0010
+#define GPIO_EDGE_CAUSE_OFF		0x0014
+#define GPIO_EDGE_MASK_OFF		0x0018
+#define GPIO_LEVEL_MASK_OFF		0x001c
+#define GPIO_BLINK_CNT_SELECT_OFF	0x0020
+
+/*
+ * PWM register offsets.
+ */
+#define PWM_BLINK_ON_DURATION_OFF	0x0
+#define PWM_BLINK_OFF_DURATION_OFF	0x4
+
 
 /* The MV78200 has per-CPU registers for edge mask and level mask */
 #define GPIO_EDGE_MASK_MV78200_OFF(cpu)	  ((cpu) ? 0x30 : 0x18)
@@ -78,6 +90,20 @@
 
 #define MVEBU_MAX_GPIO_PER_BANK		32
 
+struct mvebu_pwm {
+	void __iomem		*membase;
+	unsigned long		 clk_rate;
+	struct gpio_desc	*gpiod;
+	struct pwm_chip		 chip;
+	spinlock_t		 lock;
+	struct mvebu_gpio_chip	*mvchip;
+
+	/* Used to preserve GPIO/PWM registers across suspend/resume */
+	u32			 blink_select;
+	u32			 blink_on_duration;
+	u32			 blink_off_duration;
+};
+
 struct mvebu_gpio_chip {
 	struct gpio_chip   chip;
 	spinlock_t	   lock;
@@ -87,6 +113,10 @@ struct mvebu_gpio_chip {
 	struct irq_domain *domain;
 	int		   soc_variant;
 
+	/* Used for PWM support */
+	struct clk	  *clk;
+	struct mvebu_pwm  *mvpwm;
+
 	/* Used to preserve GPIO registers across suspend/resume */
 	u32		   out_reg;
 	u32		   io_conf_reg;
@@ -110,6 +140,12 @@ static void __iomem *mvebu_gpioreg_blink(struct mvebu_gpio_chip *mvchip)
 	return mvchip->membase + GPIO_BLINK_EN_OFF;
 }
 
+static void __iomem *mvebu_gpioreg_blink_counter_select(struct mvebu_gpio_chip
+							*mvchip)
+{
+	return mvchip->membase + GPIO_BLINK_CNT_SELECT_OFF;
+}
+
 static void __iomem *mvebu_gpioreg_io_conf(struct mvebu_gpio_chip *mvchip)
 {
 	return mvchip->membase + GPIO_IO_CONF_OFF;
@@ -181,6 +217,20 @@ static void __iomem *mvebu_gpioreg_level_mask(struct mvebu_gpio_chip *mvchip)
 }
 
 /*
+ * Functions returning addresses of individual registers for a given
+ * PWM controller.
+ */
+static void __iomem *mvebu_pwmreg_blink_on_duration(struct mvebu_pwm *mvpwm)
+{
+	return mvpwm->membase + PWM_BLINK_ON_DURATION_OFF;
+}
+
+static void __iomem *mvebu_pwmreg_blink_off_duration(struct mvebu_pwm *mvpwm)
+{
+	return mvpwm->membase + PWM_BLINK_OFF_DURATION_OFF;
+}
+
+/*
  * Functions implementing the gpio_chip methods
  */
 static void mvebu_gpio_set(struct gpio_chip *chip, unsigned int pin, int value)
@@ -484,6 +534,246 @@ static void mvebu_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+/*
+ * Functions implementing the pwm_chip methods
+ */
+static struct mvebu_pwm *to_mvebu_pwm(struct pwm_chip *chip)
+{
+	return container_of(chip, struct mvebu_pwm, chip);
+}
+
+static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
+	struct mvebu_gpio_chip *mvchip = mvpwm->mvchip;
+	struct gpio_desc *desc;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&mvpwm->lock, flags);
+
+	if (mvpwm->gpiod) {
+		ret = -EBUSY;
+	} else {
+		desc = gpio_to_desc(mvchip->chip.base + pwm->hwpwm);
+		if (!desc) {
+			ret = -ENODEV;
+			goto out;
+		}
+
+		ret = gpiod_request(desc, "mvebu-pwm");
+		if (ret)
+			goto out;
+
+		ret = gpiod_direction_output(desc, 0);
+		if (ret) {
+			gpiod_free(desc);
+			goto out;
+		}
+
+		mvpwm->gpiod = desc;
+	}
+out:
+	spin_unlock_irqrestore(&mvpwm->lock, flags);
+	return ret;
+}
+
+static void mvebu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mvpwm->lock, flags);
+	gpiod_free(mvpwm->gpiod);
+	mvpwm->gpiod = NULL;
+	spin_unlock_irqrestore(&mvpwm->lock, flags);
+}
+
+static void mvebu_pwm_get_state(struct pwm_chip *chip,
+				struct pwm_device *pwm,
+				struct pwm_state *state) {
+
+	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
+	struct mvebu_gpio_chip *mvchip = mvpwm->mvchip;
+	unsigned long long val;
+	unsigned long flags;
+	u32 u;
+
+	spin_lock_irqsave(&mvpwm->lock, flags);
+
+	val = (unsigned long long)
+		readl_relaxed(mvebu_pwmreg_blink_on_duration(mvpwm));
+	val *= NSEC_PER_SEC;
+	do_div(val, mvpwm->clk_rate);
+	if (val > UINT_MAX)
+		state->duty_cycle = UINT_MAX;
+	else if (val)
+		state->duty_cycle = val;
+	else
+		state->duty_cycle = 1;
+
+	val = (unsigned long long)
+		readl_relaxed(mvebu_pwmreg_blink_off_duration(mvpwm));
+	val *= NSEC_PER_SEC;
+	do_div(val, mvpwm->clk_rate);
+	if (val < state->duty_cycle) {
+		state->period = 1;
+	} else {
+		val -= state->duty_cycle;
+		if (val > UINT_MAX)
+			state->period = UINT_MAX;
+		else if (val)
+			state->period = val;
+		else
+			state->period = 1;
+	}
+
+	u = readl_relaxed(mvebu_gpioreg_blink(mvchip));
+	if (u)
+		state->enabled = true;
+	else
+		state->enabled = false;
+
+	spin_unlock_irqrestore(&mvpwm->lock, flags);
+}
+
+static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   struct pwm_state *state)
+{
+	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
+	struct mvebu_gpio_chip *mvchip = mvpwm->mvchip;
+	unsigned long long val;
+	unsigned long flags;
+	unsigned int on, off;
+
+	val = (unsigned long long) mvpwm->clk_rate * state->duty_cycle;
+	do_div(val, NSEC_PER_SEC);
+	if (val > UINT_MAX)
+		return -EINVAL;
+	if (val)
+		on = val;
+	else
+		on = 1;
+
+	val = (unsigned long long) mvpwm->clk_rate *
+		(state->period - state->duty_cycle);
+	do_div(val, NSEC_PER_SEC);
+	if (val > UINT_MAX)
+		return -EINVAL;
+	if (val)
+		off = val;
+	else
+		off = 1;
+
+	spin_lock_irqsave(&mvpwm->lock, flags);
+
+	writel_relaxed(on, mvebu_pwmreg_blink_on_duration(mvpwm));
+	writel_relaxed(off, mvebu_pwmreg_blink_off_duration(mvpwm));
+	if (state->enabled)
+		mvebu_gpio_blink(&mvchip->chip, pwm->hwpwm, 1);
+	else
+		mvebu_gpio_blink(&mvchip->chip, pwm->hwpwm, 0);
+
+	spin_unlock_irqrestore(&mvpwm->lock, flags);
+
+	return 0;
+}
+
+static const struct pwm_ops mvebu_pwm_ops = {
+	.request = mvebu_pwm_request,
+	.free = mvebu_pwm_free,
+	.get_state = mvebu_pwm_get_state,
+	.apply = mvebu_pwm_apply,
+	.owner = THIS_MODULE,
+};
+
+static void __maybe_unused mvebu_pwm_suspend(struct mvebu_gpio_chip *mvchip)
+{
+	struct mvebu_pwm *mvpwm = mvchip->mvpwm;
+
+	mvpwm->blink_select =
+		readl_relaxed(mvebu_gpioreg_blink_counter_select(mvchip));
+	mvpwm->blink_on_duration =
+		readl_relaxed(mvebu_pwmreg_blink_on_duration(mvpwm));
+	mvpwm->blink_off_duration =
+		readl_relaxed(mvebu_pwmreg_blink_off_duration(mvpwm));
+}
+
+static void __maybe_unused mvebu_pwm_resume(struct mvebu_gpio_chip *mvchip)
+{
+	struct mvebu_pwm *mvpwm = mvchip->mvpwm;
+
+	writel_relaxed(mvpwm->blink_select,
+		       mvebu_gpioreg_blink_counter_select(mvchip));
+	writel_relaxed(mvpwm->blink_on_duration,
+		       mvebu_pwmreg_blink_on_duration(mvpwm));
+	writel_relaxed(mvpwm->blink_off_duration,
+		       mvebu_pwmreg_blink_off_duration(mvpwm));
+}
+
+static int mvebu_pwm_probe(struct platform_device *pdev,
+			   struct mvebu_gpio_chip *mvchip,
+			   int id)
+{
+	struct device *dev = &pdev->dev;
+	struct mvebu_pwm *mvpwm;
+	struct resource *res;
+	u32 set;
+
+	if (!of_device_is_compatible(mvchip->chip.of_node,
+				     "marvell,armada-370-xp-gpio"))
+		return 0;
+
+	if (IS_ERR(mvchip->clk))
+		return PTR_ERR(mvchip->clk);
+
+	/*
+	 * There are only two sets of PWM configuration registers for
+	 * all the GPIO lines on those SoCs which this driver reserves
+	 * for the first two GPIO chips. So if the resource is missing
+	 * we can't treat it as an error.
+	 */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm");
+	if (!res)
+		return 0;
+
+	/*
+	 * Use set A for lines of GPIO chip with id 0, B for GPIO chip
+	 * with id 1. Don't allow further GPIO chips to be used for PWM.
+	 */
+	if (id == 0)
+		set = 0;
+	else if (id == 1)
+		set = U32_MAX;
+	else
+		return -EINVAL;
+	writel_relaxed(0, mvebu_gpioreg_blink_counter_select(mvchip));
+
+	mvpwm = devm_kzalloc(dev, sizeof(struct mvebu_pwm), GFP_KERNEL);
+	if (!mvpwm)
+		return -ENOMEM;
+	mvchip->mvpwm = mvpwm;
+	mvpwm->mvchip = mvchip;
+
+	mvpwm->membase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(mvpwm->membase))
+		return PTR_ERR(mvpwm->membase);
+
+	mvpwm->clk_rate = clk_get_rate(mvchip->clk);
+	if (!mvpwm->clk_rate) {
+		dev_err(dev, "failed to get clock rate\n");
+		return -EINVAL;
+	}
+
+	mvpwm->chip.dev = dev;
+	mvpwm->chip.ops = &mvebu_pwm_ops;
+	mvpwm->chip.npwm = mvchip->chip.ngpio;
+
+	spin_lock_init(&mvpwm->lock);
+
+	return pwmchip_add(&mvpwm->chip);
+}
+
 #ifdef CONFIG_DEBUG_FS
 #include <linux/seq_file.h>
 
@@ -555,6 +845,10 @@ static const struct of_device_id mvebu_gpio_of_match[] = {
 		.data	    = (void *) MVEBU_GPIO_SOC_VARIANT_ARMADAXP,
 	},
 	{
+		.compatible = "marvell,armada-370-xp-gpio",
+		.data	    = (void *) MVEBU_GPIO_SOC_VARIANT_ORION,
+	},
+	{
 		/* sentinel */
 	},
 };
@@ -600,6 +894,9 @@ static int mvebu_gpio_suspend(struct platform_device *pdev, pm_message_t state)
 		BUG();
 	}
 
+	if (IS_ENABLED(CONFIG_PWM))
+		mvebu_pwm_suspend(mvchip);
+
 	return 0;
 }
 
@@ -643,6 +940,9 @@ static int mvebu_gpio_resume(struct platform_device *pdev)
 		BUG();
 	}
 
+	if (IS_ENABLED(CONFIG_PWM))
+		mvebu_pwm_resume(mvchip);
+
 	return 0;
 }
 
@@ -654,7 +954,6 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
-	struct clk *clk;
 	unsigned int ngpios;
 	bool have_irqs;
 	int soc_variant;
@@ -688,10 +987,10 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 		return id;
 	}
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	mvchip->clk = devm_clk_get(&pdev->dev, NULL);
 	/* Not all SoCs require a clock.*/
-	if (!IS_ERR(clk))
-		clk_prepare_enable(clk);
+	if (!IS_ERR(mvchip->clk))
+		clk_prepare_enable(mvchip->clk);
 
 	mvchip->soc_variant = soc_variant;
 	mvchip->chip.label = dev_name(&pdev->dev);
@@ -822,6 +1121,10 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 						 mvchip);
 	}
 
+	/* Armada 370/XP has simple PWM support for GPIO lines */
+	if (IS_ENABLED(CONFIG_PWM))
+		return mvebu_pwm_probe(pdev, mvchip, id);
+
 	return 0;
 
 err_domain:
-- 
2.10.2
