From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [RFC PATCH 08/15] backlight: pwm_bl: remove useless call to pwm_set_period
Date: Wed,  1 Jul 2015 10:21:54 +0200
Message-ID: <1435738921-25027-9-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:34331 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753282AbbGAIWW (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Jul 2015 04:22:22 -0400
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>, Boris Brezillon <boris.brezillon@free-electrons.com>

The PWM period will be set when calling pwm_config. Remove this useless
call to pwm_set_period, which might mess up with the initial PWM state
once we have added proper support for PWM init state retrieval.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/video/backlight/pwm_bl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index ae498c1..fe5597c 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -295,10 +295,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	 * via the PWM lookup table.
 	 */
 	pb->period = pwm_get_default_period(pb->pwm);
-	if (!pb->period && (data->pwm_period_ns > 0)) {
+	if (!pb->period && (data->pwm_period_ns > 0))
 		pb->period = data->pwm_period_ns;
-		pwm_set_period(pb->pwm, data->pwm_period_ns);
-	}
 
 	pb->lth_brightness = data->lth_brightness * (pb->period / pb->scale);
 
-- 
1.9.1
