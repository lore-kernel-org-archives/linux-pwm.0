Return-Path: <enric.balletbo@collabora.com>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 10/11] mfd: cros_ec: Use mfd_add_hotplug_devices() helper
Date: Tue, 25 Jun 2019 11:38:18 +0200
Message-Id: <20190625093819.10190-11-enric.balletbo@collabora.com>
In-Reply-To: <20190625093819.10190-1-enric.balletbo@collabora.com>
References: <20190625093819.10190-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-pwm.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, gwendal@chromium.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Cheng-Yi Chiang <cychiang@chromium.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, Neil Armstrong <narmstrong@baylibre.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, linux-media@vger.kernel.org, linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com

Use mfd_add_hotplug_devices() helper to register the subdevices.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3:
- Add a new patch to use mfd_add_hoplug_devices to register subdevices

Changes in v2: None

 drivers/mfd/cros_ec_dev.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 96ba99a99c64..8b228864c55c 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -355,10 +355,8 @@ static int ec_device_probe(struct platform_device *pdev)
 	 * The following subdevices cannot be detected by sending the
 	 * EC_FEATURE_GET_CMD to the Embedded Controller device.
 	 */
-	retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
-				 cros_ec_platform_cells,
-				 ARRAY_SIZE(cros_ec_platform_cells),
-				 NULL, 0, NULL);
+	retval = mfd_add_hotplug_devices(ec->dev, cros_ec_platform_cells,
+					 ARRAY_SIZE(cros_ec_platform_cells));
 	if (retval)
 		dev_warn(ec->dev,
 			 "failed to add cros-ec platform devices: %d\n",
@@ -367,10 +365,8 @@ static int ec_device_probe(struct platform_device *pdev)
 	/* Check whether this EC instance has a VBC NVRAM */
 	node = ec->ec_dev->dev->of_node;
 	if (of_property_read_bool(node, "google,has-vbc-nvram")) {
-		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
-					 cros_ec_vbc_cells,
-					 ARRAY_SIZE(cros_ec_vbc_cells),
-					 NULL, 0, NULL);
+		retval = mfd_add_hotplug_devices(ec->dev, cros_ec_vbc_cells,
+						ARRAY_SIZE(cros_ec_vbc_cells));
 		if (retval)
 			dev_warn(ec->dev, "failed to add VBC devices: %d\n",
 				 retval);
-- 
2.20.1
