From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCHv4 2/4] pwm: make the PWM_POLARITY flag in DTB optional
Date: Wed, 20 Aug 2014 08:55:54 +0200
Message-ID: <1408517756-9412-3-git-send-email-LW@KARO-electronics.de>
References: <1408517756-9412-1-git-send-email-LW@KARO-electronics.de>
 <1408517756-9412-2-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408517756-9412-2-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>, Tony Prisk <linux@prisktech.co.nz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Change the pwm chip driver registration, so that a chip driver that
supports polarity inversion can still be used with DTBs that don't
provide the 'PWM_POLARITY' flag.

This is done to provide polarity inversion support for the pwm-imx
driver without having to modify all existing DTS files.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/pwm/core.c            |   18 ++++++------------
 drivers/pwm/pwm-atmel-tcb.c   |    1 -
 drivers/pwm/pwm-atmel.c       |    4 +---
 drivers/pwm/pwm-pxa.c         |    5 ++---
 drivers/pwm/pwm-renesas-tpu.c |    1 -
 drivers/pwm/pwm-samsung.c     |    1 -
 drivers/pwm/pwm-tiecap.c      |    1 -
 drivers/pwm/pwm-tiehrpwm.c    |    1 -
 drivers/pwm/pwm-vt8500.c      |    1 -
 include/linux/pwm.h           |    1 -
 10 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 7af0043..ab0fc5a 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -136,7 +136,7 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const =
struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
=20
-	if (pc->of_pwm_n_cells < 3)
+	if (args->args_count !=3D 3)
 		return ERR_PTR(-EINVAL);
=20
 	if (args->args[0] >=3D pc->npwm)
@@ -162,12 +162,15 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const st=
ruct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
=20
-	if (pc->of_pwm_n_cells < 2)
+	if (args->args_count < 2)
 		return ERR_PTR(-EINVAL);
=20
 	if (args->args[0] >=3D pc->npwm)
 		return ERR_PTR(-EINVAL);
=20
+	if (args->args_count > 2)
+		return of_pwm_xlate_with_flags(pc, args);
+
 	pwm =3D pwm_request_from_chip(pc, args->args[0], NULL);
 	if (IS_ERR(pwm))
 		return pwm;
@@ -182,10 +185,8 @@ static void of_pwmchip_add(struct pwm_chip *chip)
 	if (!chip->dev || !chip->dev->of_node)
 		return;
=20
-	if (!chip->of_xlate) {
+	if (!chip->of_xlate)
 		chip->of_xlate =3D of_pwm_simple_xlate;
-		chip->of_pwm_n_cells =3D 2;
-	}
=20
 	of_node_get(chip->dev->of_node);
 }
@@ -536,13 +537,6 @@ struct pwm_device *of_pwm_get(struct device_node *=
np, const char *con_id)
 		goto put;
 	}
=20
-	if (args.args_count !=3D pc->of_pwm_n_cells) {
-		pr_debug("%s: wrong #pwm-cells for %s\n", np->full_name,
-			 args.np->full_name);
-		pwm =3D ERR_PTR(-EINVAL);
-		goto put;
-	}
-
 	pwm =3D pc->of_xlate(pc, &args);
 	if (IS_ERR(pwm))
 		goto put;
diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index f3dcd02..55fabf8 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -395,7 +395,6 @@ static int atmel_tcb_pwm_probe(struct platform_devi=
ce *pdev)
 	tcbpwm->chip.dev =3D &pdev->dev;
 	tcbpwm->chip.ops =3D &atmel_tcb_pwm_ops;
 	tcbpwm->chip.of_xlate =3D of_pwm_xlate_with_flags;
-	tcbpwm->chip.of_pwm_n_cells =3D 3;
 	tcbpwm->chip.base =3D -1;
 	tcbpwm->chip.npwm =3D NPWM;
 	tcbpwm->tc =3D tc;
diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 6e700a5..ae7c946 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -350,10 +350,8 @@ static int atmel_pwm_probe(struct platform_device =
*pdev)
 	atmel_pwm->chip.dev =3D &pdev->dev;
 	atmel_pwm->chip.ops =3D &atmel_pwm_ops;
=20
-	if (pdev->dev.of_node) {
+	if (pdev->dev.of_node)
 		atmel_pwm->chip.of_xlate =3D of_pwm_xlate_with_flags;
-		atmel_pwm->chip.of_pwm_n_cells =3D 3;
-	}
=20
 	atmel_pwm->chip.base =3D -1;
 	atmel_pwm->chip.npwm =3D 4;
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 0b312ec..5656052 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -191,10 +191,9 @@ static int pwm_probe(struct platform_device *pdev)
 	pwm->chip.base =3D -1;
 	pwm->chip.npwm =3D (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
=20
-	if (IS_ENABLED(CONFIG_OF)) {
+	if (IS_ENABLED(CONFIG_OF))
 		pwm->chip.of_xlate =3D pxa_pwm_of_xlate;
-		pwm->chip.of_pwm_n_cells =3D 1;
-	}
+
=20
 	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pwm->mmio_base =3D devm_ioremap_resource(&pdev->dev, r);
diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tp=
u.c
index 3b71b42..5271da3 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -419,7 +419,6 @@ static int tpu_probe(struct platform_device *pdev)
 	tpu->chip.dev =3D &pdev->dev;
 	tpu->chip.ops =3D &tpu_pwm_ops;
 	tpu->chip.of_xlate =3D of_pwm_xlate_with_flags;
-	tpu->chip.of_pwm_n_cells =3D 3;
 	tpu->chip.base =3D -1;
 	tpu->chip.npwm =3D TPU_CHANNEL_MAX;
=20
diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index ba6b650..317d7d1 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -484,7 +484,6 @@ static int pwm_samsung_probe(struct platform_device=
 *pdev)
 			return ret;
=20
 		chip->chip.of_xlate =3D of_pwm_xlate_with_flags;
-		chip->chip.of_pwm_n_cells =3D 3;
 	} else {
 		if (!pdev->dev.platform_data) {
 			dev_err(&pdev->dev, "no platform data specified\n");
diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 74efbe7..a8e8282 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -227,7 +227,6 @@ static int ecap_pwm_probe(struct platform_device *p=
dev)
 	pc->chip.dev =3D &pdev->dev;
 	pc->chip.ops =3D &ecap_pwm_ops;
 	pc->chip.of_xlate =3D of_pwm_xlate_with_flags;
-	pc->chip.of_pwm_n_cells =3D 3;
 	pc->chip.base =3D -1;
 	pc->chip.npwm =3D 1;
=20
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index cb75133..12a8ae4 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -458,7 +458,6 @@ static int ehrpwm_pwm_probe(struct platform_device =
*pdev)
 	pc->chip.dev =3D &pdev->dev;
 	pc->chip.ops =3D &ehrpwm_pwm_ops;
 	pc->chip.of_xlate =3D of_pwm_xlate_with_flags;
-	pc->chip.of_pwm_n_cells =3D 3;
 	pc->chip.base =3D -1;
 	pc->chip.npwm =3D NUM_PWM_CHANNEL;
=20
diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 652e6b5..e04a3c0 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -217,7 +217,6 @@ static int vt8500_pwm_probe(struct platform_device =
*pdev)
 	chip->chip.dev =3D &pdev->dev;
 	chip->chip.ops =3D &vt8500_pwm_ops;
 	chip->chip.of_xlate =3D of_pwm_xlate_with_flags;
-	chip->chip.of_pwm_n_cells =3D 3;
 	chip->chip.base =3D -1;
 	chip->chip.npwm =3D VT8500_NR_PWMS;
=20
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e90628c..4cf1569 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -174,7 +174,6 @@ struct pwm_chip {
=20
 	struct pwm_device *	(*of_xlate)(struct pwm_chip *pc,
 					    const struct of_phandle_args *args);
-	unsigned int		of_pwm_n_cells;
 	bool			can_sleep;
 };
=20
--=20
1.7.10.4
