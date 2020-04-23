From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: [PATCH v3 09/16] gpiolib: Introduce gpiochip_irqchip_add_domain()
Date: Thu, 23 Apr 2020 19:45:36 +0200
Message-ID: <20200423174543.17161-10-michael@walle.cc>
References: <20200423174543.17161-1-michael@walle.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200423174543.17161-1-michael-QKn5cuLxLXY@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <maz-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

This connects an IRQ domain to a gpiochip and reuses gpiochip_to_irq().

Signed-off-by: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
---
 drivers/gpio/gpiolib.c      | 20 ++++++++++++++++++++
 include/linux/gpio/driver.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 40f2d7f69be2..7b3d7f496b9a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2722,6 +2722,26 @@ int gpiochip_irqchip_add_key(struct gpio_chip *gc,
 }
 EXPORT_SYMBOL_GPL(gpiochip_irqchip_add_key);
 
+/**
+ * gpiochip_irqchip_add_key() - adds an irqdomain to a gpiochip
+ * @gc: the gpiochip to add the irqchip to
+ * @domain: the irqdomain to add to the gpiochip
+ *
+ * This function adds an IRQ domain to the gpiochip.
+ */
+int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
+				struct irq_domain *domain)
+{
+	if (!domain)
+		return -EINVAL;
+
+	gc->to_irq = gpiochip_to_irq;
+	gc->irq.domain = domain;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gpiochip_irqchip_add_domain);
+
 #else /* CONFIG_GPIOLIB_IRQCHIP */
 
 static inline int gpiochip_add_irqchip(struct gpio_chip *gc,
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index b8fc92c177eb..dfb1aa0ad4dc 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -599,6 +599,9 @@ int gpiochip_irqchip_add_key(struct gpio_chip *gc,
 bool gpiochip_irqchip_irq_valid(const struct gpio_chip *gc,
 				unsigned int offset);
 
+int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
+				struct irq_domain *domain);
+
 #ifdef CONFIG_LOCKDEP
 
 /*
-- 
2.20.1
