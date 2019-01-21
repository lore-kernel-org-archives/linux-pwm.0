From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH 2/4] pwm: atmel: add support for controllers with 32 bit
 counters
Date: Mon, 21 Jan 2019 12:30:53 +0000
Message-ID: <1548073783-22640-3-git-send-email-claudiu.beznea@microchip.com>
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

New SAM9X60's PWM controller use 32 bits counters thus it could generate
signals with higher period and duty cycles. Update the current driver
to work with old controller (that uses 16 bits counters) and with the
new SAM9X60's controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 7e86a5266eb6..44f4a1c9f60b 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -48,15 +48,15 @@
 #define PWMV2_CPRD		0x0C
 #define PWMV2_CPRDUPD		0x10
=20
-/*
- * Max value for duty and period
- *
- * Although the duty and period register is 32 bit,
- * however only the LSB 16 bits are significant.
- */
-#define PWM_MAX_DTY		0xFFFF
-#define PWM_MAX_PRD		0xFFFF
-#define PRD_MAX_PRES		10
+/* Max values for period and prescaler */
+
+/* Only the LSB 16 bits are significant. */
+#define PWM_MAXV1_PRD		0xFFFF
+
+/* All 32 bits are significant. */
+#define PWM_MAXV2_PRD		0xFFFFFFFF
+
+#define PRD_MAXV1_PRES		10
=20
 struct atmel_pwm_registers {
 	u8 period;
@@ -65,8 +65,14 @@ struct atmel_pwm_registers {
 	u8 duty_upd;
 };
=20
+struct atmel_pwm_config {
+	u32 max_period;
+	u32 max_pres;
+};
+
 struct atmel_pwm_data {
 	struct atmel_pwm_registers regs;
+	struct atmel_pwm_config cfg;
 };
=20
 struct atmel_pwm_chip {
@@ -125,10 +131,10 @@ static int atmel_pwm_calculate_cprd_and_pres(struct p=
wm_chip *chip,
 	cycles *=3D clk_get_rate(atmel_pwm->clk);
 	do_div(cycles, NSEC_PER_SEC);
=20
-	for (*pres =3D 0; cycles > PWM_MAX_PRD; cycles >>=3D 1)
+	for (*pres =3D 0; cycles > atmel_pwm->data->cfg.max_period; cycles >>=3D =
1)
 		(*pres)++;
=20
-	if (*pres > PRD_MAX_PRES) {
+	if (*pres > atmel_pwm->data->cfg.max_pres) {
 		dev_err(chip->dev, "pres exceeds the maximum value\n");
 		return -EINVAL;
 	}
@@ -288,6 +294,11 @@ static const struct atmel_pwm_data atmel_pwm_data_v1 =
=3D {
 		.duty		=3D PWMV1_CDTY,
 		.duty_upd	=3D PWMV1_CUPD,
 	},
+	.cfg =3D {
+		/* 16 bits to keep period and duty. */
+		.max_period	=3D PWM_MAXV1_PRD,
+		.max_pres	=3D PRD_MAXV1_PRES,
+	},
 };
=20
 static const struct atmel_pwm_data atmel_pwm_data_v2 =3D {
@@ -297,6 +308,11 @@ static const struct atmel_pwm_data atmel_pwm_data_v2 =
=3D {
 		.duty		=3D PWMV2_CDTY,
 		.duty_upd	=3D PWMV2_CDTYUPD,
 	},
+	.cfg =3D {
+		/* 16 bits to keep period and duty. */
+		.max_period	=3D PWM_MAXV1_PRD,
+		.max_pres	=3D PRD_MAXV1_PRES,
+	},
 };
=20
 static const struct platform_device_id atmel_pwm_devtypes[] =3D {
--=20
2.7.4
