From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [RFC PATCH 08/10] rtc: New driver for RTC in Netronix embedded controller
Date: Sun, 21 Jun 2020 00:42:19 +0200
Message-ID: <20200620224222.1312520-7-j.neuschaefer@gmx.net>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Sam Ravnborg <sam@ravnborg.org>, Linus Walleij <linus.walleij@linaro.org>, Heiko Stuebner <heiko.stuebner@theobroma-systems.com>, Stephan Gerhold <stephan@gerhold.net>, Lubomir Rintel <lkundrak@v3.sk>, Mark Brown <broonie@kernel.>
List-Id: linux-pwm@vger.kernel.org

With this driver, mainline Linux can keep its time and date in sync with
the vendor kernel.

Advanced functionality like alarm and automatic power-on is not yet
supported.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/rtc/Kconfig     |   4 ++
 drivers/rtc/Makefile    |   1 +
 drivers/rtc/rtc-ntxec.c | 115 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)
 create mode 100644 drivers/rtc/rtc-ntxec.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index b54d87d45c89b..2310d08933f9c 100644
=2D-- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1300,6 +1300,10 @@ config RTC_DRV_CROS_EC
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-cros-ec.

+config RTC_DRV_NTXEC
+	tristate "Netronix embedded controller RTC driver"
+	depends on MFD_NTXEC
+
 comment "on-CPU RTC drivers"

 config RTC_DRV_ASM9260
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 0721752c6ed4c..8653d04aefa99 100644
=2D-- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -111,6 +111,7 @@ obj-$(CONFIG_RTC_DRV_MT7622)	+=3D rtc-mt7622.o
 obj-$(CONFIG_RTC_DRV_MV)	+=3D rtc-mv.o
 obj-$(CONFIG_RTC_DRV_MXC)	+=3D rtc-mxc.o
 obj-$(CONFIG_RTC_DRV_MXC_V2)	+=3D rtc-mxc_v2.o
+obj-$(CONFIG_RTC_DRV_NTXEC)	+=3D rtc-ntxec.o
 obj-$(CONFIG_RTC_DRV_OMAP)	+=3D rtc-omap.o
 obj-$(CONFIG_RTC_DRV_OPAL)	+=3D rtc-opal.o
 obj-$(CONFIG_RTC_DRV_PALMAS)	+=3D rtc-palmas.o
diff --git a/drivers/rtc/rtc-ntxec.c b/drivers/rtc/rtc-ntxec.c
new file mode 100644
index 0000000000000..44d5a5eedb597
=2D-- /dev/null
+++ b/drivers/rtc/rtc-ntxec.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2020 Jonathan Neusch=C3=A4fer
+
+#include <linux/rtc.h>
+#include <linux/mfd/ntxec.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+struct ntxec_rtc {
+	struct device *dev;
+	struct ntxec *ec;
+};
+
+#define NTXEC_WRITE_YEAR	0x10
+#define NTXEC_WRITE_MONTH	0x11
+#define NTXEC_WRITE_DAY		0x12
+#define NTXEC_WRITE_HOUR	0x13
+#define NTXEC_WRITE_MINUTE	0x14
+#define NTXEC_WRITE_SECOND	0x15
+
+#define NTXEC_READ_YM		0x20
+#define NTXEC_READ_DH		0x21
+#define NTXEC_READ_MS		0x22
+
+
+static int ntxec_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct ntxec_rtc *rtc =3D dev_get_drvdata(dev);
+	int res;
+
+	res =3D ntxec_read16(rtc->ec, NTXEC_READ_YM);
+	if (res < 0)
+		return res;
+
+	tm->tm_year =3D (res >> 8) + 100;
+	tm->tm_mon =3D (res & 0xff) - 1;
+
+	res =3D ntxec_read16(rtc->ec, NTXEC_READ_DH);
+	if (res < 0)
+		return res;
+
+	tm->tm_mday =3D res >> 8;
+	tm->tm_hour =3D res & 0xff;
+
+	res =3D ntxec_read16(rtc->ec, NTXEC_READ_MS);
+	if (res < 0)
+		return res;
+
+	tm->tm_min =3D res >> 8;
+	tm->tm_sec =3D res & 0xff;
+
+	return 0;
+}
+
+static int ntxec_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct ntxec_rtc *rtc =3D dev_get_drvdata(dev);
+	int res =3D 0;
+
+	res |=3D ntxec_write8(rtc->ec, NTXEC_WRITE_YEAR, tm->tm_year - 100);
+	res |=3D ntxec_write8(rtc->ec, NTXEC_WRITE_MONTH, tm->tm_mon + 1);
+	res |=3D ntxec_write8(rtc->ec, NTXEC_WRITE_DAY, tm->tm_mday);
+	res |=3D ntxec_write8(rtc->ec, NTXEC_WRITE_HOUR, tm->tm_hour);
+	res |=3D ntxec_write8(rtc->ec, NTXEC_WRITE_MINUTE, tm->tm_min);
+	res |=3D ntxec_write8(rtc->ec, NTXEC_WRITE_SECOND, tm->tm_sec);
+
+	return (res < 0)? -EIO : 0;
+}
+
+static const struct rtc_class_ops ntxec_rtc_ops =3D {
+	.read_time		=3D ntxec_read_time,
+	.set_time		=3D ntxec_set_time,
+};
+
+static int ntxec_rtc_probe(struct platform_device *pdev)
+{
+	struct rtc_device *rtcdev;
+	struct ntxec_rtc *rtc;
+
+	rtc =3D devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	rtc->dev =3D &pdev->dev;
+	rtc->ec =3D dev_get_drvdata(pdev->dev.parent);
+	platform_set_drvdata(pdev, rtc);
+
+	rtcdev =3D devm_rtc_device_register(&pdev->dev, "ntxec-rtc",
+					  &ntxec_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtcdev))
+		return PTR_ERR(rtc);
+
+	return 0;
+}
+
+static const struct of_device_id ntxec_rtc_of_match[] =3D {
+	{ .compatible =3D "netronix,ntxec-rtc" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ntxec_rtc_of_match);
+
+static struct platform_driver ntxec_rtc_driver =3D {
+	.driver =3D {
+		.name =3D "ntxec-rtc",
+		.of_match_table =3D ntxec_rtc_of_match,
+	},
+	.probe =3D ntxec_rtc_probe,
+};
+module_platform_driver(ntxec_rtc_driver);
+
+MODULE_AUTHOR("Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>");
+MODULE_DESCRIPTION("RTC driver for Netronix EC");
+MODULE_LICENSE("GPL");
=2D-
2.27.0
