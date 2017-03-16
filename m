From: Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/4] gpio: mvebu: Add limited PWM support
Date: Thu, 16 Mar 2017 07:42:15 +0100
Message-ID: <20170316064218.9169-2-ralph.sennhauser@gmail.com>
References: <20170316064218.9169-1-ralph.sennhauser@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170316064218.9169-1-ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "open list:PWM SUBSYSTEM" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>

Armada 370/XP devices can 'blink' gpio lines with a configurable on
and off period. This can be modelled as a PWM.

However, there are only two sets of PWM configuration registers for
all the gpio lines. This driver simply allows a single gpio line per
gpio chip of 32 lines to be used as a PWM. Attempts to use more return
EBUSY.

Due to the interleaving of registers it is not simple to separate the
PWM driver from the gpio driver. Thus the gpio driver has been
extended with a PWM driver.

Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
URL: https://patchwork.ozlabs.org/patch/427287/
URL: https://patchwork.ozlabs.org/patch/427295/
[Ralph Sennhauser:
  * port forward
  * merge pwm portion into gpio-mvebu.c
  * merge doc patch
  * update MAINAINERS]
Signed-off-by: Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/gpio/gpio-mvebu.txt        |  31 +++
 MAINTAINERS                                        |   2 +
 drivers/gpio/gpio-mvebu.c                          | 274 ++++++++++++++++++++-
 3 files changed, 295 insertions(+), 12 deletions(-)

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
 M:	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 029f43c..ce08b73 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -42,21 +42,33 @@
 #include <linux/io.h>
 #include <linux/of_irq.h>
 #include <linux/of_device.h>
+#include <linux/pwm.h>
 #include <linux/clk.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/platform_device.h>
+
+#include "gpiolib.h"
 
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
@@ -77,6 +89,22 @@
 
 #define MVEBU_MAX_GPIO_PER_BANK		32
 
+struct mvebu_pwm {
+	void __iomem		*membase;
+	unsigned long		 clk_rate;
+	bool			 used;
+	unsigned int		 pin;
+	struct pwm_chip		 chip;
+	int			 id;
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
@@ -85,6 +113,8 @@ struct mvebu_gpio_chip {
 	int		   irqbase;
 	struct irq_domain *domain;
 	int		   soc_variant;
+	struct clk	  *clk;
+	struct mvebu_pwm  *pwm;
 
 	/* Used to preserve GPIO registers across suspend/resume */
 	u32		   out_reg;
@@ -109,6 +139,11 @@ static void __iomem *mvebu_gpioreg_blink(struct mvebu_gpio_chip *mvchip)
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
@@ -180,6 +215,20 @@ static void __iomem *mvebu_gpioreg_level_mask(struct mvebu_gpio_chip *mvchip)
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
@@ -483,6 +532,198 @@ static void mvebu_gpio_irq_handler(struct irq_desc *desc)
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
+	u &= ~(1 << pwm->pin);
+	u |= (pwm->id << pwm->pin);
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
+/*
+ * Armada 370/XP has simple PWM support for gpio lines. Other SoCs
+ * don't have this hardware. So if we don't have the necessary
+ * resource, it is not an error.
+ */
+static int mvebu_pwm_probe(struct platform_device *pdev,
+		    struct mvebu_gpio_chip *mvchip,
+		    int id)
+{
+	struct device *dev = &pdev->dev;
+	struct mvebu_pwm *pwm;
+	struct resource *res;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm");
+	if (!res)
+		return 0;
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
+	if (id < 0 || id > 1)
+		return -EINVAL;
+	pwm->id = id;
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
 
@@ -599,6 +840,9 @@ static int mvebu_gpio_suspend(struct platform_device *pdev, pm_message_t state)
 		BUG();
 	}
 
+	if (IS_ENABLED(CONFIG_PWM))
+		mvebu_pwm_suspend(mvchip);
+
 	return 0;
 }
 
@@ -642,6 +886,9 @@ static int mvebu_gpio_resume(struct platform_device *pdev)
 		BUG();
 	}
 
+	if (IS_ENABLED(CONFIG_PWM))
+		mvebu_pwm_resume(mvchip);
+
 	return 0;
 }
 
@@ -653,7 +900,6 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
-	struct clk *clk;
 	unsigned int ngpios;
 	bool have_irqs;
 	int soc_variant;
@@ -687,10 +933,10 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
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
@@ -821,6 +1067,10 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 						 mvchip);
 	}
 
+	/* Armada 370/XP has simple PWM support for gpio lines */
+	if (IS_ENABLED(CONFIG_PWM))
+		return mvebu_pwm_probe(pdev, mvchip, id);
+
 	return 0;
 
 err_domain:
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
