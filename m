From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 01/18] drm/omap: display: use devm_of_find_backlight
Date: Thu, 14 May 2020 21:09:44 +0200
Message-ID: <20200514191001.457441-2-sam@ravnborg.org>
References: <20200514191001.457441-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20200514191001.457441-1-sam@ravnborg.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Allison Randal <allison@lohutok.net>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Enrico Weigelt <info@metux.net>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, Jyri Sarha <jsarha@ti.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael
List-Id: linux-pwm@vger.kernel.org

Look up backlight device using devm_of_find_backlight().
This simplifies the code and prevents us from hardcoding
the node name in the driver.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Zheng Bin <zhengbin13@huawei.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Enrico Weigelt <info@metux.net>
Cc: Allison Randal <allison@lohutok.net>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../gpu/drm/omapdrm/displays/panel-dsi-cm.c    | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 3484b5d4a91c..faca5c873bde 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -1163,7 +1163,7 @@ static const struct omap_dss_driver dsicm_dss_driver = {
 static int dsicm_probe_of(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct device_node *backlight;
+	struct backlight_device *backlight;
 	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
 	struct display_timing timing;
 	int err;
@@ -1216,17 +1216,15 @@ static int dsicm_probe_of(struct platform_device *pdev)
 		ddata->vddi = NULL;
 	}
 
-	backlight = of_parse_phandle(node, "backlight", 0);
-	if (backlight) {
-		ddata->extbldev = of_find_backlight_by_node(backlight);
-		of_node_put(backlight);
+	backlight = devm_of_find_backlight(&pdev->dev);
+	if (IS_ERR(backlight))
+		return PTR_ERR(backlight);
 
-		if (!ddata->extbldev)
-			return -EPROBE_DEFER;
-	} else {
-		/* assume native backlight support */
+	/* If no backlight device is found assume native backlight support */
+	if (backlight)
+		ddata->extbldev = backlight;
+	else
 		ddata->use_dsi_backlight = true;
-	}
 
 	/* TODO: ulps */
 
-- 
2.25.1
