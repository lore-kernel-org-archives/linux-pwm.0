Return-Path: <sourav.poddar@ti.com>
Message-ID: <5294ACE1.9020008@ti.com>
Date: Tue, 26 Nov 2013 19:44:57 +0530
From: Sourav Poddar <sourav.poddar@ti.com>
MIME-Version: 1.0
Subject: [RFC] backlight: pwm_bl: usage of regulators for turning on of backlight.
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com, jg1.han@samsung.com
Cc: linux-pwm@vger.kernel.org, Felipe Balbi <balbi@ti.com>

Hi,

This is in regards to the following patch[1] in 3.13-rc1 kernel..

Should not the usage of 'regulator_enable' should be optional?

Without a power-supply node in dts, backlight entires does
not get populated,

[1]:
commit 22ceeee16eb8f0d04de3ef43a5174fb30ec18af9
Author: Thierry Reding <treding@nvidia.com>
Date:   Fri Aug 30 12:38:34 2013 +0200

     pwm-backlight: Add power supply support

     Backlights require a power supply to work properly. This commit adds a
     regulator to power up and power down the backlight.

     Signed-off-by: Thierry Reding <treding@nvidia.com>

diff --git 
a/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt 
b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
index 72810cc..764db86 100644
--- a/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
+++ b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
@@ -10,6 +10,7 @@ Required properties:
        last value in the array represents a 100% duty cycle (brightest).
    - default-brightness-level: the default brightness level (index into the
        array defined by the "brightness-levels" property)
+  - power-supply: regulator for supply voltage

  Optional properties:
    - pwm-names: a list of names for the PWM devices specified in the
@@ -29,5 +30,6 @@ Example:
          brightness-levels = <0 4 8 16 32 64 128 255>;
          default-brightness-level = <6>;

+        power-supply = <&vdd_bl_reg>;
          enable-gpios = <&gpio 58 0>;
      };
diff --git a/drivers/video/backlight/pwm_bl.c 
b/drivers/video/backlight/pwm_bl.c
index cdef4a3..eec6c98 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -21,6 +21,7 @@
  #include <linux/err.h>
  #include <linux/pwm.h>
  #include <linux/pwm_backlight.h>
+#include <linux/regulator/consumer.h>
  #include <linux/slab.h>

  struct pwm_bl_data {
@@ -30,6 +31,7 @@ struct pwm_bl_data {
      unsigned int        lth_brightness;
      unsigned int        *levels;
      bool            enabled;
+    struct regulator    *power_supply;
      int            enable_gpio;
      unsigned long        enable_gpio_flags;
      int            (*notify)(struct device *,
@@ -60,6 +62,10 @@ static void pwm_backlight_power_on(struct pwm_bl_data 
*pb, int brightness,

      pwm_config(pb->pwm, duty_cycle, pb->period);

+    err = regulator_enable(pb->power_supply);
+    if (err < 0)
+        dev_err(pb->dev, "failed to enable power supply\n");
+
      if (gpio_is_valid(pb->enable_gpio)) {
          if (pb->enable_gpio_flags & PWM_BACKLIGHT_GPIO_ACTIVE_LOW)
              gpio_set_value(pb->enable_gpio, 0);
@@ -86,6 +92,7 @@ static void pwm_backlight_power_off(struct pwm_bl_data 
*pb)
              gpio_set_value(pb->enable_gpio, 0);
      }

+    regulator_disable(pb->power_supply);
      pb->enabled = false;
  }

@@ -268,6 +275,12 @@ static int pwm_backlight_probe(struct 
platform_device *pdev)
          }
      }

+    pb->power_supply = devm_regulator_get(&pdev->dev, "power");
+    if (IS_ERR(pb->power_supply)) {
+        ret = PTR_ERR(pb->power_supply);
+        goto err_gpio;
+    }
+
      pb->pwm = devm_pwm_get(&pdev->dev, NULL);
      if (IS_ERR(pb->pwm)) {
          dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
