Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-mw2nam12on2065.outbound.protection.outlook.com ([40.107.244.65]:11831
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726621AbfLIAis (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 8 Dec 2019 19:38:48 -0500
From: Jeff LaBundy <jeff@labundy.com>
Date: Mon, 9 Dec 2019 00:38:38 +0000
Message-ID: <1575851866-18919-6-git-send-email-jeff@labundy.com>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
In-Reply-To: <1575851866-18919-1-git-send-email-jeff@labundy.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH v2 5/7] iio: temperature: Add support for Azoteq IQS620AT
 temperature sensor
To: "lee.jones@linaro.org" <lee.jones@linaro.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "jic23@kernel.org" <jic23@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Jeff LaBundy <jeff@labundy.com>

This patch adds support for the Azoteq IQS620AT temperature sensor,
capable of reporting its absolute die temperature.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
Changes in v2:
  - Moved the driver from hwmon to iio
  - Merged 'Copyright' and 'Author' lines into one in introductory comments
  - Replaced 'error' with 'ret' throughout
  - Eliminated tabbed alignment of platform_driver struct members
  - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST

 drivers/iio/temperature/Kconfig         | 10 ++++
 drivers/iio/temperature/Makefile        |  1 +
 drivers/iio/temperature/iqs620at-temp.c | 97 +++++++++++++++++++++++++++++=
++++
 3 files changed, 108 insertions(+)
 create mode 100644 drivers/iio/temperature/iqs620at-temp.c

diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kcon=
fig
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
 	tristate "Analog Devices Multi-Sensor Digital Temperature Measurement Sys=
tem"
 	depends on SPI
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Mak=
efile
index d6b850b..90c1131 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -3,6 +3,7 @@
 # Makefile for industrial I/O temperature drivers
 #

+obj-$(CONFIG_IQS620AT_TEMP) +=3D iqs620at-temp.o
 obj-$(CONFIG_LTC2983) +=3D ltc2983.o
 obj-$(CONFIG_HID_SENSOR_TEMP) +=3D hid-sensor-temperature.o
 obj-$(CONFIG_MAXIM_THERMOCOUPLE) +=3D maxim_thermocouple.o
diff --git a/drivers/iio/temperature/iqs620at-temp.c b/drivers/iio/temperat=
ure/iqs620at-temp.c
new file mode 100644
index 0000000..d20cb6ad
--- /dev/null
+++ b/drivers/iio/temperature/iqs620at-temp.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS620AT Temperature Sensor
+ *
+ * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
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
+	struct iqs62x_core *iqs62x =3D iio_device_get_drvdata(indio_dev);
+	int ret;
+	__le16 val_buf;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret =3D regmap_raw_read(iqs62x->map, IQS620_TEMP_UI_OUT, &val_buf,
+				      sizeof(val_buf));
+		if (ret)
+			return ret;
+
+		*val =3D le16_to_cpu(val_buf);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val =3D IQS620_TEMP_SCALE;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_OFFSET:
+		*val =3D IQS620_TEMP_OFFSET;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info iqs620_temp_info =3D {
+	.read_raw =3D &iqs620_temp_read_raw,
+};
+
+static const struct iio_chan_spec iqs620_temp_channels[] =3D {
+	{
+		.type =3D IIO_TEMP,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+	},
+};
+
+static int iqs620_temp_probe(struct platform_device *pdev)
+{
+	struct iqs62x_core *iqs62x =3D dev_get_drvdata(pdev->dev.parent);
+	struct iio_dev *indio_dev;
+
+	indio_dev =3D devm_iio_device_alloc(&pdev->dev, 0);
+	if (!indio_dev)
+		return -ENOMEM;
+
+	iio_device_set_drvdata(indio_dev, iqs62x);
+
+	indio_dev->modes =3D INDIO_DIRECT_MODE;
+	indio_dev->dev.parent =3D &pdev->dev;
+	indio_dev->channels =3D iqs620_temp_channels;
+	indio_dev->num_channels =3D ARRAY_SIZE(iqs620_temp_channels);
+	indio_dev->name =3D iqs62x->dev_desc->dev_name;
+	indio_dev->info =3D &iqs620_temp_info;
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static struct platform_driver iqs620_temp_platform_driver =3D {
+	.driver =3D {
+		.name =3D IQS620_DRV_NAME_TEMP,
+	},
+	.probe =3D iqs620_temp_probe,
+};
+module_platform_driver(iqs620_temp_platform_driver);
+
+MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
+MODULE_DESCRIPTION("Azoteq IQS620AT Temperature Sensor");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" IQS620_DRV_NAME_TEMP);
--
2.7.4
