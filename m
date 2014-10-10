From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH 3/3] pwm: imx: support output polarity inversion
Date: Fri, 10 Oct 2014 16:22:29 +0200
Message-ID: <1412950949-7505-4-git-send-email-LW@KARO-electronics.de>
References: <20141009151605.GA8818@ulmo.nvidia.com>
 <1412950949-7505-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:63213 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbaJJOWm (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Oct 2014 10:22:42 -0400
In-Reply-To: <1412950949-7505-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>

The i.MX pwm unit on i.MX27 and newer SoCs provides a configurable
output polarity. This patch adds support to utilize this feature where
available.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/pwm/pwm-imx.c |   43 ++++++++++++++++++++++++++++++++++++++++-=
--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index f8b5f10..10e0018 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -38,6 +38,7 @@
 #define MX3_PWMCR_DOZEEN		(1 << 24)
 #define MX3_PWMCR_WAITEN		(1 << 23)
 #define MX3_PWMCR_DBGEN			(1 << 22)
+#define MX3_PWMCR_POUTC			(1 << 18)
 #define MX3_PWMCR_CLKSRC_IPG_HIGH	(2 << 16)
 #define MX3_PWMCR_CLKSRC_IPG		(1 << 16)
 #define MX3_PWMCR_SWR			(1 << 3)
@@ -179,6 +180,9 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 	if (enable)
 		cr |=3D MX3_PWMCR_EN;
=20
+	if (pwm->polarity =3D=3D PWM_POLARITY_INVERSED)
+		cr |=3D MX3_PWMCR_POUTC;
+
 	writel(cr, imx->mmio_base + MX3_PWMCR);
=20
 	return 0;
@@ -196,6 +200,11 @@ static void imx_pwm_set_enable_v2(struct pwm_chip =
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
@@ -239,27 +248,49 @@ static void imx_pwm_disable(struct pwm_chip *chip=
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
@@ -281,6 +312,8 @@ static int imx_pwm_probe(struct platform_device *pd=
ev)
 	if (!of_id)
 		return -ENODEV;
=20
+	data =3D of_id->data;
+
 	imx =3D devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
 	if (imx =3D=3D NULL)
 		return -ENOMEM;
@@ -299,18 +332,22 @@ static int imx_pwm_probe(struct platform_device *=
pdev)
 		return PTR_ERR(imx->clk_ipg);
 	}
=20
-	imx->chip.ops =3D &imx_pwm_ops;
+	imx->chip.ops =3D data->pwm_ops;
 	imx->chip.dev =3D &pdev->dev;
 	imx->chip.base =3D -1;
 	imx->chip.npwm =3D 1;
 	imx->chip.can_sleep =3D true;
+	if (data->pwm_ops->set_polarity) {
+		dev_dbg(&pdev->dev, "PWM supports output inversion\n");
+		imx->chip.of_xlate =3D of_pwm_xlate_with_flags;
+		imx->chip.of_pwm_n_cells =3D 3;
+	}
=20
 	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	imx->mmio_base =3D devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
=20
-	data =3D of_id->data;
 	imx->config =3D data->config;
 	imx->set_enable =3D data->set_enable;
=20
--=20
1.7.10.4

