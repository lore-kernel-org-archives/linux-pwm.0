From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 4/5] backlight: pwm_bl: switch to power-of-2 base for fixed-point math
Date: Thu, 19 Sep 2019 16:06:19 +0200
Message-ID: <20190919140620.32407-4-linux@rasmusvillemoes.dk>
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Using a power-of-2 instead of power-of-10 base makes the computations
much cheaper. 2^16 is safe; retval never becomes more than 2^48 +
2^16/2. On a 32 bit platform, the very expensive 64/32 division at the
end of cie1931() instead becomes essentially free (a shift by 32 is
just a register rename).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/video/backlight/pwm_bl.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index aee6839e024a..102bc191310f 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -148,7 +148,8 @@ static const struct backlight_ops pwm_backlight_ops = {
 };
 
 #ifdef CONFIG_OF
-#define PWM_LUMINANCE_SCALE	10000 /* luminance scale */
+#define PWM_LUMINANCE_SHIFT	16
+#define PWM_LUMINANCE_SCALE	(1 << PWM_LUMINANCE_SHIFT) /* luminance scale */
 
 /*
  * CIE lightness to PWM conversion.
@@ -165,23 +166,25 @@ static const struct backlight_ops pwm_backlight_ops = {
  * The following function does the fixed point maths needed to implement the
  * above formula.
  */
-static u64 cie1931(unsigned int lightness, unsigned int scale)
+static u64 cie1931(unsigned int lightness)
 {
 	u64 retval;
 
 	/*
 	 * @lightness is given as a number between 0 and 1, expressed
-	 * as a fixed-point number in scale @scale. Convert to a
-	 * percentage, still expressed as a fixed-point number, so the
-	 * above formulas can be applied.
+	 * as a fixed-point number in scale
+	 * PWM_LUMINANCE_SCALE. Convert to a percentage, still
+	 * expressed as a fixed-point number, so the above formulas
+	 * can be applied.
 	 */
 	lightness *= 100;
-	if (lightness <= (8 * scale)) {
+	if (lightness <= (8 * PWM_LUMINANCE_SCALE)) {
 		retval = DIV_ROUND_CLOSEST(lightness * 10, 9033);
 	} else {
-		retval = (lightness + (16 * scale)) / 116;
+		retval = (lightness + (16 * PWM_LUMINANCE_SCALE)) / 116;
 		retval *= retval * retval;
-		retval = DIV_ROUND_CLOSEST_ULL(retval, (scale * scale));
+		retval += PWM_LUMINANCE_SCALE/2;
+		retval >>= 2*PWM_LUMINANCE_SHIFT;
 	}
 
 	return retval;
@@ -215,8 +218,7 @@ int pwm_backlight_brightness_default(struct device *dev,
 	/* Fill the table using the cie1931 algorithm */
 	for (i = 0; i < data->max_brightness; i++) {
 		retval = cie1931((i * PWM_LUMINANCE_SCALE) /
-				 data->max_brightness, PWM_LUMINANCE_SCALE) *
-				 period;
+				 data->max_brightness) * period;
 		retval = DIV_ROUND_CLOSEST_ULL(retval, PWM_LUMINANCE_SCALE);
 		if (retval > UINT_MAX)
 			return -EINVAL;
-- 
2.20.1
