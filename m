From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 2/2] pwm: Remove .can_sleep from struct pwm_chip
Date: Wed,  4 Jan 2017 10:13:48 +0100
Message-ID: <20170104091348.31277-2-thierry.reding@gmail.com>
References: <20170104091348.31277-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20170104091348.31277-1-thierry.reding@gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-pwm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

All PWM devices have been marked as "might sleep" since v4.5, there is
no longer a need to differentiate on a per-chip basis.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 1 -
 drivers/pwm/pwm-atmel.c       | 1 -
 drivers/pwm/pwm-bcm-kona.c    | 1 -
 drivers/pwm/pwm-berlin.c      | 1 -
 drivers/pwm/pwm-brcmstb.c     | 1 -
 drivers/pwm/pwm-fsl-ftm.c     | 1 -
 drivers/pwm/pwm-imx.c         | 1 -
 drivers/pwm/pwm-lp3943.c      | 1 -
 drivers/pwm/pwm-mxs.c         | 2 +-
 drivers/pwm/pwm-pca9685.c     | 1 -
 drivers/pwm/pwm-sti.c         | 1 -
 drivers/pwm/pwm-sun4i.c       | 1 -
 drivers/pwm/pwm-twl-led.c     | 1 -
 drivers/pwm/pwm-twl.c         | 1 -
 drivers/staging/greybus/pwm.c | 1 -
 include/linux/pwm.h           | 3 ---
 16 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 14fc011faa32..999187277ea5 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -270,7 +270,6 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 	chip->chip.npwm = 1;
 	chip->chip.of_xlate = of_pwm_xlate_with_flags;
 	chip->chip.of_pwm_n_cells = 3;
-	chip->chip.can_sleep = 1;
 
 	ret = pwmchip_add_with_polarity(&chip->chip, PWM_POLARITY_INVERSED);
 	if (ret) {
diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index e6b8b1b7e6ba..67a7023be5c2 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -385,7 +385,6 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 
 	atmel_pwm->chip.base = -1;
 	atmel_pwm->chip.npwm = 4;
-	atmel_pwm->chip.can_sleep = true;
 	atmel_pwm->config = data->config;
 	atmel_pwm->updated_pwms = 0;
 	mutex_init(&atmel_pwm->isr_lock);
diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index c63418322023..09a95aeb3a70 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -276,7 +276,6 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 	kp->chip.npwm = 6;
 	kp->chip.of_xlate = of_pwm_xlate_with_flags;
 	kp->chip.of_pwm_n_cells = 3;
-	kp->chip.can_sleep = true;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	kp->base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index 01339c152ab0..771859aca4be 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -206,7 +206,6 @@ static int berlin_pwm_probe(struct platform_device *pdev)
 	pwm->chip.ops = &berlin_pwm_ops;
 	pwm->chip.base = -1;
 	pwm->chip.npwm = 4;
-	pwm->chip.can_sleep = true;
 	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
 	pwm->chip.of_pwm_n_cells = 3;
 
diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index 5d5adee16886..8063cffa1c96 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -270,7 +270,6 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
 	p->chip.ops = &brcmstb_pwm_ops;
 	p->chip.base = -1;
 	p->chip.npwm = 2;
-	p->chip.can_sleep = true;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	p->base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index fad968eb75f6..557b4ea16796 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -446,7 +446,6 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 	fpc->chip.of_pwm_n_cells = 3;
 	fpc->chip.base = -1;
 	fpc->chip.npwm = 8;
-	fpc->chip.can_sleep = true;
 
 	ret = pwmchip_add(&fpc->chip);
 	if (ret < 0) {
diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index d600fd5cd4ba..1223187ad354 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -304,7 +304,6 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	imx->chip.dev = &pdev->dev;
 	imx->chip.base = -1;
 	imx->chip.npwm = 1;
-	imx->chip.can_sleep = true;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	imx->mmio_base = devm_ioremap_resource(&pdev->dev, r);
diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index 872ea76a4f19..52584e9962ed 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -278,7 +278,6 @@ static int lp3943_pwm_probe(struct platform_device *pdev)
 	lp3943_pwm->chip.dev = &pdev->dev;
 	lp3943_pwm->chip.ops = &lp3943_pwm_ops;
 	lp3943_pwm->chip.npwm = LP3943_NUM_PWMS;
-	lp3943_pwm->chip.can_sleep = true;
 
 	platform_set_drvdata(pdev, lp3943_pwm);
 
diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index 9a596324ebef..a6017ad9926c 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -151,7 +151,7 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 	mxs->chip.dev = &pdev->dev;
 	mxs->chip.ops = &mxs_pwm_ops;
 	mxs->chip.base = -1;
-	mxs->chip.can_sleep = true;
+
 	ret = of_property_read_u32(np, "fsl,pwm-number", &mxs->chip.npwm);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);
diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 117fccf7934a..c8282a2650be 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -343,7 +343,6 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 
 	pca->chip.dev = &client->dev;
 	pca->chip.base = -1;
-	pca->chip.can_sleep = true;
 
 	return pwmchip_add(&pca->chip);
 }
diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index dd82dc840af9..2b7c31c9d1ab 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -635,7 +635,6 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	pc->chip.ops = &sti_pwm_ops;
 	pc->chip.base = -1;
 	pc->chip.npwm = pc->cdata->pwm_num_devs;
-	pc->chip.can_sleep = true;
 
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index b0803f6c64d9..1284ffa05921 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -340,7 +340,6 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	pwm->chip.ops = &sun4i_pwm_ops;
 	pwm->chip.base = -1;
 	pwm->chip.npwm = pwm->data->npwm;
-	pwm->chip.can_sleep = true;
 	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
 	pwm->chip.of_pwm_n_cells = 3;
 
diff --git a/drivers/pwm/pwm-twl-led.c b/drivers/pwm/pwm-twl-led.c
index b964470025c5..21eff991d0e3 100644
--- a/drivers/pwm/pwm-twl-led.c
+++ b/drivers/pwm/pwm-twl-led.c
@@ -303,7 +303,6 @@ static int twl_pwmled_probe(struct platform_device *pdev)
 
 	twl->chip.dev = &pdev->dev;
 	twl->chip.base = -1;
-	twl->chip.can_sleep = true;
 
 	mutex_init(&twl->mutex);
 
diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
index 7a993b056638..9de617b76680 100644
--- a/drivers/pwm/pwm-twl.c
+++ b/drivers/pwm/pwm-twl.c
@@ -323,7 +323,6 @@ static int twl_pwm_probe(struct platform_device *pdev)
 	twl->chip.dev = &pdev->dev;
 	twl->chip.base = -1;
 	twl->chip.npwm = 2;
-	twl->chip.can_sleep = true;
 
 	mutex_init(&twl->mutex);
 
diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index c4bf3298ba07..f0404bc37123 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -284,7 +284,6 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_dev,
 	pwm->ops = &gb_pwm_ops;
 	pwm->base = -1;			/* Allocate base dynamically */
 	pwm->npwm = pwmc->pwm_max + 1;
-	pwm->can_sleep = true;		/* FIXME */
 
 	ret = pwmchip_add(pwm);
 	if (ret) {
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e15fd3ce6502..eae215ef1b2c 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -287,8 +287,6 @@ struct pwm_ops {
  * @pwms: array of PWM devices allocated by the framework
  * @of_xlate: request a PWM device given a device tree PWM specifier
  * @of_pwm_n_cells: number of cells expected in the device tree PWM specifier
- * @can_sleep: must be true if the .config(), .enable() or .disable()
- *             operations may sleep
  */
 struct pwm_chip {
 	struct device *dev;
@@ -302,7 +300,6 @@ struct pwm_chip {
 	struct pwm_device * (*of_xlate)(struct pwm_chip *pc,
 					const struct of_phandle_args *args);
 	unsigned int of_pwm_n_cells;
-	bool can_sleep;
 };
 
 /**
-- 
2.11.0
