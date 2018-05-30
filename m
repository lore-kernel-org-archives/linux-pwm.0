From: Shenwei Wang <shenwei.wang@nxp.com>
Subject: RE: [PATCH 1/1] pwm: fsl-ftm: Support the new version of FTM block on
 i.MX8x
Date: Wed, 30 May 2018 16:59:38 +0000
Message-ID: <HE1PR04MB328939CAD27C15DD182C5E40896C0@HE1PR04MB3289.eurprd04.prod.outlook.com>
References: <20180524180848.61844-1-shenwei.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180524180848.61844-1-shenwei.wang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Ping.

Shenwei

-----Original Message-----
From: Shenwei Wang=20
Sent: Thursday, May 24, 2018 1:09 PM
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; linux-kern=
el@vger.kernel.org; Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH 1/1] pwm: fsl-ftm: Support the new version of FTM block on =
i.MX8x

On the new i.MX8x SoC family, the following changes were made on the FTM
block:

1. Need to enable the IPG clock before accessing any FTM registers. Because=
 the IPG clock is not an option for FTM counter clock source, it can't be u=
sed as the ftm_sys clock.

2. An additional PWM enable bit was added for each PWM channel in register =
FTM_SC[16:23]. It supports 8 channels. Bit16 is for channel 0, and bit23 fo=
r channel 7.

As the IP version information can not be obtained in any of the FTM registe=
rs, a property of "fsl,has-pwmen-bits" is added in the ftm pwm device node.=
 If it has the property, the driver set the PWM enable bit when a PWM chann=
el is requested.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c index 55=
7b4ea..0426458f 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -86,7 +86,9 @@ struct fsl_pwm_chip {
 	struct regmap *regmap;
=20
 	int period_ns;
+	bool has_pwmen;
=20
+	struct clk *ipg_clk;
 	struct clk *clk[FSL_PWM_CLK_MAX];
 };
=20
@@ -97,16 +99,31 @@ static inline struct fsl_pwm_chip *to_fsl_chip(struct p=
wm_chip *chip)
=20
 static int fsl_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm) =
 {
+	int ret;
 	struct fsl_pwm_chip *fpc =3D to_fsl_chip(chip);
=20
-	return clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+	ret =3D clk_prepare_enable(fpc->ipg_clk);
+
+	if ((!ret) && (fpc->has_pwmen)) {
+		mutex_lock(&fpc->lock);
+		regmap_update_bits(fpc->regmap, FTM_SC,
+				BIT(pwm->hwpwm + 16), BIT(pwm->hwpwm + 16));
+		mutex_unlock(&fpc->lock);
+	}
+
+	return ret;
 }
=20
 static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)  {
 	struct fsl_pwm_chip *fpc =3D to_fsl_chip(chip);
=20
-	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+	if (fpc->has_pwmen) {
+		mutex_lock(&fpc->lock);
+		regmap_update_bits(fpc->regmap, FTM_SC, BIT(pwm->hwpwm + 16), 0);
+		mutex_unlock(&fpc->lock);
+	}
+	clk_disable_unprepare(fpc->ipg_clk);
 }
=20
 static int fsl_pwm_calculate_default_ps(struct fsl_pwm_chip *fpc, @@ -363,=
7 +380,7 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)  {
 	int ret;
=20
-	ret =3D clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+	ret =3D clk_prepare_enable(fpc->ipg_clk);
 	if (ret)
 		return ret;
=20
@@ -371,7 +388,7 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)
 	regmap_write(fpc->regmap, FTM_OUTINIT, 0x00);
 	regmap_write(fpc->regmap, FTM_OUTMASK, 0xFF);
=20
-	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+	clk_disable_unprepare(fpc->ipg_clk);
=20
 	return 0;
 }
@@ -428,6 +445,10 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_SYS]);
 	}
=20
+	fpc->ipg_clk =3D devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(fpc->ipg_clk))
+		fpc->ipg_clk =3D fpc->clk[FSL_PWM_CLK_SYS];
+
 	fpc->clk[FSL_PWM_CLK_FIX] =3D devm_clk_get(fpc->chip.dev, "ftm_fix");
 	if (IS_ERR(fpc->clk[FSL_PWM_CLK_FIX]))
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_FIX]);
@@ -446,6 +467,8 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 	fpc->chip.of_pwm_n_cells =3D 3;
 	fpc->chip.base =3D -1;
 	fpc->chip.npwm =3D 8;
+	fpc->has_pwmen =3D of_property_read_bool(pdev->dev.of_node,
+						"fsl,ftm-has-pwmen-bits");
=20
 	ret =3D pwmchip_add(&fpc->chip);
 	if (ret < 0) {
@@ -480,7 +503,7 @@ static int fsl_pwm_suspend(struct device *dev)
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
=20
-		clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+		clk_disable_unprepare(fpc->ipg_clk);
=20
 		if (!pwm_is_enabled(pwm))
 			continue;
@@ -503,7 +526,7 @@ static int fsl_pwm_resume(struct device *dev)
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
=20
-		clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+		clk_prepare_enable(fpc->ipg_clk);
=20
 		if (!pwm_is_enabled(pwm))
 			continue;
--
2.9.2
