Return-Path: <root@danube-imgworks.hb.imgtec.org>
From: Naidu.Tellapati@imgtec.com
Subject: [PATCH 3/4] pdm: Imagination Technologies PDM DAC driver
Date: Wed, 12 Nov 2014 18:07:52 +0530
Message-Id: <1415795873-4816-4-git-send-email-Naidu.Tellapati@imgtec.com>
In-Reply-To: <1415795873-4816-1-git-send-email-Naidu.Tellapati@imgtec.com>
References: <1415795873-4816-1-git-send-email-Naidu.Tellapati@imgtec.com>
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org, James.Hartley@imgtec.com, abrestic@chromium.org, Ezequiel.Garcia@imgtec.com
Cc: Arul.Ramasamy@imgtec.com, Sai.Masarapu@imgtec.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Naidu Tellapati <Naidu.Tellapati@imgtec.com>

From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>

The Pistachio SOC from Imagination Technologies includes a Pulse Density
Modulation DAC which produces a form of analogue output according to the
relative density of output pulses to the intended analogue signal amplitude.
Four PDM outputs are provided that can be used to control targets such as LCD
backlight.

Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Signed-off-by: Arul Ramasamy <Arul.Ramasamy@imgtec.com>
---
 drivers/misc/Kconfig    |   10 +
 drivers/misc/Makefile   |    1 +
 drivers/misc/img-pdm.c  |  657 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/img_pdm.h |   52 ++++
 4 files changed, 720 insertions(+), 0 deletions(-)
 create mode 100644 drivers/misc/img-pdm.c
 create mode 100644 include/linux/img_pdm.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index bbeb451..4ca439f 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -515,6 +515,16 @@ config VEXPRESS_SYSCFG
 	  bus. System Configuration interface is one of the possible means
 	  of generating transactions on this bus.
 
+config IMG_PDM
+	tristate "Imagination Technologies PDM driver"
+	depends on MFD_SYSCON 
+	help
+	  PDM driver for Imagination Technologies PDM block which supports 4
+	  channels.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called img-pdm.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 7d5c4cd..d8c7d55 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -56,3 +56,4 @@ obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_CXL_BASE)		+= cxl/
+obj-$(CONFIG_IMG_PDM)		+= img-pdm.o
diff --git a/drivers/misc/img-pdm.c b/drivers/misc/img-pdm.c
new file mode 100644
index 0000000..0e5522a
--- /dev/null
+++ b/drivers/misc/img-pdm.c
@@ -0,0 +1,657 @@
+/**
+ * Imagination Technologies Pulse Density Modulator driver
+ *
+ * Copyright (C) 2014 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/capability.h>
+#include <linux/ctype.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/list.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/clk.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/img_pdm.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+struct img_pdm_channel *pdm_channels;
+
+static DEFINE_MUTEX(pdm_lock);
+
+static struct img_pdm_channel *of_img_pdm_channel_get(struct device_node *np)
+{
+	int err;
+	int index = 0;
+	struct of_phandle_args args;
+	struct img_pdm_channel *chan;
+
+	err = of_parse_phandle_with_args(np, "pdms", "#pdm-cells",
+							index, &args);
+	if (err) {
+		pr_debug("%s(): can't parse \"pdms\" property\n", __func__);
+		return ERR_PTR(err);
+	}
+
+	if (args.args_count != 2) {
+		pr_debug("%s(): wrong #pwm-cells\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	chan = img_pdm_channel_request(args.args[0]);
+	if (chan)
+		img_pdm_channel_pulse_in_set(chan, args.args[1]);
+
+	return chan;
+}
+
+static void of_img_pdm_channel_put(struct device_node *np)
+{
+	struct img_pdm_channel *chan = NULL;
+	struct of_phandle_args args;
+	int index = 0;
+	int err;
+
+	err = of_parse_phandle_with_args(np, "pdms", "#pdm-cells",
+				index, &args);
+	if (err) {
+		pr_debug("%s(): can't parse \"pdms\" property\n", __func__);
+		return;
+	}
+
+	if (args.args_count != 2) {
+		pr_debug("%s(): wrong #pwm-cells\n", __func__);
+		return;
+	}
+
+	if (args.args[0] < 0 || args.args[0] >= NUM_PDM || !pdm_channels)
+		return;
+
+	chan = &pdm_channels[args.args[0]];
+	img_pdm_channel_free(chan);
+}
+
+struct img_pdm_channel *img_pdm_channel_get(struct device *dev)
+{
+	/* look up via DT */
+	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
+		return of_img_pdm_channel_get(dev->of_node);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(img_pdm_channel_get);
+
+void img_pdm_channel_put(struct device *dev)
+{
+	/* look up via DT */
+	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
+		of_img_pdm_channel_put(dev->of_node);
+}
+EXPORT_SYMBOL_GPL(img_pdm_channel_put);
+
+struct img_pdm_channel *img_pdm_channel_request(unsigned int pdm_id)
+{
+	struct img_pdm_device *pdm_dev;
+	struct img_pdm_channel *chan = NULL;
+	unsigned int i;
+
+	mutex_lock(&pdm_lock);
+
+	if (pdm_id < 0 || pdm_id >= NUM_PDM || !pdm_channels)
+		return NULL;
+
+	pdm_dev = pdm_channels[0].pdm_dev;
+	if (!pdm_dev)
+		return NULL;
+
+	for (i = 0; i < NUM_PDM; i++) {
+		if (&pdm_channels[i] && (pdm_channels[i].pdm_id == pdm_id)) {
+			chan = &pdm_channels[i];
+			break;
+		}
+	}
+
+	if (!chan) {
+		mutex_unlock(&pdm_lock);
+		return NULL;
+	}
+
+	/* Check if channel is already requested */
+	if (test_bit(PDM_CHANNEL_REQUESTED, &chan->flags)) {
+		dev_err(&pdm_dev->pdev->dev,
+			"pdm channel %d already requested\n", chan->pdm_id);
+		mutex_unlock(&pdm_lock);
+		return NULL;
+	}
+
+	set_bit(PDM_CHANNEL_REQUESTED, &chan->flags);
+	mutex_unlock(&pdm_lock);
+
+	return chan;
+}
+
+int img_pdm_channel_free(struct img_pdm_channel *chan)
+{
+	int i;
+	struct img_pdm_device *pdm_dev;
+
+	mutex_lock(&pdm_lock);
+
+	if (!pdm_channels || !chan) {
+		mutex_unlock(&pdm_lock);
+		return -EINVAL;
+	}
+
+	pdm_dev = pdm_channels[0].pdm_dev;
+	if (!pdm_dev) {
+		mutex_unlock(&pdm_lock);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < NUM_PDM; i++) {
+		if (&pdm_channels[i] && (&pdm_channels[i] == chan))
+			break;
+	}
+
+	if (i == NUM_PDM) {
+		dev_err(&pdm_dev->pdev->dev,
+			"Invalid pdm channel address to free\n");
+		mutex_unlock(&pdm_lock);
+		return -EINVAL;
+	}
+
+	if (test_bit(PDM_CHANNEL_ENABLED, &chan->flags)) {
+		dev_err(&pdm_dev->pdev->dev,
+			"can't free the channel while it is enabled\n");
+		mutex_unlock(&pdm_lock);
+		return -EINVAL;
+	}
+
+	if (!test_bit(PDM_CHANNEL_REQUESTED, &chan->flags)) {
+		dev_err(&pdm_dev->pdev->dev,
+			"trying to free channel which is not requested\n");
+		mutex_unlock(&pdm_lock);
+		return -EINVAL;
+	}
+
+	clear_bit(PDM_CHANNEL_REQUESTED, &chan->flags);
+
+	mutex_unlock(&pdm_lock);
+
+	return 0;
+}
+
+int img_pdm_channel_enable_get(struct img_pdm_channel *chan)
+{
+	int ret;
+	struct img_pdm_device *pdm_dev;
+
+	if (!chan)
+		return -EINVAL;
+
+	pdm_dev = chan->pdm_dev;
+
+	if (!test_bit(PDM_CHANNEL_REQUESTED, &chan->flags)) {
+		dev_err(&pdm_dev->pdev->dev, "pdm chan is notrequested\n");
+		return -EINVAL;
+	}
+
+	if (test_bit(PDM_CHANNEL_ENABLED, &chan->flags))
+		ret = PDM_CHANNEL_ENABLE;
+	else
+		ret = PDM_CHANNEL_DISABLE;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(img_pdm_channel_enable_get);
+
+int img_pdm_channel_pulse_in_get(struct img_pdm_channel *chan)
+{
+	int val = 0;
+	struct img_pdm_device *pdm_dev;
+
+	if (!chan)
+		return -EINVAL;
+
+	pdm_dev = chan->pdm_dev;
+
+	if (!test_bit(PDM_CHANNEL_REQUESTED, &chan->flags)) {
+		dev_err(&pdm_dev->pdev->dev, "pdm chan is notrequested\n");
+		return -EINVAL;
+	}
+
+	regmap_read(pdm_dev->periph_regs,
+		CR_PERIP_PDM0_VAL + PDM_CH_ADDR_SHIFT(chan->pdm_id), &val);
+	val &= PDM_SRC_DATA_MASK;
+
+	return val;
+}
+EXPORT_SYMBOL_GPL(img_pdm_channel_pulse_in_get);
+
+int img_pdm_channel_enable_set(struct img_pdm_channel *chan, bool state)
+{
+	unsigned int value;
+	struct img_pdm_device *pdm_dev;
+
+	if (!chan)
+		return -EINVAL;
+
+	pdm_dev = chan->pdm_dev;
+
+	if (!test_bit(PDM_CHANNEL_REQUESTED, &chan->flags)) {
+		dev_err(&pdm_dev->pdev->dev, "invalid pdm chan enable\n");
+		return -EINVAL;
+	}
+
+	if ((state == PDM_CHANNEL_ENABLE) &&
+		test_bit(PDM_CHANNEL_ENABLED, &chan->flags)) {
+		dev_err(&pdm_dev->pdev->dev, "pdm chan already enabled\n");
+		return -EBUSY;
+	} else if ((state == PDM_CHANNEL_DISABLE) &&
+		!test_bit(PDM_CHANNEL_ENABLED, &chan->flags)) {
+		dev_err(&pdm_dev->pdev->dev, "pdm chan not enabled\n");
+		return -EINVAL;
+	}
+
+	regmap_read(pdm_dev->periph_regs, CR_PERIP_PWM_PDM_CONTROL, &value);
+
+	if (state == PDM_CHANNEL_ENABLE)
+		value |= BIT(chan->pdm_id *
+				PWM_PDM_CH_CTRL_SHIFT(chan->pdm_id));
+	else if	(state == PDM_CHANNEL_DISABLE)
+		value &= ~BIT(chan->pdm_id *
+				PWM_PDM_CH_CTRL_SHIFT(chan->pdm_id));
+
+	regmap_write(pdm_dev->periph_regs, CR_PERIP_PWM_PDM_CONTROL, value);
+
+	if (state == PDM_CHANNEL_DISABLE) {
+		regmap_write(pdm_dev->periph_regs,
+		CR_PERIP_PDM0_VAL + PDM_CH_ADDR_SHIFT(chan->pdm_id), 0);
+	}
+
+	if (state == PDM_CHANNEL_ENABLE)
+		set_bit(PDM_CHANNEL_ENABLED, &chan->flags);
+	else
+		clear_bit(PDM_CHANNEL_ENABLED, &chan->flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(img_pdm_channel_enable_set);
+
+int img_pdm_channel_pulse_in_set(struct img_pdm_channel *chan, unsigned int val)
+{
+	struct img_pdm_device *pdm_dev;
+
+	if (!chan)
+		return -EINVAL;
+
+	pdm_dev = chan->pdm_dev;
+
+	if (!test_bit(PDM_CHANNEL_REQUESTED, &chan->flags)) {
+		dev_err(&pdm_dev->pdev->dev, "invalid pdm chan to configure\n");
+		return -EINVAL;
+	}
+
+	val = val & PDM_SRC_DATA_MASK;
+	regmap_write(pdm_dev->periph_regs,
+		CR_PERIP_PDM0_VAL + PDM_CH_ADDR_SHIFT(chan->pdm_id), val);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(img_pdm_channel_pulse_in_set);
+
+static ssize_t img_pdm_enable_read(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	int ret;
+	unsigned int val = 0;
+	unsigned int ch_num = 0;
+	unsigned char kobj_name[2];
+	struct platform_device *pdev;
+	struct img_pdm_device *pdm_dev;
+
+	pdev = to_platform_device(kobj_to_dev(kobj->parent));
+	pdm_dev = platform_get_drvdata(pdev);
+	kobj_name[0] = *(kobj->name+3);
+	kobj_name[1] = '\0';
+	ret = kstrtou32(kobj_name, 10, &ch_num);
+	if (ret) {
+		dev_err(&pdev->dev, "could not parse channel number string\n");
+		return ret;
+	}
+
+	val = img_pdm_channel_enable_get(&pdm_channels[ch_num]);
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t img_pdm_pulse_in_read(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	int ret;
+	unsigned int val;
+	unsigned int ch_num;
+	unsigned char kobj_name[2];
+	struct platform_device *pdev;
+	struct img_pdm_device *pdm_dev;
+
+	pdev = to_platform_device(kobj_to_dev(kobj->parent));
+	pdm_dev = platform_get_drvdata(pdev);
+	kobj_name[0] = *(kobj->name+3);
+	kobj_name[1] = '\0';
+	ret = kstrtou32(kobj_name, 10, &ch_num);
+	if (ret) {
+		dev_err(&pdev->dev, "could not parse channel number string\n");
+		return ret;
+	}
+
+	val = img_pdm_channel_pulse_in_get(&pdm_channels[ch_num]);
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t img_pdm_enable_write(struct kobject *kobj,
+					struct kobj_attribute *attr,
+						const char *buf, size_t size)
+{
+	int ret;
+	unsigned int enable;
+	unsigned int ch_num;
+	unsigned char kobj_name[2];
+	struct platform_device *pdev;
+	struct img_pdm_device *pdm_dev;
+
+	pdev = to_platform_device(kobj_to_dev(kobj->parent));
+	pdm_dev = platform_get_drvdata(pdev);
+	kobj_name[0] = *(kobj->name+3);
+	kobj_name[1] = '\0';
+	ret = kstrtou32(kobj_name, 10, &ch_num);
+	if (ret) {
+		dev_err(&pdev->dev, "could not parse channel number string\n");
+		return ret;
+	}
+
+	ret = kstrtou32(buf, 10, &enable);
+	if (ret) {
+		dev_err(&pdev->dev, "could not parse enable attr value\n");
+		return ret;
+	}
+
+	if (enable > PDM_CHANNEL_ENABLE) {
+		dev_err(&pdev->dev, "invalid enable attribute value\n");
+		return ret;
+	}
+
+	ret = img_pdm_channel_enable_set(&pdm_channels[ch_num],
+		enable ? PDM_CHANNEL_ENABLE : PDM_CHANNEL_DISABLE);
+	if (ret < 0)
+		return ret;
+
+	return size;
+}
+
+static ssize_t img_pdm_pulse_in_write(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t size)
+{
+	int ret;
+	unsigned int pulse_in;
+	unsigned int ch_num;
+	unsigned char kobj_name[2];
+	struct platform_device *pdev;
+	struct img_pdm_device *pdm_dev;
+
+	pdev = to_platform_device(kobj_to_dev(kobj->parent));
+	pdm_dev = platform_get_drvdata(pdev);
+	kobj_name[0] = *(kobj->name+3);
+	kobj_name[1] = '\0';
+	ret = kstrtou32(kobj_name, 10, &ch_num);
+	if (ret) {
+		dev_err(&pdev->dev, "could not parse channel number string\n");
+		return ret;
+	}
+
+	ret = kstrtouint(buf, 16, &pulse_in);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"could not parse pulse_in attr value\n");
+		return ret;
+	}
+
+	if (pulse_in > PDM_SRC_DATA_MASK) {
+		dev_err(&pdev->dev,
+			"invalid attr value for pulse_in string\n");
+		return -EINVAL;
+	}
+
+	ret = img_pdm_channel_pulse_in_set(&pdm_channels[ch_num], pulse_in);
+	if (ret < 0)
+		return ret;
+
+	return size;
+}
+
+#define PDM_ATTR(_name, _mode, _show, _store) \
+struct kobj_attribute pdm_attr_##_name = { \
+	.attr = {.name = __stringify(_name), .mode = _mode}, \
+	.show = _show, \
+	.store = _store, \
+}
+
+static PDM_ATTR(enable, S_IRUGO | S_IWUSR, img_pdm_enable_read,
+						img_pdm_enable_write);
+static PDM_ATTR(pulse_in, S_IRUGO | S_IWUSR, img_pdm_pulse_in_read,
+						img_pdm_pulse_in_write);
+
+static struct attribute *pdm_sysfs_attrs[] = {
+	&pdm_attr_enable.attr,
+	&pdm_attr_pulse_in.attr,
+	NULL,
+};
+
+static const struct attribute_group pdm_attr_group = {
+	.attrs = pdm_sysfs_attrs,
+};
+
+static ssize_t img_pdm_export(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t size)
+{
+	int ret;
+	unsigned int ch_num;
+	unsigned char buf1[5];
+	struct platform_device *pdev;
+	struct img_pdm_device *pdm_dev;
+
+	pdev = to_platform_device(dev);
+	pdm_dev = platform_get_drvdata(pdev);
+
+	ret = kstrtou32(buf, 10, &ch_num);
+	if (ret) {
+		dev_err(&pdev->dev, "could not parse channel number string\n");
+		return ret;
+	}
+
+	if (img_pdm_channel_request(ch_num) == NULL)
+		return -EINVAL;
+
+	memset(buf1, 0, sizeof(buf1));
+	sprintf(buf1, "pdm%d", ch_num);
+	pdm_dev->pdm_kobj[ch_num] = kobject_create_and_add(buf1,
+							&pdev->dev.kobj);
+	if (!pdm_dev->pdm_kobj[ch_num])
+		return -ENOMEM;
+
+	ret = sysfs_create_group(pdm_dev->pdm_kobj[ch_num], &pdm_attr_group);
+	if (ret) {
+		kobject_put(pdm_dev->pdm_kobj[ch_num]);
+		dev_err(&pdev->dev, "unable to register device attributes\n");
+		return ret;
+	}
+
+	return size;
+}
+
+static ssize_t img_pdm_unexport(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t size)
+{
+	int ret;
+	unsigned int ch_num;
+	struct img_pdm_channel *channel;
+	struct platform_device *pdev;
+	struct img_pdm_device *pdm_dev;
+
+	pdev = to_platform_device(dev);
+	pdm_dev = platform_get_drvdata(pdev);
+
+	ret = kstrtou32(buf, 10, &ch_num);
+	if (ret < 0)
+		return ret;
+
+	if (ch_num < 0 || ch_num >= NUM_PDM) {
+		dev_err(&pdev->dev, "Invalid channel number %d\n", ch_num);
+		return -EINVAL;
+	}
+
+	channel = &pdm_channels[ch_num];
+	if (img_pdm_channel_free(channel) < 0)
+		return -EINVAL;
+
+	if (pdm_dev->pdm_kobj[ch_num]) {
+		sysfs_remove_group(pdm_dev->pdm_kobj[ch_num], &pdm_attr_group);
+		kobject_put(pdm_dev->pdm_kobj[ch_num]);
+	}
+
+	return size;
+}
+
+/* The sysfs attributes. */
+static DEVICE_ATTR(export, S_IRUGO | S_IWUSR, NULL, img_pdm_export);
+static DEVICE_ATTR(unexport, S_IRUGO | S_IWUSR, NULL, img_pdm_unexport);
+
+static struct attribute *img_pdm_sysfs_attrs[] = {
+	&dev_attr_export.attr,
+	&dev_attr_unexport.attr,
+	NULL,
+};
+
+static const struct attribute_group img_pdm_attr_group = {
+	.attrs = img_pdm_sysfs_attrs,
+};
+
+static int img_pdm_probe(struct platform_device *pdev)
+{
+	int i, ret;
+	struct img_pdm_device *pdm_dev;
+
+	pdm_dev = devm_kzalloc(&pdev->dev,
+			sizeof(struct img_pdm_device), GFP_KERNEL);
+	if (!pdm_dev)
+		return -ENOMEM;
+
+	pdm_dev->pdm_kobj = devm_kzalloc(&pdev->dev,
+				NUM_PDM * sizeof(struct img_pdm_device *),
+					GFP_KERNEL);
+	if (!pdm_dev->pdm_kobj)
+		return -ENOMEM;
+
+	pdm_channels = devm_kzalloc(&pdev->dev,
+				NUM_PDM * sizeof(struct img_pdm_channel),
+					GFP_KERNEL);
+	if (!pdm_channels)
+		return -ENOMEM;
+
+	pdm_dev->periph_regs = syscon_regmap_lookup_by_phandle(
+					pdev->dev.of_node, "img,cr-periph");
+	if (IS_ERR(pdm_dev->periph_regs))
+		return PTR_ERR(pdm_dev->periph_regs);
+
+	pdm_dev->clk = devm_clk_get(&pdev->dev, "pdm");
+	if (IS_ERR(pdm_dev->clk)) {
+		dev_err(&pdev->dev, "failed to get pdm clock\n");
+		return PTR_ERR(pdm_dev->clk);
+	}
+
+	ret = clk_prepare_enable(pdm_dev->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not prepare or enable pdm clock.\n");
+		return ret;
+	}
+
+	for (i = 0; i < NUM_PDM; i++) {
+		pdm_channels[i].pdm_id = i;
+		pdm_channels[i].pdm_dev = pdm_dev;
+	}
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &img_pdm_attr_group);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to register device attributes\n");
+		clk_disable_unprepare(pdm_dev->clk);
+		return ret;
+	}
+
+	pdm_dev->pdev = pdev;
+	platform_set_drvdata(pdev, pdm_dev);
+
+	return 0;
+}
+
+static int img_pdm_remove(struct platform_device *pdev)
+{
+	int i;
+	struct img_pdm_channel *chan;
+	struct img_pdm_device *pdm_dev;
+
+	pdm_dev = platform_get_drvdata(pdev);
+
+	for (i = 0; i < NUM_PDM; i++) {
+		chan = &pdm_channels[i];
+		if (test_bit(PDM_CHANNEL_REQUESTED, &chan->flags)) {
+			img_pdm_channel_enable_set(chan, PDM_CHANNEL_DISABLE);
+			img_pdm_channel_pulse_in_set(chan, 0);
+			if (pdm_dev->pdm_kobj[i]) {
+				sysfs_remove_group(pdm_dev->pdm_kobj[i],
+							&pdm_attr_group);
+				kobject_del(pdm_dev->pdm_kobj[i]);
+			}
+		}
+	}
+
+	clk_disable_unprepare(pdm_dev->clk);
+
+	return 0;
+}
+
+static const struct of_device_id img_pdm_of_match[] = {
+	{ .compatible = "img,pistachio-pdm", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, img_pdm_of_match);
+
+static struct platform_driver img_pdm_driver = {
+	.driver = {
+		.name = "imgtec-pdm",
+		.owner = THIS_MODULE,
+		.of_match_table = img_pdm_of_match,
+	},
+	.probe = img_pdm_probe,
+	.remove = img_pdm_remove,
+};
+module_platform_driver(img_pdm_driver);
+
+MODULE_AUTHOR("Arul Ramasamy <Arul.Ramasamy@imgtec.com>");
+MODULE_DESCRIPTION("Imagination Technologies PDM driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/img_pdm.h b/include/linux/img_pdm.h
new file mode 100644
index 0000000..45c17aa
--- /dev/null
+++ b/include/linux/img_pdm.h
@@ -0,0 +1,52 @@
+/**
+ * Imagination Technologies Pulse Density Modulator driver
+ *
+ * Copyright (C) 2014 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __IMG_PDM_H
+#define __IMG_PDM_H
+
+/* Registers */
+#define	CR_PERIP_PWM_PDM_CONTROL	0x0140  /* PWM and PDM ctrl register */
+#define PWM_PDM_CH_CTRL_SHIFT(ch)	(ch * 4)
+
+#define	CR_PERIP_PDM0_VAL		0x0140	/* PDM0 source data register */
+#define PDM_CH_ADDR_SHIFT(ch)		(ch * 4)
+
+#define	PDM_SRC_DATA_MASK		0xfff	/* 12 bit source data mask */
+#define	PDM_CHANNEL_ENABLE		1	/* Enable PDM channel */
+#define	PDM_CHANNEL_DISABLE		0	/* Disable PDM channel */
+#define	NUM_PDM				4
+
+#define PDM_CHANNEL_REQUESTED		1
+#define PDM_CHANNEL_ENABLED		2
+
+struct img_pdm_device {
+	struct clk *clk;
+	struct kobject **pdm_kobj;
+	struct regmap *periph_regs;
+	struct platform_device *pdev;
+};
+
+struct img_pdm_channel {
+	unsigned int pdm_id;
+	unsigned long flags;
+	struct img_pdm_device *pdm_dev;
+};
+
+struct img_pdm_channel *img_pdm_channel_request(unsigned int pdm_id);
+int img_pdm_channel_free(struct img_pdm_channel *chan);
+int img_pdm_channel_enable_get(struct img_pdm_channel *chan);
+int img_pdm_channel_enable_set(struct img_pdm_channel *chan, bool state);
+int img_pdm_channel_pulse_in_get(struct img_pdm_channel *chan);
+int img_pdm_channel_pulse_in_set(struct img_pdm_channel *chan,
+							unsigned int val);
+struct img_pdm_channel *img_pdm_channel_get(struct device *dev);
+void img_pdm_channel_put(struct device *dev);
+
+#endif
-- 
1.7.0.4
