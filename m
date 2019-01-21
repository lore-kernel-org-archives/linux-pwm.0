From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH 3/4] pwm: atmel: add support for SAM9X60's PWM controller
Date: Mon, 21 Jan 2019 12:30:57 +0000
Message-ID: <1548073783-22640-4-git-send-email-claudiu.beznea@microchip.com>
References: <1548073783-22640-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548073783-22640-1-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Claudiu.Beznea@microchip.com
List-Id: linux-pwm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add support for SAM9X60's PWM controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 44f4a1c9f60b..44a99ba60e11 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -315,6 +315,20 @@ static const struct atmel_pwm_data atmel_pwm_data_v2 =
=3D {
 	},
 };
=20
+static const struct atmel_pwm_data atmel_pwm_data_v3 =3D {
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
@@ -339,6 +353,9 @@ static const struct of_device_id atmel_pwm_dt_ids[] =3D=
 {
 		.compatible =3D "atmel,sama5d2-pwm",
 		.data =3D &atmel_pwm_data_v2,
 	}, {
+		.compatible =3D "microchip,sam9x60-pwm",
+		.data =3D &atmel_pwm_data_v3,
+	}, {
 		/* sentinel */
 	},
 };
--=20
2.7.4
