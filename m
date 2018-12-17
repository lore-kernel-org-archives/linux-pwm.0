From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH v6 3/6] pwm: atmel: add pwm capabilities
Date: Mon, 17 Dec 2018 14:03:22 +0000
Message-ID: <1545055368-23338-4-git-send-email-claudiu.beznea@microchip.com>
References: <1545055368-23338-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545055368-23338-1-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, corbet@lwn.net, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, robh@kernel.org
Cc: linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Claudiu.Beznea@microchip.com
List-Id: linux-pwm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add pwm capabilities for Atmel/Microchip PWM controllers.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 86 ++++++++++++++++++++++++++++++++-------------=
----
 1 file changed, 57 insertions(+), 29 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 530d7dc5f1b5..b72cacd5dca3 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -65,18 +65,23 @@ struct atmel_pwm_registers {
 	u8 duty_upd;
 };
=20
+struct atmel_pwm_data {
+	struct atmel_pwm_registers regs;
+	struct pwm_caps caps;
+};
+
 struct atmel_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
-	const struct atmel_pwm_registers *regs;
+	const struct atmel_pwm_data *data;
=20
 	unsigned int updated_pwms;
 	/* ISR is cleared when read, ensure only one thread does that */
 	struct mutex isr_lock;
 };
=20
-static inline struct atmel_pwm_chip *to_atmel_pwm_chip(struct pwm_chip *ch=
ip)
+static inline struct atmel_pwm_chip *to_atmel_pwm_chip(const struct pwm_ch=
ip *chip)
 {
 	return container_of(chip, struct atmel_pwm_chip, chip);
 }
@@ -150,15 +155,15 @@ static void atmel_pwm_update_cdty(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
 	struct atmel_pwm_chip *atmel_pwm =3D to_atmel_pwm_chip(chip);
 	u32 val;
=20
-	if (atmel_pwm->regs->duty_upd =3D=3D
-	    atmel_pwm->regs->period_upd) {
+	if (atmel_pwm->data->regs.duty_upd =3D=3D
+	    atmel_pwm->data->regs.period_upd) {
 		val =3D atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
 		val &=3D ~PWM_CMR_UPD_CDTY;
 		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
 	}
=20
 	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm,
-			    atmel_pwm->regs->duty_upd, cdty);
+			    atmel_pwm->data->regs.duty_upd, cdty);
 }
=20
 static void atmel_pwm_set_cprd_cdty(struct pwm_chip *chip,
@@ -168,9 +173,9 @@ static void atmel_pwm_set_cprd_cdty(struct pwm_chip *ch=
ip,
 	struct atmel_pwm_chip *atmel_pwm =3D to_atmel_pwm_chip(chip);
=20
 	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm,
-			    atmel_pwm->regs->duty, cdty);
+			    atmel_pwm->data->regs.duty, cdty);
 	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm,
-			    atmel_pwm->regs->period, cprd);
+			    atmel_pwm->data->regs.period, cprd);
 }
=20
 static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pw=
m,
@@ -225,7 +230,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struc=
t pwm_device *pwm,
 		    cstate.polarity =3D=3D state->polarity &&
 		    cstate.period =3D=3D state->period) {
 			cprd =3D atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
-						  atmel_pwm->regs->period);
+						  atmel_pwm->data->regs.period);
 			atmel_pwm_calculate_cdty(state, cprd, &cdty);
 			atmel_pwm_update_cdty(chip, pwm, cdty);
 			return 0;
@@ -272,32 +277,55 @@ static int atmel_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
 	return 0;
 }
=20
+static int atmel_pwm_get_caps(const struct pwm_chip *chip,
+			      const struct pwm_device *pwm,
+			      struct pwm_caps *caps)
+{
+	struct atmel_pwm_chip *atmel_pwm =3D to_atmel_pwm_chip(chip);
+
+	*caps =3D atmel_pwm->data->caps;
+
+	return 0;
+}
+
 static const struct pwm_ops atmel_pwm_ops =3D {
 	.apply =3D atmel_pwm_apply,
+	.get_caps =3D atmel_pwm_get_caps,
 	.owner =3D THIS_MODULE,
 };
=20
-static const struct atmel_pwm_registers atmel_pwm_regs_v1 =3D {
-	.period		=3D PWMV1_CPRD,
-	.period_upd	=3D PWMV1_CUPD,
-	.duty		=3D PWMV1_CDTY,
-	.duty_upd	=3D PWMV1_CUPD,
+static const struct atmel_pwm_data atmel_pwm_data_v1 =3D {
+	.regs =3D {
+		.period		=3D PWMV1_CPRD,
+		.period_upd	=3D PWMV1_CUPD,
+		.duty		=3D PWMV1_CDTY,
+		.duty_upd	=3D PWMV1_CUPD,
+	},
+	.caps =3D {
+		.modes_msk =3D PWM_MODE_BIT(NORMAL),
+	},
 };
=20
-static const struct atmel_pwm_registers atmel_pwm_regs_v2 =3D {
-	.period		=3D PWMV2_CPRD,
-	.period_upd	=3D PWMV2_CPRDUPD,
-	.duty		=3D PWMV2_CDTY,
-	.duty_upd	=3D PWMV2_CDTYUPD,
+static const struct atmel_pwm_data atmel_pwm_data_v2 =3D {
+	.regs =3D {
+		.period		=3D PWMV2_CPRD,
+		.period_upd	=3D PWMV2_CPRDUPD,
+		.duty		=3D PWMV2_CDTY,
+		.duty_upd	=3D PWMV2_CDTYUPD,
+	},
+	.caps =3D {
+		.modes_msk =3D PWM_MODE_BIT(NORMAL) |
+			     PWM_MODE_BIT(COMPLEMENTARY),
+	},
 };
=20
 static const struct platform_device_id atmel_pwm_devtypes[] =3D {
 	{
 		.name =3D "at91sam9rl-pwm",
-		.driver_data =3D (kernel_ulong_t)&atmel_pwm_regs_v1,
+		.driver_data =3D (kernel_ulong_t)&atmel_pwm_data_v1,
 	}, {
 		.name =3D "sama5d3-pwm",
-		.driver_data =3D (kernel_ulong_t)&atmel_pwm_regs_v2,
+		.driver_data =3D (kernel_ulong_t)&atmel_pwm_data_v2,
 	}, {
 		/* sentinel */
 	},
@@ -307,20 +335,20 @@ MODULE_DEVICE_TABLE(platform, atmel_pwm_devtypes);
 static const struct of_device_id atmel_pwm_dt_ids[] =3D {
 	{
 		.compatible =3D "atmel,at91sam9rl-pwm",
-		.data =3D &atmel_pwm_regs_v1,
+		.data =3D &atmel_pwm_data_v1,
 	}, {
 		.compatible =3D "atmel,sama5d3-pwm",
-		.data =3D &atmel_pwm_regs_v2,
+		.data =3D &atmel_pwm_data_v2,
 	}, {
 		.compatible =3D "atmel,sama5d2-pwm",
-		.data =3D &atmel_pwm_regs_v2,
+		.data =3D &atmel_pwm_data_v2,
 	}, {
 		/* sentinel */
 	},
 };
 MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
=20
-static inline const struct atmel_pwm_registers *
+static inline const struct atmel_pwm_data *
 atmel_pwm_get_driver_data(struct platform_device *pdev)
 {
 	const struct platform_device_id *id;
@@ -330,18 +358,18 @@ atmel_pwm_get_driver_data(struct platform_device *pde=
v)
=20
 	id =3D platform_get_device_id(pdev);
=20
-	return (struct atmel_pwm_registers *)id->driver_data;
+	return (struct atmel_pwm_data *)id->driver_data;
 }
=20
 static int atmel_pwm_probe(struct platform_device *pdev)
 {
-	const struct atmel_pwm_registers *regs;
+	const struct atmel_pwm_data *data;
 	struct atmel_pwm_chip *atmel_pwm;
 	struct resource *res;
 	int ret;
=20
-	regs =3D atmel_pwm_get_driver_data(pdev);
-	if (!regs)
+	data =3D atmel_pwm_get_driver_data(pdev);
+	if (!data)
 		return -ENODEV;
=20
 	atmel_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*atmel_pwm), GFP_KERNEL);
@@ -373,7 +401,7 @@ static int atmel_pwm_probe(struct platform_device *pdev=
)
=20
 	atmel_pwm->chip.base =3D -1;
 	atmel_pwm->chip.npwm =3D 4;
-	atmel_pwm->regs =3D regs;
+	atmel_pwm->data =3D data;
 	atmel_pwm->updated_pwms =3D 0;
 	mutex_init(&atmel_pwm->isr_lock);
=20
--=20
2.7.4
