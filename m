Return-Path: <enric.balletbo@collabora.com>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 09/11] mfd: cros_ec: Add convenience struct to define autodetectable CrOS EC subdevices
Date: Tue, 25 Jun 2019 11:38:17 +0200
Message-Id: <20190625093819.10190-10-enric.balletbo@collabora.com>
In-Reply-To: <20190625093819.10190-1-enric.balletbo@collabora.com>
References: <20190625093819.10190-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-pwm.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, gwendal@chromium.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Cheng-Yi Chiang <cychiang@chromium.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, Neil Armstrong <narmstrong@baylibre.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, linux-media@vger.kernel.org, linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com

The CrOS EC is gaining lots of subdevices that are autodetectable by
sending the EC_FEATURE_GET_CMD, it takes fair amount of boiler plate
code to add those devices. So, add a struct that can be used to quickly
add new subdevices without having to duplicate code.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Gwendal Grignou <gwendal@chromium.org>
---

Changes in v3:
- Use mfd_add_hotplug_devices helper (Gwendal)

Changes in v2: None

 drivers/mfd/cros_ec_dev.c | 131 +++++++++++++++++++++-----------------
 1 file changed, 73 insertions(+), 58 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 68fa3a0ba4d6..96ba99a99c64 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -46,6 +46,18 @@ struct cros_feature_to_name {
 	const char *desc;
 };
 
+/**
+ * cros_feature_to_cells - CrOS feature id to mfd cells association.
+ * @id: The feature identifier.
+ * @mfd_cells: Pointer to the array of mfd cells that needs to be added.
+ * @num_cells: Number of mfd cells into the array.
+ */
+struct cros_feature_to_cells {
+	unsigned int id;
+	const struct mfd_cell *mfd_cells;
+	unsigned int num_cells;
+};
+
 static const struct cros_feature_to_name cros_mcu_devices[] = {
 	{
 		.id	= EC_FEATURE_FINGERPRINT,
@@ -64,6 +76,48 @@ static const struct cros_feature_to_name cros_mcu_devices[] = {
 	},
 };
 
+static const struct mfd_cell cros_ec_cec_cells[] = {
+	{ .name = "cros-ec-cec", },
+};
+
+static const struct mfd_cell cros_ec_rtc_cells[] = {
+	{ .name = "cros-ec-rtc", },
+};
+
+static const struct mfd_cell cros_usbpd_charger_cells[] = {
+	{ .name = "cros-usbpd-charger", },
+	{ .name = "cros-usbpd-logger", },
+};
+
+static const struct cros_feature_to_cells cros_subdevices[] = {
+	{
+		.id		= EC_FEATURE_CEC,
+		.mfd_cells	= cros_ec_cec_cells,
+		.num_cells	= ARRAY_SIZE(cros_ec_cec_cells),
+	},
+	{
+		.id		= EC_FEATURE_RTC,
+		.mfd_cells	= cros_ec_rtc_cells,
+		.num_cells	= ARRAY_SIZE(cros_ec_rtc_cells),
+	},
+	{
+		.id		= EC_FEATURE_USB_PD,
+		.mfd_cells	= cros_usbpd_charger_cells,
+		.num_cells	= ARRAY_SIZE(cros_usbpd_charger_cells),
+	},
+};
+
+static const struct mfd_cell cros_ec_platform_cells[] = {
+	{ .name = "cros-ec-chardev", },
+	{ .name = "cros-ec-debugfs", },
+	{ .name = "cros-ec-lightbar", },
+	{ .name = "cros-ec-sysfs", },
+};
+
+static const struct mfd_cell cros_ec_vbc_cells[] = {
+	{ .name = "cros-ec-vbc", }
+};
+
 static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 {
 	struct cros_ec_command *msg;
@@ -223,30 +277,6 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 	kfree(msg);
 }
 
-static const struct mfd_cell cros_ec_cec_cells[] = {
-	{ .name = "cros-ec-cec" }
-};
-
-static const struct mfd_cell cros_ec_rtc_cells[] = {
-	{ .name = "cros-ec-rtc" }
-};
-
-static const struct mfd_cell cros_usbpd_charger_cells[] = {
-	{ .name = "cros-usbpd-charger" },
-	{ .name = "cros-usbpd-logger" },
-};
-
-static const struct mfd_cell cros_ec_platform_cells[] = {
-	{ .name = "cros-ec-chardev" },
-	{ .name = "cros-ec-debugfs" },
-	{ .name = "cros-ec-lightbar" },
-	{ .name = "cros-ec-sysfs" },
-};
-
-static const struct mfd_cell cros_ec_vbc_cells[] = {
-	{ .name = "cros-ec-vbc" }
-};
-
 static int ec_device_probe(struct platform_device *pdev)
 {
 	int retval = -ENOMEM;
@@ -304,42 +334,27 @@ static int ec_device_probe(struct platform_device *pdev)
 	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
 		cros_ec_sensors_register(ec);
 
-	/* Check whether this EC instance has CEC host command support */
-	if (cros_ec_check_features(ec, EC_FEATURE_CEC)) {
-		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
-					 cros_ec_cec_cells,
-					 ARRAY_SIZE(cros_ec_cec_cells),
-					 NULL, 0, NULL);
-		if (retval)
-			dev_err(ec->dev,
-				"failed to add cros-ec-cec device: %d\n",
-				retval);
-	}
-
-	/* Check whether this EC instance has RTC host command support */
-	if (cros_ec_check_features(ec, EC_FEATURE_RTC)) {
-		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
-					 cros_ec_rtc_cells,
-					 ARRAY_SIZE(cros_ec_rtc_cells),
-					 NULL, 0, NULL);
-		if (retval)
-			dev_err(ec->dev,
-				"failed to add cros-ec-rtc device: %d\n",
-				retval);
-	}
-
-	/* Check whether this EC instance has the PD charge manager */
-	if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
-		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
-					 cros_usbpd_charger_cells,
-					 ARRAY_SIZE(cros_usbpd_charger_cells),
-					 NULL, 0, NULL);
-		if (retval)
-			dev_err(ec->dev,
-				"failed to add cros-usbpd-charger device: %d\n",
-				retval);
+	/*
+	 * The following subdevices can be detected by sending the
+	 * EC_FEATURE_GET_CMD Embedded Controller device.
+	 */
+	for (i = 0; i < ARRAY_SIZE(cros_subdevices); i++) {
+		if (cros_ec_check_features(ec, cros_subdevices[i].id)) {
+			retval = mfd_add_hotplug_devices(ec->dev,
+						cros_subdevices[i].mfd_cells,
+						cros_subdevices[i].num_cells);
+			if (retval)
+				dev_err(ec->dev,
+					"failed to add %s subdevice: %d\n",
+					cros_subdevices[i].mfd_cells->name,
+					retval);
+		}
 	}
 
+	/*
+	 * The following subdevices cannot be detected by sending the
+	 * EC_FEATURE_GET_CMD to the Embedded Controller device.
+	 */
 	retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
 				 cros_ec_platform_cells,
 				 ARRAY_SIZE(cros_ec_platform_cells),
-- 
2.20.1
