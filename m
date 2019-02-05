From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 4/4] iio: counter: stm32-lptimer: Add power management support
Date: Tue, 5 Feb 2019 13:40:29 +0100
Message-ID: <1549370429-19116-5-git-send-email-fabrice.gasnier@st.com>
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
active counter. Only active counter should be resumed: don't touch
disabled counter, as it may be used by other LPTimer MFD child driver.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/counter/stm32-lptimer-cnt.c | 55 +++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/iio/counter/stm32-lptimer-cnt.c b/drivers/iio/counter/stm32-lptimer-cnt.c
index 42fb8ba..2a49cce 100644
--- a/drivers/iio/counter/stm32-lptimer-cnt.c
+++ b/drivers/iio/counter/stm32-lptimer-cnt.c
@@ -14,6 +14,7 @@
 #include <linux/iio/iio.h>
 #include <linux/mfd/stm32-lptimer.h>
 #include <linux/module.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 
 struct stm32_lptim_cnt {
@@ -23,6 +24,7 @@ struct stm32_lptim_cnt {
 	u32 preset;
 	u32 polarity;
 	u32 quadrature_mode;
+	bool enabled;
 };
 
 static int stm32_lptim_is_enabled(struct stm32_lptim_cnt *priv)
@@ -50,6 +52,7 @@ static int stm32_lptim_set_enable_state(struct stm32_lptim_cnt *priv,
 
 	if (!enable) {
 		clk_disable(priv->clk);
+		priv->enabled = false;
 		return 0;
 	}
 
@@ -79,6 +82,7 @@ static int stm32_lptim_set_enable_state(struct stm32_lptim_cnt *priv,
 		regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
 		return ret;
 	}
+	priv->enabled = true;
 
 	/* Start LP timer in continuous mode */
 	return regmap_update_bits(priv->regmap, STM32_LPTIM_CR,
@@ -361,6 +365,56 @@ static int stm32_lptim_cnt_probe(struct platform_device *pdev)
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int stm32_lptim_cnt_suspend(struct device *dev)
+{
+	struct stm32_lptim_cnt *priv = dev_get_drvdata(dev);
+	int ret;
+
+	/* Only take care of enabled counter: don't disturb other MFD child */
+	if (priv->enabled) {
+		ret = stm32_lptim_setup(priv, 0);
+		if (ret)
+			return ret;
+
+		ret = stm32_lptim_set_enable_state(priv, 0);
+		if (ret)
+			return ret;
+
+		/* Force enable state for later resume */
+		priv->enabled = true;
+	}
+
+	return pinctrl_pm_select_sleep_state(dev);
+}
+
+static int stm32_lptim_cnt_resume(struct device *dev)
+{
+	struct stm32_lptim_cnt *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret)
+		return ret;
+
+	if (priv->enabled) {
+		priv->enabled = false;
+		ret = stm32_lptim_setup(priv, 1);
+		if (ret)
+			return ret;
+
+		ret = stm32_lptim_set_enable_state(priv, 1);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(stm32_lptim_cnt_pm_ops, stm32_lptim_cnt_suspend,
+			 stm32_lptim_cnt_resume);
+
 static const struct of_device_id stm32_lptim_cnt_of_match[] = {
 	{ .compatible = "st,stm32-lptimer-counter", },
 	{},
@@ -372,6 +426,7 @@ static int stm32_lptim_cnt_probe(struct platform_device *pdev)
 	.driver = {
 		.name = "stm32-lptimer-counter",
 		.of_match_table = stm32_lptim_cnt_of_match,
+		.pm = &stm32_lptim_cnt_pm_ops,
 	},
 };
 module_platform_driver(stm32_lptim_cnt_driver);
-- 
1.9.1
