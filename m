From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 2/2] leds: Add multi-LED driver for PWM driven multi-LED
Date: Fri,  6 Feb 2015 19:18:49 +0100
Message-ID: <1423246729-4932-3-git-send-email-bigeasy@linutronix.de>
References: <1423246729-4932-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1423246729-4932-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-leds-owner@vger.kernel.org
To: Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-pwm@vger.kernel.org

A multi-LED (I've seen so far) have three inputs: red, green and blue.
You can hook them with three PWMs. Then you can program the red and
green PWM to on and make it shine yellow. This works in generall.
If a trigger is not exactly programmed then you might see two colors for
a short period of time which looks odd.
Therefore this patch introduces a multi-led driver which programms all
three PWMs as required within one IRQ disabled section.

The way this is currently used, is to programm the three colors via
sysfs ("echo 255 255 0 > brightness" for yellow for instance) and then
use a trigger like timer.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/leds/leds-multi-pwm.c | 291 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 291 insertions(+)
 create mode 100644 drivers/leds/leds-multi-pwm.c

diff --git a/drivers/leds/leds-multi-pwm.c b/drivers/leds/leds-multi-pwm.c
new file mode 100644
index 000000000000..9a336a941431
--- /dev/null
+++ b/drivers/leds/leds-multi-pwm.c
@@ -0,0 +1,291 @@
+/*
+ * multi PWM based LED control
+ *
+ * based on leds-pwm.c by Luotao Fu @ Pengutronix (l.fu@pengutronix.de)
+ * based on leds-gpio.c by Raphael Assenat <raph@8d.com>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/leds.h>
+#include <linux/err.h>
+#include <linux/pwm.h>
+#include <linux/leds_pwm.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+
+struct single_pwm {
+	struct pwm_device	*pwm;
+	u32			duty;
+	bool			enabled;
+	bool			trigger_enabled;
+	bool			active_low;
+};
+
+struct mled_pwm_data {
+	struct led_classdev	cdev;
+	struct work_struct	work;
+	bool			can_sleep;
+	struct single_pwm	*spwm;
+};
+
+struct mled_pwm_priv {
+	int num_leds;
+	struct mled_pwm_data leds[0];
+};
+
+static int of_pwm_count(struct device_node *np)
+{
+	return of_count_phandle_with_args(np, "pwms", "#pwm-cells");
+}
+
+static void __mled_pwm_set(struct mled_pwm_data *led_dat)
+{
+	struct single_pwm *spwm;
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < led_dat->cdev.num_leds; i++) {
+		spwm = &led_dat->spwm[i];
+		pwm_config(spwm->pwm, spwm->duty, pwm_get_period(spwm->pwm));
+	}
+
+	local_irq_save(flags);
+	for (i = 0; i < led_dat->cdev.num_leds; i++) {
+		spwm = &led_dat->spwm[i];
+
+		if (spwm->trigger_enabled)
+			pwm_enable(spwm->pwm);
+		else
+			pwm_disable(spwm->pwm);
+	}
+	local_irq_restore(flags);
+}
+
+static void mled_pwm_work(struct work_struct *work)
+{
+	struct mled_pwm_data *led_dat =
+		container_of(work, struct mled_pwm_data, work);
+
+	__mled_pwm_set(led_dat);
+}
+
+static void mled_pwm_compute(struct single_pwm *spwm,
+				  enum led_brightness brightness,
+				  unsigned int max_brightness)
+{
+	unsigned long long duty;
+
+	duty = pwm_get_period(spwm->pwm);
+
+	duty *= brightness;
+	do_div(duty, max_brightness);
+
+	if (spwm->active_low)
+		duty = pwm_get_period(spwm->pwm) - duty;
+
+	spwm->duty = duty;
+	spwm->enabled = brightness == LED_OFF ? false : true;
+	spwm->trigger_enabled = spwm->enabled;
+}
+
+static void mled_pwm_set_multi(struct led_classdev *led_cdev,
+	enum led_brightness *brightness)
+{
+	struct mled_pwm_data *led_dat =
+		container_of(led_cdev, struct mled_pwm_data, cdev);
+	unsigned int max_brightness = led_dat->cdev.max_brightness;
+	int i;
+
+	for (i = 0; i < led_dat->cdev.num_leds; i++)
+		mled_pwm_compute(&led_dat->spwm[i], brightness[i],
+				      max_brightness);
+
+	if (led_dat->can_sleep)
+		schedule_work(&led_dat->work);
+	else
+		__mled_pwm_set(led_dat);
+}
+
+static void mled_pwm_set_single(struct led_classdev *led_cdev,
+	enum led_brightness brightness)
+{
+	int i;
+	struct mled_pwm_data *led_dat =
+		container_of(led_cdev, struct mled_pwm_data, cdev);
+
+	for (i = 0; i < led_dat->cdev.num_leds; i++) {
+		struct single_pwm *spwm;
+
+		spwm = &led_dat->spwm[i];
+		if (spwm->enabled && brightness != LED_OFF)
+			spwm->trigger_enabled = true;
+		else
+			spwm->trigger_enabled = false;
+	}
+
+	if (led_dat->can_sleep)
+		schedule_work(&led_dat->work);
+	else
+		__mled_pwm_set(led_dat);
+}
+
+static inline size_t sizeof_pwm_leds_priv(int count)
+{
+	return sizeof(struct mled_pwm_priv) +
+		      (sizeof(struct mled_pwm_data) * count);
+}
+
+static void mled_pwm_cleanup(struct mled_pwm_priv *priv)
+{
+	while (priv->num_leds--) {
+		led_classdev_unregister(&priv->leds[priv->num_leds].cdev);
+		if (priv->leds[priv->num_leds].can_sleep)
+			cancel_work_sync(&priv->leds[priv->num_leds].work);
+	}
+}
+
+static int mled_pwm_add(struct device *dev, struct mled_pwm_data *led_dat,
+		       struct device_node *child)
+{
+	unsigned int max_brightness = led_dat->cdev.max_brightness;
+	u32 def_brightness[3] = { 0, };
+	int ret;
+	u32 num_pwms;
+	int i;
+
+	of_property_read_u32_array(child, "linux,default-brightness",
+				   def_brightness, 3);
+
+	num_pwms = of_pwm_count(child);
+	for (i = 0; i < num_pwms; i++) {
+		struct single_pwm *spwm;
+		enum led_brightness brightness;
+
+		spwm = &led_dat->spwm[i];
+
+		spwm->active_low = of_property_read_bool(child, "active-low");
+
+		spwm->pwm = devm_of_pwm_get_index(dev, child, i);
+		if (IS_ERR(spwm->pwm)) {
+			ret = PTR_ERR(spwm->pwm);
+			dev_err(dev, "unable to request PWM for [%s:%d]: %d\n",
+				child->name, i, ret);
+			return ret;
+		}
+		brightness = min_t(unsigned int, def_brightness[i], LED_FULL);
+		mled_pwm_compute(spwm, brightness, max_brightness);
+		led_dat->can_sleep |= pwm_can_sleep(spwm->pwm);
+	}
+
+	if (led_dat->can_sleep)
+		INIT_WORK(&led_dat->work, mled_pwm_work);
+	return 0;
+}
+
+static int mled_pwm_create_of(struct device *dev, struct mled_pwm_priv *priv)
+{
+	struct device_node *child;
+	int ret = -EINVAL;
+
+	for_each_child_of_node(dev->of_node, child) {
+		struct mled_pwm_data *led_dat = &priv->leds[priv->num_leds];
+		int num_pwms;
+		u32 max_brightness = 0;
+
+		num_pwms = of_pwm_count(child);
+		if (num_pwms != 3) {
+			pr_err("Need atleast three pwms.\n");
+			ret = -EINVAL;
+			goto err;
+		}
+		led_dat->spwm = devm_kzalloc(dev, sizeof(struct single_pwm) *
+					      num_pwms, GFP_KERNEL);
+
+		of_property_read_u32(child, "max-brightness", &max_brightness);
+		led_dat->cdev.name = of_get_property(child, "label", NULL) ? :
+			child->name;
+		led_dat->cdev.default_trigger = of_get_property(child,
+						 "linux,default-trigger", NULL);
+		led_dat->cdev.brightness_set = mled_pwm_set_single;
+		led_dat->cdev.brightness_set_multi = mled_pwm_set_multi;
+		led_dat->cdev.brightness = LED_OFF;
+		led_dat->cdev.max_brightness = max_brightness;
+		led_dat->cdev.flags = LED_CORE_SUSPENDRESUME | LED_IS_MULTI;
+		led_dat->cdev.num_leds = num_pwms;
+
+		ret = mled_pwm_add(dev, led_dat, child);
+		if (ret)
+			goto err;
+		ret = led_classdev_register(dev, &led_dat->cdev);
+		if (ret == 0) {
+			priv->num_leds++;
+		} else {
+			dev_err(dev, "failed to register PWM led for %s: %d\n",
+				child->name, ret);
+			goto err;
+		}
+	}
+
+	return ret;
+err:
+	of_node_put(child);
+	return ret;
+}
+
+static int mled_pwm_probe(struct platform_device *pdev)
+{
+	struct mled_pwm_priv *priv;
+	int count;
+	int ret;
+
+	count = of_get_child_count(pdev->dev.of_node);
+	if (!count)
+		return -EINVAL;
+
+
+	priv = devm_kzalloc(&pdev->dev, sizeof_pwm_leds_priv(count),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = mled_pwm_create_of(&pdev->dev, priv);
+	if (ret) {
+		mled_pwm_cleanup(priv);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, priv);
+	return 0;
+}
+
+static int mled_pwm_remove(struct platform_device *pdev)
+{
+	struct mled_pwm_priv *priv = platform_get_drvdata(pdev);
+
+	mled_pwm_cleanup(priv);
+	return 0;
+}
+
+static const struct of_device_id of_pwm_leds_match[] = {
+	{ .compatible = "pwm-multi-leds", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_pwm_leds_match);
+
+static struct platform_driver mled_pwm_driver = {
+	.probe		= mled_pwm_probe,
+	.remove		= mled_pwm_remove,
+	.driver		= {
+		.name	= "multi-leds_pwm",
+		.of_match_table = of_pwm_leds_match,
+	},
+};
+
+module_platform_driver(mled_pwm_driver);
+
+MODULE_DESCRIPTION("Multi-LED PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.1.4
