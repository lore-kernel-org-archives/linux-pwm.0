From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 01/16] drivers: pwm: core: use a single of xlate function
Date: Fri, 12 Jan 2018 16:22:48 +0200
Message-ID: <1515766983-15151-2-git-send-email-claudiu.beznea@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, corbet@lwn.net, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>, Mike Dunn <mikedunn@newsguy.com>, Brian Norris <briannorris@chromium.org>, Alexander Shiyan <shc_work@mail.ru>
List-Id: linux-pwm@vger.kernel.org

Remove of_pwm_simple_xlate() and of_pwm_xlate_with_flags() functions
and add of_pwm_xlate() which is used in all cases no mather if the OF
bindings are with PWM flags or not. This should not affect the old
behavior since the xlate will be based on #pwm-cells property of the
PWM controller. Based on #pwm-cells property the xlate will consider
the flags or not. This will permit the addition of other inputs to OF
xlate by just adding proper code at the end of of_pwm_xlate() and a new
input to enum pwm_args_xlate_options. With this changes there will be
no need to fill of_xlate and of_pwm_n_cells of struct pwm_chip from
the drivers probe methods. References in drives to references to of_xlate
and of_pwm_n_cells were removed. Drivers which used private of_xlate
functions switched to the generic of_pwm_xlate() function which fits
for it but with little changes in device trees (these drivers translated
differently the "pwms" bindings; the "pwms" bindings now are generic to
all drivers and all drivers should provide them in the format described
in pwm documentation).

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Mike Dunn <mikedunn@newsguy.com>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

This patch (and the next 7) could be applied independetly by this series, if
any, but I choosed to have it here since it makes easy the PWM modes parsing.
If you feel it could be independently of this series I could send a new version.

Also, Thierry, Mike, Brian, Shiyan, please take an extra look over pwm-pxa.c,
pwm-cros-ec.c and pwm-clps711x.c since these were moved to use the generic
pwms (minimum 2 pwm-cells).

 drivers/pwm/core.c             | 56 +++++++++++-------------------------------
 drivers/pwm/pwm-atmel-hlcdc.c  |  2 --
 drivers/pwm/pwm-atmel-tcb.c    |  2 --
 drivers/pwm/pwm-atmel.c        |  6 -----
 drivers/pwm/pwm-bcm-iproc.c    |  2 --
 drivers/pwm/pwm-bcm-kona.c     |  2 --
 drivers/pwm/pwm-bcm2835.c      |  2 --
 drivers/pwm/pwm-berlin.c       |  2 --
 drivers/pwm/pwm-clps711x.c     | 11 ---------
 drivers/pwm/pwm-cros-ec.c      | 20 ---------------
 drivers/pwm/pwm-fsl-ftm.c      |  2 --
 drivers/pwm/pwm-hibvt.c        |  2 --
 drivers/pwm/pwm-imx.c          |  8 ------
 drivers/pwm/pwm-lpc18xx-sct.c  |  2 --
 drivers/pwm/pwm-meson.c        |  2 --
 drivers/pwm/pwm-omap-dmtimer.c |  2 --
 drivers/pwm/pwm-pxa.c          | 19 --------------
 drivers/pwm/pwm-renesas-tpu.c  |  2 --
 drivers/pwm/pwm-rockchip.c     |  5 ----
 drivers/pwm/pwm-samsung.c      |  3 ---
 drivers/pwm/pwm-sun4i.c        |  2 --
 drivers/pwm/pwm-tiecap.c       |  2 --
 drivers/pwm/pwm-tiehrpwm.c     |  2 --
 drivers/pwm/pwm-vt8500.c       |  2 --
 drivers/pwm/pwm-zx.c           |  2 --
 include/linux/pwm.h            | 23 ++++++++++-------
 26 files changed, 29 insertions(+), 156 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1581f6ab1b1f..7208b95e8d2f 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -132,47 +132,23 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 	return 0;
 }
 
-struct pwm_device *
-of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
+static inline void of_pwm_xlate_flags(struct pwm_device *pwm,
+				      const struct of_phandle_args *args)
 {
-	struct pwm_device *pwm;
-
-	/* check, whether the driver supports a third cell for flags */
-	if (pc->of_pwm_n_cells < 3)
-		return ERR_PTR(-EINVAL);
-
-	/* flags in the third cell are optional */
-	if (args->args_count < 2)
-		return ERR_PTR(-EINVAL);
-
-	if (args->args[0] >= pc->npwm)
-		return ERR_PTR(-EINVAL);
-
-	pwm = pwm_request_from_chip(pc, args->args[0], NULL);
-	if (IS_ERR(pwm))
-		return pwm;
-
-	pwm->args.period = args->args[1];
-	pwm->args.polarity = PWM_POLARITY_NORMAL;
-
-	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
+	if (args->args_count >= PWM_ARGS_CNT_XLATE_FLAGS &&
+	    args->args[PWM_ARGS_CNT_XLATE_FLAGS - 1] & PWM_POLARITY_INVERTED)
 		pwm->args.polarity = PWM_POLARITY_INVERSED;
-
-	return pwm;
+	else
+		pwm->args.polarity = PWM_POLARITY_NORMAL;
 }
-EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
 
-static struct pwm_device *
-of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
+struct pwm_device *of_pwm_xlate(struct pwm_chip *pc,
+				const struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
 
-	/* sanity check driver support */
-	if (pc->of_pwm_n_cells < 2)
-		return ERR_PTR(-EINVAL);
-
-	/* all cells are required */
-	if (args->args_count != pc->of_pwm_n_cells)
+	if (args->args_count < PWM_ARGS_CNT_XLATE_PERIOD ||
+	    args->args_count > PWM_ARGS_CNT_XLATE_MAX)
 		return ERR_PTR(-EINVAL);
 
 	if (args->args[0] >= pc->npwm)
@@ -182,21 +158,19 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 	if (IS_ERR(pwm))
 		return pwm;
 
-	pwm->args.period = args->args[1];
+	pwm->args.period = args->args[PWM_ARGS_CNT_XLATE_PERIOD - 1];
+
+	of_pwm_xlate_flags(pwm, args);
 
 	return pwm;
 }
+EXPORT_SYMBOL_GPL(of_pwm_xlate);
 
 static void of_pwmchip_add(struct pwm_chip *chip)
 {
 	if (!chip->dev || !chip->dev->of_node)
 		return;
 
-	if (!chip->of_xlate) {
-		chip->of_xlate = of_pwm_simple_xlate;
-		chip->of_pwm_n_cells = 2;
-	}
-
 	of_node_get(chip->dev->of_node);
 }
 
@@ -685,7 +659,7 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
 		goto put;
 	}
 
-	pwm = pc->of_xlate(pc, &args);
+	pwm = of_pwm_xlate(pc, &args);
 	if (IS_ERR(pwm))
 		goto put;
 
diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 54c6633d9b5d..b574e9e639f1 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -277,8 +277,6 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 	chip->chip.dev = dev;
 	chip->chip.base = -1;
 	chip->chip.npwm = 1;
-	chip->chip.of_xlate = of_pwm_xlate_with_flags;
-	chip->chip.of_pwm_n_cells = 3;
 
 	ret = pwmchip_add_with_polarity(&chip->chip, PWM_POLARITY_INVERSED);
 	if (ret) {
diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index acd3ce8ecf3f..e75bef50b831 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -407,8 +407,6 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 
 	tcbpwm->chip.dev = &pdev->dev;
 	tcbpwm->chip.ops = &atmel_tcb_pwm_ops;
-	tcbpwm->chip.of_xlate = of_pwm_xlate_with_flags;
-	tcbpwm->chip.of_pwm_n_cells = 3;
 	tcbpwm->chip.base = -1;
 	tcbpwm->chip.npwm = NPWM;
 	tcbpwm->tc = tc;
diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 530d7dc5f1b5..32427d2b7877 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -365,12 +365,6 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 
 	atmel_pwm->chip.dev = &pdev->dev;
 	atmel_pwm->chip.ops = &atmel_pwm_ops;
-
-	if (pdev->dev.of_node) {
-		atmel_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
-		atmel_pwm->chip.of_pwm_n_cells = 3;
-	}
-
 	atmel_pwm->chip.base = -1;
 	atmel_pwm->chip.npwm = 4;
 	atmel_pwm->regs = regs;
diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index d961a8207b1c..773c53b6c13d 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -207,8 +207,6 @@ static int iproc_pwmc_probe(struct platform_device *pdev)
 	ip->chip.ops = &iproc_pwm_ops;
 	ip->chip.base = -1;
 	ip->chip.npwm = 4;
-	ip->chip.of_xlate = of_pwm_xlate_with_flags;
-	ip->chip.of_pwm_n_cells = 3;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ip->base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 09a95aeb3a70..e3418e9b7828 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -274,8 +274,6 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 	kp->chip.ops = &kona_pwm_ops;
 	kp->chip.base = -1;
 	kp->chip.npwm = 6;
-	kp->chip.of_xlate = of_pwm_xlate_with_flags;
-	kp->chip.of_pwm_n_cells = 3;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	kp->base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index db001cba937f..c5dbf16d810b 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -167,8 +167,6 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &bcm2835_pwm_ops;
 	pc->chip.npwm = 2;
-	pc->chip.of_xlate = of_pwm_xlate_with_flags;
-	pc->chip.of_pwm_n_cells = 3;
 
 	platform_set_drvdata(pdev, pc);
 
diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index 771859aca4be..ffe75a891d35 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -206,8 +206,6 @@ static int berlin_pwm_probe(struct platform_device *pdev)
 	pwm->chip.ops = &berlin_pwm_ops;
 	pwm->chip.base = -1;
 	pwm->chip.npwm = 4;
-	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
-	pwm->chip.of_pwm_n_cells = 3;
 
 	ret = pwmchip_add(&pwm->chip);
 	if (ret < 0) {
diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 26ec24e457b1..432b6ff174e9 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -106,15 +106,6 @@ static const struct pwm_ops clps711x_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
-static struct pwm_device *clps711x_pwm_xlate(struct pwm_chip *chip,
-					     const struct of_phandle_args *args)
-{
-	if (args->args[0] >= chip->npwm)
-		return ERR_PTR(-EINVAL);
-
-	return pwm_request_from_chip(chip, args->args[0], NULL);
-}
-
 static int clps711x_pwm_probe(struct platform_device *pdev)
 {
 	struct clps711x_chip *priv;
@@ -137,8 +128,6 @@ static int clps711x_pwm_probe(struct platform_device *pdev)
 	priv->chip.dev = &pdev->dev;
 	priv->chip.base = -1;
 	priv->chip.npwm = 2;
-	priv->chip.of_xlate = clps711x_pwm_xlate;
-	priv->chip.of_pwm_n_cells = 1;
 
 	spin_lock_init(&priv->lock);
 
diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 9c13694eaa24..692298693768 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -133,24 +133,6 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	state->duty_cycle = ret;
 }
 
-static struct pwm_device *
-cros_ec_pwm_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
-{
-	struct pwm_device *pwm;
-
-	if (args->args[0] >= pc->npwm)
-		return ERR_PTR(-EINVAL);
-
-	pwm = pwm_request_from_chip(pc, args->args[0], NULL);
-	if (IS_ERR(pwm))
-		return pwm;
-
-	/* The EC won't let us change the period */
-	pwm->args.period = EC_PWM_MAX_DUTY;
-
-	return pwm;
-}
-
 static const struct pwm_ops cros_ec_pwm_ops = {
 	.get_state	= cros_ec_pwm_get_state,
 	.apply		= cros_ec_pwm_apply,
@@ -207,8 +189,6 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
 	/* PWM chip */
 	chip->dev = dev;
 	chip->ops = &cros_ec_pwm_ops;
-	chip->of_xlate = cros_ec_pwm_xlate;
-	chip->of_pwm_n_cells = 1;
 	chip->base = -1;
 	ret = cros_ec_num_pwms(ec);
 	if (ret < 0) {
diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 557b4ea16796..7b9d59796ebd 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -442,8 +442,6 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_CNTEN]);
 
 	fpc->chip.ops = &fsl_pwm_ops;
-	fpc->chip.of_xlate = of_pwm_xlate_with_flags;
-	fpc->chip.of_pwm_n_cells = 3;
 	fpc->chip.base = -1;
 	fpc->chip.npwm = 8;
 
diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index 27c107e78d59..afc74ef76551 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -196,8 +196,6 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 	pwm_chip->chip.dev = &pdev->dev;
 	pwm_chip->chip.base = -1;
 	pwm_chip->chip.npwm = soc->num_pwms;
-	pwm_chip->chip.of_xlate = of_pwm_xlate_with_flags;
-	pwm_chip->chip.of_pwm_n_cells = 3;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pwm_chip->base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 2ba5c3a398ff..cdfb04f40583 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -240,7 +240,6 @@ static const struct pwm_ops imx_pwm_ops_v2 = {
 };
 
 struct imx_pwm_data {
-	bool polarity_supported;
 	const struct pwm_ops *ops;
 };
 
@@ -249,7 +248,6 @@ static struct imx_pwm_data imx_pwm_data_v1 = {
 };
 
 static struct imx_pwm_data imx_pwm_data_v2 = {
-	.polarity_supported = true,
 	.ops = &imx_pwm_ops_v2,
 };
 
@@ -290,12 +288,6 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	imx->chip.base = -1;
 	imx->chip.npwm = 1;
 
-	if (data->polarity_supported) {
-		dev_dbg(&pdev->dev, "PWM supports output inversion\n");
-		imx->chip.of_xlate = of_pwm_xlate_with_flags;
-		imx->chip.of_pwm_n_cells = 3;
-	}
-
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	imx->mmio_base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(imx->mmio_base))
diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index d7f5f7de030d..ea825ec28da9 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -380,8 +380,6 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	lpc18xx_pwm->chip.ops = &lpc18xx_pwm_ops;
 	lpc18xx_pwm->chip.base = -1;
 	lpc18xx_pwm->chip.npwm = 16;
-	lpc18xx_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
-	lpc18xx_pwm->chip.of_pwm_n_cells = 3;
 
 	/* SCT counter must be in unify (32 bit) mode */
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CONFIG,
diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 0767deba8e62..6702fcc203ce 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -535,8 +535,6 @@ static int meson_pwm_probe(struct platform_device *pdev)
 	meson->chip.ops = &meson_pwm_ops;
 	meson->chip.base = -1;
 	meson->chip.npwm = 2;
-	meson->chip.of_xlate = of_pwm_xlate_with_flags;
-	meson->chip.of_pwm_n_cells = 3;
 
 	meson->data = of_device_get_match_data(&pdev->dev);
 	meson->inverter_mask = BIT(meson->chip.npwm) - 1;
diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 5ad42f33e70c..6bd32ae6dd3e 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -317,8 +317,6 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	omap->chip.ops = &pwm_omap_dmtimer_ops;
 	omap->chip.base = -1;
 	omap->chip.npwm = 1;
-	omap->chip.of_xlate = of_pwm_xlate_with_flags;
-	omap->chip.of_pwm_n_cells = 3;
 
 	mutex_init(&omap->mutex);
 
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 4143a46684d2..d66816037e87 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -151,20 +151,6 @@ static const struct platform_device_id *pxa_pwm_get_id_dt(struct device *dev)
 	return id ? id->data : NULL;
 }
 
-static struct pwm_device *
-pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
-{
-	struct pwm_device *pwm;
-
-	pwm = pwm_request_from_chip(pc, 0, NULL);
-	if (IS_ERR(pwm))
-		return pwm;
-
-	pwm->args.period = args->args[0];
-
-	return pwm;
-}
-
 static int pwm_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
@@ -191,11 +177,6 @@ static int pwm_probe(struct platform_device *pdev)
 	pwm->chip.base = -1;
 	pwm->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
 
-	if (IS_ENABLED(CONFIG_OF)) {
-		pwm->chip.of_xlate = pxa_pwm_of_xlate;
-		pwm->chip.of_pwm_n_cells = 1;
-	}
-
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pwm->mmio_base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(pwm->mmio_base))
diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 29267d12fb4c..a4606957e7e5 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -418,8 +418,6 @@ static int tpu_probe(struct platform_device *pdev)
 
 	tpu->chip.dev = &pdev->dev;
 	tpu->chip.ops = &tpu_pwm_ops;
-	tpu->chip.of_xlate = of_pwm_xlate_with_flags;
-	tpu->chip.of_pwm_n_cells = 3;
 	tpu->chip.base = -1;
 	tpu->chip.npwm = TPU_CHANNEL_MAX;
 
diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 4d99d468df09..c754c57118be 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -363,11 +363,6 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	pc->chip.base = -1;
 	pc->chip.npwm = 1;
 
-	if (pc->data->supports_polarity) {
-		pc->chip.of_xlate = of_pwm_xlate_with_flags;
-		pc->chip.of_pwm_n_cells = 3;
-	}
-
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
 		clk_unprepare(pc->clk);
diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 062f2cfc45ec..de171bfa4903 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -532,9 +532,6 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 		ret = pwm_samsung_parse_dt(chip);
 		if (ret)
 			return ret;
-
-		chip->chip.of_xlate = of_pwm_xlate_with_flags;
-		chip->chip.of_pwm_n_cells = 3;
 	} else {
 		if (!pdev->dev.platform_data) {
 			dev_err(&pdev->dev, "no platform data specified\n");
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 334199c58f1d..b8476ce713a2 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -390,8 +390,6 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	pwm->chip.ops = &sun4i_pwm_ops;
 	pwm->chip.base = -1;
 	pwm->chip.npwm = pwm->data->npwm;
-	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
-	pwm->chip.of_pwm_n_cells = 3;
 
 	spin_lock_init(&pwm->ctrl_lock);
 
diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 34b228626bd5..4210f3ad87e1 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -238,8 +238,6 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &ecap_pwm_ops;
-	pc->chip.of_xlate = of_pwm_xlate_with_flags;
-	pc->chip.of_pwm_n_cells = 3;
 	pc->chip.base = -1;
 	pc->chip.npwm = 1;
 
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 4c22cb395040..7b0715624282 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -469,8 +469,6 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &ehrpwm_pwm_ops;
-	pc->chip.of_xlate = of_pwm_xlate_with_flags;
-	pc->chip.of_pwm_n_cells = 3;
 	pc->chip.base = -1;
 	pc->chip.npwm = NUM_PWM_CHANNEL;
 
diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 3a78dd09ac81..3a923c1d30d3 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -216,8 +216,6 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 
 	chip->chip.dev = &pdev->dev;
 	chip->chip.ops = &vt8500_pwm_ops;
-	chip->chip.of_xlate = of_pwm_xlate_with_flags;
-	chip->chip.of_pwm_n_cells = 3;
 	chip->chip.base = -1;
 	chip->chip.npwm = VT8500_NR_PWMS;
 
diff --git a/drivers/pwm/pwm-zx.c b/drivers/pwm/pwm-zx.c
index 5d27c16edfb1..201b6f540ad6 100644
--- a/drivers/pwm/pwm-zx.c
+++ b/drivers/pwm/pwm-zx.c
@@ -228,8 +228,6 @@ static int zx_pwm_probe(struct platform_device *pdev)
 	zpc->chip.ops = &zx_pwm_ops;
 	zpc->chip.base = -1;
 	zpc->chip.npwm = 4;
-	zpc->chip.of_xlate = of_pwm_xlate_with_flags;
-	zpc->chip.of_pwm_n_cells = 3;
 
 	/*
 	 * PWM devices may be enabled by firmware, and let's disable all of
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 56518adc31dd..4bb628b94d88 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -48,6 +48,18 @@ enum {
 	PWMF_EXPORTED = 1 << 1,
 };
 
+/**
+ * enum pwm_args_xlate_options - options for translating PWM options
+ * @PWM_ARGS_CNT_XLATE_PERIOD: translate period
+ * @PWM_ARGS_CNT_XLATE_FLAGS: translate flags (polarity flags)
+ * @PWM_ARGS_CNT_XLATE_MAX: maximum number of translate options
+ */
+enum pwm_args_xlate_options {
+	PWM_ARGS_CNT_XLATE_PERIOD = 2,
+	PWM_ARGS_CNT_XLATE_FLAGS,
+	PWM_ARGS_CNT_XLATE_MAX = PWM_ARGS_CNT_XLATE_FLAGS,
+};
+
 /*
  * struct pwm_state - state of a PWM channel
  * @period: PWM period (in nanoseconds)
@@ -286,8 +298,6 @@ struct pwm_ops {
  * @base: number of first PWM controlled by this chip
  * @npwm: number of PWMs controlled by this chip
  * @pwms: array of PWM devices allocated by the framework
- * @of_xlate: request a PWM device given a device tree PWM specifier
- * @of_pwm_n_cells: number of cells expected in the device tree PWM specifier
  */
 struct pwm_chip {
 	struct device *dev;
@@ -295,12 +305,7 @@ struct pwm_chip {
 	const struct pwm_ops *ops;
 	int base;
 	unsigned int npwm;
-
 	struct pwm_device *pwms;
-
-	struct pwm_device * (*of_xlate)(struct pwm_chip *pc,
-					const struct of_phandle_args *args);
-	unsigned int of_pwm_n_cells;
 };
 
 /**
@@ -438,8 +443,8 @@ struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 					 unsigned int index,
 					 const char *label);
 
-struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
-		const struct of_phandle_args *args);
+struct pwm_device *of_pwm_xlate(struct pwm_chip *pc,
+				const struct of_phandle_args *args);
 
 struct pwm_device *pwm_get(struct device *dev, const char *con_id);
 struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id);
-- 
2.7.4
