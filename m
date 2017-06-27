From: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Subject: [RFC] pwm: Add Xilinx AXI Timer in PWM mode support
Date: Tue, 27 Jun 2017 12:05:22 +0200
Message-ID: <20170627100522.30447-1-alvaro.gamez@hazent.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34532 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbdF0KLh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 27 Jun 2017 06:11:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id p204so28454wmg.1
        for <linux-pwm@vger.kernel.org>; Tue, 27 Jun 2017 03:11:37 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alvaro Gamez Machado <alvaro.gamez@hazent.com>

This patch adds support for the IP core provided by Xilinx.
This IP core can function as a two independent timers, but can also use
both counters as values for period and duty cycle of a PWM output.

Signed-off-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
---

Hi!

AXI timer IP core is also used on Microblaze based systems to generate a
periodic interrupt, as defined in arch/microblaze/kernel/timer.c

If this patch is applied as is on a hardware that defines two timers (one
intended to generate the periodic interrupt and the other one to be the
PWM controller), the driver finds two devices:

axi_timer-pwm 41c00000.timer: at 0x41C00000 mapped to 0xf0080000
axi_timer-pwm 41c10000.timer: at 0x41C10000 mapped to 0xf00a0000

Of course, the first one is the interrupt generator, so using this PWM
would alter its configuration and screw everything up.

I'm quite new tinkering with the kernel, so I'd like to know which would
be a nice solution for this:

a) Changing "xlnx,axi-timer-2.0" compatible string for this device to something
   different like xlnx,axi-pwm-2.0?
b) Is there a way to make arch/microblaze/kernel/timer.c take full posession
   of its axi timer device so that any further driver can't access it?

I've tried option (a) and works flawlessly as far as I can tell (tested
through /sys interface), but I think option (b) would be better, if it's
something that can be done.

Best regards,

Alvaro Gamez Machado


 drivers/pwm/Kconfig         |   9 ++
 drivers/pwm/Makefile        |   1 +
 drivers/pwm/pwm-axi-timer.c | 196 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 206 insertions(+)
 create mode 100644 drivers/pwm/pwm-axi-timer.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 313c10789ca2..d4e9fa4ed40e 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -74,6 +74,15 @@ config PWM_ATMEL_TCB
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-atmel-tcb.
 
+config PWM_AXI_TIMER
+	tristate "AXI Timer PWM support"
+	depends on ARCH_ZYNQ || MICROBLAZE
+	help
+	  Generic PWM framework driver for Xilinx's AXI Timer
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-axi-timer.
+
 config PWM_BCM_IPROC
 	tristate "iProc PWM support"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 93da1f79a3b8..773f99f20d4b 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
 obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
+obj-$(CONFIG_PWM_AXI_TIMER)	+= pwm-axi-timer.o
 obj-$(CONFIG_PWM_BCM_IPROC)	+= pwm-bcm-iproc.o
 obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
 obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
diff --git a/drivers/pwm/pwm-axi-timer.c b/drivers/pwm/pwm-axi-timer.c
new file mode 100644
index 000000000000..94748e526eb8
--- /dev/null
+++ b/drivers/pwm/pwm-axi-timer.c
@@ -0,0 +1,196 @@
+/*
+ * Copyright 2017 Alvaro Gamez Machado <alvaro.gamez@hazent.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+
+struct axi_timer_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	void __iomem *regs;  /* virt. address of the control registers */
+};
+
+#define TCSR0   (0x00)
+#define TLR0    (0x04)
+#define TCR0    (0x08)
+#define TCSR1   (0x10)
+#define TLR1    (0x14)
+#define TCR1    (0x18)
+
+#define TCSR_MDT        BIT(0)
+#define TCSR_UDT        BIT(1)
+#define TCSR_GENT       BIT(2)
+#define TCSR_CAPT       BIT(3)
+#define TCSR_ARHT       BIT(4)
+#define TCSR_LOAD       BIT(5)
+#define TCSR_ENIT       BIT(6)
+#define TCSR_ENT        BIT(7)
+#define TCSR_TINT       BIT(8)
+#define TCSR_PWMA       BIT(9)
+#define TCSR_ENALL      BIT(10)
+#define TCSR_CASC       BIT(11)
+
+#define to_axi_timer_pwm_chip(_chip) \
+	container_of(_chip, struct axi_timer_pwm_chip, chip)
+
+static int axi_timer_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+				int duty_ns, int period_ns)
+{
+	struct axi_timer_pwm_chip *axi_timer = to_axi_timer_pwm_chip(chip);
+	unsigned long long c;
+	int period_cycles, duty_cycles;
+
+	c = clk_get_rate(axi_timer->clk);
+
+	/* When counters are configured to count down, UDT=1 (see datasheet):
+	 * PWM_PERIOD = (TLR0 + 2) * AXI_CLOCK_PERIOD
+	 * PWM_HIGH_TIME = (TLR1 + 2) * AXI_CLOCK_PERIOD
+	 */
+	period_cycles = div64_u64(c * period_ns, NSEC_PER_SEC) - 2;
+	duty_cycles = div64_u64(c * duty_ns, NSEC_PER_SEC) - 2;
+
+	iowrite32(period_cycles, axi_timer->regs + TLR0);
+	iowrite32(duty_cycles, axi_timer->regs + TLR1);
+
+	/* Load timer values */
+	u32 tcsr;
+
+	tcsr = ioread32(axi_timer->regs + TCSR0);
+	iowrite32(tcsr | TCSR_LOAD, axi_timer->regs + TCSR0);
+	iowrite32(tcsr, axi_timer->regs + TCSR0);
+
+	tcsr = ioread32(axi_timer->regs + TCSR1);
+	iowrite32(tcsr | TCSR_LOAD, axi_timer->regs + TCSR1);
+	iowrite32(tcsr, axi_timer->regs + TCSR1);
+
+	return 0;
+}
+
+static int axi_timer_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct axi_timer_pwm_chip *axi_timer = to_axi_timer_pwm_chip(chip);
+
+	/* see timer data sheet for detail
+	 * !CASC - disable cascaded operation
+	 * ENALL - enable all
+	 * PWMA - enable PWM
+	 * !TINT - don't care about interrupts
+	 * ENT- enable timer itself
+	 * !ENIT - disable interrupt
+	 * !LOAD - clear the bit to let go
+	 * ARHT - auto reload
+	 * !CAPT - no external trigger
+	 * GENT - required for PWM
+	 * UDT - set the timer as down counter
+	 * !MDT - generate mode
+	 */
+	iowrite32(TCSR_ENALL | TCSR_PWMA | TCSR_ENT | TCSR_ARHT |
+		  TCSR_GENT | TCSR_UDT, axi_timer->regs + TCSR0);
+	iowrite32(TCSR_ENALL | TCSR_PWMA | TCSR_ENT | TCSR_ARHT |
+		  TCSR_GENT | TCSR_UDT, axi_timer->regs + TCSR1);
+
+	return 0;
+}
+
+static void axi_timer_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct axi_timer_pwm_chip *axi_timer = to_axi_timer_pwm_chip(chip);
+
+	u32 tcsr;
+
+	tcsr = ioread32(axi_timer->regs + TCSR0);
+	iowrite32(tcsr & ~TCSR_PWMA, axi_timer->regs + TCSR0);
+
+	tcsr = ioread32(axi_timer->regs + TCSR1);
+	iowrite32(tcsr & ~TCSR_PWMA, axi_timer->regs + TCSR1);
+}
+
+static const struct pwm_ops axi_timer_pwm_ops = {
+	.config = axi_timer_pwm_config,
+	.enable = axi_timer_pwm_enable,
+	.disable = axi_timer_pwm_disable,
+	.owner = THIS_MODULE,
+};
+
+static int axi_timer_pwm_probe(struct platform_device *pdev)
+{
+	struct axi_timer_pwm_chip *axi_timer;
+	struct resource *res;
+	int ret;
+
+	axi_timer = devm_kzalloc(&pdev->dev, sizeof(*axi_timer), GFP_KERNEL);
+	if (!axi_timer)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	axi_timer->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(axi_timer->regs))
+		return PTR_ERR(axi_timer->regs);
+
+	axi_timer->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(axi_timer->clk))
+		return PTR_ERR(axi_timer->clk);
+
+	axi_timer->chip.dev = &pdev->dev;
+	axi_timer->chip.ops = &axi_timer_pwm_ops;
+	axi_timer->chip.npwm = 1;
+	axi_timer->chip.base = -1;
+
+	dev_info(&pdev->dev, "at 0x%08llX mapped to 0x%p\n",
+		 (unsigned long long)res->start, axi_timer->regs);
+
+	ret = pwmchip_add(&axi_timer->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to add PWM chip, error %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, axi_timer);
+
+	return 0;
+}
+
+static int axi_timer_pwm_remove(struct platform_device *pdev)
+{
+	struct axi_timer_pwm_chip *axi_timer = platform_get_drvdata(pdev);
+	unsigned int i;
+
+	for (i = 0; i < axi_timer->chip.npwm; i++)
+		pwm_disable(&axi_timer->chip.pwms[i]);
+
+	return pwmchip_remove(&axi_timer->chip);
+}
+
+static const struct of_device_id axi_timer_pwm_dt_ids[] = {
+	{ .compatible = "xlnx,axi-timer-2.0", },
+};
+MODULE_DEVICE_TABLE(of, axi_timer_pwm_dt_ids);
+
+static struct platform_driver axi_timer_pwm_driver = {
+	.driver = {
+		.name = "axi_timer-pwm",
+		.of_match_table = axi_timer_pwm_dt_ids,
+	},
+	.probe = axi_timer_pwm_probe,
+	.remove = axi_timer_pwm_remove,
+};
+module_platform_driver(axi_timer_pwm_driver);
+
+MODULE_ALIAS("platform:axi_timer-pwm");
+MODULE_AUTHOR("Alvaro Gamez Machado <alvaro.gamez@hazent.com>");
+MODULE_DESCRIPTION("AXI TIMER PWM Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0
