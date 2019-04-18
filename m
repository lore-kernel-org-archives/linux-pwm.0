From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [RESEND PATCH v5 2/3] pwm: stm32-lp: Add power management support
Date: Thu, 18 Apr 2019 11:37:46 +0200
Message-ID: <1555580267-29299-3-git-send-email-fabrice.gasnier@st.com>
References: <1555580267-29299-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555580267-29299-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: robh+dt@kernel.org, u.kleine-koenig@pengutronix.de, tduszyns@gmail.com, mark.rutland@arm.com, alexandre.torgue@st.com, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org

Add suspend/resume PM sleep ops. When going to low power, enforce the PWM
channel isn't active. Let the PWM consumers disable it during their own
suspend sequence. Only perform a check here, and handle the pinctrl states.
See [1].
[1] https://lkml.org/lkml/2019/2/5/770

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- Don't disable PWM channel: let the PWM user disable it. Refuse to
  suspend in case it's been left enabled.
- Drop the ifdefs, use __maybe_unused instead.
---
 drivers/pwm/pwm-stm32-lp.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 0059b24c..2211a64 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -13,6 +13,7 @@
 #include <linux/mfd/stm32-lptimer.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 
@@ -223,6 +224,29 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
 	return pwmchip_remove(&priv->chip);
 }
 
+static int __maybe_unused stm32_pwm_lp_suspend(struct device *dev)
+{
+	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
+	struct pwm_state state;
+
+	pwm_get_state(&priv->chip.pwms[0], &state);
+	if (state.enabled) {
+		dev_err(dev, "The consumer didn't stop us (%s)\n",
+			priv->chip.pwms[0].label);
+		return -EBUSY;
+	}
+
+	return pinctrl_pm_select_sleep_state(dev);
+}
+
+static int __maybe_unused stm32_pwm_lp_resume(struct device *dev)
+{
+	return pinctrl_pm_select_default_state(dev);
+}
+
+static SIMPLE_DEV_PM_OPS(stm32_pwm_lp_pm_ops, stm32_pwm_lp_suspend,
+			 stm32_pwm_lp_resume);
+
 static const struct of_device_id stm32_pwm_lp_of_match[] = {
 	{ .compatible = "st,stm32-pwm-lp", },
 	{},
@@ -235,6 +259,7 @@ static struct platform_driver stm32_pwm_lp_driver = {
 	.driver	= {
 		.name = "stm32-pwm-lp",
 		.of_match_table = of_match_ptr(stm32_pwm_lp_of_match),
+		.pm = &stm32_pwm_lp_pm_ops,
 	},
 };
 module_platform_driver(stm32_pwm_lp_driver);
-- 
2.7.4
