From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [RFC PATCH 2/2] pmw: imx: Configure output to GPIO in disabled state
Date: Tue, 21 Aug 2018 16:38:53 +0200
Message-ID: <1534862333-27950-3-git-send-email-michal.vokac@ysoft.com>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Fabio Estevam <fabio.estevam@nxp.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@karo-electronics.de>, =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
List-Id: linux-pwm@vger.kernel.org

The PWM output is held at zero whenever the PWM block is disabled.
This can cause issues when inverted PWM signal polarity is needed.

Allow users to set a "default" pinctrl state that will be used when
PWM is disabled and a "pwm" pinctrl state that will be used when
PWM output is needed.

As an example, with this a PWM controlled backlight with inversed
signal polarity can be used in full brightness range. Without this
the backlight could not be turned off as brightness = 0 disables
the PWM and that in turn set output to 0V, that is full brightness.

When the pinctrl states are not correctly specifid in DT the logic
will work as before.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 drivers/pwm/pwm-imx.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 1d5242c..6212c98 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -13,6 +13,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/pwm.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -52,10 +53,39 @@ struct imx_chip {
 	void __iomem	*mmio_base;
 
 	struct pwm_chip	chip;
+
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pinctrl_pins_default;
+	struct pinctrl_state *pinctrl_pins_pwm;
 };
 
+
 #define to_imx_chip(chip)	container_of(chip, struct imx_chip, chip)
 
+static int imx_pwm_init_pinctrl_info(struct imx_chip *imx_chip,
+		struct platform_device *pdev)
+{
+	imx_chip->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (!imx_chip->pinctrl || IS_ERR(imx_chip->pinctrl)) {
+		dev_info(&pdev->dev, "can not get pinctrl\n");
+		return PTR_ERR(imx_chip->pinctrl);
+	}
+
+	imx_chip->pinctrl_pins_default = pinctrl_lookup_state(imx_chip->pinctrl,
+			PINCTRL_STATE_DEFAULT);
+	imx_chip->pinctrl_pins_pwm = pinctrl_lookup_state(imx_chip->pinctrl,
+			"pwm");
+
+	if (IS_ERR(imx_chip->pinctrl_pins_default) ||
+	    IS_ERR(imx_chip->pinctrl_pins_pwm)) {
+		dev_info(&pdev->dev, "PWM output mux information incomplete\n");
+		devm_pinctrl_put(imx_chip->pinctrl);
+		imx_chip->pinctrl = NULL;
+	}
+
+	return 0;
+}
+
 static int imx_pwm_config_v1(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns)
 {
@@ -216,7 +246,29 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 			cr |= MX3_PWMCR_POUTC;
 
 		writel(cr, imx->mmio_base + MX3_PWMCR);
+
+		/*
+		 * If we are in charge of pinctrl then switch output to
+		 * the PWM signal.
+		 */
+		if (imx->pinctrl)
+			pinctrl_select_state(imx->pinctrl,
+					imx->pinctrl_pins_pwm);
 	} else if (cstate.enabled) {
+		/*
+		 * PWM block will be disabled. Normally its output will go
+		 * to 0 no matter what polarity is set. In case reversed PWM
+		 * polarity is required reconfigure the output pin to GPIO to
+		 * keep the output at the same level as for duty-cycle = 0.
+		 *
+		 * First switch the muxing and then disable the PWM. In that
+		 * order we do not get unwanted logic level changes on the
+		 * output.
+		 */
+		if (imx->pinctrl)
+			pinctrl_select_state(imx->pinctrl,
+					imx->pinctrl_pins_default);
+
 		writel(0, imx->mmio_base + MX3_PWMCR);
 
 		clk_disable_unprepare(imx->clk_per);
@@ -294,6 +346,10 @@ static int imx_pwm_probe(struct platform_device *pdev)
 		imx->chip.of_pwm_n_cells = 3;
 	}
 
+	ret = imx_pwm_init_pinctrl_info(imx, pdev);
+	if (ret)
+		return ret;
+
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	imx->mmio_base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(imx->mmio_base))
-- 
2.1.4
