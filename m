From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v2 2/3] pwm: stm32: split breakinput apply routine to ease PM support
Date: Fri, 4 Oct 2019 14:53:52 +0200
Message-ID: <1570193633-6600-3-git-send-email-fabrice.gasnier@st.com>
References: <1570193633-6600-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1570193633-6600-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, u.kleine-koenig@pengutronix.de
Cc: alexandre.torgue@st.com, mark.rutland@arm.com, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, benjamin.gaignard@st.com, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org

Split breakinput routine that configures STM32 timers 'break' safety
feature upon probe, into two routines:
- stm32_pwm_apply_breakinputs() sets all the break inputs into registers.
- stm32_pwm_probe_breakinputs() probes the device tree break input settings
  before calling stm32_pwm_apply_breakinputs()

This is a precursor patch to ease PM support. Registers content may get
lost during low power. So, break input settings applied upon probe need
to be restored upon resume (e.g. by calling stm32_pwm_apply_breakinputs()).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pwm/pwm-stm32.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 359b085..cf8658c 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -19,6 +19,12 @@
 #define CCMR_CHANNEL_MASK  0xFF
 #define MAX_BREAKINPUT 2
 
+struct stm32_breakinput {
+	u32 index;
+	u32 level;
+	u32 filter;
+};
+
 struct stm32_pwm {
 	struct pwm_chip chip;
 	struct mutex lock; /* protect pwm config/enable */
@@ -26,15 +32,11 @@ struct stm32_pwm {
 	struct regmap *regmap;
 	u32 max_arr;
 	bool have_complementary_output;
+	struct stm32_breakinput breakinput[MAX_BREAKINPUT];
+	unsigned int nbreakinput;
 	u32 capture[4] ____cacheline_aligned; /* DMA'able buffer */
 };
 
-struct stm32_breakinput {
-	u32 index;
-	u32 level;
-	u32 filter;
-};
-
 static inline struct stm32_pwm *to_stm32_pwm_dev(struct pwm_chip *chip)
 {
 	return container_of(chip, struct stm32_pwm, chip);
@@ -512,15 +514,27 @@ static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
 	return (bdtr & bke) ? 0 : -EINVAL;
 }
 
-static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv,
+static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < priv->nbreakinput && !ret; i++) {
+		ret = stm32_pwm_set_breakinput(priv,
+					       priv->breakinput[i].index,
+					       priv->breakinput[i].level,
+					       priv->breakinput[i].filter);
+	}
+
+	return ret;
+}
+
+static int stm32_pwm_probe_breakinputs(struct stm32_pwm *priv,
 				       struct device_node *np)
 {
-	struct stm32_breakinput breakinput[MAX_BREAKINPUT];
-	int nb, ret, i, array_size;
+	int nb, ret, array_size;
 
 	nb = of_property_count_elems_of_size(np, "st,breakinput",
 					     sizeof(struct stm32_breakinput));
-
 	/*
 	 * Because "st,breakinput" parameter is optional do not make probe
 	 * failed if it doesn't exist.
@@ -531,20 +545,14 @@ static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv,
 	if (nb > MAX_BREAKINPUT)
 		return -EINVAL;
 
+	priv->nbreakinput = nb;
 	array_size = nb * sizeof(struct stm32_breakinput) / sizeof(u32);
 	ret = of_property_read_u32_array(np, "st,breakinput",
-					 (u32 *)breakinput, array_size);
+					 (u32 *)priv->breakinput, array_size);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < nb && !ret; i++) {
-		ret = stm32_pwm_set_breakinput(priv,
-					       breakinput[i].index,
-					       breakinput[i].level,
-					       breakinput[i].filter);
-	}
-
-	return ret;
+	return stm32_pwm_apply_breakinputs(priv);
 }
 
 static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
@@ -614,7 +622,7 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	if (!priv->regmap || !priv->clk)
 		return -EINVAL;
 
-	ret = stm32_pwm_apply_breakinputs(priv, np);
+	ret = stm32_pwm_probe_breakinputs(priv, np);
 	if (ret)
 		return ret;
 
-- 
2.7.4
