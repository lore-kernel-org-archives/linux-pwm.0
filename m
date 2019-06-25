Return-Path: <enric.balletbo@collabora.com>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 05/11] mfd / platform: cros_ec: Rename config to a better name
Date: Tue, 25 Jun 2019 11:38:13 +0200
Message-Id: <20190625093819.10190-6-enric.balletbo@collabora.com>
In-Reply-To: <20190625093819.10190-1-enric.balletbo@collabora.com>
References: <20190625093819.10190-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-pwm.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, gwendal@chromium.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Cheng-Yi Chiang <cychiang@chromium.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, Neil Armstrong <narmstrong@baylibre.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, linux-media@vger.kernel.org, linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com

The cros-ec-dev is a multifunction device that now doesn't implement any
chardev communication interface. MFD_CROS_EC_CHARDEV doesn't look
a good name to describe that device and can cause confusion. Hence
rename it to CROS_EC_DEV.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Gwendal Grignou <gwendal@chromium.org>
---

Changes in v3: None
Changes in v2: None

 drivers/mfd/Kconfig             | 16 ++++++++++------
 drivers/mfd/Makefile            |  2 +-
 drivers/platform/chrome/Kconfig | 20 ++++++++++----------
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 5bcf0af6471d..490d9e0bedd9 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -210,14 +210,18 @@ config MFD_AXP20X_RSB
 	  components like regulators or the PEK (Power Enable Key) under the
 	  corresponding menus.
 
-config MFD_CROS_EC_CHARDEV
-	tristate "Chrome OS Embedded Controller userspace device interface"
+config MFD_CROS_EC_DEV
+	tristate "ChromeOS Embedded Controller multifunction device"
+	select MFD_CORE
 	depends on CROS_EC
-	---help---
-	  This driver adds support to talk with the ChromeOS EC from userspace.
+	default CROS_EC
+	help
+	  Select this to get support for ChromeOS Embedded Controller
+	  sub-devices. This driver will instantiate additional drivers such
+	  as RTC, USBPD, etc. but you have to select the individual drivers.
 
-	  If you have a supported Chromebook, choose Y or M here.
-	  The module will be called cros_ec_dev.
+	  To compile this driver as a module, choose M here: the module will be
+	  called cros-ec-dev.
 
 config MFD_MADERA
 	tristate "Cirrus Logic Madera codecs"
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 32327dc6bb45..7d2bb3f98894 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_MFD_ASIC3)		+= asic3.o tmio_core.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
 obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
 obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
-obj-$(CONFIG_MFD_CROS_EC_CHARDEV) += cros_ec_dev.o
+obj-$(CONFIG_MFD_CROS_EC_DEV)	+= cros_ec_dev.o
 obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
 
 obj-$(CONFIG_HTC_PASIC3)	+= htc-pasic3.o
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 221e709358c0..dd30fe14222d 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -135,8 +135,8 @@ config CROS_KBD_LED_BACKLIGHT
 
 config CROS_EC_CHARDEV
 	tristate "ChromeOS EC miscdevice"
-	depends on MFD_CROS_EC_CHARDEV
-	default MFD_CROS_EC_CHARDEV
+	depends on MFD_CROS_EC_DEV
+	default MFD_CROS_EC_DEV
 	help
 	  This driver adds file operations support to talk with the
 	  ChromeOS EC from userspace via a character device.
@@ -146,8 +146,8 @@ config CROS_EC_CHARDEV
 
 config CROS_EC_LIGHTBAR
 	tristate "Chromebook Pixel's lightbar support"
-	depends on MFD_CROS_EC_CHARDEV
-	default MFD_CROS_EC_CHARDEV
+	depends on MFD_CROS_EC_DEV
+	default MFD_CROS_EC_DEV
 	help
 	  This option exposes the Chromebook Pixel's lightbar to
 	  userspace.
@@ -157,8 +157,8 @@ config CROS_EC_LIGHTBAR
 
 config CROS_EC_VBC
 	tristate "ChromeOS EC vboot context support"
-	depends on MFD_CROS_EC_CHARDEV && OF
-	default MFD_CROS_EC_CHARDEV
+	depends on MFD_CROS_EC_DEV && OF
+	default MFD_CROS_EC_DEV
 	help
 	  This option exposes the ChromeOS EC vboot context nvram to
 	  userspace.
@@ -168,8 +168,8 @@ config CROS_EC_VBC
 
 config CROS_EC_DEBUGFS
 	tristate "Export ChromeOS EC internals in DebugFS"
-	depends on MFD_CROS_EC_CHARDEV && DEBUG_FS
-	default MFD_CROS_EC_CHARDEV
+	depends on MFD_CROS_EC_DEV && DEBUG_FS
+	default MFD_CROS_EC_DEV
 	help
 	  This option exposes the ChromeOS EC device internals to
 	  userspace.
@@ -179,8 +179,8 @@ config CROS_EC_DEBUGFS
 
 config CROS_EC_SYSFS
 	tristate "ChromeOS EC control and information through sysfs"
-	depends on MFD_CROS_EC_CHARDEV && SYSFS
-	default MFD_CROS_EC_CHARDEV
+	depends on MFD_CROS_EC_DEV && SYSFS
+	default MFD_CROS_EC_DEV
 	help
 	  This option exposes some sysfs attributes to control and get
 	  information from ChromeOS EC.
-- 
2.20.1
