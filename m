From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 4/5] pwm: atmel: add support for SAM9X60's PWM controller
Date: Mon, 25 Feb 2019 16:44:45 +0000
Message-ID: <1551113039-937-5-git-send-email-claudiu.beznea@microchip.com>
References: <1551113039-937-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551113039-937-1-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Claudiu.Beznea@microchip.com
List-Id: linux-pwm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add support for SAM9X60's PWM controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 4ac899d8008c..b1473ed55110 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -52,6 +52,8 @@
=20
 /* Only the LSB 16 bits are significant. */
 #define PWM_MAXV1_PRD		0xFFFF
+/* All 32 bits are significant. */
+#define PWM_MAXV2_PRD		0xFFFFFFFF
 #define PRD_MAXV1_PRES		10
=20
 struct atmel_pwm_registers {
@@ -311,6 +313,20 @@ static const struct atmel_pwm_data atmel_sama5_pwm_dat=
a =3D {
 	},
 };
=20
+static const struct atmel_pwm_data mchp_sam9x60_pwm_data =3D {
+	.regs =3D {
+		.period		=3D PWMV1_CPRD,
+		.period_upd	=3D PWMV1_CUPD,
+		.duty		=3D PWMV1_CDTY,
+		.duty_upd	=3D PWMV1_CUPD,
+	},
+	.cfg =3D {
+		/* 32 bits to keep period and duty. */
+		.max_period	=3D PWM_MAXV2_PRD,
+		.max_pres	=3D PRD_MAXV1_PRES,
+	},
+};
+
 static const struct platform_device_id atmel_pwm_devtypes[] =3D {
 	{
 		.name =3D "at91sam9rl-pwm",
@@ -335,6 +351,9 @@ static const struct of_device_id atmel_pwm_dt_ids[] =3D=
 {
 		.compatible =3D "atmel,sama5d2-pwm",
 		.data =3D &atmel_sama5_pwm_data,
 	}, {
+		.compatible =3D "microchip,sam9x60-pwm",
+		.data =3D &mchp_sam9x60_pwm_data,
+	}, {
 		/* sentinel */
 	},
 };
--=20
2.7.4
