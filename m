From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH v2 1/5] pwm: add the Berlin pwm controller driver
Date: Thu, 30 Jul 2015 11:23:17 +0200
Message-ID: <1438248201-29222-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1438248201-29222-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438248201-29222-1-git-send-email-antoine.tenart@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: sebastian.hesselbarth@gmail.com, thierry.reding@gmail.com
Cc: zmxu@marvell.com, jszhang@marvell.com, linux-pwm@vger.kernel.org, Antoine Tenart <antoine.tenart@free-electrons.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Add a PWM controller driver for the Marvell Berlin SoCs. This PWM
controller has 4 channels.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/pwm/Kconfig      |   9 +++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-berlin.c | 207 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100644 drivers/pwm/pwm-berlin.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index b1541f40fd8d..1773da8145b8 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -92,6 +92,15 @@ config PWM_BCM2835
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-bcm2835.
 
+config PWM_BERLIN
+	tristate "Berlin PWM support"
+	depends on ARCH_BERLIN
+	help
+	  PWM framework driver for Berlin.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-berlin.
+
 config PWM_BFIN
 	tristate "Blackfin PWM support"
 	depends on BFIN_GPTIMERS
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index ec50eb5b5a8f..670c5fce8bbb 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
 obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
 obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
 obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
+obj-$(CONFIG_PWM_BERLIN)	+= pwm-berlin.o
 obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
 obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
new file mode 100644
index 000000000000..786990c1c750
--- /dev/null
+++ b/drivers/pwm/pwm-berlin.c
@@ -0,0 +1,207 @@
+/*
+ * Marvell Berlin PWM driver
+ *
+ * Copyright (C) 2015 Marvell Technology Group Ltd.
+ *
+ * Antoine Tenart <antoine.tenart@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/spinlock.h>
+
+#define BERLIN_PWM_EN			0x0
+#define BERLIN_PWM_CONTROL		0x4
+#define BERLIN_PWM_DUTY			0x8
+#define BERLIN_PWM_TCNT			0xc
+
+#define BERLIN_PWM_CLK_RATE		100000000
+#define BERLIN_PWM_PRESCALE_MASK	0x7
+#define BERLIN_PWM_PRESCALE_MAX		4096
+
+struct berlin_pwm_chip {
+	struct pwm_chip chip;
+	void __iomem *base;
+	spinlock_t lock;
+};
+
+#define to_berlin_pwm_chip(chip)	\
+	container_of((chip), struct berlin_pwm_chip, chip)
+
+#define berlin_pwm_readl(chip, channel, offset)		\
+	readl((chip)->base + (channel) * 0x10 + offset)
+#define berlin_pwm_writel(val, chip, channel, offset)	\
+	writel(val, (chip)->base + (channel) * 0x10 + offset)
+
+static const u32 prescaler_table[] = {
+	1,
+	4,
+	8,
+	16,
+	64,
+	256,
+	1024,
+	4096,
+};
+
+static int berlin_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			     int duty_ns, int period_ns)
+{
+	struct berlin_pwm_chip *berlin_chip = to_berlin_pwm_chip(chip);
+	int prescale;
+	u32 val, duty, period;
+	u64 tmp;
+
+	for (prescale = 0; prescale < ARRAY_SIZE(prescaler_table); prescale++) {
+		tmp = BERLIN_PWM_CLK_RATE;
+		do_div(tmp, prescaler_table[prescale]);
+		tmp *= period_ns;
+		do_div(tmp, NSEC_PER_SEC);
+
+		if (tmp - 1 <= BERLIN_PWM_PRESCALE_MAX)
+			break;
+	}
+
+	if (tmp - 1 > BERLIN_PWM_PRESCALE_MAX)
+		return -EINVAL;
+
+	period = tmp;
+	tmp *= duty_ns;
+	do_div(tmp, period_ns);
+	duty = tmp;
+
+	spin_lock(&berlin_chip->lock);
+
+	val = berlin_pwm_readl(berlin_chip, pwm->hwpwm, BERLIN_PWM_CONTROL);
+	val &= ~BERLIN_PWM_PRESCALE_MASK;
+	val |= prescale;
+	berlin_pwm_writel(val, berlin_chip, pwm->hwpwm, BERLIN_PWM_CONTROL);
+
+	berlin_pwm_writel(duty, berlin_chip, pwm->hwpwm, BERLIN_PWM_DUTY);
+	berlin_pwm_writel(period, berlin_chip, pwm->hwpwm, BERLIN_PWM_TCNT);
+
+	spin_unlock(&berlin_chip->lock);
+
+	return 0;
+}
+
+static int berlin_pwm_set_polarity(struct pwm_chip *chip,
+				   struct pwm_device *pwm,
+				   enum pwm_polarity polarity)
+{
+	struct berlin_pwm_chip *berlin_chip = to_berlin_pwm_chip(chip);
+	u32 val;
+
+	spin_lock(&berlin_chip->lock);
+
+	val = berlin_pwm_readl(berlin_chip, pwm->hwpwm, BERLIN_PWM_CONTROL);
+
+	if (polarity == PWM_POLARITY_NORMAL)
+		val &= ~BIT(3);
+	else
+		val |= BIT(3);
+
+	berlin_pwm_writel(val, berlin_chip, pwm->hwpwm, BERLIN_PWM_CONTROL);
+
+	spin_unlock(&berlin_chip->lock);
+
+	return 0;
+}
+
+static int berlin_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct berlin_pwm_chip *berlin_chip = to_berlin_pwm_chip(chip);
+
+	spin_lock(&berlin_chip->lock);
+	berlin_pwm_writel(0x1, berlin_chip, pwm->hwpwm, BERLIN_PWM_EN);
+	spin_unlock(&berlin_chip->lock);
+
+	return 0;
+}
+
+static void berlin_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct berlin_pwm_chip *berlin_chip = to_berlin_pwm_chip(chip);
+
+	spin_lock(&berlin_chip->lock);
+	berlin_pwm_writel(0x0, berlin_chip, pwm->hwpwm, BERLIN_PWM_EN);
+	spin_unlock(&berlin_chip->lock);
+}
+
+static const struct pwm_ops berlin_pwm_ops = {
+	.config = berlin_pwm_config,
+	.set_polarity = berlin_pwm_set_polarity,
+	.enable = berlin_pwm_enable,
+	.disable = berlin_pwm_disable,
+	.owner = THIS_MODULE,
+};
+
+static const struct of_device_id berlin_pwm_match[] = {
+	{ .compatible = "marvell,berlin-pwm" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, berlin_pwm_match);
+
+static int berlin_pwm_probe(struct platform_device *pdev)
+{
+	struct berlin_pwm_chip *pwm;
+	struct resource *res;
+	int ret;
+
+	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pwm->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pwm->base))
+		return PTR_ERR(pwm->base);
+
+	pwm->chip.dev = &pdev->dev;
+	pwm->chip.ops = &berlin_pwm_ops;
+	pwm->chip.base = -1;
+	pwm->chip.npwm = 4;
+	pwm->chip.can_sleep = true;
+	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
+	pwm->chip.of_pwm_n_cells = 3;
+
+	spin_lock_init(&pwm->lock);
+
+	ret = pwmchip_add(&pwm->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to add PWM chip: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, pwm);
+
+	return 0;
+}
+
+static int berlin_pwm_remove(struct platform_device *pdev)
+{
+	struct berlin_pwm_chip *pwm = platform_get_drvdata(pdev);
+
+	return pwmchip_remove(&pwm->chip);
+}
+
+static struct platform_driver berlin_pwm_driver = {
+	.probe	= berlin_pwm_probe,
+	.remove	= berlin_pwm_remove,
+	.driver	= {
+		.name	= "berlin-pwm",
+		.of_match_table = berlin_pwm_match,
+	},
+};
+module_platform_driver(berlin_pwm_driver);
+
+MODULE_AUTHOR("Antoine Tenart <antoine.tenart@free-electrons.com>");
+MODULE_DESCRIPTION("Marvell Berlin PWM driver");
+MODULE_LICENSE("GPL v2");
-- 
2.5.0
