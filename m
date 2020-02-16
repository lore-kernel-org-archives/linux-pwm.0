From: Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v5 3/7] input: keyboard: Add support for Azoteq IQS620A/621/622/624/625
Date: Sun, 16 Feb 2020 17:32:07 -0600
Message-ID: <1581895931-6056-4-git-send-email-jeff@labundy.com>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1581895931-6056-1-git-send-email-jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

This patch adds key and switch support for the Azoteq IQS620A,
IQS621, IQS622, IQS624 and IQS625 multi-function sensors.

Signed-off-by: Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Acked-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Changes in v5:
  - Replaced iqs62x->map with iqs62x->regmap throughout
  - Updated iqs62x_keys_parse_prop to use device_property_count_u32 instead of
    device_property_read_u32_array to count available keycodes
  - Used input_set_capability to signal available keys and switches instead of
    __set_bit and __clear_bit within iqs62x_keys_probe
  - Dropped #defines for platform_driver name and alias in favor of the actual
    string names
  - Added Acked-by trailer

Changes in v4:
  - None

Changes in v3:
  - None

Changes in v2:
  - Merged 'Copyright' and 'Author' lines into one in introductory comments
  - Replaced 'error' with 'ret' throughout
  - Updated iqs62x_keys_parse_prop to use unified device property interface
  - Clarified the comment in iqs62x_keys_notifier to state that wheel up or
    down events elicit an emulated release cycle
  - Eliminated tabbed alignment of platform_driver struct members

 drivers/input/keyboard/Kconfig       |  10 ++
 drivers/input/keyboard/Makefile      |   1 +
 drivers/input/keyboard/iqs62x-keys.c | 335 +++++++++++++++++++++++++++++++++++
 3 files changed, 346 insertions(+)
 create mode 100644 drivers/input/keyboard/iqs62x-keys.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 4706ff0..28de965 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -663,6 +663,16 @@ config KEYBOARD_IPAQ_MICRO
 	  To compile this driver as a module, choose M here: the
 	  module will be called ipaq-micro-keys.

+config KEYBOARD_IQS62X
+	tristate "Azoteq IQS620A/621/622/624/625 keys and switches"
+	depends on MFD_IQS62X
+	help
+	  Say Y here to enable key and switch support for the Azoteq IQS620A,
+	  IQS621, IQS622, IQS624 and IQS625 multi-function sensors.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called iqs62x-keys.
+
 config KEYBOARD_OMAP
 	tristate "TI OMAP keypad support"
 	depends on ARCH_OMAP1
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index f5b1752..1d689fd 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_KEYBOARD_TCA8418)		+= tca8418_keypad.o
 obj-$(CONFIG_KEYBOARD_HIL)		+= hil_kbd.o
 obj-$(CONFIG_KEYBOARD_HIL_OLD)		+= hilkbd.o
 obj-$(CONFIG_KEYBOARD_IPAQ_MICRO)	+= ipaq-micro-keys.o
+obj-$(CONFIG_KEYBOARD_IQS62X)		+= iqs62x-keys.o
 obj-$(CONFIG_KEYBOARD_IMX)		+= imx_keypad.o
 obj-$(CONFIG_KEYBOARD_IMX_SC_KEY)	+= imx_sc_key.o
 obj-$(CONFIG_KEYBOARD_HP6XX)		+= jornada680_kbd.o
diff --git a/drivers/input/keyboard/iqs62x-keys.c b/drivers/input/keyboard/iqs62x-keys.c
new file mode 100644
index 0000000..93446b2
--- /dev/null
+++ b/drivers/input/keyboard/iqs62x-keys.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS620A/621/622/624/625 Keys and Switches
+ *
+ * Copyright (C) 2019 Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
+ */
+
+#include <linux/device.h>
+#include <linux/input.h>
+#include <linux/kernel.h>
+#include <linux/mfd/iqs62x.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+enum {
+	IQS62X_SW_HALL_N,
+	IQS62X_SW_HALL_S,
+};
+
+static const char * const iqs62x_switch_names[] = {
+	[IQS62X_SW_HALL_N] = "hall-switch-north",
+	[IQS62X_SW_HALL_S] = "hall-switch-south",
+};
+
+struct iqs62x_switch_desc {
+	enum iqs62x_event_flag flag;
+	unsigned int code;
+	bool enabled;
+};
+
+struct iqs62x_keys_private {
+	struct iqs62x_core *iqs62x;
+	struct input_dev *input;
+	struct notifier_block notifier;
+	struct iqs62x_switch_desc switches[ARRAY_SIZE(iqs62x_switch_names)];
+	unsigned int keycode[IQS62X_NUM_KEYS];
+	unsigned int keycodemax;
+	u8 interval;
+};
+
+static int iqs62x_keys_parse_prop(struct platform_device *pdev,
+				  struct iqs62x_keys_private *iqs62x_keys)
+{
+	struct fwnode_handle *child;
+	unsigned int val;
+	int ret, i;
+
+	ret = device_property_count_u32(&pdev->dev, "linux,keycodes");
+	if (ret > IQS62X_NUM_KEYS) {
+		dev_err(&pdev->dev, "Too many keycodes present\n");
+		return -EINVAL;
+	} else if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to count keycodes: %d\n", ret);
+		return ret;
+	}
+	iqs62x_keys->keycodemax = ret;
+
+	ret = device_property_read_u32_array(&pdev->dev, "linux,keycodes",
+					     iqs62x_keys->keycode,
+					     iqs62x_keys->keycodemax);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to read keycodes: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++) {
+		child = device_get_named_child_node(&pdev->dev,
+						    iqs62x_switch_names[i]);
+		if (!child)
+			continue;
+
+		ret = fwnode_property_read_u32(child, "linux,code", &val);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to read switch code: %d\n",
+				ret);
+			return ret;
+		}
+		iqs62x_keys->switches[i].code = val;
+		iqs62x_keys->switches[i].enabled = true;
+
+		if (fwnode_property_present(child, "azoteq,use-prox"))
+			iqs62x_keys->switches[i].flag = (i == IQS62X_SW_HALL_N ?
+							 IQS62X_EVENT_HALL_N_P :
+							 IQS62X_EVENT_HALL_S_P);
+		else
+			iqs62x_keys->switches[i].flag = (i == IQS62X_SW_HALL_N ?
+							 IQS62X_EVENT_HALL_N_T :
+							 IQS62X_EVENT_HALL_S_T);
+	}
+
+	return 0;
+}
+
+static int iqs62x_keys_init(struct iqs62x_keys_private *iqs62x_keys)
+{
+	struct iqs62x_core *iqs62x = iqs62x_keys->iqs62x;
+	enum iqs62x_event_flag flag;
+	unsigned int event_reg, val;
+	unsigned int event_mask = 0;
+	int ret, i;
+
+	switch (iqs62x->dev_desc->prod_num) {
+	case IQS620_PROD_NUM:
+	case IQS621_PROD_NUM:
+	case IQS622_PROD_NUM:
+		event_reg = IQS620_GLBL_EVENT_MASK;
+
+		/*
+		 * Discreet button, hysteresis and SAR UI flags represent keys
+		 * and are unmasked if mapped to a valid keycode.
+		 */
+		for (i = 0; i < iqs62x_keys->keycodemax; i++) {
+			if (iqs62x_keys->keycode[i] == KEY_RESERVED)
+				continue;
+
+			if (iqs62x_events[i].reg == IQS62X_EVENT_PROX)
+				event_mask |= iqs62x->dev_desc->prox_mask;
+			else if (iqs62x_events[i].reg == IQS62X_EVENT_HYST)
+				event_mask |= (iqs62x->dev_desc->hyst_mask |
+					       iqs62x->dev_desc->sar_mask);
+		}
+
+		ret = regmap_read(iqs62x->regmap, iqs62x->dev_desc->hall_flags,
+				  &val);
+		if (ret)
+			return ret;
+
+		/*
+		 * Hall UI flags represent switches and are unmasked if their
+		 * corresponding child nodes are present.
+		 */
+		for (i = 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++) {
+			if (!(iqs62x_keys->switches[i].enabled))
+				continue;
+
+			flag = iqs62x_keys->switches[i].flag;
+
+			if (iqs62x_events[flag].reg != IQS62X_EVENT_HALL)
+				continue;
+
+			event_mask |= iqs62x->dev_desc->hall_mask;
+
+			input_report_switch(iqs62x_keys->input,
+					    iqs62x_keys->switches[i].code,
+					    (val & iqs62x_events[flag].mask) ==
+					    iqs62x_events[flag].val);
+		}
+
+		input_sync(iqs62x_keys->input);
+		break;
+
+	case IQS624_PROD_NUM:
+		event_reg = IQS624_HALL_UI;
+
+		/*
+		 * Interval change events represent keys and are unmasked if
+		 * either wheel movement flag is mapped to a valid keycode.
+		 */
+		if (iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_UP] != KEY_RESERVED)
+			event_mask |= IQS624_HALL_UI_INT_EVENT;
+
+		if (iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_DN] != KEY_RESERVED)
+			event_mask |= IQS624_HALL_UI_INT_EVENT;
+
+		ret = regmap_read(iqs62x->regmap, iqs62x->dev_desc->interval,
+				  &val);
+		if (ret)
+			return ret;
+
+		iqs62x_keys->interval = val;
+		break;
+
+	default:
+		return 0;
+	}
+
+	return regmap_update_bits(iqs62x->regmap, event_reg, event_mask, 0);
+}
+
+static int iqs62x_keys_notifier(struct notifier_block *notifier,
+				unsigned long event_flags, void *context)
+{
+	struct iqs62x_event_data *event_data = context;
+	struct iqs62x_keys_private *iqs62x_keys;
+	int ret, i;
+
+	iqs62x_keys = container_of(notifier, struct iqs62x_keys_private,
+				   notifier);
+
+	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
+		ret = iqs62x_keys_init(iqs62x_keys);
+		if (ret) {
+			dev_err(iqs62x_keys->input->dev.parent,
+				"Failed to re-initialize device: %d\n", ret);
+			return NOTIFY_BAD;
+		}
+
+		return NOTIFY_OK;
+	}
+
+	for (i = 0; i < iqs62x_keys->keycodemax; i++) {
+		if (iqs62x_events[i].reg == IQS62X_EVENT_WHEEL &&
+		    event_data->interval == iqs62x_keys->interval)
+			continue;
+
+		input_report_key(iqs62x_keys->input, iqs62x_keys->keycode[i],
+				 event_flags & BIT(i));
+	}
+
+	for (i = 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++)
+		if (iqs62x_keys->switches[i].enabled)
+			input_report_switch(iqs62x_keys->input,
+					    iqs62x_keys->switches[i].code,
+					    event_flags &
+					    BIT(iqs62x_keys->switches[i].flag));
+
+	input_sync(iqs62x_keys->input);
+
+	if (event_data->interval == iqs62x_keys->interval)
+		return NOTIFY_OK;
+
+	/*
+	 * Each frame contains at most one wheel event (up or down), in which
+	 * case a complementary release cycle is emulated.
+	 */
+	if (event_flags & BIT(IQS62X_EVENT_WHEEL_UP)) {
+		input_report_key(iqs62x_keys->input,
+				 iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_UP],
+				 0);
+		input_sync(iqs62x_keys->input);
+	} else if (event_flags & BIT(IQS62X_EVENT_WHEEL_DN)) {
+		input_report_key(iqs62x_keys->input,
+				 iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_DN],
+				 0);
+		input_sync(iqs62x_keys->input);
+	}
+
+	iqs62x_keys->interval = event_data->interval;
+
+	return NOTIFY_OK;
+}
+
+static int iqs62x_keys_probe(struct platform_device *pdev)
+{
+	struct iqs62x_core *iqs62x = dev_get_drvdata(pdev->dev.parent);
+	struct iqs62x_keys_private *iqs62x_keys;
+	struct input_dev *input;
+	int ret, i;
+
+	iqs62x_keys = devm_kzalloc(&pdev->dev, sizeof(*iqs62x_keys),
+				   GFP_KERNEL);
+	if (!iqs62x_keys)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, iqs62x_keys);
+
+	ret = iqs62x_keys_parse_prop(pdev, iqs62x_keys);
+	if (ret)
+		return ret;
+
+	input = devm_input_allocate_device(&pdev->dev);
+	if (!input)
+		return -ENOMEM;
+
+	input->keycodemax = iqs62x_keys->keycodemax;
+	input->keycode = iqs62x_keys->keycode;
+	input->keycodesize = sizeof(*iqs62x_keys->keycode);
+
+	input->name = iqs62x->dev_desc->dev_name;
+	input->id.bustype = BUS_I2C;
+
+	for (i = 0; i < iqs62x_keys->keycodemax; i++)
+		if (iqs62x_keys->keycode[i] != KEY_RESERVED)
+			input_set_capability(input, EV_KEY,
+					     iqs62x_keys->keycode[i]);
+
+	for (i = 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++)
+		if (iqs62x_keys->switches[i].enabled)
+			input_set_capability(input, EV_SW,
+					     iqs62x_keys->switches[i].code);
+
+	iqs62x_keys->iqs62x = iqs62x;
+	iqs62x_keys->input = input;
+
+	ret = iqs62x_keys_init(iqs62x_keys);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to initialize device: %d\n", ret);
+		return ret;
+	}
+
+	ret = input_register_device(iqs62x_keys->input);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register device: %d\n", ret);
+		return ret;
+	}
+
+	iqs62x_keys->notifier.notifier_call = iqs62x_keys_notifier;
+	ret = blocking_notifier_chain_register(&iqs62x_keys->iqs62x->nh,
+					       &iqs62x_keys->notifier);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
+
+	return ret;
+}
+
+static int iqs62x_keys_remove(struct platform_device *pdev)
+{
+	struct iqs62x_keys_private *iqs62x_keys = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = blocking_notifier_chain_unregister(&iqs62x_keys->iqs62x->nh,
+						 &iqs62x_keys->notifier);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to unregister notifier: %d\n", ret);
+
+	return ret;
+}
+
+static struct platform_driver iqs62x_keys_platform_driver = {
+	.driver = {
+		.name = "iqs62x-keys",
+	},
+	.probe = iqs62x_keys_probe,
+	.remove = iqs62x_keys_remove,
+};
+module_platform_driver(iqs62x_keys_platform_driver);
+
+MODULE_AUTHOR("Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>");
+MODULE_DESCRIPTION("Azoteq IQS620A/621/622/624/625 Keys and Switches");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:iqs62x-keys");
