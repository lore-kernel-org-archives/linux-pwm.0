From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 02/18] drm/tilcdc: use devm_of_find_backlight
Date: Thu, 14 May 2020 21:09:45 +0200
Message-ID: <20200514191001.457441-3-sam@ravnborg.org>
References: <20200514191001.457441-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730283AbgENTKU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 May 2020 15:10:20 -0400
In-Reply-To: <20200514191001.457441-1-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Allison Randal <allison@lohutok.net>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Enrico Weigelt <info@metux.net>, Jani Nikula <jani.nikula@intel.com>, Jonathan Corbet <corbet@lwn.net>, Jyri Sarha <jsarha@ti.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael

Look up backlight device using devm_of_find_backlight().
This simplifies the code and prevents us from hardcoding
the node name in the driver.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Jyri Sarha <jsarha@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_panel.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
index 12823d60c4e8..b207b2f19d42 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
@@ -299,7 +299,8 @@ static struct tilcdc_panel_info *of_get_panel_info(struct device_node *np)
 
 static int panel_probe(struct platform_device *pdev)
 {
-	struct device_node *bl_node, *node = pdev->dev.of_node;
+	struct device_node *node = pdev->dev.of_node;
+	struct backlight_device *backlight;
 	struct panel_module *panel_mod;
 	struct tilcdc_module *mod;
 	struct pinctrl *pinctrl;
@@ -315,16 +316,10 @@ static int panel_probe(struct platform_device *pdev)
 	if (!panel_mod)
 		return -ENOMEM;
 
-	bl_node = of_parse_phandle(node, "backlight", 0);
-	if (bl_node) {
-		panel_mod->backlight = of_find_backlight_by_node(bl_node);
-		of_node_put(bl_node);
-
-		if (!panel_mod->backlight)
-			return -EPROBE_DEFER;
-
-		dev_info(&pdev->dev, "found backlight\n");
-	}
+	backlight = devm_of_find_backlight(&pdev->dev);
+	if (IS_ERR(backlight))
+		return PTR_ERR(backlight);
+	panel_mod->backlight = backlight;
 
 	panel_mod->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
 							 GPIOD_OUT_LOW);
-- 
2.25.1
