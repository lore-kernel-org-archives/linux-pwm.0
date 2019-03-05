From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 4/7] mfd: atmel-hlcdc: add compatible for SAM9X60 HLCD
 controller
Date: Tue, 5 Mar 2019 10:07:52 +0000
Message-ID: <1551780434-4580-5-git-send-email-claudiu.beznea@microchip.com>
References: <1551780434-4580-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551780434-4580-1-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, bbrezillon@kernel.org, airlied@linux.ie, daniel@ffwll.ch, thierry.reding@gmail.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, Claudiu.Beznea@microchip.com
List-Id: linux-pwm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add compatible for SAM9X60 HLCD controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/mfd/atmel-hlcdc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
index e82543bcfdc8..35a9e16f9902 100644
--- a/drivers/mfd/atmel-hlcdc.c
+++ b/drivers/mfd/atmel-hlcdc.c
@@ -141,6 +141,7 @@ static const struct of_device_id atmel_hlcdc_match[] =
=3D {
 	{ .compatible =3D "atmel,sama5d2-hlcdc" },
 	{ .compatible =3D "atmel,sama5d3-hlcdc" },
 	{ .compatible =3D "atmel,sama5d4-hlcdc" },
+	{ .compatible =3D "microchip,sam9x60-hlcdc" },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, atmel_hlcdc_match);
--=20
2.7.4
