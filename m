From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 7/7] drm: atmel-hlcdc: add sam9x60 LCD controller
Date: Tue, 5 Mar 2019 10:08:11 +0000
Message-ID: <1551780434-4580-8-git-send-email-claudiu.beznea@microchip.com>
References: <1551780434-4580-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551780434-4580-1-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, bbrezillon@kernel.org, airlied@linux.ie, daniel@ffwll.ch, thierry.reding@gmail.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, Sandeep.Sheriker@microchip.com, Claudiu.Beznea@microchip.com
List-Id: linux-pwm@vger.kernel.org

From: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.c=
om>

Add the LCD controller for SAM9X60.

Signed-off-by: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@mi=
crochip.com>
[claudiu.beznea@microchip.com: add fixed_clksrc option to
 atmel_hlcdc_dc_sam9x60]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 101 +++++++++++++++++++++++=
++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm=
/atmel-hlcdc/atmel_hlcdc_dc.c
index 8bf51f853721..fb2e7646daeb 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -364,6 +364,103 @@ static const struct atmel_hlcdc_dc_desc atmel_hlcdc_d=
c_sama5d4 =3D {
 	.nlayers =3D ARRAY_SIZE(atmel_hlcdc_sama5d4_layers),
 	.layers =3D atmel_hlcdc_sama5d4_layers,
 };
+
+static const struct atmel_hlcdc_layer_desc atmel_hlcdc_sam9x60_layers[] =
=3D {
+	{
+		.name =3D "base",
+		.formats =3D &atmel_hlcdc_plane_rgb_formats,
+		.regs_offset =3D 0x60,
+		.id =3D 0,
+		.type =3D ATMEL_HLCDC_BASE_LAYER,
+		.cfgs_offset =3D 0x2c,
+		.layout =3D {
+			.xstride =3D { 2 },
+			.default_color =3D 3,
+			.general_config =3D 4,
+			.disc_pos =3D 5,
+			.disc_size =3D 6,
+		},
+		.clut_offset =3D 0x600,
+	},
+	{
+		.name =3D "overlay1",
+		.formats =3D &atmel_hlcdc_plane_rgb_formats,
+		.regs_offset =3D 0x160,
+		.id =3D 1,
+		.type =3D ATMEL_HLCDC_OVERLAY_LAYER,
+		.cfgs_offset =3D 0x2c,
+		.layout =3D {
+			.pos =3D 2,
+			.size =3D 3,
+			.xstride =3D { 4 },
+			.pstride =3D { 5 },
+			.default_color =3D 6,
+			.chroma_key =3D 7,
+			.chroma_key_mask =3D 8,
+			.general_config =3D 9,
+		},
+		.clut_offset =3D 0xa00,
+	},
+	{
+		.name =3D "overlay2",
+		.formats =3D &atmel_hlcdc_plane_rgb_formats,
+		.regs_offset =3D 0x260,
+		.id =3D 2,
+		.type =3D ATMEL_HLCDC_OVERLAY_LAYER,
+		.cfgs_offset =3D 0x2c,
+		.layout =3D {
+			.pos =3D 2,
+			.size =3D 3,
+			.xstride =3D { 4 },
+			.pstride =3D { 5 },
+			.default_color =3D 6,
+			.chroma_key =3D 7,
+			.chroma_key_mask =3D 8,
+			.general_config =3D 9,
+		},
+		.clut_offset =3D 0xe00,
+	},
+	{
+		.name =3D "high-end-overlay",
+		.formats =3D &atmel_hlcdc_plane_rgb_and_yuv_formats,
+		.regs_offset =3D 0x360,
+		.id =3D 3,
+		.type =3D ATMEL_HLCDC_OVERLAY_LAYER,
+		.cfgs_offset =3D 0x4c,
+		.layout =3D {
+			.pos =3D 2,
+			.size =3D 3,
+			.memsize =3D 4,
+			.xstride =3D { 5, 7 },
+			.pstride =3D { 6, 8 },
+			.default_color =3D 9,
+			.chroma_key =3D 10,
+			.chroma_key_mask =3D 11,
+			.general_config =3D 12,
+			.scaler_config =3D 13,
+			.phicoeffs =3D {
+				.x =3D 17,
+				.y =3D 33,
+			},
+			.csc =3D 14,
+		},
+		.clut_offset =3D 0x1200,
+	},
+};
+
+static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_sam9x60 =3D {
+	.min_width =3D 0,
+	.min_height =3D 0,
+	.max_width =3D 2048,
+	.max_height =3D 2048,
+	.max_spw =3D 0xff,
+	.max_vpw =3D 0xff,
+	.max_hpw =3D 0x3ff,
+	.fixed_clksrc =3D true,
+	.nlayers =3D ARRAY_SIZE(atmel_hlcdc_sam9x60_layers),
+	.layers =3D atmel_hlcdc_sam9x60_layers,
+};
+
 static const struct of_device_id atmel_hlcdc_of_match[] =3D {
 	{
 		.compatible =3D "atmel,at91sam9n12-hlcdc",
@@ -385,6 +482,10 @@ static const struct of_device_id atmel_hlcdc_of_match[=
] =3D {
 		.compatible =3D "atmel,sama5d4-hlcdc",
 		.data =3D &atmel_hlcdc_dc_sama5d4,
 	},
+	{
+		.compatible =3D "microchip,sam9x60-hlcdc",
+		.data =3D &atmel_hlcdc_dc_sam9x60,
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, atmel_hlcdc_of_match);
--=20
2.7.4
