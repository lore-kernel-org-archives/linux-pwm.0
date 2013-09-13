Return-Path: <mikedunn@newsguy.com>
From: Mike Dunn <mikedunn@newsguy.com>
Subject: [PATCH v3] PWM: PXA: add device tree support to PWM driver
Date: Fri, 13 Sep 2013 09:54:41 -0700
Message-Id: <1379091281-23662-1-git-send-email-mikedunn@newsguy.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-pwm@vger.kernel.org
Cc: Mike Dunn <mikedunn@newsguy.com>, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>

This patch adds device tree support to the PXA's PWM driver.  Only an OF match
table is added; nothing needs to be extracted from the device tree node.  The
existing ID table is reused for the match table data.

Tested on a Palm Treo 680 (both platform data and DT cases).

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---
Changle log:
v3:
- remove support for the polarity flag
- remove per-chip pwm index cell; define custom of_xlate()
   (now #pwm-cells = <1>)
- "compatible" strings for all devices added to OF match table
- various stylistic changes recommended by reviewers

v2:
- of_match_table contains only the "pxa250-pwm" compatible string; require one
  device instance per pwm
- add Documentation/devicetree/bindings/pwm/pxa-pwm.txt
- add support for polarity flag in DT and implement set_polarity() method
  (the treo 680 inverts the signal between pwm out and backlight)
- return -EINVAL instead of -ENODEV if platform data or DT node not found
- output dev_info string if platform data missing
- expanded CC list of patch

 Documentation/devicetree/bindings/pwm/pxa-pwm.txt | 31 ++++++++++++
 arch/arm/boot/dts/pxa27x.dtsi                     | 24 +++++++++
 drivers/pwm/pwm-pxa.c                             | 62 +++++++++++++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pxa-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
new file mode 100644
index 0000000..6fcf90c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
@@ -0,0 +1,31 @@
+Marvell PWM controller
+
+Required properties:
+- compatible: should be one of:
+  - "marvell,pxa250-pwm"
+  - "marvell,pxa270-pwm"
+  - "marvell,pxa168-pwm"
+  - "marvell,pxa910-pwm"
+- reg: physical base address and length of the registers used by the PWM channel
+  NB: One device instance must be created for each PWM that is used, so the
+  length covers only the register window for one PWM output, not that of the
+  entire PWM controller.  Currently length is 0x10 for all supported devices.
+- #pwm-cells: should be 1.  This cell is used to specify the period in
+  nanoseconds.  (Because one device instance is created for each PWM output,
+  the per-chip index is superflous and not used.)
+
+Example PWM device node:
+
+pwm0: pwm@40b00000 {
+	compatible = "marvell,pxa250-pwm";
+	reg = <0x40b00000 0x10>;
+	#pwm-cells = <1>;
+};
+
+Example PWM client node:
+
+backlight {
+	compatible = "pwm-backlight";
+	pwms = <&pwm0 5000000>;
+	...
+}
diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index d7c5d72..5057c41 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -10,5 +10,29 @@
 			marvell,intc-priority;
 			marvell,intc-nr-irqs = <34>;
 		};
+
+		pwm0: pwm@40b00000 {
+			compatible = "marvell,pxa270-pwm";
+			reg = <0x40b00000 0x10>;
+			#pwm-cells = <1>;
+		};
+
+		pwm1: pwm@40b00010 {
+			compatible = "marvell,pxa270-pwm";
+			reg = <0x40b00010 0x10>;
+			#pwm-cells = <1>;
+		};
+
+		pwm2: pwm@40c00000 {
+			compatible = "marvell,pxa270-pwm";
+			reg = <0x40c00000 0x10>;
+			#pwm-cells = <1>;
+		};
+
+		pwm3: pwm@40c00010 {
+			compatible = "marvell,pxa270-pwm";
+			reg = <0x40c00010 0x10>;
+			#pwm-cells = <1>;
+		};
 	};
 };
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index a4d2164..91b1cff 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/pwm.h>
+#include <linux/of_device.h>
 
 #include <asm/div64.h>
 
@@ -124,6 +125,59 @@ static struct pwm_ops pxa_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
+#ifdef CONFIG_OF
+/*
+ * Device tree users must create one device instance for each pwm channel.
+ * Hence we dispense with the HAS_SECONDARY_PWM and "tell" the original driver
+ * code that this is a single channel pxa25x-pwm.  Currently all devices are
+ * supported identically.
+ */
+static struct of_device_id pwm_of_match[] = {
+	{ .compatible = "marvell,pxa250-pwm", .data = &pwm_id_table[0]},
+	{ .compatible = "marvell,pxa270-pwm", .data = &pwm_id_table[0]},
+	{ .compatible = "marvell,pxa168-pwm", .data = &pwm_id_table[0]},
+	{ .compatible = "marvell,pxa910-pwm", .data = &pwm_id_table[0]},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pwm_of_match);
+
+static const struct platform_device_id *pxa_pwm_get_id_dt(struct device *dev)
+{
+	const struct of_device_id *id = of_match_device(pwm_of_match, dev);
+	if (id)
+		return (const struct platform_device_id *)id->data;
+	else
+		return NULL;
+}
+
+struct pwm_device *
+pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
+{
+	struct pwm_device *pwm;
+
+	pwm = pwm_request_from_chip(pc, 0, NULL);
+	if (IS_ERR(pwm))
+		return pwm;
+
+	pwm_set_period(pwm, args->args[0]);
+
+	return pwm;
+}
+
+#else  /* !CONFIG_OF */
+static const struct platform_device_id *pxa_pwm_get_id_dt(struct device *dev)
+{
+	dev_err(dev, "missing platform data\n");
+	return NULL;
+}
+
+struct pwm_device *
+pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
+{
+	return NULL;
+}
+#endif
+
 static int pwm_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
@@ -131,6 +185,11 @@ static int pwm_probe(struct platform_device *pdev)
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
@@ -145,6 +204,8 @@ static int pwm_probe(struct platform_device *pdev)
 	pwm->chip.ops = &pxa_pwm_ops;
 	pwm->chip.base = -1;
 	pwm->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
+	pwm->chip.of_xlate = pxa_pwm_of_xlate;
+	pwm->chip.of_pwm_n_cells = 1;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pwm->mmio_base = devm_ioremap_resource(&pdev->dev, r);
@@ -176,6 +237,7 @@ static struct platform_driver pwm_driver = {
 	.driver		= {
 		.name	= "pxa25x-pwm",
 		.owner	= THIS_MODULE,
+		.of_match_table	= of_match_ptr(pwm_of_match),
 	},
 	.probe		= pwm_probe,
 	.remove		= pwm_remove,
-- 
1.8.1.5
