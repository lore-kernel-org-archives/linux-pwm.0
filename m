From: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [PATCH v2 09/16] drivers: pwm: core: add PWM mode to pwm_config()
Date: Fri, 12 Jan 2018 16:22:56 +0200
Message-ID: <1515766983-15151-10-git-send-email-claudiu.beznea@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1515766983-15151-1-git-send-email-claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org, haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Add PWM mode to pwm_config() function. The drivers which uses pwm_config()
were adapted to this change.

Signed-off-by: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
---
 arch/arm/mach-s3c24xx/mach-rx1950.c  | 5 +++--
 drivers/bus/ts-nbus.c                | 2 +-
 drivers/clk/clk-pwm.c                | 3 ++-
 drivers/gpu/drm/i915/intel_panel.c   | 8 +++++---
 drivers/hwmon/pwm-fan.c              | 2 +-
 drivers/input/misc/max77693-haptic.c | 2 +-
 drivers/input/misc/max8997_haptic.c  | 3 ++-
 drivers/leds/leds-pwm.c              | 2 +-
 drivers/media/rc/ir-rx51.c           | 2 +-
 drivers/media/rc/pwm-ir-tx.c         | 2 +-
 drivers/video/backlight/lm3630a_bl.c | 2 +-
 drivers/video/backlight/lp855x_bl.c  | 2 +-
 drivers/video/backlight/lp8788_bl.c  | 2 +-
 drivers/video/backlight/pwm_bl.c     | 4 ++--
 drivers/video/fbdev/ssd1307fb.c      | 3 ++-
 include/linux/pwm.h                  | 4 +++-
 16 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index e86ad6a68a0b..9ee0ed9ff37e 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -433,14 +433,15 @@ static void rx1950_lcd_power(int enable)
 
 		/* GPB1->OUTPUT, GPB1->0 */
 		gpio_direction_output(S3C2410_GPB(1), 0);
-		pwm_config(lcd_pwm, 0, LCD_PWM_PERIOD);
+		pwm_config(lcd_pwm, 0, LCD_PWM_PERIOD, PWM_MODE_NORMAL);
 		pwm_disable(lcd_pwm);
 
 		/* GPC0->0, GPC10->0 */
 		gpio_direction_output(S3C2410_GPC(0), 0);
 		gpio_direction_output(S3C2410_GPC(10), 0);
 	} else {
-		pwm_config(lcd_pwm, LCD_PWM_DUTY, LCD_PWM_PERIOD);
+		pwm_config(lcd_pwm, LCD_PWM_DUTY, LCD_PWM_PERIOD,
+			   PWM_MODE_NORMAL);
 		pwm_enable(lcd_pwm);
 
 		gpio_direction_output(S3C2410_GPC(0), 1);
diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index 073fd9011154..dcd2ca3bcd99 100644
--- a/drivers/bus/ts-nbus.c
+++ b/drivers/bus/ts-nbus.c
@@ -316,7 +316,7 @@ static int ts_nbus_probe(struct platform_device *pdev)
 	 * the atomic PWM API.
 	 */
 	pwm_apply_args(pwm);
-	ret = pwm_config(pwm, pargs.period, pargs.period);
+	ret = pwm_config(pwm, pargs.period, pargs.period, pargs.mode);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
index 8cb9d117fdbf..605a6bffe893 100644
--- a/drivers/clk/clk-pwm.c
+++ b/drivers/clk/clk-pwm.c
@@ -92,7 +92,8 @@ static int clk_pwm_probe(struct platform_device *pdev)
 	 * atomic PWM API.
 	 */
 	pwm_apply_args(pwm);
-	ret = pwm_config(pwm, (pargs.period + 1) >> 1, pargs.period);
+	ret = pwm_config(pwm, (pargs.period + 1) >> 1, pargs.period,
+			 pargs.mode);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/gpu/drm/i915/intel_panel.c b/drivers/gpu/drm/i915/intel_panel.c
index adc51e452e3e..1ea93ebd3e56 100644
--- a/drivers/gpu/drm/i915/intel_panel.c
+++ b/drivers/gpu/drm/i915/intel_panel.c
@@ -634,7 +634,8 @@ static void pwm_set_backlight(const struct drm_connector_state *conn_state, u32
 	struct intel_panel *panel = &to_intel_connector(conn_state->connector)->panel;
 	int duty_ns = DIV_ROUND_UP(level * CRC_PMIC_PWM_PERIOD_NS, 100);
 
-	pwm_config(panel->backlight.pwm, duty_ns, CRC_PMIC_PWM_PERIOD_NS);
+	pwm_config(panel->backlight.pwm, duty_ns, CRC_PMIC_PWM_PERIOD_NS,
+		   PWM_MODE_NORMAL);
 }
 
 static void
@@ -823,7 +824,8 @@ static void pwm_disable_backlight(const struct drm_connector_state *old_conn_sta
 	struct intel_panel *panel = &connector->panel;
 
 	/* Disable the backlight */
-	pwm_config(panel->backlight.pwm, 0, CRC_PMIC_PWM_PERIOD_NS);
+	pwm_config(panel->backlight.pwm, 0, CRC_PMIC_PWM_PERIOD_NS,
+		   PWM_MODE_NORMAL);
 	usleep_range(2000, 3000);
 	pwm_disable(panel->backlight.pwm);
 }
@@ -1771,7 +1773,7 @@ static int pwm_setup_backlight(struct intel_connector *connector,
 	pwm_apply_args(panel->backlight.pwm);
 
 	retval = pwm_config(panel->backlight.pwm, CRC_PMIC_PWM_PERIOD_NS,
-			    CRC_PMIC_PWM_PERIOD_NS);
+			    CRC_PMIC_PWM_PERIOD_NS, PWM_MODE_NORMAL);
 	if (retval < 0) {
 		DRM_ERROR("Failed to configure the pwm chip\n");
 		pwm_put(panel->backlight.pwm);
diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 70cc0d134f3c..bd05cd81d3d5 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -308,7 +308,7 @@ static int pwm_fan_resume(struct device *dev)
 
 	pwm_get_args(ctx->pwm, &pargs);
 	duty = DIV_ROUND_UP(ctx->pwm_value * (pargs.period - 1), MAX_PWM);
-	ret = pwm_config(ctx->pwm, duty, pargs.period);
+	ret = pwm_config(ctx->pwm, duty, pargs.period, pargs.mode);
 	if (ret)
 		return ret;
 	return pwm_enable(ctx->pwm);
diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index 46b0f48fbf49..5fe2ff2b408b 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -76,7 +76,7 @@ static int max77693_haptic_set_duty_cycle(struct max77693_haptic *haptic)
 
 	pwm_get_args(haptic->pwm_dev, &pargs);
 	delta = (pargs.period + haptic->pwm_duty) / 2;
-	error = pwm_config(haptic->pwm_dev, delta, pargs.period);
+	error = pwm_config(haptic->pwm_dev, delta, pargs.period, pargs.mode);
 	if (error) {
 		dev_err(haptic->dev, "failed to configure pwm: %d\n", error);
 		return error;
diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/max8997_haptic.c
index 99bc762881d5..c16be1e410c6 100644
--- a/drivers/input/misc/max8997_haptic.c
+++ b/drivers/input/misc/max8997_haptic.c
@@ -73,7 +73,8 @@ static int max8997_haptic_set_duty_cycle(struct max8997_haptic *chip)
 
 	if (chip->mode == MAX8997_EXTERNAL_MODE) {
 		unsigned int duty = chip->pwm_period * chip->level / 100;
-		ret = pwm_config(chip->pwm, duty, chip->pwm_period);
+		ret = pwm_config(chip->pwm, duty, chip->pwm_period,
+				 PWM_MODE_NORMAL);
 	} else {
 		int i;
 		u8 duty_index = 0;
diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 8d456dc6c5bf..4d7a55db046a 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -40,7 +40,7 @@ static void __led_pwm_set(struct led_pwm_data *led_dat)
 {
 	int new_duty = led_dat->duty;
 
-	pwm_config(led_dat->pwm, new_duty, led_dat->period);
+	pwm_config(led_dat->pwm, new_duty, led_dat->period, PWM_MODE_NORMAL);
 
 	if (new_duty == 0)
 		pwm_disable(led_dat->pwm);
diff --git a/drivers/media/rc/ir-rx51.c b/drivers/media/rc/ir-rx51.c
index 49265f02e772..0667aa9f1566 100644
--- a/drivers/media/rc/ir-rx51.c
+++ b/drivers/media/rc/ir-rx51.c
@@ -58,7 +58,7 @@ static int init_timing_params(struct ir_rx51 *ir_rx51)
 
 	duty = DIV_ROUND_CLOSEST(ir_rx51->duty_cycle * period, 100);
 
-	pwm_config(pwm, duty, period);
+	pwm_config(pwm, duty, period, PWM_MODE_NORMAL);
 
 	return 0;
 }
diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index 27d0f5837a76..4829b09f3a0b 100644
--- a/drivers/media/rc/pwm-ir-tx.c
+++ b/drivers/media/rc/pwm-ir-tx.c
@@ -68,7 +68,7 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
 	period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
 	duty = DIV_ROUND_CLOSEST(pwm_ir->duty_cycle * period, 100);
 
-	pwm_config(pwm, duty, period);
+	pwm_config(pwm, duty, period, PWM_MODE_NORMAL);
 
 	edge = ktime_get();
 
diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 2030a6b77a09..9992aa9c4cf5 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -166,7 +166,7 @@ static void lm3630a_pwm_ctrl(struct lm3630a_chip *pchip, int br, int br_max)
 	unsigned int period = pchip->pdata->pwm_period;
 	unsigned int duty = br * period / br_max;
 
-	pwm_config(pchip->pwmd, duty, period);
+	pwm_config(pchip->pwmd, duty, period, PWM_MODE_NORMAL);
 	if (duty)
 		pwm_enable(pchip->pwmd);
 	else
diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index 939f057836e1..018be55d762c 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -256,7 +256,7 @@ static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
 		pwm_apply_args(pwm);
 	}
 
-	pwm_config(lp->pwm, duty, period);
+	pwm_config(lp->pwm, duty, period, PWM_MODE_NORMAL);
 	if (duty)
 		pwm_enable(lp->pwm);
 	else
diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backlight/lp8788_bl.c
index cf869ec90cce..cb49f34a7f2e 100644
--- a/drivers/video/backlight/lp8788_bl.c
+++ b/drivers/video/backlight/lp8788_bl.c
@@ -153,7 +153,7 @@ static void lp8788_pwm_ctrl(struct lp8788_bl *bl, int br, int max_br)
 		pwm_apply_args(pwm);
 	}
 
-	pwm_config(bl->pwm, duty, period);
+	pwm_config(bl->pwm, duty, period, PWM_MODE_NORMAL);
 	if (duty)
 		pwm_enable(bl->pwm);
 	else
diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 1c2289ddd555..ec5215c4c937 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -66,7 +66,7 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 	if (!pb->enabled)
 		return;
 
-	pwm_config(pb->pwm, 0, pb->period);
+	pwm_config(pb->pwm, 0, pb->period, PWM_MODE_NORMAL);
 	pwm_disable(pb->pwm);
 
 	if (pb->enable_gpio)
@@ -108,7 +108,7 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 
 	if (brightness > 0) {
 		duty_cycle = compute_duty_cycle(pb, brightness);
-		pwm_config(pb->pwm, duty_cycle, pb->period);
+		pwm_config(pb->pwm, duty_cycle, pb->period, PWM_MODE_NORMAL);
 		pwm_backlight_power_on(pb, brightness);
 	} else
 		pwm_backlight_power_off(pb);
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index f599520374dd..9cf17721e6e2 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -308,7 +308,8 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 
 		par->pwm_period = pargs.period;
 		/* Enable the PWM */
-		pwm_config(par->pwm, par->pwm_period / 2, par->pwm_period);
+		pwm_config(par->pwm, par->pwm_period / 2, par->pwm_period,
+			   PWM_MODE_NORMAL);
 		pwm_enable(par->pwm);
 
 		dev_dbg(&par->client->dev, "Using PWM%d with a %dns period.\n",
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 0fdc680651aa..2e8dfc3ea516 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -375,11 +375,12 @@ int pwm_adjust_config(struct pwm_device *pwm);
  * @pwm: PWM device
  * @duty_ns: "on" time (in nanoseconds)
  * @period_ns: duration (in nanoseconds) of one cycle
+ * @mode: PWM mode
  *
  * Returns: 0 on success or a negative error code on failure.
  */
 static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
-			     int period_ns)
+			     int period_ns, enum pwm_mode mode)
 {
 	struct pwm_state state;
 
@@ -395,6 +396,7 @@ static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
 
 	state.duty_cycle = duty_ns;
 	state.period = period_ns;
+	state.mode = mode;
 	return pwm_apply_state(pwm, &state);
 }
 
-- 
2.7.4
