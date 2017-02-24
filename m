From: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v4 7/9] pwm: sunxi: Add support the Allwinner
 A31 PWM.
Date: Fri, 24 Feb 2017 08:41:14 +0300
Message-ID: <1487914876-8594-8-git-send-email-lis8215@gmail.com>
References: <1487914876-8594-1-git-send-email-lis8215@gmail.com>
Reply-To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDJLROMN3MJRBB4PX7CQKGQEDBN4ANQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1487914876-8594-1-git-send-email-lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
 - sun6i channels register and field map,
 - sun6i prescaler table,
 - DT bindings for A31 SoC,
 - documentation update.

Signed-off-by: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/pwm/pwm-sun4i.txt          |  3 +-
 drivers/pwm/pwm-sun4i.c                            | 95 +++++++++++++++++++++-
 2 files changed, 95 insertions(+), 3 deletions(-)

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
index a179a53..e474303 100644
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
@@ -48,6 +49,12 @@
 
 #define SUNXI_MAX_PWM_CHANNELS	4
 
+#define SUN6I_PWMCH_OFFS	0x10
+#define SUN6I_CH_CTL_OFFS	0x0
+#define SUN6I_CH_PRD_OFFS	0x4
+#define SUN6I_PWM_CTL_REG(ch)	(SUN6I_PWMCH_OFFS * (ch) + SUN6I_CH_CTL_OFFS)
+#define SUN6I_PWM_PRD_REG(ch)	(SUN6I_PWMCH_OFFS * (ch) + SUN6I_CH_PRD_OFFS)
+
 /* regmap fields */
 enum {
 	/* Used bit fields in control register */
@@ -79,6 +86,25 @@ static const u32 sun4i_prescaler_table[] = {
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
+	0,
+};
+
 struct sunxi_pwmch_data {
 	unsigned int ctl_reg;
 	unsigned int prd_reg;
@@ -339,6 +365,54 @@ static const struct sunxi_pwmch_data sun4i_pwm_chan1_data = {
 	},
 };
 
+static const struct sunxi_pwmch_data sun6i_pwm_chan0_data = {
+	.ctl_reg = SUN6I_PWM_CTL_REG(0),
+	.prd_reg = SUN6I_PWM_PRD_REG(0),
+	.enable_bits = PWM_EN | PWM_CLK_GATING,
+	.fields = {
+		[FIELD_PRESCALER]  = REG_FIELD(SUN6I_PWM_CTL_REG(0),  0,  3),
+		[FIELD_POLARITY]   = REG_FIELD(SUN6I_PWM_CTL_REG(0),  5,  5),
+		[FIELD_CLK_GATING] = REG_FIELD(SUN6I_PWM_CTL_REG(0),  6,  6),
+		[FIELD_READY]      = REG_FIELD(SUN6I_PWM_CTL_REG(0), 28, 28),
+	},
+};
+
+static const struct sunxi_pwmch_data sun6i_pwm_chan1_data = {
+	.ctl_reg = SUN6I_PWM_CTL_REG(1),
+	.prd_reg = SUN6I_PWM_PRD_REG(1),
+	.enable_bits = PWM_EN | PWM_CLK_GATING,
+	.fields = {
+		[FIELD_PRESCALER]  = REG_FIELD(SUN6I_PWM_CTL_REG(1),  0,  3),
+		[FIELD_POLARITY]   = REG_FIELD(SUN6I_PWM_CTL_REG(1),  5,  5),
+		[FIELD_CLK_GATING] = REG_FIELD(SUN6I_PWM_CTL_REG(1),  6,  6),
+		[FIELD_READY]      = REG_FIELD(SUN6I_PWM_CTL_REG(1), 28, 28),
+	},
+};
+
+static const struct sunxi_pwmch_data sun6i_pwm_chan2_data = {
+	.ctl_reg = SUN6I_PWM_CTL_REG(2),
+	.prd_reg = SUN6I_PWM_PRD_REG(2),
+	.enable_bits = PWM_EN | PWM_CLK_GATING,
+	.fields = {
+		[FIELD_PRESCALER]  = REG_FIELD(SUN6I_PWM_CTL_REG(2),  0,  3),
+		[FIELD_POLARITY]   = REG_FIELD(SUN6I_PWM_CTL_REG(2),  5,  5),
+		[FIELD_CLK_GATING] = REG_FIELD(SUN6I_PWM_CTL_REG(2),  6,  6),
+		[FIELD_READY]      = REG_FIELD(SUN6I_PWM_CTL_REG(2), 28, 28),
+	},
+};
+
+static const struct sunxi_pwmch_data sun6i_pwm_chan3_data = {
+	.ctl_reg = SUN6I_PWM_CTL_REG(3),
+	.prd_reg = SUN6I_PWM_PRD_REG(3),
+	.enable_bits = PWM_EN | PWM_CLK_GATING,
+	.fields = {
+		[FIELD_PRESCALER]  = REG_FIELD(SUN6I_PWM_CTL_REG(3),  0,  3),
+		[FIELD_POLARITY]   = REG_FIELD(SUN6I_PWM_CTL_REG(3),  5,  5),
+		[FIELD_CLK_GATING] = REG_FIELD(SUN6I_PWM_CTL_REG(3),  6,  6),
+		[FIELD_READY]      = REG_FIELD(SUN6I_PWM_CTL_REG(3), 28, 28),
+	},
+};
+
 static const struct sun4i_pwm_data sun4i_pwm_data_a10 = {
 	.has_prescaler_bypass = false,
 	.has_rdy = false,
@@ -371,6 +445,19 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a13 = {
 	}
 };
 
+static const struct sun4i_pwm_data sun6i_pwm_data_a31 = {
+	.has_prescaler_bypass = false,
+	.has_rdy = true,
+	.npwm = 4,
+	.prescaler_table = sun6i_prescaler_table,
+	.chan_data = {
+		&sun6i_pwm_chan0_data,
+		&sun6i_pwm_chan1_data,
+		&sun6i_pwm_chan2_data,
+		&sun6i_pwm_chan3_data,
+	}
+};
+
 static const struct sun4i_pwm_data sun4i_pwm_data_a20 = {
 	.has_prescaler_bypass = true,
 	.has_rdy = true,
@@ -403,6 +490,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
 		.compatible = "allwinner,sun5i-a13-pwm",
 		.data = &sun4i_pwm_data_a13,
 	}, {
+		.compatible = "allwinner,sun6i-a31-pwm",
+		.data = &sun6i_pwm_data_a31,
+	}, {
 		.compatible = "allwinner,sun7i-a20-pwm",
 		.data = &sun4i_pwm_data_a20,
 	}, {
@@ -544,5 +634,6 @@ module_platform_driver(sun4i_pwm_driver);
 
 MODULE_ALIAS("platform:sun4i-pwm");
 MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>");
-MODULE_DESCRIPTION("Allwinner sun4i PWM driver");
+MODULE_AUTHOR("Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
+MODULE_DESCRIPTION("Allwinner sunxi PWM driver");
 MODULE_LICENSE("GPL v2");
-- 
2.4.11
