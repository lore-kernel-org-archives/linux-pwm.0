From: Lukasz Majewski <l.majewski@majess.pl>
Subject: [PATCH v2 02/10] pwm: imx: Add separate set of pwm ops for PWMv1 and PWMv2
Date: Thu, 27 Oct 2016 08:29:38 +0200
Message-ID: <1477549785-4972-3-git-send-email-l.majewski@majess.pl>
References: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de, Lukasz Majewski <l.majewski@majess.pl>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: linux-pwm@vger.kernel.org

This patch provides separate set of pwm ops utilized by
i.MX's PWMv1 and PWMv2.

Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Changes for v2:
- New patch
---
 drivers/pwm/pwm-imx.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index d600fd5..ea3ce79 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -240,7 +240,14 @@ static void imx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable_unprepare(imx->clk_per);
 }
 
-static struct pwm_ops imx_pwm_ops = {
+static struct pwm_ops imx_pwm_ops_v1 = {
+	.enable = imx_pwm_enable,
+	.disable = imx_pwm_disable,
+	.config = imx_pwm_config,
+	.owner = THIS_MODULE,
+};
+
+static struct pwm_ops imx_pwm_ops_v2 = {
 	.enable = imx_pwm_enable,
 	.disable = imx_pwm_disable,
 	.config = imx_pwm_config,
@@ -251,16 +258,19 @@ struct imx_pwm_data {
 	int (*config)(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns);
 	void (*set_enable)(struct pwm_chip *chip, bool enable);
+	struct pwm_ops *pwm_ops;
 };
 
 static struct imx_pwm_data imx_pwm_data_v1 = {
 	.config = imx_pwm_config_v1,
 	.set_enable = imx_pwm_set_enable_v1,
+	.pwm_ops = &imx_pwm_ops_v1,
 };
 
 static struct imx_pwm_data imx_pwm_data_v2 = {
 	.config = imx_pwm_config_v2,
 	.set_enable = imx_pwm_set_enable_v2,
+	.pwm_ops = &imx_pwm_ops_v2,
 };
 
 static const struct of_device_id imx_pwm_dt_ids[] = {
@@ -282,6 +292,8 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	if (!of_id)
 		return -ENODEV;
 
+	data = of_id->data;
+
 	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
 	if (imx == NULL)
 		return -ENOMEM;
@@ -300,7 +312,7 @@ static int imx_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(imx->clk_ipg);
 	}
 
-	imx->chip.ops = &imx_pwm_ops;
+	imx->chip.ops = data->pwm_ops;
 	imx->chip.dev = &pdev->dev;
 	imx->chip.base = -1;
 	imx->chip.npwm = 1;
@@ -311,7 +323,6 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
 
-	data = of_id->data;
 	imx->config = data->config;
 	imx->set_enable = data->set_enable;
 
-- 
2.1.4
