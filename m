From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCHv4 4/4] pwm: imx: support output polarity inversion
Date: Wed, 20 Aug 2014 08:55:56 +0200
Message-ID: <1408517756-9412-5-git-send-email-LW@KARO-electronics.de>
References: <1408517756-9412-1-git-send-email-LW@KARO-electronics.de>
 <1408517756-9412-2-git-send-email-LW@KARO-electronics.de>
 <1408517756-9412-3-git-send-email-LW@KARO-electronics.de>
 <1408517756-9412-4-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408517756-9412-4-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>, Tony Prisk <linux@prisktech.co.nz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

The i.MX pwm unit on i.MX27 and newer SoCs provides a configurable
output polarity. This patch adds support to utilize this feature where
available.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/pwm/pwm-imx.c |   38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index f836635..585b0a8 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -138,6 +138,8 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
=20
 	if (test_bit(PWMF_ENABLED, &pwm->flags))
 		cr |=3D MX3_PWMCR_EN;
+	if (pwm->polarity =3D=3D PWM_POLARITY_INVERSED)
+		cr |=3D MX3_PWMCR_POUTC;
=20
 	writel(cr, imx->mmio_base + MX3_PWMCR);
=20
@@ -156,6 +158,11 @@ static void imx_pwm_set_enable_v2(struct pwm_chip =
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
@@ -199,27 +206,49 @@ static void imx_pwm_disable(struct pwm_chip *chip=
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
@@ -241,6 +270,10 @@ static int imx_pwm_probe(struct platform_device *p=
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
@@ -259,7 +292,7 @@ static int imx_pwm_probe(struct platform_device *pd=
ev)
 		return PTR_ERR(imx->clk_ipg);
 	}
=20
-	imx->chip.ops =3D &imx_pwm_ops;
+	imx->chip.ops =3D data->pwm_ops;
 	imx->chip.dev =3D &pdev->dev;
 	imx->chip.base =3D -1;
 	imx->chip.npwm =3D 1;
@@ -270,7 +303,6 @@ static int imx_pwm_probe(struct platform_device *pd=
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
