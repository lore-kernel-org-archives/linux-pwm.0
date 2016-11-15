From: Jian Yuan <yuanjian12-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: [RESEND PATCH v4] pwm: add pwm driver for HiSilicon BVT SOCs
Date: Tue, 15 Nov 2016 20:41:32 +0800
Message-ID: <1479213692-223477-1-git-send-email-yuanjian12@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuejiancheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, kevin.lixu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, jalen.hsu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, yuanjian <yuanjian12-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

From: yuanjian <yuanjian12-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>

Add PWM driver for the PWM controller found on HiSilicon BVT SOCs, like Hi3519V100, Hi3516CV300, etc.
The PWM controller is primarily in charge of controlling P-Iris lens.

Reviewed-by: Jiancheng Xue <xuejiancheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Signed-off-by: Jian Yuan <yuanjian12-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
---
Change Log:
v4:
Add #pwm-cells in the bindings document.
v3:
fixed issues pointed by thierry.
Add PWM compatible string for Hi3519V100.
Implement .apply() function which support atomic, instead of .enable()/.disable()/.config().
v2:
The number of PWMs is change to be probeable based on the compatible string.

 .../devicetree/bindings/pwm/pwm-hibvt.txt          |  23 ++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-hibvt.c                            | 270 +++++++++++++++++++++
 4 files changed, 303 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
 create mode 100644 drivers/pwm/pwm-hibvt.c

diff --git a/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
new file mode 100644
index 0000000..609284f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
@@ -0,0 +1,23 @@
+Hisilicon PWM controller
+
+Required properties:
+-compatible: should contain one SoC specific compatible string and one generic compatible
+string "hisilicon, hibvt-pwm". The SoC specific strings supported including:
+	"hisilicon,hi3516cv300-pwm"
+	"hisilicon,hi3519v100-pwm"
+- reg: physical base address and length of the controller's registers.
+- clocks: phandle and clock specifier of the PWM reference clock.
+- resets: phandle and reset specifier for the PWM controller reset.
+- #pwm-cells: Should be 2. See pwm.txt in this directory for a description of
+  the cells format.
+
+Example:
+	pwm: pwm@12130000 {
+
+		compatible = "hisilicon,hi3516cv300-pwm", "hisilicon,hibvt-pwm";
+		compatible = "hisilicon,hi3519v100-pwm", "hisilicon,hibvt-pwm";
+		reg = <0x12130000 0x10000>;
+		clocks = <&crg_ctrl HI3516CV300_PWM_CLK>;
+		resets = <&crg_ctrl 0x38 0>;
+		#pwm-cells = <2>;
+	};
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index c182efc..b2d7408 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -158,6 +158,15 @@ config PWM_FSL_FTM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-fsl-ftm.
 
+config PWM_HIBVT
+	tristate "HiSilicon BVT PWM support"
+	depends on ARCH_HISI || COMPILE_TEST
+	help
+	  Generic PWM framework driver for HiSilicon BVT SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-hibvt.
+
 config PWM_IMG
 	tristate "Imagination Technologies PWM driver"
 	depends on HAS_IOMEM
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
index 0000000..1c14c21
--- /dev/null
+++ b/drivers/pwm/pwm-hibvt.c
@@ -0,0 +1,270 @@
+/*
+ * PWM Controller Driver for HiSilicon BVT SoCs
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
+#define PWM_ENABLE_MASK     BIT(0)
+
+#define PWM_POLARITY_SHIFT  1
+#define PWM_POLARITY_MASK   BIT(1)
+
+#define PWM_KEEP_SHIFT      2
+#define PWM_KEEP_MASK       BIT(2)
+
+#define PWM_PERIOD_MASK     GENMASK(31, 0)
+#define PWM_DUTY_MASK       GENMASK(31, 0)
+
+struct hibvt_pwm_chip {
+	struct pwm_chip	chip;
+	struct clk *clk;
+	void __iomem *base;
+	struct reset_control *rstc;
+};
+
+struct hibvt_pwm_soc {
+	u32 num_pwms;
+};
+
+static const struct hibvt_pwm_soc pwm_soc[2] = {
+	{ .num_pwms = 4 },
+	{ .num_pwms = 8 },
+};
+
+static inline struct hibvt_pwm_chip *to_hibvt_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct hibvt_pwm_chip, chip);
+}
+
+static void hibvt_pwm_set_bits(void __iomem *base, u32 offset,
+					u32 mask, u32 data)
+{
+	void __iomem *address = base + offset;
+	u32 value;
+
+	value = readl(address);
+	value &= ~mask;
+	value |= (data & mask);
+	writel(value, address);
+}
+
+static void hibvt_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
+
+	hibvt_pwm_set_bits(hi_pwm_chip->base, PWM_CTRL_ADDR(pwm->hwpwm),
+			PWM_ENABLE_MASK, 0x1);
+}
+
+static void hibvt_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
+
+	hibvt_pwm_set_bits(hi_pwm_chip->base, PWM_CTRL_ADDR(pwm->hwpwm),
+			PWM_ENABLE_MASK, 0x0);
+}
+
+static void hibvt_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+					int duty_cycle_ns, int period_ns)
+{
+	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
+	u32 freq, period, duty;
+
+	freq = div_u64(clk_get_rate(hi_pwm_chip->clk), 1000000);
+
+	period = div_u64(freq * period_ns, 1000);
+	duty = div_u64(period * duty_cycle_ns, period_ns);
+
+	hibvt_pwm_set_bits(hi_pwm_chip->base, PWM_CFG0_ADDR(pwm->hwpwm),
+			PWM_PERIOD_MASK, period);
+
+	hibvt_pwm_set_bits(hi_pwm_chip->base, PWM_CFG1_ADDR(pwm->hwpwm),
+			PWM_DUTY_MASK, duty);
+}
+
+static void hibvt_pwm_set_polarity(struct pwm_chip *chip,
+					struct pwm_device *pwm,
+					enum pwm_polarity polarity)
+{
+	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
+
+	if (polarity == PWM_POLARITY_INVERSED)
+		hibvt_pwm_set_bits(hi_pwm_chip->base, PWM_CTRL_ADDR(pwm->hwpwm),
+				PWM_POLARITY_MASK, (0x1 << PWM_POLARITY_SHIFT));
+	else
+		hibvt_pwm_set_bits(hi_pwm_chip->base, PWM_CTRL_ADDR(pwm->hwpwm),
+				PWM_POLARITY_MASK, (0x0 << PWM_POLARITY_SHIFT));
+}
+
+static void hibvt_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
+	void __iomem *base;
+	u32 freq, value;
+
+	freq = div_u64(clk_get_rate(hi_pwm_chip->clk), 1000000);
+	base = hi_pwm_chip->base;
+
+	value = readl(base + PWM_CFG0_ADDR(pwm->hwpwm));
+	state->period = div_u64(value * 1000, freq);
+
+	value = readl(base + PWM_CFG1_ADDR(pwm->hwpwm));
+	state->duty_cycle = div_u64(value * 1000, freq);
+
+	value = readl(base + PWM_CTRL_ADDR(pwm->hwpwm));
+	state->enabled = (PWM_ENABLE_MASK & value);
+}
+
+static int hibvt_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	if (state->polarity != pwm->state.polarity)
+		hibvt_pwm_set_polarity(chip, pwm, state->polarity);
+
+	if (state->period != pwm->state.period ||
+		state->duty_cycle != pwm->state.duty_cycle)
+		hibvt_pwm_config(chip, pwm, state->duty_cycle, state->period);
+
+	if (state->enabled != pwm->state.enabled) {
+		if (state->enabled)
+			hibvt_pwm_enable(chip, pwm);
+		else
+			hibvt_pwm_disable(chip, pwm);
+	}
+
+	return 0;
+}
+
+static struct pwm_ops hibvt_pwm_ops = {
+	.get_state = hibvt_pwm_get_state,
+	.apply = hibvt_pwm_apply,
+
+	.owner = THIS_MODULE,
+};
+
+static int hibvt_pwm_probe(struct platform_device *pdev)
+{
+	const struct hibvt_pwm_soc *soc =
+				of_device_get_match_data(&pdev->dev);
+	struct hibvt_pwm_chip *pwm_chip;
+	struct resource *res;
+	int ret;
+	int i;
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
+	pwm_chip->chip.ops = &hibvt_pwm_ops;
+	pwm_chip->chip.dev = &pdev->dev;
+	pwm_chip->chip.base = -1;
+	pwm_chip->chip.npwm = soc->num_pwms;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pwm_chip->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pwm_chip->base))
+		return PTR_ERR(pwm_chip->base);
+
+	ret = clk_prepare_enable(pwm_chip->clk);
+	if (ret < 0)
+		return ret;
+
+	pwm_chip->rstc = devm_reset_control_get(&pdev->dev, NULL);
+	if (IS_ERR(pwm_chip->rstc)) {
+		clk_disable_unprepare(pwm_chip->clk);
+		return PTR_ERR(pwm_chip->rstc);
+	}
+
+	reset_control_assert(pwm_chip->rstc);
+	msleep(30);
+	reset_control_deassert(pwm_chip->rstc);
+
+	ret = pwmchip_add(&pwm_chip->chip);
+	if (ret < 0) {
+		clk_disable_unprepare(pwm_chip->clk);
+		return ret;
+	}
+
+	for (i = 0; i < pwm_chip->chip.npwm; i++) {
+		hibvt_pwm_set_bits(pwm_chip->base, PWM_CTRL_ADDR(i),
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
+
+	reset_control_assert(pwm_chip->rstc);
+	msleep(30);
+	reset_control_deassert(pwm_chip->rstc);
+
+	clk_disable_unprepare(pwm_chip->clk);
+
+	return pwmchip_remove(&pwm_chip->chip);
+}
+
+static const struct of_device_id hibvt_pwm_of_match[] = {
+	{ .compatible = "hisilicon,hibvt-pwm" },
+	{ .compatible = "hisilicon,hi3516cv300-pwm", .data = &pwm_soc[0] },
+	{ .compatible = "hisilicon,hi3519v100-pwm", .data = &pwm_soc[1] },
+	{  }
+};
+MODULE_DEVICE_TABLE(of, hibvt_pwm_of_match);
+
+static struct platform_driver hibvt_pwm_driver = {
+	.driver = {
+		.name = "hibvt-pwm",
+		.of_match_table = hibvt_pwm_of_match,
+	},
+	.probe = hibvt_pwm_probe,
+	.remove	= hibvt_pwm_remove,
+};
+module_platform_driver(hibvt_pwm_driver);
+
+MODULE_AUTHOR("Jian Yuan");
+MODULE_DESCRIPTION("HiSilicon BVT SoCs PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
