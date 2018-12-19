From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH] pwm: imx: add ipg clock operation
Date: Wed, 19 Dec 2018 05:24:58 +0000
Message-ID: <1545196822-31361-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org

i.MX PWM module's ipg_clk_s is for PWM register access, on
most of i.MX SoCs, this ipg_clk_s is from system ipg clock
or perclk which is always enabled, but on i.MX7D, the ipg_clk_s
is from PWM1_CLK_ROOT which is controlled by CCGR132, that means
the CCGR132 MUST be enabled first before accessing PWM registers
on i.MX7D. This patch adds ipg clock operation to make sure
register access successfully on i.MX7D and it fixes Linux kernel
boot up hang during PWM driver probe.

Fixes: 4a23e6ee9f69 ("ARM: dts: imx7d-sdb: Restore pwm backlight support")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/pwm/pwm-imx.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-=
----
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 6cd3b72..55a3a36 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -87,6 +87,8 @@
 #define MX3_PWMPR_MAX			0xfffe
=20
 struct imx_chip {
+	struct clk	*clk_ipg;
+
 	struct clk	*clk_per;
=20
 	void __iomem	*mmio_base;
@@ -96,6 +98,32 @@ struct imx_chip {
=20
 #define to_imx_chip(chip)	container_of(chip, struct imx_chip, chip)
=20
+static int imx_pwm_clk_prepare_enable(struct pwm_chip *chip)
+{
+	struct imx_chip *imx =3D to_imx_chip(chip);
+	int ret;
+
+	ret =3D clk_prepare_enable(imx->clk_ipg);
+	if (ret)
+		return ret;
+
+	ret =3D clk_prepare_enable(imx->clk_per);
+	if (ret) {
+		clk_disable_unprepare(imx->clk_ipg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void imx_pwm_clk_disable_unprepare(struct pwm_chip *chip)
+{
+	struct imx_chip *imx =3D to_imx_chip(chip);
+
+	clk_disable_unprepare(imx->clk_per);
+	clk_disable_unprepare(imx->clk_ipg);
+}
+
 static void imx_pwm_get_state(struct pwm_chip *chip,
 		struct pwm_device *pwm, struct pwm_state *state)
 {
@@ -103,11 +131,15 @@ static void imx_pwm_get_state(struct pwm_chip *chip,
 	u32 period, prescaler, pwm_clk, ret, val;
 	u64 tmp;
=20
+	ret =3D imx_pwm_clk_prepare_enable(chip);
+	if (ret < 0)
+		return;
+
 	val =3D readl(imx->mmio_base + MX3_PWMCR);
=20
 	if (val & MX3_PWMCR_EN) {
 		state->enabled =3D true;
-		ret =3D clk_prepare_enable(imx->clk_per);
+		ret =3D imx_pwm_clk_prepare_enable(chip);
 		if (ret)
 			return;
 	} else {
@@ -143,6 +175,8 @@ static void imx_pwm_get_state(struct pwm_chip *chip,
 	} else {
 		state->duty_cycle =3D 0;
 	}
+
+	imx_pwm_clk_disable_unprepare(chip);
 }
=20
 static int imx_pwm_config_v1(struct pwm_chip *chip,
@@ -180,7 +214,7 @@ static int imx_pwm_enable_v1(struct pwm_chip *chip, str=
uct pwm_device *pwm)
 	u32 val;
 	int ret;
=20
-	ret =3D clk_prepare_enable(imx->clk_per);
+	ret =3D imx_pwm_clk_prepare_enable(chip);
 	if (ret < 0)
 		return ret;
=20
@@ -200,7 +234,7 @@ static void imx_pwm_disable_v1(struct pwm_chip *chip, s=
truct pwm_device *pwm)
 	val &=3D ~MX1_PWMC_EN;
 	writel(val, imx->mmio_base + MX1_PWMC);
=20
-	clk_disable_unprepare(imx->clk_per);
+	imx_pwm_clk_disable_unprepare(chip);
 }
=20
 static void imx_pwm_sw_reset(struct pwm_chip *chip)
@@ -286,7 +320,7 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
 		if (cstate.enabled) {
 			imx_pwm_wait_fifo_slot(chip, pwm);
 		} else {
-			ret =3D clk_prepare_enable(imx->clk_per);
+			ret =3D imx_pwm_clk_prepare_enable(chip);
 			if (ret)
 				return ret;
=20
@@ -309,7 +343,7 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
 	} else if (cstate.enabled) {
 		writel(0, imx->mmio_base + MX3_PWMCR);
=20
-		clk_disable_unprepare(imx->clk_per);
+		imx_pwm_clk_disable_unprepare(chip);
 	}
=20
 	return 0;
@@ -367,6 +401,13 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	if (imx =3D=3D NULL)
 		return -ENOMEM;
=20
+	imx->clk_ipg =3D devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(imx->clk_ipg)) {
+		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
+				PTR_ERR(imx->clk_ipg));
+		return PTR_ERR(imx->clk_ipg);
+	}
+
 	imx->clk_per =3D devm_clk_get(&pdev->dev, "per");
 	if (IS_ERR(imx->clk_per)) {
 		dev_err(&pdev->dev, "getting per clock failed with %ld\n",
@@ -406,6 +447,8 @@ static int imx_pwm_remove(struct platform_device *pdev)
 	if (imx =3D=3D NULL)
 		return -ENODEV;
=20
+	imx_pwm_clk_disable_unprepare(&imx->chip);
+
 	return pwmchip_remove(&imx->chip);
 }
=20
--=20
2.7.4
