Return-Path: <enric.balletbo@collabora.com>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 02/11] mfd / platform: cros_ec: Move cros-ec core driver out from MFD
Date: Tue, 25 Jun 2019 11:38:10 +0200
Message-Id: <20190625093819.10190-3-enric.balletbo@collabora.com>
In-Reply-To: <20190625093819.10190-1-enric.balletbo@collabora.com>
References: <20190625093819.10190-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-pwm.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, gwendal@chromium.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Cheng-Yi Chiang <cychiang@chromium.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, Neil Armstrong <narmstrong@baylibre.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, linux-media@vger.kernel.org, linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sebastian Reichel <sebastian.reichel@collabora.com>

Now, the ChromeOS EC core driver has nothing related to an MFD device, so
move that driver from the MFD subsystem to the platform/chrome subsystem.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Gwendal Grignou <gwendal@chromium.org>
---

Changes in v3: None
Changes in v2: None

 drivers/extcon/Kconfig                     |  2 +-
 drivers/hid/Kconfig                        |  2 +-
 drivers/i2c/busses/Kconfig                 |  2 +-
 drivers/iio/common/cros_ec_sensors/Kconfig |  2 +-
 drivers/input/keyboard/Kconfig             |  2 +-
 drivers/media/platform/Kconfig             |  3 +--
 drivers/mfd/Kconfig                        | 14 +-------------
 drivers/mfd/Makefile                       |  2 --
 drivers/platform/chrome/Kconfig            | 21 +++++++++++++++++----
 drivers/platform/chrome/Makefile           |  1 +
 drivers/{mfd => platform/chrome}/cros_ec.c |  0
 drivers/power/supply/Kconfig               |  2 +-
 drivers/pwm/Kconfig                        |  2 +-
 drivers/rtc/Kconfig                        |  2 +-
 sound/soc/codecs/Kconfig                   |  4 ++--
 sound/soc/qcom/Kconfig                     |  2 +-
 16 files changed, 31 insertions(+), 32 deletions(-)
 rename drivers/{mfd => platform/chrome}/cros_ec.c (100%)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index de06fafb52ff..5b0996b10d40 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -168,7 +168,7 @@ config EXTCON_USB_GPIO
 
 config EXTCON_USBC_CROS_EC
 	tristate "ChromeOS Embedded Controller EXTCON support"
-	depends on MFD_CROS_EC
+	depends on CROS_EC
 	help
 	  Say Y here to enable USB Type C cable detection extcon support when
 	  using Chrome OS EC based USB Type-C ports.
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index c3c390ca3690..b8022c158cb7 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -375,7 +375,7 @@ config HOLTEK_FF
 
 config HID_GOOGLE_HAMMER
 	tristate "Google Hammer Keyboard"
-	depends on USB_HID && LEDS_CLASS && MFD_CROS_EC
+	depends on USB_HID && LEDS_CLASS && CROS_EC
 	---help---
 	Say Y here if you have a Google Hammer device.
 
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 26186439db6b..f2c2ab7eeffa 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1335,7 +1335,7 @@ config I2C_SIBYTE
 
 config I2C_CROS_EC_TUNNEL
 	tristate "ChromeOS EC tunnel I2C bus"
-	depends on MFD_CROS_EC
+	depends on CROS_EC
 	help
 	  If you say yes here you get an I2C bus that will tunnel i2c commands
 	  through to the other side of the ChromeOS EC to the i2c bus
diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
index 135f6825903f..c7d5b140491f 100644
--- a/drivers/iio/common/cros_ec_sensors/Kconfig
+++ b/drivers/iio/common/cros_ec_sensors/Kconfig
@@ -3,7 +3,7 @@
 #
 config IIO_CROS_EC_SENSORS_CORE
 	tristate "ChromeOS EC Sensors Core"
-	depends on SYSFS && MFD_CROS_EC
+	depends on SYSFS && CROS_EC
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 82398827b64f..fb843b56d439 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -728,7 +728,7 @@ config KEYBOARD_W90P910
 config KEYBOARD_CROS_EC
 	tristate "ChromeOS EC keyboard"
 	select INPUT_MATRIXKMAP
-	depends on MFD_CROS_EC
+	depends on CROS_EC
 	help
 	  Say Y here to enable the matrix keyboard used by ChromeOS devices
 	  and implemented on the ChromeOS EC. You must enable one bus option
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 011c1c2fcf19..9883526c5ff0 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -557,10 +557,9 @@ if CEC_PLATFORM_DRIVERS
 
 config VIDEO_CROS_EC_CEC
 	tristate "ChromeOS EC CEC driver"
-	depends on MFD_CROS_EC
+	depends on CROS_EC
 	select CEC_CORE
 	select CEC_NOTIFIER
-	select CHROME_PLATFORMS
 	select CROS_EC_PROTO
 	help
 	  If you say yes here you will get support for the
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 294d9567cc71..5bcf0af6471d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -210,21 +210,9 @@ config MFD_AXP20X_RSB
 	  components like regulators or the PEK (Power Enable Key) under the
 	  corresponding menus.
 
-config MFD_CROS_EC
-	tristate "ChromeOS Embedded Controller"
-	select MFD_CORE
-	select CHROME_PLATFORMS
-	select CROS_EC_PROTO
-	depends on X86 || ARM || ARM64 || COMPILE_TEST
-	help
-	  If you say Y here you get support for the ChromeOS Embedded
-	  Controller (EC) providing keyboard, battery and power services.
-	  You also need to enable the driver for the bus you are using. The
-	  protocol for talking to the EC is defined by the bus driver.
-
 config MFD_CROS_EC_CHARDEV
 	tristate "Chrome OS Embedded Controller userspace device interface"
-	depends on MFD_CROS_EC
+	depends on CROS_EC
 	---help---
 	  This driver adds support to talk with the ChromeOS EC from userspace.
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 52b1a90ff515..32327dc6bb45 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -13,8 +13,6 @@ obj-$(CONFIG_MFD_ASIC3)		+= asic3.o tmio_core.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
 obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
 obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
-cros_ec_core-objs		:= cros_ec.o
-obj-$(CONFIG_MFD_CROS_EC)	+= cros_ec_core.o
 obj-$(CONFIG_MFD_CROS_EC_CHARDEV) += cros_ec_dev.o
 obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
 
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 997317d2f2b9..1e7a10500b3f 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -49,9 +49,22 @@ config CHROMEOS_TBMC
 	  To compile this driver as a module, choose M here: the
 	  module will be called chromeos_tbmc.
 
+config CROS_EC
+	tristate "ChromeOS Embedded Controller"
+	select CROS_EC_PROTO
+	depends on X86 || ARM || ARM64 || COMPILE_TEST
+	help
+	  If you say Y here you get support for the ChromeOS Embedded
+	  Controller (EC) providing keyboard, battery and power services.
+	  You also need to enable the driver for the bus you are using. The
+	  protocol for talking to the EC is defined by the bus driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cros_ec.
+
 config CROS_EC_I2C
 	tristate "ChromeOS Embedded Controller (I2C)"
-	depends on MFD_CROS_EC && I2C
+	depends on CROS_EC && I2C
 
 	help
 	  If you say Y here, you get support for talking to the ChromeOS
@@ -61,7 +74,7 @@ config CROS_EC_I2C
 
 config CROS_EC_RPMSG
 	tristate "ChromeOS Embedded Controller (rpmsg)"
-	depends on MFD_CROS_EC && RPMSG && OF
+	depends on CROS_EC && RPMSG && OF
 	help
 	  If you say Y here, you get support for talking to the ChromeOS EC
 	  through rpmsg. This uses a simple byte-level protocol with a
@@ -73,7 +86,7 @@ config CROS_EC_RPMSG
 
 config CROS_EC_SPI
 	tristate "ChromeOS Embedded Controller (SPI)"
-	depends on MFD_CROS_EC && SPI
+	depends on CROS_EC && SPI
 
 	---help---
 	  If you say Y here, you get support for talking to the ChromeOS EC
@@ -83,7 +96,7 @@ config CROS_EC_SPI
 
 config CROS_EC_LPC
         tristate "ChromeOS Embedded Controller (LPC)"
-        depends on MFD_CROS_EC && ACPI && (X86 || COMPILE_TEST)
+        depends on CROS_EC && ACPI && (X86 || COMPILE_TEST)
         help
           If you say Y here, you get support for talking to the ChromeOS EC
           over an LPC bus. This uses a simple byte-level protocol with a
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 1b2f1dcfcd5c..f69e0be98bd6 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -6,6 +6,7 @@ CFLAGS_cros_ec_trace.o:=		-I$(src)
 obj-$(CONFIG_CHROMEOS_LAPTOP)		+= chromeos_laptop.o
 obj-$(CONFIG_CHROMEOS_PSTORE)		+= chromeos_pstore.o
 obj-$(CONFIG_CHROMEOS_TBMC)		+= chromeos_tbmc.o
+obj-$(CONFIG_CROS_EC)			+= cros_ec.o
 obj-$(CONFIG_CROS_EC_I2C)		+= cros_ec_i2c.o
 obj-$(CONFIG_CROS_EC_RPMSG)		+= cros_ec_rpmsg.o
 obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
diff --git a/drivers/mfd/cros_ec.c b/drivers/platform/chrome/cros_ec.c
similarity index 100%
rename from drivers/mfd/cros_ec.c
rename to drivers/platform/chrome/cros_ec.c
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 26dacdab03cc..4c60cf22dbd7 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -655,7 +655,7 @@ config CHARGER_RT9455
 
 config CHARGER_CROS_USBPD
 	tristate "ChromeOS EC based USBPD charger"
-	depends on MFD_CROS_EC
+	depends on CROS_EC
 	default n
 	help
 	  Say Y here to enable ChromeOS EC based USBPD charger
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 1311b54089be..a7edd9cc35eb 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -144,7 +144,7 @@ config PWM_CRC
 
 config PWM_CROS_EC
 	tristate "ChromeOS EC PWM driver"
-	depends on MFD_CROS_EC
+	depends on CROS_EC
 	help
 	  PWM driver for exposing a PWM attached to the ChromeOS Embedded
 	  Controller.
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 7b8e156dbf38..a4ed24b6ecdf 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1264,7 +1264,7 @@ config RTC_DRV_ZYNQMP
 
 config RTC_DRV_CROS_EC
 	tristate "Chrome OS EC RTC driver"
-	depends on MFD_CROS_EC
+	depends on CROS_EC
 	help
 	  If you say yes here you will get support for the
 	  Chrome OS Embedded Controller's RTC.
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 8f577258080b..895c763cf7dc 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -50,7 +50,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_BT_SCO
 	select SND_SOC_BD28623
 	select SND_SOC_CQ0093VC
-	select SND_SOC_CROS_EC_CODEC if MFD_CROS_EC
+	select SND_SOC_CROS_EC_CODEC if CROS_EC
 	select SND_SOC_CS35L32 if I2C
 	select SND_SOC_CS35L33 if I2C
 	select SND_SOC_CS35L34 if I2C
@@ -465,7 +465,7 @@ config SND_SOC_CQ0093VC
 
 config SND_SOC_CROS_EC_CODEC
 	tristate "codec driver for ChromeOS EC"
-	depends on MFD_CROS_EC
+	depends on CROS_EC
 	help
 	  If you say yes here you will get support for the
 	  ChromeOS Embedded Controller's Audio Codec.
diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index b1764af858ba..34636f5b2cd5 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -98,7 +98,7 @@ config SND_SOC_MSM8996
 
 config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
-	depends on QCOM_APR && MFD_CROS_EC && I2C
+	depends on QCOM_APR && CROS_EC && I2C
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
-- 
2.20.1
