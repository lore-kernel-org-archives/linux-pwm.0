From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: [PATCH v2 1/4] gpio: mvebu: Add limited PWM support
Date: Sat, 18 Mar 2017 16:43:01 +0100
Message-ID: <20170318154305.28348-2-ralph.sennhauser@gmail.com>
References: <20170318154305.28348-1-ralph.sennhauser@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170318154305.28348-1-ralph.sennhauser@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Imre Kaloz <kaloz@openwrt.org>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Mauro Carvalho Chehab <mchehab@kernel.org>, Guenter Roeck <linux@roeck-us.net>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

Armada 370/XP devices can 'blink' gpio lines with a configurable on
and off period. This can be modelled as a PWM.

However, there are only two sets of PWM configuration registers for
all the gpio lines. This driver simply allows a single gpio line per
gpio chip of 32 lines to be used as a PWM. Attempts to use more return
EBUSY.

Due to the interleaving of registers it is not simple to separate the
PWM driver from the gpio driver. Thus the gpio driver has been
extended with a PWM driver.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
URL: https://patchwork.ozlabs.org/patch/427287/
URL: https://patchwork.ozlabs.org/patch/427295/
[Ralph Sennhauser:
  * port forward
  * merge pwm portion into gpio-mvebu.c
  * merge documentation patch
  * update MAINTAINERS]
Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
---
 .../devicetree/bindings/gpio/gpio-mvebu.txt        |  31 +++
 MAINTAINERS                                        |   2 +
 drivers/gpio/gpio-mvebu.c                          | 291 +++++++++++++++++++--
 3 files changed, 307 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
index a6f3bec..86932e3 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
@@ -38,6 +38,23 @@ Required properties:
 - #gpio-cells: Should be two. The first cell is the pin number. The
   second cell is reserved for flags, unused at the moment.
 
+Optional properties:
+
+In order to use the gpio lines in PWM mode, some additional optional
+properties are required. Only Armada 370 and XP support these properties.
+
+- reg: an additional register set is needed, for the GPIO Blink
+  Counter on/off registers.
+
+- reg-names: Must contain an entry "pwm" corresponding to the
+  additional register range needed for pwm operation.
+
+- #pwm-cells: Should be two. The first cell is the pin number. The
+  second cell is reserved for flags and should be set to 0, so it has a
+  known value. It then becomes possible to use it in the future.
+
+- clocks: Must be a phandle to the clock for the gpio controller.
+
 Example:
 
 		gpio0: gpio@d0018100 {
@@ -51,3 +68,17 @@ Example:
 			#interrupt-cells = <2>;
 			interrupts = <16>, <17>, <18>, <19>;
 		};
+
+		gpio1: gpio@18140 {
+			compatible = "marvell,orion-gpio";
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
index 40ac605..efe3a22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10266,6 +10266,8 @@ F:	include/linux/pwm.h
 F:	drivers/pwm/
 F:	drivers/video/backlight/pwm_bl.c
 F:	include/linux/pwm_backlight.h
+F:	drivers/gpio/gpio-mvebu.c
+F:	Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
 
 PXA2xx/PXA3xx SUPPORT
 M:	Daniel Mack <daniel@zonque.org>
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index fae4db6..ee49589 100644
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
@@ -78,6 +90,21 @@
 
 #define MVEBU_MAX_GPIO_PER_BANK		32
 
+struct mvebu_pwm {
+	void __iomem		*membase;
+	unsigned long		 clk_rate;
+	bool			 used;
+	unsigned int		 pin;
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
@@ -87,6 +114,11 @@ struct mvebu_gpio_chip {
 	struct irq_domain *domain;
 	int		   soc_variant;
 
+	/* Used for PWM support */
+	struct clk	  *clk;
+	struct mvebu_pwm  *pwm;
+	int		   id;
+
 	/* Used to preserve GPIO registers across suspend/resume */
 	u32		   out_reg;
 	u32		   io_conf_reg;
@@ -110,6 +142,11 @@ static void __iomem *mvebu_gpioreg_blink(struct mvebu_gpio_chip *mvchip)
 	return mvchip->membase + GPIO_BLINK_EN_OFF;
 }
 
+static void __iomem *mvebu_gpioreg_blink_select(struct mvebu_gpio_chip *mvchip)
+{
+	return mvchip->membase + GPIO_BLINK_CNT_SELECT_OFF;
+}
+
 static void __iomem *mvebu_gpioreg_io_conf(struct mvebu_gpio_chip *mvchip)
 {
 	return mvchip->membase + GPIO_IO_CONF_OFF;
@@ -181,6 +218,20 @@ static void __iomem *mvebu_gpioreg_level_mask(struct mvebu_gpio_chip *mvchip)
 }
 
 /*
+ * Functions returning addresses of individual registers for a given
+ * PWM controller.
+ */
+static void __iomem *mvebu_pwmreg_blink_on_duration(struct mvebu_pwm *pwm)
+{
+	return pwm->membase + PWM_BLINK_ON_DURATION_OFF;
+}
+
+static void __iomem *mvebu_pwmreg_blink_off_duration(struct mvebu_pwm *pwm)
+{
+	return pwm->membase + PWM_BLINK_OFF_DURATION_OFF;
+}
+
+/*
  * Functions implementing the gpio_chip methods
  */
 static void mvebu_gpio_set(struct gpio_chip *chip, unsigned int pin, int value)
@@ -484,6 +535,203 @@ static void mvebu_gpio_irq_handler(struct irq_desc *desc)
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
+static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwmd)
+{
+	struct mvebu_pwm *pwm = to_mvebu_pwm(chip);
+	struct mvebu_gpio_chip *mvchip = pwm->mvchip;
+	struct gpio_desc *desc = gpio_to_desc(pwmd->pwm);
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&pwm->lock, flags);
+	if (pwm->used) {
+		ret = -EBUSY;
+	} else {
+		if (!desc) {
+			ret = -ENODEV;
+			goto out;
+		}
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
+		pwm->pin = pwmd->pwm - mvchip->chip.base;
+		pwm->used = true;
+	}
+
+out:
+	spin_unlock_irqrestore(&pwm->lock, flags);
+	return ret;
+}
+
+static void mvebu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwmd)
+{
+	struct mvebu_pwm *pwm = to_mvebu_pwm(chip);
+	struct gpio_desc *desc = gpio_to_desc(pwmd->pwm);
+	unsigned long flags;
+
+	spin_lock_irqsave(&pwm->lock, flags);
+	gpiod_free(desc);
+	pwm->used = false;
+	spin_unlock_irqrestore(&pwm->lock, flags);
+}
+
+static int mvebu_pwm_config(struct pwm_chip *chip, struct pwm_device *pwmd,
+			    int duty_ns, int period_ns)
+{
+	struct mvebu_pwm *pwm = to_mvebu_pwm(chip);
+	struct mvebu_gpio_chip *mvchip = pwm->mvchip;
+	unsigned int on, off;
+	unsigned long long val;
+	u32 u;
+
+	val = (unsigned long long) pwm->clk_rate * duty_ns;
+	do_div(val, NSEC_PER_SEC);
+	if (val > UINT_MAX)
+		return -EINVAL;
+	if (val)
+		on = val;
+	else
+		on = 1;
+
+	val = (unsigned long long) pwm->clk_rate * (period_ns - duty_ns);
+	do_div(val, NSEC_PER_SEC);
+	if (val > UINT_MAX)
+		return -EINVAL;
+	if (val)
+		off = val;
+	else
+		off = 1;
+
+	u = readl_relaxed(mvebu_gpioreg_blink_select(mvchip));
+	/* mvchip->id is either 0 or 1 */
+	if (mvchip->id)
+		u |= BIT(pwm->pin);
+	else
+		u &= ~BIT(pwm->pin);
+	writel_relaxed(u, mvebu_gpioreg_blink_select(mvchip));
+
+	writel_relaxed(on, mvebu_pwmreg_blink_on_duration(pwm));
+	writel_relaxed(off, mvebu_pwmreg_blink_off_duration(pwm));
+
+	return 0;
+}
+
+static int mvebu_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwmd)
+{
+	struct mvebu_pwm *pwm = to_mvebu_pwm(chip);
+	struct mvebu_gpio_chip *mvchip = pwm->mvchip;
+
+	mvebu_gpio_blink(&mvchip->chip, pwm->pin, 1);
+
+	return 0;
+}
+
+static void mvebu_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwmd)
+{
+	struct mvebu_pwm *pwm = to_mvebu_pwm(chip);
+	struct mvebu_gpio_chip *mvchip = pwm->mvchip;
+
+	mvebu_gpio_blink(&mvchip->chip, pwm->pin, 0);
+}
+
+static const struct pwm_ops mvebu_pwm_ops = {
+	.request = mvebu_pwm_request,
+	.free = mvebu_pwm_free,
+	.config = mvebu_pwm_config,
+	.enable = mvebu_pwm_enable,
+	.disable = mvebu_pwm_disable,
+	.owner = THIS_MODULE,
+};
+
+static void mvebu_pwm_suspend(struct mvebu_gpio_chip *mvchip)
+{
+	struct mvebu_pwm *pwm = mvchip->pwm;
+
+	pwm->blink_select = readl_relaxed(mvebu_gpioreg_blink_select(mvchip));
+	pwm->blink_on_duration =
+		readl_relaxed(mvebu_pwmreg_blink_on_duration(pwm));
+	pwm->blink_off_duration =
+		readl_relaxed(mvebu_pwmreg_blink_off_duration(pwm));
+}
+
+static void mvebu_pwm_resume(struct mvebu_gpio_chip *mvchip)
+{
+	struct mvebu_pwm *pwm = mvchip->pwm;
+
+	writel_relaxed(pwm->blink_select, mvebu_gpioreg_blink_select(mvchip));
+	writel_relaxed(pwm->blink_on_duration,
+		       mvebu_pwmreg_blink_on_duration(pwm));
+	writel_relaxed(pwm->blink_off_duration,
+		       mvebu_pwmreg_blink_off_duration(pwm));
+}
+
+static int mvebu_pwm_probe(struct platform_device *pdev,
+			   struct mvebu_gpio_chip *mvchip)
+{
+	struct device *dev = &pdev->dev;
+	struct mvebu_pwm *pwm;
+	struct resource *res;
+
+	/*
+	 * Armada 370/XP has simple PWM support for gpio lines. Other SoCs
+	 * don't have this hardware. So if we don't have the necessary
+	 * resource, it is not an error.
+	 */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm");
+	if (!res)
+		return 0;
+	/*
+	 * There are only two sets of PWM configuration registers for all
+	 * the gpio lines on those SoCs. Assert one set for each of the
+	 * first two (and only) gpio chips, return an error otherwise.
+	 */
+	if (mvchip->id < 0 || mvchip->id > 1)
+		return -EINVAL;
+
+	pwm = devm_kzalloc(dev, sizeof(struct mvebu_pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+	mvchip->pwm = pwm;
+	pwm->mvchip = mvchip;
+
+	pwm->membase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pwm->membase))
+		return PTR_ERR(pwm->membase);
+
+	if (IS_ERR(mvchip->clk))
+		return PTR_ERR(mvchip->clk);
+
+	pwm->clk_rate = clk_get_rate(mvchip->clk);
+	if (!pwm->clk_rate) {
+		dev_err(dev, "failed to get clock rate\n");
+		return -EINVAL;
+	}
+
+	pwm->chip.dev = dev;
+	pwm->chip.ops = &mvebu_pwm_ops;
+	pwm->chip.base = mvchip->chip.base;
+	pwm->chip.npwm = mvchip->chip.ngpio;
+
+	spin_lock_init(&pwm->lock);
+
+	return pwmchip_add(&pwm->chip);
+}
+
 #ifdef CONFIG_DEBUG_FS
 #include <linux/seq_file.h>
 
@@ -600,6 +848,9 @@ static int mvebu_gpio_suspend(struct platform_device *pdev, pm_message_t state)
 		BUG();
 	}
 
+	if (IS_ENABLED(CONFIG_PWM))
+		mvebu_pwm_suspend(mvchip);
+
 	return 0;
 }
 
@@ -643,6 +894,9 @@ static int mvebu_gpio_resume(struct platform_device *pdev)
 		BUG();
 	}
 
+	if (IS_ENABLED(CONFIG_PWM))
+		mvebu_pwm_resume(mvchip);
+
 	return 0;
 }
 
@@ -654,11 +908,10 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
-	struct clk *clk;
 	unsigned int ngpios;
 	bool have_irqs;
 	int soc_variant;
-	int i, cpu, id;
+	int i, cpu;
 	int err;
 
 	match = of_match_device(mvebu_gpio_of_match, &pdev->dev);
@@ -682,16 +935,16 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	id = of_alias_get_id(pdev->dev.of_node, "gpio");
-	if (id < 0) {
+	mvchip->id = of_alias_get_id(pdev->dev.of_node, "gpio");
+	if (mvchip->id < 0) {
 		dev_err(&pdev->dev, "Couldn't get OF id\n");
-		return id;
+		return mvchip->id;
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
@@ -704,7 +957,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	mvchip->chip.set = mvebu_gpio_set;
 	if (have_irqs)
 		mvchip->chip.to_irq = mvebu_gpio_to_irq;
-	mvchip->chip.base = id * MVEBU_MAX_GPIO_PER_BANK;
+	mvchip->chip.base = mvchip->id * MVEBU_MAX_GPIO_PER_BANK;
 	mvchip->chip.ngpio = ngpios;
 	mvchip->chip.can_sleep = false;
 	mvchip->chip.of_node = np;
@@ -822,6 +1075,10 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 						 mvchip);
 	}
 
+	/* Armada 370/XP has simple PWM support for gpio lines */
+	if (IS_ENABLED(CONFIG_PWM))
+		return mvebu_pwm_probe(pdev, mvchip);
+
 	return 0;
 
 err_domain:
-- 
2.10.2
