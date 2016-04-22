From: Lee Jones <lee.jones@linaro.org>
Subject: [[PATCH v2] 06/11] pwm: sti: Supply PWM Capture register addresses and bit locations
Date: Fri, 22 Apr 2016 11:18:10 +0100
Message-ID: <1461320295-20414-7-git-send-email-lee.jones@linaro.org>
References: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36234 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbcDVKSc (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Apr 2016 06:18:32 -0400
Received: by mail-wm0-f41.google.com with SMTP id v188so15133940wme.1
        for <linux-pwm@vger.kernel.org>; Fri, 22 Apr 2016 03:18:27 -0700 (PDT)
In-Reply-To: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-sti.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index c4a34af..2f61e1e 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -22,26 +22,48 @@
 #include <linux/time.h>
 
 #define PWM_OUT_VAL(x)	(0x00 + (4 * (x))) /* Device's Duty Cycle register */
+#define PWM_CPT_VAL(x)	(0x10 + (4 * (x))) /* Capture value */
+#define PWM_CPT_EDGE(x) (0x30 + (4 * (x))) /* Edge to capture on */
 
 #define STI_PWM_CTRL		0x50	/* Control/Config register */
 #define STI_INT_EN		0x54	/* Interrupt Enable/Disable register */
+#define STI_INT_STA		0x58	/* Interrupt Status register */
+#define PWM_INT_ACK			0x5c
 #define PWM_PRESCALE_LOW_MASK		0x0f
 #define PWM_PRESCALE_HIGH_MASK		0xf0
+#define PWM_CPT_EDGE_MASK		0x03
+#define PWM_INT_ACK_MASK		0x1ff
+
+#define STI_MAX_CPT_DEVS		4
+#define CPT_DC_MAX			0xff
 
 /* Regfield IDs */
 enum {
 	/* Bits in PWM_CTRL*/
 	PWMCLK_PRESCALE_LOW,
 	PWMCLK_PRESCALE_HIGH,
+	CPTCLK_PRESCALE,
 
 	PWM_OUT_EN,
+	PWM_CPT_EN,
 
 	PWM_CPT_INT_EN,
+	PWM_CPT_INT_STAT,
 
 	/* Keep last */
 	MAX_REGFIELDS
 };
 
+/* Each capture input can be programmed to detect rising-edge, falling-edge,
+ * either edge or neither egde
+ */
+enum sti_cpt_edge {
+	CPT_EDGE_DISABLED,
+	CPT_EDGE_RISING,
+	CPT_EDGE_FALLING,
+	CPT_EDGE_BOTH,
+};
+
 struct sti_pwm_compat_data {
 	const struct reg_field *reg_fields;
 	unsigned int num_devs;
@@ -69,8 +91,11 @@ struct sti_pwm_chip {
 static const struct reg_field sti_pwm_regfields[MAX_REGFIELDS] = {
 	[PWMCLK_PRESCALE_LOW]	= REG_FIELD(STI_PWM_CTRL, 0, 3),
 	[PWMCLK_PRESCALE_HIGH]	= REG_FIELD(STI_PWM_CTRL, 11, 14),
+	[CPTCLK_PRESCALE]	= REG_FIELD(STI_PWM_CTRL, 4, 8),
 	[PWM_OUT_EN]		= REG_FIELD(STI_PWM_CTRL, 9, 9),
+	[PWM_CPT_EN]		= REG_FIELD(STI_PWM_CTRL, 10, 10),
 	[PWM_CPT_INT_EN]	= REG_FIELD(STI_INT_EN, 1, 4),
+	[PWM_CPT_INT_STAT]	= REG_FIELD(STI_INT_STA, 1, 4),
 };
 
 static inline struct sti_pwm_chip *to_sti_pwmchip(struct pwm_chip *chip)
-- 
2.8.0
