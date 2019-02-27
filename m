From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH 5/7] pwm: atmel-hlcdc: add compatible for SAM9X60 HLCDC's PWM
Date: Wed, 27 Feb 2019 16:24:35 +0000
Message-ID: <1551284609-14594-6-git-send-email-claudiu.beznea@microchip.com>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, bbrezillon@kernel.org, airlied@linux.ie, daniel@ffwll.ch, thierry.reding@gmail.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, Claudiu.Beznea@microchip.com
List-Id: linux-pwm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add compatible string for SAM9X60 HLCDC's PWM.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 54c6633d9b5d..331ca0233d9e 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -246,6 +246,9 @@ static const struct of_device_id atmel_hlcdc_dt_ids[] =
=3D {
 		.compatible =3D "atmel,sama5d4-hlcdc",
 		.data =3D &atmel_hlcdc_pwm_sama5d3_errata,
 	},
+	{
+		.compatible =3D "microchip,sam9x60-hlcdc",
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, atmel_hlcdc_dt_ids);
--=20
2.7.4
