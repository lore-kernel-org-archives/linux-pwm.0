From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] pwm: imx: Allow keeping the PWM active during suspend
Date: Sat, 18 Nov 2017 12:36:08 -0200
Message-ID: <1511015768-14140-1-git-send-email-festevam@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46770 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761708AbdKROgW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 18 Nov 2017 09:36:22 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: robh+dt@kernel.org, linux@arm.linux.org.uk, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>

In some systems it is desirable to keep the PWM active during system
suspend.

One use case is the imx6q-cubox-i board, which has an LED driven by PWM.
When the system goes into suspend the PWM block is disabled by default,
the PWM pin goes to zero and turn on the LED during suspend, which is
not really the behaviour we want to see.

By keeping the PWM enabled during suspend the pwm-leds driver sets
the brightness to zero in suspend and then the LED is turned off as
expected.

Introduce the 'fsl,active-in-suspend' property to indicate that the
PWM will stay active during suspend.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Rename the property to 'fsl,active-in-suspend' to better describe
its purpose.

 Documentation/devicetree/bindings/pwm/imx-pwm.txt | 5 +++++
 drivers/pwm/pwm-imx.c                             | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
index c61bdf8..ec2a84c 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
@@ -14,6 +14,11 @@ See the clock consumer binding,
 	Documentation/devicetree/bindings/clock/clock-bindings.txt
 - interrupts: The interrupt for the pwm controller
 
+Optional properties:
+- fsl,active-in-suspend: Boolean property that indicates that the PWM block
+			 stays active during system suspend. If not present,
+			 the PWM block stays inactive during suspend.
+
 Example:
 
 pwm1: pwm@53fb4000 {
diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 2ba5c3a..afa1b20 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -35,6 +35,7 @@
 #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
 #define MX3_PWMPR			0x10    /* PWM Period Register */
 #define MX3_PWMCR_PRESCALER(x)		((((x) - 1) & 0xFFF) << 4)
+#define MX3_PWMCR_STOPEN		(1 << 25)
 #define MX3_PWMCR_DOZEEN		(1 << 24)
 #define MX3_PWMCR_WAITEN		(1 << 23)
 #define MX3_PWMCR_DBGEN			(1 << 22)
@@ -54,6 +55,7 @@ struct imx_chip {
 	void __iomem	*mmio_base;
 
 	struct pwm_chip	chip;
+	bool active;
 };
 
 #define to_imx_chip(chip)	container_of(chip, struct imx_chip, chip)
@@ -217,6 +219,9 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 		if (state->polarity == PWM_POLARITY_INVERSED)
 			cr |= MX3_PWMCR_POUTC;
 
+		if (imx->active)
+			cr |= MX3_PWMCR_STOPEN;
+
 		writel(cr, imx->mmio_base + MX3_PWMCR);
 	} else if (cstate.enabled) {
 		writel(0, imx->mmio_base + MX3_PWMCR);
@@ -264,6 +269,7 @@ static int imx_pwm_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =
 			of_match_device(imx_pwm_dt_ids, &pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
 	const struct imx_pwm_data *data;
 	struct imx_chip *imx;
 	struct resource *r;
@@ -301,6 +307,8 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
 
+	imx->active = of_property_read_bool(np, "fsl,active-in-suspend");
+
 	ret = pwmchip_add(&imx->chip);
 	if (ret < 0)
 		return ret;
-- 
2.7.4
