From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCHv3 3/3] pwm: imx: support output polarity inversion
Date: Fri, 28 Mar 2014 09:49:00 +0100
Message-ID: <1395996540-10999-4-git-send-email-LW@KARO-electronics.de>
References: <1395235375-12925-1-git-send-email-LW@KARO-electronics.de>
 <1395996540-10999-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395996540-10999-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pwm@vger.kernel.org

The i.MX pwm unit on i.MX27 and newer SoCs provides a configurable
output polarity. This patch adds support to utilize this feature where
available.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/pwm/pwm-imx.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 52aac5e..a43410a 100644
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
@@ -199,6 +206,17 @@ static void imx_pwm_disable(struct pwm_chip *chip,=
 struct pwm_device *pwm)
 	clk_disable_unprepare(imx->clk_per);
 }
=20
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
 static struct pwm_ops imx_pwm_ops =3D {
 	.enable =3D imx_pwm_enable,
 	.disable =3D imx_pwm_disable,
@@ -210,6 +228,7 @@ struct imx_pwm_data {
 	int (*config)(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns);
 	void (*set_enable)(struct pwm_chip *chip, bool enable);
+	unsigned output_polarity:1;
 };
=20
 static struct imx_pwm_data imx_pwm_data_v1 =3D {
@@ -220,6 +239,7 @@ static struct imx_pwm_data imx_pwm_data_v1 =3D {
 static struct imx_pwm_data imx_pwm_data_v2 =3D {
 	.config =3D imx_pwm_config_v2,
 	.set_enable =3D imx_pwm_set_enable_v2,
+	.output_polarity =3D 1,
 };
=20
 static const struct of_device_id imx_pwm_dt_ids[] =3D {
@@ -272,6 +292,11 @@ static int imx_pwm_probe(struct platform_device *p=
dev)
 		return PTR_ERR(imx->mmio_base);
=20
 	data =3D of_id->data;
+	if (data->output_polarity) {
+		dev_dbg(&pdev->dev, "PWM supports output inversion\n");
+		imx_pwm_ops.set_polarity =3D imx_pwm_set_polarity;
+	}
+
 	imx->config =3D data->config;
 	imx->set_enable =3D data->set_enable;
=20
--=20
1.7.10.4
