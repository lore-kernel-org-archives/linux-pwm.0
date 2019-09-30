From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 2/2] pwm: stm32: add power management support
Date: Mon, 30 Sep 2019 17:39:11 +0200
Message-ID: <1569857951-20007-3-git-send-email-fabrice.gasnier@st.com>
References: <1569857951-20007-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1569857951-20007-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org
Cc: alexandre.torgue@st.com, mark.rutland@arm.com, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, benjamin.gaignard@st.com, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org

Add suspend/resume PM sleep ops. When going to low power, enforce the PWM
channel isn't active. Let the PWM consumers disable it during their own
suspend sequence, see [1]. So, perform a check here, and handle the
pinctrl states. Also restore the break inputs upon resume, as registers
content may be lost when going to low power mode.

[1] https://lkml.org/lkml/2019/2/5/770

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pwm/pwm-stm32.c | 82 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 740e2de..9bcd73a 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -12,6 +12,7 @@
 #include <linux/mfd/stm32-timers.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 
@@ -19,6 +20,12 @@
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
@@ -26,15 +33,11 @@ struct stm32_pwm {
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
@@ -512,15 +515,27 @@ static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
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
@@ -531,20 +546,14 @@ static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv,
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
@@ -614,7 +623,7 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	if (!priv->regmap || !priv->clk)
 		return -EINVAL;
 
-	ret = stm32_pwm_apply_breakinputs(priv, np);
+	ret = stm32_pwm_probe_breakinputs(priv, np);
 	if (ret)
 		return ret;
 
@@ -647,6 +656,38 @@ static int stm32_pwm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused stm32_pwm_suspend(struct device *dev)
+{
+	struct stm32_pwm *priv = dev_get_drvdata(dev);
+	struct pwm_state state;
+	unsigned int i;
+
+	for (i = 0; i < priv->chip.npwm; i++) {
+		pwm_get_state(&priv->chip.pwms[i], &state);
+		if (state.enabled) {
+			dev_err(dev, "The consumer didn't stop us (%s)\n",
+				priv->chip.pwms[i].label);
+			return -EBUSY;
+		}
+	}
+
+	return pinctrl_pm_select_sleep_state(dev);
+}
+
+static int __maybe_unused stm32_pwm_resume(struct device *dev)
+{
+	struct stm32_pwm *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret)
+		return ret;
+
+	return stm32_pwm_apply_breakinputs(priv);
+}
+
+static SIMPLE_DEV_PM_OPS(stm32_pwm_pm_ops, stm32_pwm_suspend, stm32_pwm_resume);
+
 static const struct of_device_id stm32_pwm_of_match[] = {
 	{ .compatible = "st,stm32-pwm",	},
 	{ /* end node */ },
@@ -659,6 +700,7 @@ static struct platform_driver stm32_pwm_driver = {
 	.driver	= {
 		.name = "stm32-pwm",
 		.of_match_table = stm32_pwm_of_match,
+		.pm = &stm32_pwm_pm_ops,
 	},
 };
 module_platform_driver(stm32_pwm_driver);
-- 
2.7.4
