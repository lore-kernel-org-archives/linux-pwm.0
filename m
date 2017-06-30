From: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH v2 2/4] pwm-backlight: add support for pwm-delay-us property
Date: Fri, 30 Jun 2017 13:21:07 +0200
Message-ID: <20170630112109.13785-2-enric.balletbo@collabora.com>
References: <20170630112109.13785-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20170630112109.13785-1-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <jacek.anaszewski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, huang lin <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

From: huang lin <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Some panels (i.e. N116BGE-L41), in their power sequence specifications,
request a delay between set the PWM signal and enable the backlight and
between clear the PWM signal and disable the backlight. Add support for
the new pwm-delay-us property to meet the timing.

Note that this patch inverts current sequence. Before this patch the
enable signal was set before the PWM signal and vice-versa on power off.

I assumed that this sequence was wrong, at least it is on different panel
datasheets that I checked, so I inverted the sequence to follow:

  On power on, set the PWM signal, wait, and set the LED_EN signal.
  On power off, clear the LED_EN signal, wait, and stop the PWM signal.

Signed-off-by: huang lin <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
---
Changes since v1:
 - As suggested by Daniel Thompson
   - Do not assume power-on delay and power-off delay will be the same
 - Move the check of dt property to the parse dt function.

v1: https://lkml.org/lkml/2017/6/28/219

 drivers/video/backlight/pwm_bl.c | 24 ++++++++++++++++++++----
 include/linux/pwm_backlight.h    |  1 +
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 002f1ce..0f5470e 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -10,6 +10,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
@@ -35,6 +36,7 @@ struct pwm_bl_data {
 	struct gpio_desc	*enable_gpio;
 	unsigned int		scale;
 	bool			legacy;
+	unsigned int		pwm_delay[2];
 	int			(*notify)(struct device *,
 					  int brightness);
 	void			(*notify_after)(struct device *,
@@ -54,10 +56,14 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
 	if (err < 0)
 		dev_err(pb->dev, "failed to enable power supply\n");
 
+	pwm_enable(pb->pwm);
+
+	if (pb->pwm_delay[0])
+		usleep_range(pb->pwm_delay[0], pb->pwm_delay[0] + 2000);
+
 	if (pb->enable_gpio)
 		gpiod_set_value_cansleep(pb->enable_gpio, 1);
 
-	pwm_enable(pb->pwm);
 	pb->enabled = true;
 }
 
@@ -66,12 +72,15 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 	if (!pb->enabled)
 		return;
 
-	pwm_config(pb->pwm, 0, pb->period);
-	pwm_disable(pb->pwm);
-
 	if (pb->enable_gpio)
 		gpiod_set_value_cansleep(pb->enable_gpio, 0);
 
+	if (pb->pwm_delay[1])
+		usleep_range(pb->pwm_delay[1], pb->pwm_delay[1] + 2000);
+
+	pwm_config(pb->pwm, 0, pb->period);
+	pwm_disable(pb->pwm);
+
 	regulator_disable(pb->power_supply);
 	pb->enabled = false;
 }
@@ -174,6 +183,12 @@ static int pwm_backlight_parse_dt(struct device *dev,
 		data->max_brightness--;
 	}
 
+	/* read pwm to enable pre/post delays from DT property */
+	ret = of_property_read_u32_array(node, "pwm-delay-us", data->pwm_delay,
+					 ARRAY_SIZE(data->pwm_delay));
+	if (ret < 0)
+		return ret;
+
 	data->enable_gpio = -EINVAL;
 	return 0;
 }
@@ -272,6 +287,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	pb->exit = data->exit;
 	pb->dev = &pdev->dev;
 	pb->enabled = false;
+	memcpy(pb->pwm_delay, data->pwm_delay, sizeof(pb->pwm_delay));
 
 	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
 						  GPIOD_ASIS);
diff --git a/include/linux/pwm_backlight.h b/include/linux/pwm_backlight.h
index efdd922..bf37131 100644
--- a/include/linux/pwm_backlight.h
+++ b/include/linux/pwm_backlight.h
@@ -13,6 +13,7 @@ struct platform_pwm_backlight_data {
 	unsigned int lth_brightness;
 	unsigned int pwm_period_ns;
 	unsigned int *levels;
+	unsigned int pwm_delay[2];
 	/* TODO remove once all users are switched to gpiod_* API */
 	int enable_gpio;
 	int (*init)(struct device *dev);
-- 
2.9.3
