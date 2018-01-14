From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 3/3] backlight: pwm_bl: don't use GPIOF_* with gpiod_get_direction
Date: Sun, 14 Jan 2018 22:07:10 +0100
Message-ID: <20180114210711.13863-4-wsa+renesas@sang-engineering.com>
References: <20180114210711.13863-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:36573 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752116AbeANVHk (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 14 Jan 2018 16:07:40 -0500
In-Reply-To: <20180114210711.13863-1-wsa+renesas@sang-engineering.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The documentation was wrong, gpiod_get_direction() returns 0/1 instead
of the GPIOF_* flags. The docs were fixed with commit 94fc73094abe47
("gpio: correct docs about return value of gpiod_get_direction"). Now,
fix this user (until a better, system-wide solution is in place).

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Only build tested!

 drivers/video/backlight/pwm_bl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 1c2289ddd555a6..0fa7d2bd0e4811 100644
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
