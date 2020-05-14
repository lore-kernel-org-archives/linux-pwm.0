From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 03/18] video: amba-clcd: use devm_of_find_backlight
Date: Thu, 14 May 2020 21:09:46 +0200
Message-ID: <20200514191001.457441-4-sam@ravnborg.org>
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
Cc: Russell King <linux@armlinux.org.uk>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Douglas Anderson <dianders@chromium.org>
---
 drivers/video/fbdev/amba-clcd.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index c3d55fc6c4e0..b7682de412d8 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -602,20 +602,17 @@ static int clcdfb_snprintf_mode(char *buf, int size, struct fb_videomode *mode)
 			mode->refresh);
 }
 
-static int clcdfb_of_get_backlight(struct device_node *panel,
+static int clcdfb_of_get_backlight(struct device *dev,
 				   struct clcd_panel *clcd_panel)
 {
-	struct device_node *backlight;
+	struct backlight_device *backlight;
 
-	/* Look up the optional backlight phandle */
-	backlight = of_parse_phandle(panel, "backlight", 0);
-	if (backlight) {
-		clcd_panel->backlight = of_find_backlight_by_node(backlight);
-		of_node_put(backlight);
+	/* Look up the optional backlight device */
+	backlight = devm_of_find_backlight(dev);
+	if (IS_ERR(backlight))
+		return PTR_ERR(backlight);
 
-		if (!clcd_panel->backlight)
-			return -EPROBE_DEFER;
-	}
+	clcd_panel->backlight = backlight;
 	return 0;
 }
 
@@ -717,7 +714,7 @@ static int clcdfb_of_init_display(struct clcd_fb *fb)
 	if (!panel)
 		return -ENODEV;
 
-	err = clcdfb_of_get_backlight(panel, fb->panel);
+	err = clcdfb_of_get_backlight(&fb->dev->dev, fb->panel);
 	if (err)
 		return err;
 
-- 
2.25.1
