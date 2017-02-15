From: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v3 3/4] pwm: sunxi: Add support the Allwinner
 A31 PWM.
Date: Wed, 15 Feb 2017 23:06:06 +0300
Message-ID: <1487189167-32486-4-git-send-email-lis8215@gmail.com>
References: <1487189167-32486-1-git-send-email-lis8215@gmail.com>
Reply-To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDJLROMN3MJRBNXJSLCQKGQEIKZCT4I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1487189167-32486-1-git-send-email-lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

From: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This patch introduce the sun6i PWM driver itself:
 - sun6i channels configuration,
 - sun6i prescaler table,
 - DT bindings for A31 SoC,
 - documentation update,
 - module description and author update.

Signed-off-by: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/pwm/pwm-sun4i.txt          |  3 +-
 drivers/pwm/pwm-sun4i.c                            | 89 +++++++++++++++++++++-
 2 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
index f1cbeef..109b997 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
@@ -1,10 +1,11 @@
-Allwinner sun4i and sun7i SoC PWM controller
+Allwinner sunxi SoC PWM controller

 Required properties:
   - compatible: should be one of:
     - "allwinner,sun4i-a10-pwm"
     - "allwinner,sun5i-a10s-pwm"
     - "allwinner,sun5i-a13-pwm"
+    - "allwinner,sun6i-a31-pwm"
     - "allwinner,sun7i-a20-pwm"
     - "allwinner,sun8i-h3-pwm"
   - reg: physical base address and length of the controller's registers
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index b4706af..8c96251 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -1,7 +1,8 @@
 /*
- * Driver for Allwinner sun4i Pulse Width Modulation Controller
+ * Driver for Allwinner sunxi Pulse Width Modulation Controller
  *
  * Copyright (C) 2014 Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
+ * Copyright (C) 2017 Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
  *
  * Licensed under GPLv2.
  */
@@ -27,6 +28,12 @@

 #define PWMCH_OFFSET		15

+#define SUN6I_PWM_CTL_OFFSET	0x0
+#define SUN6I_PWM_PRD_OFFSET	0x4
+#define SUN6I_PWMCH_OFFSET(ch)	(0x10 * (ch))
+#define SUN6I_PWM_CTL_REG(ch)	(SUN6I_PWMCH_OFFSET(ch) + SUN6I_PWM_CTL_OFFSET)
+#define SUN6I_PWM_PRD_REG(ch)	(SUN6I_PWMCH_OFFSET(ch) + SUN6I_PWM_PRD_OFFSET)
+
 #define PWM_PRESCAL_LSB		0
 #define PWM_PRESCAL_MSB		3
 #define PWM_PRESCAL_MASK	GENMASK(PWM_PRESCAL_MSB - PWM_PRESCAL_LSB, 0)
@@ -55,7 +62,7 @@
 #define FIELD_READY		3
 #define NUM_FIELDS		4

-#define MAX_CHANNELS		2
+#define MAX_CHANNELS		4

 #define SUN4I_REGMAP_FIELDS(chan) {\
 	[FIELD_PRESCALER] = \
@@ -76,6 +83,24 @@
 			  PWM_RDY_BIT(chan)), \
 }

+#define SUN6I_REGMAP_FIELDS(chan) {\
+	[FIELD_PRESCALER] = \
+		REG_FIELD(SUN6I_PWM_CTL_REG(chan), \
+			  PWM_PRESCAL_LSB, \
+			  PWM_PRESCAL_MSB), \
+	[FIELD_POLARITY] = \
+		REG_FIELD(SUN6I_PWM_CTL_REG(chan), \
+			  PWM_ACT_STATE_BIT, \
+			  PWM_ACT_STATE_BIT), \
+	[FIELD_CLK_GATING] = \
+		REG_FIELD(SUN6I_PWM_CTL_REG(chan), \
+			  PWM_CLK_GATING_BIT, \
+			  PWM_CLK_GATING_BIT), \
+	[FIELD_READY] = \
+		REG_FIELD(SUN6I_PWM_CTL_REG(chan), \
+			  PWM_RDY_BASE, \
+			  PWM_RDY_BASE), \
+}

 static const u32 sun4i_prescaler_table[] = {
 	120,
@@ -96,6 +121,25 @@ static const u32 sun4i_prescaler_table[] = {
 	0, /* Actually 1 but tested separately */
 };

+static const u32 sun6i_prescaler_table[] = {
+	1,
+	2,
+	4,
+	8,
+	16,
+	32,
+	64,
+	0,
+	0,
+	0,
+	0,
+	0,
+	0,
+	0,
+	0,
+	0, /* Actually 1 but tested separately */
+};
+
 struct sunxi_pwmch_reg_info {
 	struct reg_field fields[NUM_FIELDS];
 	unsigned int control_reg;
@@ -318,6 +362,33 @@ static const struct sunxi_pwmch_reg_info sun4i_field_info[2] = {
 	},
 };

+static const struct sunxi_pwmch_reg_info sun6i_field_info[4] = {
+	{
+		.fields = SUN6I_REGMAP_FIELDS(0),
+		.control_reg =    SUN6I_PWM_CTL_REG(0),
+		.period_reg  =    SUN6I_PWM_PRD_REG(0),
+		.enable_bitmask = BIT(PWM_EN_BIT) | BIT(PWM_CLK_GATING_BIT),
+	},
+	{
+		.fields = SUN6I_REGMAP_FIELDS(1),
+		.control_reg =    SUN6I_PWM_CTL_REG(1),
+		.period_reg  =    SUN6I_PWM_PRD_REG(1),
+		.enable_bitmask = BIT(PWM_EN_BIT) | BIT(PWM_CLK_GATING_BIT),
+	},
+	{
+		.fields = SUN6I_REGMAP_FIELDS(2),
+		.control_reg =    SUN6I_PWM_CTL_REG(2),
+		.period_reg  =    SUN6I_PWM_PRD_REG(2),
+		.enable_bitmask = BIT(PWM_EN_BIT) | BIT(PWM_CLK_GATING_BIT),
+	},
+	{
+		.fields = SUN6I_REGMAP_FIELDS(3),
+		.control_reg =    SUN6I_PWM_CTL_REG(3),
+		.period_reg  =    SUN6I_PWM_PRD_REG(3),
+		.enable_bitmask = BIT(PWM_EN_BIT) | BIT(PWM_CLK_GATING_BIT),
+	},
+};
+
 static const struct pwm_ops sun4i_pwm_ops = {
 	.config = sun4i_pwm_config,
 	.set_polarity = sun4i_pwm_set_polarity,
@@ -350,6 +421,14 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a13 = {
 	.chan_info = sun4i_field_info,
 };

+static const struct sun4i_pwm_data sun6i_pwm_data_a31 = {
+	.has_prescaler_bypass = false,
+	.has_rdy = true,
+	.npwm = 4,
+	.prescaler_table = sun6i_prescaler_table,
+	.chan_info = sun6i_field_info,
+};
+
 static const struct sun4i_pwm_data sun4i_pwm_data_a20 = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
@@ -377,6 +456,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
 		.compatible = "allwinner,sun5i-a13-pwm",
 		.data = &sun4i_pwm_data_a13,
 	}, {
+		.compatible = "allwinner,sun6i-a31-pwm",
+		.data = &sun6i_pwm_data_a31,
+	}, {
 		.compatible = "allwinner,sun7i-a20-pwm",
 		.data = &sun4i_pwm_data_a20,
 	}, {
@@ -517,5 +599,6 @@ module_platform_driver(sun4i_pwm_driver);

 MODULE_ALIAS("platform:sun4i-pwm");
 MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>");
-MODULE_DESCRIPTION("Allwinner sun4i PWM driver");
+MODULE_AUTHOR("Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
+MODULE_DESCRIPTION("Allwinner sunxi PWM driver");
 MODULE_LICENSE("GPL v2");
--
2.4.11
