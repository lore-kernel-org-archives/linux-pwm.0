From: Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v5 5/7] iio: temperature: Add support for Azoteq IQS620AT temperature sensor
Date: Sun, 16 Feb 2020 17:32:09 -0600
Message-ID: <1581895931-6056-6-git-send-email-jeff@labundy.com>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1581895931-6056-1-git-send-email-jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

This patch adds support for the Azoteq IQS620AT temperature sensor,
capable of reporting its absolute die temperature.

Signed-off-by: Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
Changes in v5:
  - Replaced iqs62x->map with iqs62x->regmap throughout
  - Dropped #defines for platform_driver name and alias in favor of the actual
    string names

Changes in v4:
  - None

Changes in v3:
  - Added Reviewed-by trailer

Changes in v2:
  - Moved the driver from hwmon to iio
  - Merged 'Copyright' and 'Author' lines into one in introductory comments
  - Replaced 'error' with 'ret' throughout
  - Eliminated tabbed alignment of platform_driver struct members
  - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST

 drivers/iio/temperature/Kconfig         | 10 ++++
 drivers/iio/temperature/Makefile        |  1 +
 drivers/iio/temperature/iqs620at-temp.c | 97 +++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)
 create mode 100644 drivers/iio/temperature/iqs620at-temp.c

diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index e1ccb40..f1f2a14 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -4,6 +4,16 @@
 #
 menu "Temperature sensors"

+config IQS620AT_TEMP
+	tristate "Azoteq IQS620AT temperature sensor"
+	depends on MFD_IQS62X || COMPILE_TEST
+	help
+	  Say Y here if you want to build support for the Azoteq IQS620AT
+	  temperature sensor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called iqs620at-temp.
+
 config LTC2983
 	tristate "Analog Devices Multi-Sensor Digital Temperature Measurement System"
 	depends on SPI
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index d6b850b..90c1131 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -3,6 +3,7 @@
 # Makefile for industrial I/O temperature drivers
 #

+obj-$(CONFIG_IQS620AT_TEMP) += iqs620at-temp.o
 obj-$(CONFIG_LTC2983) += ltc2983.o
 obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
 obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
diff --git a/drivers/iio/temperature/iqs620at-temp.c b/drivers/iio/temperature/iqs620at-temp.c
new file mode 100644
index 0000000..3fd52b3
--- /dev/null
+++ b/drivers/iio/temperature/iqs620at-temp.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS620AT Temperature Sensor
+ *
+ * Copyright (C) 2019 Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
+ */
+
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/mfd/iqs62x.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define IQS620_TEMP_UI_OUT			0x1A
+
+#define IQS620_TEMP_SCALE			1000
+#define IQS620_TEMP_OFFSET			(-100)
+
+static int iqs620_temp_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct iqs62x_core *iqs62x = iio_device_get_drvdata(indio_dev);
+	int ret;
+	__le16 val_buf;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_raw_read(iqs62x->regmap, IQS620_TEMP_UI_OUT,
+				      &val_buf, sizeof(val_buf));
+		if (ret)
+			return ret;
+
+		*val = le16_to_cpu(val_buf);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = IQS620_TEMP_SCALE;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_OFFSET:
+		*val = IQS620_TEMP_OFFSET;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info iqs620_temp_info = {
+	.read_raw = &iqs620_temp_read_raw,
+};
+
+static const struct iio_chan_spec iqs620_temp_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+	},
+};
+
+static int iqs620_temp_probe(struct platform_device *pdev)
+{
+	struct iqs62x_core *iqs62x = dev_get_drvdata(pdev->dev.parent);
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, 0);
+	if (!indio_dev)
+		return -ENOMEM;
+
+	iio_device_set_drvdata(indio_dev, iqs62x);
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->channels = iqs620_temp_channels;
+	indio_dev->num_channels = ARRAY_SIZE(iqs620_temp_channels);
+	indio_dev->name = iqs62x->dev_desc->dev_name;
+	indio_dev->info = &iqs620_temp_info;
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static struct platform_driver iqs620_temp_platform_driver = {
+	.driver = {
+		.name = "iqs620at-temp",
+	},
+	.probe = iqs620_temp_probe,
+};
+module_platform_driver(iqs620_temp_platform_driver);
+
+MODULE_AUTHOR("Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>");
+MODULE_DESCRIPTION("Azoteq IQS620AT Temperature Sensor");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:iqs620at-temp");
--
2.7.4
