From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 3/4] backlight: pwm_bl: drop use of int_pow()
Date: Tue,  8 Oct 2019 14:03:26 +0200
Message-ID: <20191008120327.24208-4-linux@rasmusvillemoes.dk>
References: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

For a fixed small exponent of 3, it is more efficient to simply use
two explicit multiplications rather than calling the int_pow() library
function: Aside from the function call overhead, its implementation
using repeated squaring means it ends up doing four 64x64
multiplications.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/video/backlight/pwm_bl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 672c5e7cfcd1..273d3fb628a0 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -179,7 +179,8 @@ static u64 cie1931(unsigned int lightness, unsigned int scale)
 	if (lightness <= (8 * scale)) {
 		retval = DIV_ROUND_CLOSEST(lightness * 10, 9033);
 	} else {
-		retval = int_pow((lightness + (16 * scale)) / 116, 3);
+		retval = (lightness + (16 * scale)) / 116;
+		retval *= retval * retval;
 		retval = DIV_ROUND_CLOSEST_ULL(retval, (scale * scale));
 	}
 
-- 
2.20.1
