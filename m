Return-Path: <mikedunn@newsguy.com>
From: Mike Dunn <mikedunn@newsguy.com>
Subject: [PATCH] pwm: pxa: add device tree support to pwm driver
Date: Tue,  3 Sep 2013 12:23:53 -0700
Message-Id: <1378236233-15637-1-git-send-email-mikedunn@newsguy.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-pwm@vger.kernel.org
Cc: Mike Dunn <mikedunn@newsguy.com>, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This patch adds device tree support to the pxa's pwm driver.  Only an OF match
table is added; nothing needs to be extracted from the device tree node.  The
existing platform_device id table is reused for the match table data.

Tested on a Palm Treo 680 (both platform data and DT cases).

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---

I don't have data sheets handy for the newer Marvell pxa's (and I'm confused
about the presence of a pwm unit on pxa25x), so only pxa27x.dtsi was updated.
Thanks for looking!

 arch/arm/boot/dts/pxa27x.dtsi | 12 ++++++++++++
 drivers/pwm/pwm-pxa.c         | 31 +++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index d7c5d72..4031dce 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -10,5 +10,17 @@
 			marvell,intc-priority;
 			marvell,intc-nr-irqs = <34>;
 		};
+
+		pwm0: pwm@40b00000 {
+			compatible = "marvell,pxa27x-pwm";
+			reg = <0x40b00000 0x100000>;
+			#pwm-cells = <2>;
+		};
+
+		pwm1: pwm@40c00000 {
+			compatible = "marvell,pxa27x-pwm";
+			reg = <0x40c00000 0x100000>;
+			#pwm-cells = <2>;
+		};
 	};
 };
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index a4d2164..be5f914 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/pwm.h>
+#include <linux/of_device.h>
 
 #include <asm/div64.h>
 
@@ -124,6 +125,30 @@ static struct pwm_ops pxa_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
+#ifdef CONFIG_OF
+/* use the platform_device id table for OF match table data */
+static struct of_device_id pwm_of_match[] = {
+	{ .compatible = "marvell,pxa25x-pwm", .data = &pwm_id_table[0] },
+	{ .compatible = "marvell,pxa27x-pwm", .data = &pwm_id_table[1] },
+	{ .compatible = "marvell,pxa168-pwm", .data = &pwm_id_table[2] },
+	{ .compatible = "marvell,pxa910-pwm", .data = &pwm_id_table[3] },
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
+#define pxa_pwm_get_id_dt(dev) ((const struct platform_device_id *)NULL)
+#endif
+
 static int pwm_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
@@ -131,6 +156,11 @@ static int pwm_probe(struct platform_device *pdev)
 	struct resource *r;
 	int ret = 0;
 
+	if (id == NULL)		/* using device tree */
+		id = pxa_pwm_get_id_dt(&pdev->dev);
+	if (id == NULL)
+		return -ENODEV;
+
 	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
 	if (pwm == NULL) {
 		dev_err(&pdev->dev, "failed to allocate memory\n");
@@ -176,6 +206,7 @@ static struct platform_driver pwm_driver = {
 	.driver		= {
 		.name	= "pxa25x-pwm",
 		.owner	= THIS_MODULE,
+		.of_match_table	= of_match_ptr(pwm_of_match),
 	},
 	.probe		= pwm_probe,
 	.remove		= pwm_remove,
-- 
1.8.1.5
