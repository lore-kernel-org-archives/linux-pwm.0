From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] pwm: sun4i: Add support for pwm controller on sun5i SoCs
Date: Sun, 11 Oct 2015 11:49:57 +0200
Message-ID: <1444556997-28885-1-git-send-email-hdegoede@redhat.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

The pwm controller on sun5i SoCs is identical to the one found on sun7i
SoCs. On the A13 package only one of the 2 pins is routed to the outside,
so only advertise one pwm there.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/pwm/pwm-sun4i.txt          |  2 ++
 drivers/pwm/pwm-sun4i.c                            | 25 ++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
index ae0273e..cf6068b 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
@@ -3,6 +3,8 @@ Allwinner sun4i and sun7i SoC PWM controller
 Required properties:
   - compatible: should be one of:
     - "allwinner,sun4i-a10-pwm"
+    - "allwinner,sun5i-a10s-pwm"
+    - "allwinner,sun5i-a13-pwm"
     - "allwinner,sun7i-a20-pwm"
   - reg: physical base address and length of the controller's registers
   - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index cd9dde5..b093cc5 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -68,6 +68,7 @@ static const u32 prescaler_table[] = {
 struct sun4i_pwm_data {
 	bool has_prescaler_bypass;
 	bool has_rdy;
+	unsigned int npwm;
 };
 
 struct sun4i_pwm_chip {
@@ -262,11 +263,25 @@ static const struct pwm_ops sun4i_pwm_ops = {
 static const struct sun4i_pwm_data sun4i_pwm_data_a10 = {
 	.has_prescaler_bypass = false,
 	.has_rdy = false,
+	.npwm = 2,
+};
+
+static const struct sun4i_pwm_data sun4i_pwm_data_a10s = {
+	.has_prescaler_bypass = true,
+	.has_rdy = true,
+	.npwm = 2,
+};
+
+static const struct sun4i_pwm_data sun4i_pwm_data_a13 = {
+	.has_prescaler_bypass = true,
+	.has_rdy = true,
+	.npwm = 1,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a20 = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
+	.npwm = 2,
 };
 
 static const struct of_device_id sun4i_pwm_dt_ids[] = {
@@ -274,6 +289,12 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
 		.compatible = "allwinner,sun4i-a10-pwm",
 		.data = &sun4i_pwm_data_a10,
 	}, {
+		.compatible = "allwinner,sun5i-a10s-pwm",
+		.data = &sun4i_pwm_data_a10s,
+	}, {
+		.compatible = "allwinner,sun5i-a13-pwm",
+		.data = &sun4i_pwm_data_a13,
+	}, {
 		.compatible = "allwinner,sun7i-a20-pwm",
 		.data = &sun4i_pwm_data_a20,
 	}, {
@@ -305,14 +326,14 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm->clk))
 		return PTR_ERR(pwm->clk);
 
+	pwm->data = match->data;
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &sun4i_pwm_ops;
 	pwm->chip.base = -1;
-	pwm->chip.npwm = 2;
+	pwm->chip.npwm = pwm->data->npwm;
 	pwm->chip.can_sleep = true;
 	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
 	pwm->chip.of_pwm_n_cells = 3;
-	pwm->data = match->data;
 
 	spin_lock_init(&pwm->ctrl_lock);
 
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
