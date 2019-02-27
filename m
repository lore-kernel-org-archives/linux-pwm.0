From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH 2/7] drm: atmel-hlcdc: avoid initializing cfg with zero
Date: Wed, 27 Feb 2019 16:24:21 +0000
Message-ID: <1551284609-14594-3-git-send-email-claudiu.beznea@microchip.com>
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

Remove cfg initialization with zero and read state with
drm_crtc_state_to_atmel_hlcdc_crtc_state() so that cfg to be initialized
with state's output_mode.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/d=
rm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 17a7a18f6a07..7b0c6683a690 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -138,7 +138,8 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_c=
rtc *c)
=20
 	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(0), mask, cfg);
=20
-	cfg =3D 0;
+	state =3D drm_crtc_state_to_atmel_hlcdc_crtc_state(c->state);
+	cfg =3D state->output_mode << 8;
=20
 	if (adj->flags & DRM_MODE_FLAG_NVSYNC)
 		cfg |=3D ATMEL_HLCDC_VSPOL;
@@ -146,9 +147,6 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_c=
rtc *c)
 	if (adj->flags & DRM_MODE_FLAG_NHSYNC)
 		cfg |=3D ATMEL_HLCDC_HSPOL;
=20
-	state =3D drm_crtc_state_to_atmel_hlcdc_crtc_state(c->state);
-	cfg |=3D state->output_mode << 8;
-
 	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(5),
 			   ATMEL_HLCDC_HSPOL | ATMEL_HLCDC_VSPOL |
 			   ATMEL_HLCDC_VSPDLYS | ATMEL_HLCDC_VSPDLYE |
--=20
2.7.4
