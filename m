From: Arnd Bergmann <arnd@arndb.de>
Subject: [BACKPORT 4.14.y 7/8] pwm-backlight: Enable/disable the PWM before/after LCD enable toggle.
Date: Fri, 22 Mar 2019 17:17:22 +0100
Message-ID: <20190322161727.1153278-8-arnd@arndb.de>
References: <20190322161727.1153278-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190322161727.1153278-1-arnd@arndb.de>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Before this patch the enable signal was set before the PWM signal and
vice-versa on power off. This sequence is wrong, at least, it is on
the different panels datasheets that I checked, so I inverted the sequence
to follow the specs.

For reference the following panels have the mentioned sequence:
  - N133HSE-EA1 (Innolux)
  - N116BGE (Innolux)
  - N156BGE-L21 (Innolux)
  - B101EAN0 (Auo)
  - B101AW03 (Auo)
  - LTN101NT05 (Samsung)
  - CLAA101WA01A (Chunghwa)

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
(cherry picked from commit 5fb5caee92ba35a4a3baa61d45a78eb057e2c031)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/backlight/pwm_bl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 0fa7d2bd0e48..155153ecb894 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -54,10 +54,11 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
 	if (err < 0)
 		dev_err(pb->dev, "failed to enable power supply\n");
 
+	pwm_enable(pb->pwm);
+
 	if (pb->enable_gpio)
 		gpiod_set_value_cansleep(pb->enable_gpio, 1);
 
-	pwm_enable(pb->pwm);
 	pb->enabled = true;
 }
 
@@ -66,12 +67,12 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 	if (!pb->enabled)
 		return;
 
-	pwm_config(pb->pwm, 0, pb->period);
-	pwm_disable(pb->pwm);
-
 	if (pb->enable_gpio)
 		gpiod_set_value_cansleep(pb->enable_gpio, 0);
 
+	pwm_config(pb->pwm, 0, pb->period);
+	pwm_disable(pb->pwm);
+
 	regulator_disable(pb->power_supply);
 	pb->enabled = false;
 }
-- 
2.20.0
