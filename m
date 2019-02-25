From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 3/5] pwm: atmel: rename objects of type atmel_pwm_data
Date: Mon, 25 Feb 2019 16:44:41 +0000
Message-ID: <1551113039-937-4-git-send-email-claudiu.beznea@microchip.com>
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

Rename objects of type atmel_pwm_data to contain chip name instead of
version number.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 647d063562db..4ac899d8008c 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -283,7 +283,7 @@ static const struct pwm_ops atmel_pwm_ops =3D {
 	.owner =3D THIS_MODULE,
 };
=20
-static const struct atmel_pwm_data atmel_pwm_data_v1 =3D {
+static const struct atmel_pwm_data atmel_sam9rl_pwm_data =3D {
 	.regs =3D {
 		.period		=3D PWMV1_CPRD,
 		.period_upd	=3D PWMV1_CUPD,
@@ -297,7 +297,7 @@ static const struct atmel_pwm_data atmel_pwm_data_v1 =
=3D {
 	},
 };
=20
-static const struct atmel_pwm_data atmel_pwm_data_v2 =3D {
+static const struct atmel_pwm_data atmel_sama5_pwm_data =3D {
 	.regs =3D {
 		.period		=3D PWMV2_CPRD,
 		.period_upd	=3D PWMV2_CPRDUPD,
@@ -314,10 +314,10 @@ static const struct atmel_pwm_data atmel_pwm_data_v2 =
=3D {
 static const struct platform_device_id atmel_pwm_devtypes[] =3D {
 	{
 		.name =3D "at91sam9rl-pwm",
-		.driver_data =3D (kernel_ulong_t)&atmel_pwm_data_v1,
+		.driver_data =3D (kernel_ulong_t)&atmel_sam9rl_pwm_data,
 	}, {
 		.name =3D "sama5d3-pwm",
-		.driver_data =3D (kernel_ulong_t)&atmel_pwm_data_v2,
+		.driver_data =3D (kernel_ulong_t)&atmel_sama5_pwm_data,
 	}, {
 		/* sentinel */
 	},
@@ -327,13 +327,13 @@ MODULE_DEVICE_TABLE(platform, atmel_pwm_devtypes);
 static const struct of_device_id atmel_pwm_dt_ids[] =3D {
 	{
 		.compatible =3D "atmel,at91sam9rl-pwm",
-		.data =3D &atmel_pwm_data_v1,
+		.data =3D &atmel_sam9rl_pwm_data,
 	}, {
 		.compatible =3D "atmel,sama5d3-pwm",
-		.data =3D &atmel_pwm_data_v2,
+		.data =3D &atmel_sama5_pwm_data,
 	}, {
 		.compatible =3D "atmel,sama5d2-pwm",
-		.data =3D &atmel_pwm_data_v2,
+		.data =3D &atmel_sama5_pwm_data,
 	}, {
 		/* sentinel */
 	},
--=20
2.7.4
