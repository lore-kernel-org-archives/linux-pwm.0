From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] backlight: pwm_bl: Don't assign levels table repeatedly
Date: Wed,  2 Oct 2019 09:56:01 -0700
Message-ID: <20191002095541.v2.1.I4f2ede1f55ddd1c72b0303b7fd7f73a782fa33e5@changeid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Matthias Kaehlcke <mka@chromium.org>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

pwm_backlight_probe() re-assigns pb->levels for every brightness
level. This is not needed and was likely not intended, since
neither side of the assignment changes during the loop. Assign
the field only once.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
- removed curly braces from for loop

 drivers/video/backlight/pwm_bl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 746eebc411df..05d3b3802658 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -564,18 +564,17 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	memset(&props, 0, sizeof(struct backlight_properties));
 
 	if (data->levels) {
+		pb->levels = data->levels;
+
 		/*
 		 * For the DT case, only when brightness levels is defined
 		 * data->levels is filled. For the non-DT case, data->levels
 		 * can come from platform data, however is not usual.
 		 */
-		for (i = 0; i <= data->max_brightness; i++) {
+		for (i = 0; i <= data->max_brightness; i++)
 			if (data->levels[i] > pb->scale)
 				pb->scale = data->levels[i];
 
-			pb->levels = data->levels;
-		}
-
 		if (pwm_backlight_is_linear(data))
 			props.scale = BACKLIGHT_SCALE_LINEAR;
 		else
-- 
2.23.0.444.g18eeb5a265-goog
