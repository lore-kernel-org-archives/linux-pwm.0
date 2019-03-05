From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 6/7] drm: atmel-hlcdc: enable sys_clk during initalization.
Date: Tue, 5 Mar 2019 10:08:06 +0000
Message-ID: <1551780434-4580-7-git-send-email-claudiu.beznea@microchip.com>
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

For SAM9X60 SoC, sys_clk is through lcd_gclk clock source and this
needs to be enabled before enabling lcd_clk.

Signed-off-by: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@mi=
crochip.com>
[claudiu.beznea@microchip.com: add fixed_clksrc checks]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm=
/atmel-hlcdc/atmel_hlcdc_dc.c
index 0be13eceedba..8bf51f853721 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -625,10 +625,18 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev=
)
 	dc->hlcdc =3D dev_get_drvdata(dev->dev->parent);
 	dev->dev_private =3D dc;
=20
+	if (dc->desc->fixed_clksrc) {
+		ret =3D clk_prepare_enable(dc->hlcdc->sys_clk);
+		if (ret) {
+			dev_err(dev->dev, "failed to enable sys_clk\n");
+			goto err_destroy_wq;
+		}
+	}
+
 	ret =3D clk_prepare_enable(dc->hlcdc->periph_clk);
 	if (ret) {
 		dev_err(dev->dev, "failed to enable periph_clk\n");
-		goto err_destroy_wq;
+		goto err_sys_clk_disable;
 	}
=20
 	pm_runtime_enable(dev->dev);
@@ -664,6 +672,9 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
 err_periph_clk_disable:
 	pm_runtime_disable(dev->dev);
 	clk_disable_unprepare(dc->hlcdc->periph_clk);
+err_sys_clk_disable:
+	if (dc->desc->fixed_clksrc)
+		clk_disable_unprepare(dc->hlcdc->sys_clk);
=20
 err_destroy_wq:
 	destroy_workqueue(dc->wq);
@@ -688,6 +699,8 @@ static void atmel_hlcdc_dc_unload(struct drm_device *de=
v)
=20
 	pm_runtime_disable(dev->dev);
 	clk_disable_unprepare(dc->hlcdc->periph_clk);
+	if (dc->desc->fixed_clksrc)
+		clk_disable_unprepare(dc->hlcdc->sys_clk);
 	destroy_workqueue(dc->wq);
 }
=20
@@ -805,6 +818,8 @@ static int atmel_hlcdc_dc_drm_suspend(struct device *de=
v)
 	regmap_read(regmap, ATMEL_HLCDC_IMR, &dc->suspend.imr);
 	regmap_write(regmap, ATMEL_HLCDC_IDR, dc->suspend.imr);
 	clk_disable_unprepare(dc->hlcdc->periph_clk);
+	if (dc->desc->fixed_clksrc)
+		clk_disable_unprepare(dc->hlcdc->sys_clk);
=20
 	return 0;
 }
@@ -814,6 +829,8 @@ static int atmel_hlcdc_dc_drm_resume(struct device *dev=
)
 	struct drm_device *drm_dev =3D dev_get_drvdata(dev);
 	struct atmel_hlcdc_dc *dc =3D drm_dev->dev_private;
=20
+	if (dc->desc->fixed_clksrc)
+		clk_prepare_enable(dc->hlcdc->sys_clk);
 	clk_prepare_enable(dc->hlcdc->periph_clk);
 	regmap_write(dc->hlcdc->regmap, ATMEL_HLCDC_IER, dc->suspend.imr);
=20
--=20
2.7.4
