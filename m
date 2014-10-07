From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCHv5 3/3] pwm: imx: support output polarity inversion
Date: Tue,  7 Oct 2014 15:55:34 +0200
Message-ID: <1412690134-13712-4-git-send-email-LW@KARO-electronics.de>
References: <1412690134-13712-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:49961 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbaJGNzr (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 09:55:47 -0400
In-Reply-To: <1412690134-13712-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, Tony Prisk <linux@prisktech.co.nz>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>

The i.MX pwm unit on i.MX27 and newer SoCs provides a configurable
output polarity. This patch adds support to utilize this feature where
available.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/pwm/pwm-imx.c |   39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index f8b5f10..57aac836 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -179,6 +179,9 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 	if (enable)
 		cr |=3D MX3_PWMCR_EN;
=20
+	if (pwm->polarity =3D=3D PWM_POLARITY_INVERSED)
+		cr |=3D MX3_PWMCR_POUTC;
+
 	writel(cr, imx->mmio_base + MX3_PWMCR);
=20
 	return 0;
@@ -196,6 +199,11 @@ static void imx_pwm_set_enable_v2(struct pwm_chip =
*chip, bool enable)
 	else
 		val &=3D ~MX3_PWMCR_EN;
=20
+	if (chip->pwms[0].polarity =3D=3D PWM_POLARITY_INVERSED)
+		val |=3D MX3_PWMCR_POUTC;
+	else
+		val &=3D ~MX3_PWMCR_POUTC;
+
 	writel(val, imx->mmio_base + MX3_PWMCR);
 }
=20
@@ -239,27 +247,49 @@ static void imx_pwm_disable(struct pwm_chip *chip=
, struct pwm_device *pwm)
 	clk_disable_unprepare(imx->clk_per);
 }
=20
-static struct pwm_ops imx_pwm_ops =3D {
+static int imx_pwm_set_polarity(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
+				enum pwm_polarity polarity)
+{
+	struct imx_chip *imx =3D to_imx_chip(chip);
+
+	dev_dbg(imx->chip.dev, "%s: polarity set to %s\n", __func__,
+		polarity =3D=3D PWM_POLARITY_INVERSED ? "inverted" : "normal");
+
+	return 0;
+}
+
+static struct pwm_ops imx_pwm_ops_v1 =3D {
 	.enable =3D imx_pwm_enable,
 	.disable =3D imx_pwm_disable,
 	.config =3D imx_pwm_config,
 	.owner =3D THIS_MODULE,
 };
=20
+static struct pwm_ops imx_pwm_ops_v2 =3D {
+	.enable =3D imx_pwm_enable,
+	.disable =3D imx_pwm_disable,
+	.set_polarity =3D imx_pwm_set_polarity,
+	.config =3D imx_pwm_config,
+	.owner =3D THIS_MODULE,
+};
+
 struct imx_pwm_data {
 	int (*config)(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns);
 	void (*set_enable)(struct pwm_chip *chip, bool enable);
+	struct pwm_ops *pwm_ops;
 };
=20
 static struct imx_pwm_data imx_pwm_data_v1 =3D {
 	.config =3D imx_pwm_config_v1,
 	.set_enable =3D imx_pwm_set_enable_v1,
+	.pwm_ops =3D &imx_pwm_ops_v1,
 };
=20
 static struct imx_pwm_data imx_pwm_data_v2 =3D {
 	.config =3D imx_pwm_config_v2,
 	.set_enable =3D imx_pwm_set_enable_v2,
+	.pwm_ops =3D &imx_pwm_ops_v2,
 };
=20
 static const struct of_device_id imx_pwm_dt_ids[] =3D {
@@ -281,6 +311,10 @@ static int imx_pwm_probe(struct platform_device *p=
dev)
 	if (!of_id)
 		return -ENODEV;
=20
+	data =3D of_id->data;
+	if (data->pwm_ops->set_polarity)
+		dev_dbg(&pdev->dev, "PWM supports output inversion\n");
+
 	imx =3D devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
 	if (imx =3D=3D NULL)
 		return -ENOMEM;
@@ -299,7 +333,7 @@ static int imx_pwm_probe(struct platform_device *pd=
ev)
 		return PTR_ERR(imx->clk_ipg);
 	}
=20
-	imx->chip.ops =3D &imx_pwm_ops;
+	imx->chip.ops =3D data->pwm_ops;
 	imx->chip.dev =3D &pdev->dev;
 	imx->chip.base =3D -1;
 	imx->chip.npwm =3D 1;
@@ -310,7 +344,6 @@ static int imx_pwm_probe(struct platform_device *pd=
ev)
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
=20
-	data =3D of_id->data;
 	imx->config =3D data->config;
 	imx->set_enable =3D data->set_enable;
=20
--=20
1.7.10.4

