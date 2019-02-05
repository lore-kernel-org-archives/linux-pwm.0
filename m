From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 2/4] pwm: stm32-lp: Add power management support
Date: Tue, 5 Feb 2019 13:40:27 +0100
Message-ID: <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jic23@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org
Cc: mark.rutland@arm.com, alexandre.torgue@st.com, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, vilhelm.gray@gmail.com, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org

Add suspend/resume PM sleep ops. When going to low power, disable
active PWM channel. Active PWM channel is resumed, by calling
pwm_apply_state(). This is inspired by Thierry's comment in [1].
Don't touch inactive channels, as it may be used by other LPTimer MFD
child driver.
[1]https://lkml.org/lkml/2017/12/5/175

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pwm/pwm-stm32-lp.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 0059b24c..0c40d48 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -13,6 +13,7 @@
 #include <linux/mfd/stm32-lptimer.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 
@@ -20,6 +21,8 @@ struct stm32_pwm_lp {
 	struct pwm_chip chip;
 	struct clk *clk;
 	struct regmap *regmap;
+	struct pwm_state suspend;
+	bool suspended;
 };
 
 static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
@@ -223,6 +226,40 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
 	return pwmchip_remove(&priv->chip);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int stm32_pwm_lp_suspend(struct device *dev)
+{
+	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
+
+	pwm_get_state(&priv->chip.pwms[0], &priv->suspend);
+	priv->suspended = priv->suspend.enabled;
+
+	/* safe to call pwm_disable() for already disabled pwm */
+	pwm_disable(&priv->chip.pwms[0]);
+
+	return pinctrl_pm_select_sleep_state(dev);
+}
+
+static int stm32_pwm_lp_resume(struct device *dev)
+{
+	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret)
+		return ret;
+
+	/* Only restore suspended pwm, not to disrupt other MFD child */
+	if (!priv->suspended)
+		return 0;
+
+	return pwm_apply_state(&priv->chip.pwms[0], &priv->suspend);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(stm32_pwm_lp_pm_ops, stm32_pwm_lp_suspend,
+			 stm32_pwm_lp_resume);
+
 static const struct of_device_id stm32_pwm_lp_of_match[] = {
 	{ .compatible = "st,stm32-pwm-lp", },
 	{},
@@ -235,6 +272,7 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
 	.driver	= {
 		.name = "stm32-pwm-lp",
 		.of_match_table = of_match_ptr(stm32_pwm_lp_of_match),
+		.pm = &stm32_pwm_lp_pm_ops,
 	},
 };
 module_platform_driver(stm32_pwm_lp_driver);
-- 
1.9.1
