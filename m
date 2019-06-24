From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 4/4] backlight: pwm_bl: Set scale type for brightness curves specified in the DT
Date: Mon, 24 Jun 2019 13:31:13 -0700
Message-ID: <20190624203114.93277-5-mka@chromium.org>
References: <20190624203114.93277-1-mka@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190624203114.93277-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Pavel Machek <pavel@ucw.cz>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pwm@vger.kernel.org

Check if a brightness curve specified in the device tree is linear or
not and set the corresponding property accordingly. This makes the
scale type available to userspace via the 'scale' sysfs attribute.

To determine if a curve is linear it is compared to a interpolated linear
curve between min and max brightness. The curve is considered linear if
no value deviates more than +/-5% of ${brightness_range} from their
interpolated value.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---
Changes in v2:
- use 128 (power of two) instead of 100 as factor for the slope
- add comment about max quantization error
- added Daniel's 'Acked-by' tag
---
 drivers/video/backlight/pwm_bl.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index f067fe7aa35d..2297fb4af49d 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -404,6 +404,31 @@ int pwm_backlight_brightness_default(struct device *dev,
 }
 #endif
 
+static bool pwm_backlight_is_linear(struct platform_pwm_backlight_data *data)
+{
+	unsigned int nlevels = data->max_brightness + 1;
+	unsigned int min_val = data->levels[0];
+	unsigned int max_val = data->levels[nlevels - 1];
+	/*
+	 * Multiplying by 128 means that even in pathological cases such
+	 * as (max_val - min_val) == nlevels the error at max_val is less
+	 * than 1%.
+	 */
+	unsigned int slope = (128 * (max_val - min_val)) / nlevels;
+	unsigned int margin = (max_val - min_val) / 20; /* 5% */
+	int i;
+
+	for (i = 1; i < nlevels; i++) {
+		unsigned int linear_value = min_val + ((i * slope) / 128);
+		unsigned int delta = abs(linear_value - data->levels[i]);
+
+		if (delta > margin)
+			return false;
+	}
+
+	return true;
+}
+
 static int pwm_backlight_initial_power_state(const struct pwm_bl_data *pb)
 {
 	struct device_node *node = pb->dev->of_node;
@@ -567,6 +592,11 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 			pb->levels = data->levels;
 		}
+
+		if (pwm_backlight_is_linear(data))
+			props.scale = BACKLIGHT_SCALE_LINEAR;
+		else
+			props.scale = BACKLIGHT_SCALE_NON_LINEAR;
 	} else if (!data->max_brightness) {
 		/*
 		 * If no brightness levels are provided and max_brightness is
-- 
2.22.0.410.gd8fdbe21b5-goog
