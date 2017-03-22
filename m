From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] backlight: pwm_bl: Fix GPIO out for unimplemented .get_direction()
Date: Wed, 22 Mar 2017 18:21:25 +0100
Message-ID: <1490203285-28324-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pwm@vger.kernel.org

Commit 7613c922315e308a ("backlight: pwm_bl: Move the checks for initial
power state to a separate function") not just moved some code, but made
slight changes in semantics.

If a gpiochip doesn't implement the optional .get_direction() callback,
gpiod_get_direction always returns -EINVAL, which is never equal to
GPIOF_DIR_IN, leading to the GPIO not being configured for output.

To avoid this, invert the test and check for not GPIOF_DIR_OUT instead,
like the original code did.

This restores the display on r8a7740/armadillo.

Fixes: 7613c922315e308a ("backlight: pwm_bl: Move the checks for initial power state to a separate function")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/video/backlight/pwm_bl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index d7efcb632f7d9dde..002f1ce22bd02032 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -297,14 +297,15 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * If the GPIO is configured as input, change the direction to output
-	 * and set the GPIO as active.
+	 * If the GPIO is not known to be already configured as output, that
+	 * is, if gpiod_get_direction returns either GPIOF_DIR_IN or -EINVAL,
+	 * change the direction to output and set the GPIO as active.
 	 * Do not force the GPIO to active when it was already output as it
 	 * could cause backlight flickering or we would enable the backlight too
 	 * early. Leave the decision of the initial backlight state for later.
 	 */
 	if (pb->enable_gpio &&
-	    gpiod_get_direction(pb->enable_gpio) == GPIOF_DIR_IN)
+	    gpiod_get_direction(pb->enable_gpio) != GPIOF_DIR_OUT)
 		gpiod_direction_output(pb->enable_gpio, 1);
 
 	pb->power_supply = devm_regulator_get(&pdev->dev, "power");
-- 
2.7.4
