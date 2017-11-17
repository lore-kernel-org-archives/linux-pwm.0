From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] pwm: imx: Allow keeping the PWM active during suspend
Date: Fri, 17 Nov 2017 20:59:27 -0200
Message-ID: <1510959567-7956-1-git-send-email-festevam@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

From: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>

In some systems it is desirable to keep the PWM active during system
suspend.

One use case is the imx6q-cubox-i board, which has an LED driven by PWM.
When the system goes into suspend the PWM block is disabled by default,
the PWM pin goes to zero and turn on the LED during suspend, which is
not really the behaviour we want to see.

By keeping the PWM enabled during suspend the pwm-leds driver sets
the brightness to zero in suspend and then the LED is turned off as
expected.

Introduce the 'fsl,suspend-enable' property to indicate that the PWM
will stay active during suspend.

Signed-off-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
---
 Documentation/devicetree/bindings/pwm/imx-pwm.txt | 5 +++++
 drivers/pwm/pwm-imx.c                             | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
index c61bdf8..1e00a89 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
@@ -14,6 +14,11 @@ See the clock consumer binding,
 	Documentation/devicetree/bindings/clock/clock-bindings.txt
 - interrupts: The interrupt for the pwm controller
 
+Optional properties:
+- fsl,suspend-enable: Boolean property that indicates that the PWM block stays
+		      enabled during system suspend. If not present, the PWM
+		      block will be disabled during suspend.
+
 Example:
 
 pwm1: pwm@53fb4000 {
diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 2ba5c3a..b9c60fe 100644
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
+	bool suspend_enable;
 };
 
 #define to_imx_chip(chip)	container_of(chip, struct imx_chip, chip)
@@ -217,6 +219,9 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 		if (state->polarity == PWM_POLARITY_INVERSED)
 			cr |= MX3_PWMCR_POUTC;
 
+		if (imx->suspend_enable)
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
 
+	imx->suspend_enable = of_property_read_bool(np, "fsl,suspend-enable");
+
 	ret = pwmchip_add(&imx->chip);
 	if (ret < 0)
 		return ret;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
