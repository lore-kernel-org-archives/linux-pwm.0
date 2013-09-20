Return-Path: <mikedunn@newsguy.com>
From: Mike Dunn <mikedunn@newsguy.com>
Subject: [PATCH v5 1/2] PWM: PXA: add device tree support to PWM driver
Date: Fri, 20 Sep 2013 09:12:46 -0700
Message-Id: <1379693567-15860-2-git-send-email-mikedunn@newsguy.com>
In-Reply-To: <1379693567-15860-1-git-send-email-mikedunn@newsguy.com>
References: <1379693567-15860-1-git-send-email-mikedunn@newsguy.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-pwm@vger.kernel.org
Cc: Mike Dunn <mikedunn@newsguy.com>, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>

This patch adds device tree support to the PXA's PWM driver.  Nothing
needs to be extracted from the device tree node by the PWM device.
Client devices need only specify the period; the per-chip index is
implicitly zero because one device node must be present for each PWM
output in use.  This approach is more convenient due to the wide
variability in the number of PWM channels present across the various PXA
variants, and is made possible by the fact that the register sets for
each PWM channel are segregated from each other.  An of_xlate() method
is added to parse this single-cell node.  The existing ID table is
reused for the match table data.

Tested on a Palm Treo 680 (both platform data and DT cases).

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---
 drivers/pwm/pwm-pxa.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index a4d2164..e928cc8 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/pwm.h>
+#include <linux/of_device.h>
 
 #include <asm/div64.h>
 
@@ -124,6 +125,45 @@ static struct pwm_ops pxa_pwm_ops = {
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
+#else
+static struct of_device_id *pwm_of_match;
+#endif
+
+static const struct platform_device_id *pxa_pwm_get_id_dt(struct device *dev)
+{
+	const struct of_device_id *id = of_match_device(pwm_of_match, dev);
+	return id ? id->data : NULL;
+}
+
+static struct pwm_device *
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
 static int pwm_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
@@ -131,6 +171,12 @@ static int pwm_probe(struct platform_device *pdev)
 	struct resource *r;
 	int ret = 0;
 
+	if (IS_ENABLED(CONFIG_OF) && id == NULL)
+		id = pxa_pwm_get_id_dt(&pdev->dev);
+
+	if (id == NULL)
+		return -EINVAL;
+
 	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
 	if (pwm == NULL) {
 		dev_err(&pdev->dev, "failed to allocate memory\n");
@@ -145,7 +191,10 @@ static int pwm_probe(struct platform_device *pdev)
 	pwm->chip.ops = &pxa_pwm_ops;
 	pwm->chip.base = -1;
 	pwm->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
-
+	if (IS_ENABLED(CONFIG_OF)) {
+		pwm->chip.of_xlate = pxa_pwm_of_xlate;
+		pwm->chip.of_pwm_n_cells = 1;
+	}
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pwm->mmio_base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(pwm->mmio_base))
@@ -176,6 +225,7 @@ static struct platform_driver pwm_driver = {
 	.driver		= {
 		.name	= "pxa25x-pwm",
 		.owner	= THIS_MODULE,
+		.of_match_table	= of_match_ptr(pwm_of_match),
 	},
 	.probe		= pwm_probe,
 	.remove		= pwm_remove,
-- 
1.8.1.5
