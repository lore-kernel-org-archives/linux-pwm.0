Return-Path: <enric.balletbo@collabora.com>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 08/11] mfd: cros_ec: Add convenience struct to define dedicated CrOS EC MCUs
Date: Tue, 25 Jun 2019 11:38:16 +0200
Message-Id: <20190625093819.10190-9-enric.balletbo@collabora.com>
In-Reply-To: <20190625093819.10190-1-enric.balletbo@collabora.com>
References: <20190625093819.10190-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-pwm.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, gwendal@chromium.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Cheng-Yi Chiang <cychiang@chromium.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, Neil Armstrong <narmstrong@baylibre.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, linux-media@vger.kernel.org, linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com

With the increasing use of dedicated CrOS EC MCUs, it takes a fair amount
of boiler plate code to add those devices, add a struct that can be used
to specify a dedicated CrOS EC MCU so we can just add a new item to it to
define a new dedicated MCU.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Gwendal Grignou <gwendal@chromium.org>
---

Changes in v3: None
Changes in v2: None

 drivers/mfd/cros_ec_dev.c | 72 +++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 818eb1ba77bb..68fa3a0ba4d6 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -34,6 +34,36 @@ static struct class cros_class = {
 	.name           = "chromeos",
 };
 
+/**
+ * cros_feature_to_name - CrOS feature id to name/short description.
+ * @id: The feature identifier.
+ * @name: Device name associated with the feature id.
+ * @desc: Short name that will be displayed.
+ */
+struct cros_feature_to_name {
+	unsigned int id;
+	const char *name;
+	const char *desc;
+};
+
+static const struct cros_feature_to_name cros_mcu_devices[] = {
+	{
+		.id	= EC_FEATURE_FINGERPRINT,
+		.name	= CROS_EC_DEV_FP_NAME,
+		.desc	= "Fingerprint",
+	},
+	{
+		.id	= EC_FEATURE_ISH,
+		.name	= CROS_EC_DEV_ISH_NAME,
+		.desc	= "Integrated Sensor Hub",
+	},
+	{
+		.id	= EC_FEATURE_TOUCHPAD,
+		.name	= CROS_EC_DEV_TP_NAME,
+		.desc	= "Touchpad",
+	},
+};
+
 static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 {
 	struct cros_ec_command *msg;
@@ -224,6 +254,7 @@ static int ec_device_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct cros_ec_platform *ec_platform = dev_get_platdata(dev);
 	struct cros_ec_dev *ec = kzalloc(sizeof(*ec), GFP_KERNEL);
+	int i;
 
 	if (!ec)
 		return retval;
@@ -236,37 +267,20 @@ static int ec_device_probe(struct platform_device *pdev)
 	ec->features[1] = -1U; /* Not cached yet */
 	device_initialize(&ec->class_dev);
 
-	/* Check whether this is actually a Fingerprint MCU rather than an EC */
-	if (cros_ec_check_features(ec, EC_FEATURE_FINGERPRINT)) {
-		dev_info(dev, "CrOS Fingerprint MCU detected.\n");
+	for (i = 0; i < ARRAY_SIZE(cros_mcu_devices); i++) {
 		/*
-		 * Help userspace differentiating ECs from FP MCU,
-		 * regardless of the probing order.
+		 * Check whether this is actually a dedicated MCU rather
+		 * than an standard EC.
 		 */
-		ec_platform->ec_name = CROS_EC_DEV_FP_NAME;
-	}
-
-	/*
-	 * Check whether this is actually an Integrated Sensor Hub (ISH)
-	 * rather than an EC.
-	 */
-	if (cros_ec_check_features(ec, EC_FEATURE_ISH)) {
-		dev_info(dev, "CrOS ISH MCU detected.\n");
-		/*
-		 * Help userspace differentiating ECs from ISH MCU,
-		 * regardless of the probing order.
-		 */
-		ec_platform->ec_name = CROS_EC_DEV_ISH_NAME;
-	}
-
-	/* Check whether this is actually a Touchpad MCU rather than an EC */
-	if (cros_ec_check_features(ec, EC_FEATURE_TOUCHPAD)) {
-		dev_info(dev, "CrOS Touchpad MCU detected.\n");
-		/*
-		 * Help userspace differentiating ECs from TP MCU,
-		 * regardless of the probing order.
-		 */
-		ec_platform->ec_name = CROS_EC_DEV_TP_NAME;
+		if (cros_ec_check_features(ec, cros_mcu_devices[i].id)) {
+			dev_info(dev, "CrOS %s MCU detected\n",
+				 cros_mcu_devices[i].desc);
+			/*
+			 * Help userspace differentiating ECs from other MCU,
+			 * regardless of the probing order.
+			 */
+			ec_platform->ec_name = cros_mcu_devices[i].name;
+		}
 	}
 
 	/*
-- 
2.20.1
