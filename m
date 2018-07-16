From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH] backlight: pwm_bl: Fix uninitialized variable
Date: Mon, 16 Jul 2018 22:02:41 +0100
Message-ID: <20180716210241.9457-1-daniel.thompson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, patches@linaro.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>
List-Id: linux-pwm@vger.kernel.org

Currently, if the DT does not define num-interpolated-steps then
num_steps is undefined and the interpolation code will deploy randomly.
Fix this.

Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between
brightness-levels")
Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---
 drivers/video/backlight/pwm_bl.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 9ee4c1b735b2..e3c22b79fbcd 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -299,15 +299,14 @@ static int pwm_backlight_parse_dt(struct device *dev,
 		 * interpolation between each of the values of brightness levels
 		 * and creates a new pre-computed table.
 		 */
-		of_property_read_u32(node, "num-interpolated-steps",
-				     &num_steps);
-
-		/*
-		 * Make sure that there is at least two entries in the
-		 * brightness-levels table, otherwise we can't interpolate
-		 * between two points.
-		 */
-		if (num_steps) {
+		if ((of_property_read_u32(node, "num-interpolated-steps",
+					  &num_steps) == 0) && num_steps) {
+			/*
+			 * Make sure that there is at least two entries in the
+			 * brightness-levels table, otherwise we can't
+			 * interpolate
+			 * between two points.
+			 */
 			if (data->max_brightness < 2) {
 				dev_err(dev, "can't interpolate\n");
 				return -EINVAL;
--
2.17.1
