From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH RESEND] backlight: pwm_bl: don't use GPIOF_* with gpiod_get_direction
Date: Tue, 10 Apr 2018 14:32:40 +0200
Message-ID: <20180410123241.25745-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

The documentation was wrong, gpiod_get_direction() returns 0/1 instead
of the GPIOF_* flags. The docs were fixed with commit 94fc73094abe47
("gpio: correct docs about return value of gpiod_get_direction"). Now,
fix this user (until a better, system-wide solution is in place).

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Changes since V1:
	* rebased to top-of-linus-tree
	* added tag from Daniel, thanks!

Through which tree does this need to go?

 drivers/video/backlight/pwm_bl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 1c2289ddd555..0fa7d2bd0e48 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -301,14 +301,14 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 	/*
 	 * If the GPIO is not known to be already configured as output, that
-	 * is, if gpiod_get_direction returns either GPIOF_DIR_IN or -EINVAL,
-	 * change the direction to output and set the GPIO as active.
+	 * is, if gpiod_get_direction returns either 1 or -EINVAL, change the
+	 * direction to output and set the GPIO as active.
 	 * Do not force the GPIO to active when it was already output as it
 	 * could cause backlight flickering or we would enable the backlight too
 	 * early. Leave the decision of the initial backlight state for later.
 	 */
 	if (pb->enable_gpio &&
-	    gpiod_get_direction(pb->enable_gpio) != GPIOF_DIR_OUT)
+	    gpiod_get_direction(pb->enable_gpio) != 0)
 		gpiod_direction_output(pb->enable_gpio, 1);
 
 	pb->power_supply = devm_regulator_get(&pdev->dev, "power");
-- 
2.11.0
