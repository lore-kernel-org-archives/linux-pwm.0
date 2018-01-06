From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/4] pwm: jz4740: Add support for devicetree
Date: Sat,  6 Jan 2018 17:58:42 +0100
Message-ID: <20180106165843.3461-3-paul@crapouillou.net>
References: <20180106165843.3461-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180106165843.3461-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

Add support for probing the pwm-jz4740 directly from devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt | 25 ++++++++++++++++++++++
 drivers/pwm/pwm-jz4740.c                           | 14 ++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
new file mode 100644
index 000000000000..7d9d3f90641b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
@@ -0,0 +1,25 @@
+Ingenic JZ47xx PWM Controller
+=============================
+
+Required properties:
+- compatible: One of:
+  * "ingenic,jz4740-pwm"
+  * "ingenic,jz4770-pwm"
+  * "ingenic,jz4780-pwm"
+- #pwm-cells: Should be 3. See pwm.txt in this directory for a description
+  of the cells format.
+- clocks : phandle to the external clock.
+- clock-names : Should be "ext".
+
+
+Example:
+
+	pwm: pwm@10002000 {
+		compatible = "ingenic,jz4740-pwm";
+		reg = <0x10002000 0x1000>;
+
+		#pwm-cells = <3>;
+
+		clocks = <&ext>;
+		clock-names = "ext";
+	};
diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 6539c001fe32..a7b134af5e04 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -18,6 +18,7 @@
 #include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 
@@ -174,6 +175,8 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	jz4740->chip.ops = &jz4740_pwm_ops;
 	jz4740->chip.npwm = NUM_PWM;
 	jz4740->chip.base = -1;
+	jz4740->chip.of_xlate = of_pwm_xlate_with_flags;
+	jz4740->chip.of_pwm_n_cells = 3;
 
 	platform_set_drvdata(pdev, jz4740);
 
@@ -187,9 +190,20 @@ static int jz4740_pwm_remove(struct platform_device *pdev)
 	return pwmchip_remove(&jz4740->chip);
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id jz4740_pwm_dt_ids[] = {
+	{ .compatible = "ingenic,jz4740-pwm", },
+	{ .compatible = "ingenic,jz4770-pwm", },
+	{ .compatible = "ingenic,jz4780-pwm", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, jz4740_pwm_dt_ids);
+#endif
+
 static struct platform_driver jz4740_pwm_driver = {
 	.driver = {
 		.name = "jz4740-pwm",
+		.of_match_table = of_match_ptr(jz4740_pwm_dt_ids),
 	},
 	.probe = jz4740_pwm_probe,
 	.remove = jz4740_pwm_remove,
-- 
2.11.0
