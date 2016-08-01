From: Jian Yuan <yuanjian12-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: [PATCH] pwm: add pwm driver for HiSilicon BVT SOCs
Date: Mon, 1 Aug 2016 09:42:08 +0800
Message-ID: <1470015728-36979-1-git-send-email-yuanjian12@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: xuejiancheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, kevin.lixu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, yuanjian12-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, jalen.hsu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

From: yuanjian <yuanjian12-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>

Add pwm driver for HiSilicon BVT SOCs

Reviewed-by: Jiancheng Xue <xuejiancheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Signed-off-by: Jian Yuan <yuanjian12-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
---
 .../devicetree/bindings/pwm/pwm-hibvt.txt          |  18 ++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-hibvt.c                            | 272 +++++++++++++++++++++
 4 files changed, 301 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
 create mode 100644 drivers/pwm/pwm-hibvt.c

diff --git a/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
new file mode 100644
index 0000000..4efd83e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
@@ -0,0 +1,18 @@
+Hisilicon PWM controller
+
+Required properties:
+ - compatible: should be "hisilicon,hibvt-pwm" and one of the following:
+			"hisilicon,hi3516cv300-pwm".
+ - reg: physical base address and length of the controller's registers.
+ - clocks: phandle and clock specifier of the PWM reference clock.
+ - resets: offset address and offset bit for reset or unreset of the controller.
+ - pwm-nums: pwm number of the controller.
+
+Example:
+	pwm: pwm@12130000 {                                                                                                                                     
+		compatible = "hisilicon,hibvt-pwm";
+		reg = <0x12130000 0x10000>;
+		clocks = <&crg_ctrl HI3516CV300_PWM_CLK>;
+		resets = <&crg_ctrl 0x38 0>;
+		pwm-nums = <4>;
+	};
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index c182efc..3c48768 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -158,6 +158,15 @@ config PWM_FSL_FTM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-fsl-ftm.
 
+config PWM_HIBVT
+	tristate "HiSilicon BVT PWM support"
+	depends on ARCH_HISI
+	help
+	  Generic PWM framework driver for hisilicon BVT SOCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-hibvt.
+
 config PWM_IMG
 	tristate "Imagination Technologies PWM driver"
 	depends on HAS_IOMEM
@@ -438,4 +447,5 @@ config PWM_VT8500
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-vt8500.
 
+
 endif
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index dd35bc1..37ec39e 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
 obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
+obj-$(CONFIG_PWM_HIBVT)		+= pwm-hibvt.o
 obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
 obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
 obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
new file mode 100644
index 0000000..a073cc4
--- /dev/null
+++ b/drivers/pwm/pwm-hibvt.c
@@ -0,0 +1,272 @@
+/*
+ * PWM Controller Driver for HiSilicon BVT SOCs
+ *
+ * Copyright (c) 2016 HiSilicon Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+
+#define PWM_CFG0_ADDR(x)    (((x) * 0x20) + 0x0)
+#define PWM_CFG1_ADDR(x)    (((x) * 0x20) + 0x4)
+#define PWM_CFG2_ADDR(x)    (((x) * 0x20) + 0x8)
+#define PWM_CTRL_ADDR(x)    (((x) * 0x20) + 0xC)
+
+#define PWM_ENABLE_SHIFT    0
+#define PWM_ENABLE_MASK		BIT(0)
+
+#define PWM_POLARITY_SHIFT	1
+#define PWM_POLARITY_MASK	BIT(1)
+
+#define PWM_KEEP_SHIFT	    2
+#define PWM_KEEP_MASK	    BIT(2)
+
+#define PWM_PERIOD_MASK	    GENMASK(31, 0)
+#define PWM_DUTY_MASK	    GENMASK(31, 0)
+
+struct hibvt_pwm_chip {
+	struct pwm_chip	chip;
+	struct clk	*clk;
+	void __iomem	*mmio_base;
+	struct reset_control *rstc;
+};
+
+static inline
+struct hibvt_pwm_chip *to_hibvt_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct hibvt_pwm_chip, chip);
+}
+
+static void hibvt_pwm_set_bits(void __iomem *base, unsigned int offset,
+					unsigned int mask, unsigned int data)
+{
+	void __iomem *address = base + offset;
+	unsigned int value;
+
+	value = readl(address);
+	value &= ~mask;
+	value |= (data & mask);
+	writel(value, address);
+}
+
+static int hibvt_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
+	unsigned int offset;
+
+	offset = PWM_CTRL_ADDR(pwm->hwpwm);
+	hibvt_pwm_set_bits(hi_pwm_chip->mmio_base, offset,
+			PWM_ENABLE_MASK, 0x1);
+
+	return 0;
+}
+
+static void hibvt_pwm_disable(struct pwm_chip *chip,
+					struct pwm_device *pwm)
+{
+	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
+	unsigned int offset;
+
+	offset = PWM_CTRL_ADDR(pwm->hwpwm);
+	hibvt_pwm_set_bits(hi_pwm_chip->mmio_base, offset,
+			PWM_ENABLE_MASK, 0x0);
+}
+
+static int hibvt_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+					int duty_cycle_ns, int period_ns)
+{
+	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
+	unsigned int offset;
+	unsigned int freq;
+	unsigned int period_num, duty_num;
+
+	freq = div_u64(clk_get_rate(hi_pwm_chip->clk), 1000000);
+
+	period_num = div_u64(freq * period_ns, 1000);
+	duty_num = div_u64(period_num * duty_cycle_ns, period_ns);
+
+	offset = PWM_CFG0_ADDR(pwm->hwpwm);
+	hibvt_pwm_set_bits(hi_pwm_chip->mmio_base, offset,
+			PWM_PERIOD_MASK, period_num);
+
+	offset = PWM_CFG1_ADDR(pwm->hwpwm);
+	hibvt_pwm_set_bits(hi_pwm_chip->mmio_base, offset,
+			PWM_DUTY_MASK, duty_num);
+
+	return 0;
+}
+
+static int hibvt_pwm_set_polarity(struct pwm_chip *chip,
+					struct pwm_device *pwm,
+					enum pwm_polarity polarity)
+{
+	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
+	unsigned int offset;
+
+	offset = PWM_CTRL_ADDR(pwm->hwpwm);
+	if (polarity == PWM_POLARITY_INVERSED)
+		hibvt_pwm_set_bits(hi_pwm_chip->mmio_base, offset,
+				PWM_POLARITY_MASK, (0x1 << PWM_POLARITY_SHIFT));
+	else
+		hibvt_pwm_set_bits(hi_pwm_chip->mmio_base, offset,
+				PWM_POLARITY_MASK, (0x0 << PWM_POLARITY_SHIFT));
+
+	return 0;
+}
+
+void hibvt_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
+	void __iomem *base;
+	unsigned int offset;
+	unsigned int freq;
+	unsigned int period_num, duty_num;
+	unsigned int enable;
+
+	freq = div_u64(clk_get_rate(hi_pwm_chip->clk), 1000000);
+	base = hi_pwm_chip->mmio_base;
+
+	offset = PWM_CFG0_ADDR(pwm->hwpwm);
+	period_num = readl(base + offset);
+	state->period = div_u64(period_num * 1000, freq);
+
+	offset = PWM_CFG1_ADDR(pwm->hwpwm);
+	duty_num = readl(base + offset);
+	state->duty_cycle = div_u64(duty_num * 1000, freq);
+
+	offset = PWM_CTRL_ADDR(pwm->hwpwm);
+	enable = readl(base + offset);
+	state->enabled = (PWM_ENABLE_MASK & enable);
+}
+
+static struct pwm_ops hibvt_pwm_ops = {
+	.enable       = hibvt_pwm_enable,
+	.disable      = hibvt_pwm_disable,
+	.config       = hibvt_pwm_config,
+	.set_polarity = hibvt_pwm_set_polarity,
+	.get_state    = hibvt_pwm_get_state,
+
+	.owner        = THIS_MODULE,
+};
+
+static int hibvt_pwm_probe(struct platform_device *pdev)
+{
+	struct hibvt_pwm_chip *pwm_chip;
+	struct device_node *np = pdev->dev.of_node;
+	struct resource *res;
+	int ret = 0;
+	int i;
+	int offset;
+	int pwm_nums;
+
+	pwm_chip = devm_kzalloc(&pdev->dev, sizeof(*pwm_chip), GFP_KERNEL);
+	if (pwm_chip == NULL)
+		return -ENOMEM;
+
+	pwm_chip->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(pwm_chip->clk)) {
+		dev_err(&pdev->dev, "getting clock failed with %ld\n",
+				PTR_ERR(pwm_chip->clk));
+		return PTR_ERR(pwm_chip->clk);
+	}
+
+	ret = of_property_read_u32(np, "pwm-nums", &pwm_nums);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+				"failed to get PWM number from device tree (error: %d)\n",
+				ret);
+		return ret;
+	}
+
+	pwm_chip->chip.ops = &hibvt_pwm_ops;
+	pwm_chip->chip.dev = &pdev->dev;
+	pwm_chip->chip.base = -1;
+	pwm_chip->chip.npwm = pwm_nums;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pwm_chip->mmio_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pwm_chip->mmio_base))
+		return PTR_ERR(pwm_chip->mmio_base);
+
+	ret = clk_prepare_enable(pwm_chip->clk);
+	if (ret < 0)
+		return ret;
+
+	pwm_chip->rstc = devm_reset_control_get(&pdev->dev, NULL);
+	if (IS_ERR(pwm_chip->rstc))
+		return PTR_ERR(pwm_chip->rstc);
+
+	reset_control_assert(pwm_chip->rstc);
+	msleep(30);
+	reset_control_deassert(pwm_chip->rstc);
+
+	ret = pwmchip_add(&pwm_chip->chip);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < pwm_nums; i++) {
+		offset = PWM_CTRL_ADDR(i);
+		hibvt_pwm_set_bits(pwm_chip->mmio_base, offset,
+				PWM_KEEP_MASK, (0x1 << PWM_KEEP_SHIFT));
+	}
+
+	platform_set_drvdata(pdev, pwm_chip);
+
+	return 0;
+}
+
+static int hibvt_pwm_remove(struct platform_device *pdev)
+{
+	struct hibvt_pwm_chip *pwm_chip;
+
+	pwm_chip = platform_get_drvdata(pdev);
+	if (pwm_chip == NULL)
+		return -ENODEV;
+
+	clk_disable_unprepare(pwm_chip->clk);
+
+	return pwmchip_remove(&pwm_chip->chip);
+}
+
+static const struct of_device_id hibvt_pwm_of_match[] = {
+	{.compatible = "hisilicon,hibvt-pwm"},
+	{.compatible = "hisilicon,hi3516cv300-pwm"},
+	{  }
+};
+MODULE_DEVICE_TABLE(of, hibvt_pwm_of_match);
+
+static struct platform_driver hibvt_pwm_driver = {
+	.driver		= {
+		.name	= "hibvt-pwm",
+		.of_match_table = hibvt_pwm_of_match,
+	},
+	.probe		= hibvt_pwm_probe,
+	.remove		= hibvt_pwm_remove,
+};
+
+module_platform_driver(hibvt_pwm_driver);
+
+MODULE_AUTHOR("yuanjian12-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org");
+MODULE_DESCRIPTION("Hisilicon BVT SOCs PWM driver");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
