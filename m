Return-Path: <mikedunn@newsguy.com>
From: Mike Dunn <mikedunn@newsguy.com>
Subject: [PATCH v2] pwm: pxa: add device tree support to pwm driver
Date: Sun,  8 Sep 2013 12:40:18 -0700
Message-Id: <1378669218-10944-1-git-send-email-mikedunn@newsguy.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-pwm@vger.kernel.org
Cc: Mike Dunn <mikedunn@newsguy.com>, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

This patch adds device tree support to the pxa's pwm driver.  Only an OF match
table is added; nothing needs to be extracted from the device tree node.  The
existing platform_device id table is reused for the match table data.  Support
for inverted polarity is also added.

Tested on a Palm Treo 680 (both platform data and DT cases).

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---
Changle log:
v2:
- of_match_table contains only the "pxa250-pwm" compatible string; require one
  device instance per pwm
- add Documentation/devicetree/bindings/pwm/pxa-pwm.txt
- add support for polarity flag in DT and implement set_polarity() method
  (the treo 680 inverts the signal between pwm out and backlight)
- return -EINVAL instead of -ENODEV if platform data or DT node not found
- output dev_info string if platform data missing
- expanded CC list of patch

 Documentation/devicetree/bindings/pwm/pxa-pwm.txt | 33 +++++++++++++
 arch/arm/boot/dts/pxa27x.dtsi                     | 24 ++++++++++
 drivers/pwm/pwm-pxa.c                             | 57 +++++++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pxa-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
new file mode 100644
index 0000000..7b09bfa
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
@@ -0,0 +1,33 @@
+Marvell pwm controller
+
+Required properties:
+- compatible:
+  for pxa25x, pxa27x, pxa168, pxa910: must be compatible = "marvell,pxa250-pwm";
+- reg: physical base address and length of the registers used by the pwm channel
+  NB: One device instance must be created for each pwm that is used, so the
+  length covers only the register window for one pwm output, not that of the
+  entire pwm controller.  Currently length is 0x10 for all supported devices.
+- #pwm-cells: should be 3.
+   cell 1: the per-chip index of the PWM to use,
+   cell 2: the period in nanoseconds,
+   cell 3: flags; set bit 0 to specify inverse polarity.  The pwm controller
+   does not implement reverse polarity, but some boards may pass the pwm output
+   through an external inverter, which can cause problems if a client device
+   assumes that an increase in the duty cycle results in an increase in output
+   power.  The pwm-backlight is an example of such a client.
+
+Example pwm device node:
+
+pwm0: pwm@40b00000 {
+	compatible = "marvell,pxa250-pwm";
+	reg = <0x40b00000 0x10>;
+	#pwm-cells = <3>;
+};
+
+Example pwm client node:
+
+backlight {
+      	compatible = "pwm-backlight";
+     	pwms = <&pwm0 0 5000000 1>;  /* pwm output is inverted */
+	...
+}
diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index d7c5d72..a12fe8e 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -10,5 +10,29 @@
 			marvell,intc-priority;
 			marvell,intc-nr-irqs = <34>;
 		};
+
+		pwm0: pwm@40b00000 {
+			compatible = "marvell,pxa250-pwm";
+			reg = <0x40b00000 0x10>;
+			#pwm-cells = <3>;
+		};
+
+		pwm1: pwm@40b00010 {
+			compatible = "marvell,pxa250-pwm";
+			reg = <0x40b00010 0x10>;
+			#pwm-cells = <3>;
+		};
+
+		pwm2: pwm@40c00000 {
+			compatible = "marvell,pxa250-pwm";
+			reg = <0x40c00000 0x10>;
+			#pwm-cells = <3>;
+		};
+
+		pwm3: pwm@40c00010 {
+			compatible = "marvell,pxa250-pwm";
+			reg = <0x40c00010 0x10>;
+			#pwm-cells = <3>;
+		};
 	};
 };
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index a4d2164..33e6a7d 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/pwm.h>
+#include <linux/of_device.h>
 
 #include <asm/div64.h>
 
@@ -48,6 +49,7 @@ struct pxa_pwm_chip {
 
 	struct clk	*clk;
 	void __iomem	*mmio_base;
+	enum pwm_polarity polarity;
 };
 
 static inline struct pxa_pwm_chip *to_pxa_pwm_chip(struct pwm_chip *chip)
@@ -88,6 +90,15 @@ static int pxa_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		dc = (pv + 1) * duty_ns / period_ns;
 
+	if (pc->polarity == PWM_POLARITY_INVERSED) {
+		if (dc & PWMDCR_FD)
+			dc = 0;	        /* continuously low */
+		else if (dc == 0)
+			dc = PWMDCR_FD; /* continuously high */
+		else
+			dc = 1023 - dc; /* complement duty cycle */
+	}
+
 	/* NOTE: the clock to PWM has to be enabled first
 	 * before writing to the registers
 	 */
@@ -117,13 +128,51 @@ static void pxa_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable_unprepare(pc->clk);
 }
 
+static int pxa_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
+				enum pwm_polarity polarity)
+{
+	struct pxa_pwm_chip *pc = to_pxa_pwm_chip(chip);
+	pc->polarity = polarity;
+	return 0;
+}
+
 static struct pwm_ops pxa_pwm_ops = {
 	.config = pxa_pwm_config,
 	.enable = pxa_pwm_enable,
 	.disable = pxa_pwm_disable,
+	.set_polarity = pxa_pwm_set_polarity,
 	.owner = THIS_MODULE,
 };
 
+#ifdef CONFIG_OF
+/*
+ * Device tree users should create one device instance for each pwm channel.
+ * Hence we dispense with the HAS_SECONDARY_PWM and "tell" the original driver
+ * code that this is a single channel pxa25x-pwm.
+ */
+static struct of_device_id pwm_of_match[] = {
+	{ .compatible = "marvell,pxa250-pwm", .data = &pwm_id_table[0]},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pwm_of_match);
+
+static const struct platform_device_id *pxa_pwm_get_id_dt(struct device *dev)
+{
+	const struct of_device_id *pwm_pxa_devid =
+		of_match_device(pwm_of_match, dev);
+	if (pwm_pxa_devid)
+		return (const struct platform_device_id *)pwm_pxa_devid->data;
+	else
+		return NULL;
+}
+#else  /* !CONFIG_OF */
+static const struct platform_device_id *pxa_pwm_get_id_dt(struct device *dev)
+{
+	dev_info(dev, "missing platform data\n");
+	return NULL;
+}
+#endif
+
 static int pwm_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
@@ -131,6 +180,11 @@ static int pwm_probe(struct platform_device *pdev)
 	struct resource *r;
 	int ret = 0;
 
+	if (id == NULL)		/* using device tree */
+		id = pxa_pwm_get_id_dt(&pdev->dev);
+	if (id == NULL)
+		return -EINVAL;
+
 	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
 	if (pwm == NULL) {
 		dev_err(&pdev->dev, "failed to allocate memory\n");
@@ -145,6 +199,8 @@ static int pwm_probe(struct platform_device *pdev)
 	pwm->chip.ops = &pxa_pwm_ops;
 	pwm->chip.base = -1;
 	pwm->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
+	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
+	pwm->chip.of_pwm_n_cells = 3;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pwm->mmio_base = devm_ioremap_resource(&pdev->dev, r);
@@ -176,6 +232,7 @@ static struct platform_driver pwm_driver = {
 	.driver		= {
 		.name	= "pxa25x-pwm",
 		.owner	= THIS_MODULE,
+		.of_match_table	= of_match_ptr(pwm_of_match),
 	},
 	.probe		= pwm_probe,
 	.remove		= pwm_remove,
-- 
1.8.1.5
