From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH 1/7] drm: atmel-hlcdc: add config option for clock selection
Date: Wed, 27 Feb 2019 16:24:16 +0000
Message-ID: <1551284609-14594-2-git-send-email-claudiu.beznea@microchip.com>
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

SAM9x60 LCD Controller has no option to select clock source as previous
controllers have. To be able to use the same driver even for this LCD
controller add a config option to know if controller supports this.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 12 +++++++-----
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h   |  2 ++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/d=
rm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 8070a558d7b1..17a7a18f6a07 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -78,7 +78,8 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crt=
c *c)
 	unsigned long mode_rate;
 	struct videomode vm;
 	unsigned long prate;
-	unsigned int cfg;
+	unsigned int mask =3D ATMEL_HLCDC_CLKDIV_MASK | ATMEL_HLCDC_CLKPOL;
+	unsigned int cfg =3D 0;
 	int div;
=20
 	vm.vfront_porch =3D adj->crtc_vsync_start - adj->crtc_vdisplay;
@@ -101,7 +102,10 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_=
crtc *c)
 		     (adj->crtc_hdisplay - 1) |
 		     ((adj->crtc_vdisplay - 1) << 16));
=20
-	cfg =3D ATMEL_HLCDC_CLKSEL;
+	if (!crtc->dc->desc->fixed_clksrc) {
+		cfg =3D ATMEL_HLCDC_CLKSEL;
+		mask |=3D ATMEL_HLCDC_CLKSEL;
+	}
=20
 	prate =3D 2 * clk_get_rate(crtc->dc->hlcdc->sys_clk);
 	mode_rate =3D adj->crtc_clock * 1000;
@@ -132,9 +136,7 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_c=
rtc *c)
=20
 	cfg |=3D ATMEL_HLCDC_CLKDIV(div);
=20
-	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(0),
-			   ATMEL_HLCDC_CLKSEL | ATMEL_HLCDC_CLKDIV_MASK |
-			   ATMEL_HLCDC_CLKPOL, cfg);
+	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(0), mask, cfg);
=20
 	cfg =3D 0;
=20
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm=
/atmel-hlcdc/atmel_hlcdc_dc.h
index 70bd540d644e..0155efb9c443 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -328,6 +328,7 @@ atmel_hlcdc_layer_to_plane(struct atmel_hlcdc_layer *la=
yer)
  * @max_hpw: maximum horizontal back/front porch width
  * @conflicting_output_formats: true if RGBXXX output formats conflict wit=
h
  *				each other.
+ * @fixed_clksrc: true if clock source is fixed
  * @layers: a layer description table describing available layers
  * @nlayers: layer description table size
  */
@@ -340,6 +341,7 @@ struct atmel_hlcdc_dc_desc {
 	int max_vpw;
 	int max_hpw;
 	bool conflicting_output_formats;
+	bool fixed_clksrc;
 	const struct atmel_hlcdc_layer_desc *layers;
 	int nlayers;
 };
--=20
2.7.4
