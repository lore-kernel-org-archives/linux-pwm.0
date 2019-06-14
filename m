Return-Path: <enric.balletbo@collabora.com>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 00/10] Move part of cros-ec out of MFD subsystem
Date: Fri, 14 Jun 2019 18:36:25 +0200
Message-Id: <20190614163635.22413-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-pwm.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: gwendal@chromium.org, Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>, Lee Jones <lee.jones@linaro.org>, kernel@collabora.com, dtor@chromium.org, Patrick Lai <plai@codeaurora.org>, Alessandro Zummo <a.zummo@towertech.it>, Jean Delvare <jdelvare@suse.de>, Philipp Zabel <p.zabel@pengutronix.de>, Fabien Lahoudere <fabien.lahoudere@collabora.com>, linux-samsung-soc@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Colin Ian King <colin.king@canonical.com>, Kukjin Kim <kgene@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Elie Morisse <syniurge@gmail.com>, linux-pm@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>, Simon Horman <horms+renesas@verge.net.au>, Marco Felsch <m.felsch@pengutronix.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org, Wu Hao <hao.wu@intel.com>, linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Chanwoo Choi <cw00.choi@samsung.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Stefan Agner <stefan@agner.ch>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hans Verkuil <hans.verkuil@cisco.com>, linux-media@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Sakari Ailus <sakari.ailus@linux.intel.com>, Jagan Teki <jagan@amarulasolutions.com>, Evan Green <evgreen@chromium.org>, linux-arm-kernel@lists.infradead.org, Pu Wen <puwen@hygon.cn>, Enno Luebbers <enno.luebbers@intel.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Gerd Hoffmann <kraxel@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-iio@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Olof Johansson <olof@lixom.net>, linux-rtc@vger.kernel.org, Ettore Chimenti <ek5.chimenti@gmail.com>, Vignesh R <vigneshr@ti.com>, Brian Norris <briannorris@chromium.org>, Sebastian Reichel <sre@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Juergen Fitschen <jfi@ssv-embedded.de>, Jonathan Cameron <jic23@kernel.org>, Sean Young <sean@mess.org>, linux-pwm@vger.kernel.org, linux-input@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Daniel Mack <daniel@zonque.org>, Russell King <linux@armlinux.org.uk>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>, Jacky Bai <ping.bai@nxp.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Brown <broonie@kernel.org>, Neil Armstrong <narmstrong@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, Tony Lindgren <tony@atomide.com>, Kishon Vijay Abraham I <kishon@ti.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Alexandre Torgue <alexandre.torgue@st.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Marek Szyprowski <m.szyprowski@samsung.com>, Randy Dunlap <rdunlap@infradead.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rushikesh S Kadam <rushikesh.s.kadam@intel.com>, Will Deacon <will.deacon@arm.com>, Steve Longerbeam <slongerbeam@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Eddie James <eajames@linux.vnet.ibm.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Hartmut Knaack <knaack.h@gmx.de>, Cheng-Yi Chiang <cychiang@chromium.org>, Jaroslav Kysela <perex@perex.cz>, Guido Kiener <guido@kiener-muenchen.de>, Robert Jarzmik <robert.jarzmik@free.fr>, Ajay Gupta <ajayg@nvidia.com>

Hi,

This is another attempt to clean up a bit more the cros-ec driver
to have a better separation on what is part of the MFD subsystem and
what is part of platform/chrome.

It'd be really nice have some reviews, acks and tested on different
platforms from the chromiumos people before merge all this patchset,
as this moves a lot of code.

The major changes introduced by this patchset are:
1. Move the core driver to platform/chrome, as is not really related
   to an MFD device driver.
2. Create a new misc chardev driver to replace the chardev bits from
   cros-ec-dev (MFD)
3. Added some convenience structs on cros-ec-dev (MFD) to easy add
   more subdrivers avoiding to add more boiler plate.

Once applied we have moved all the code to platform/chrome except
the cros-ec-dev driver, which is the one that instantiates the different
subdrivers as cells of the MFD driver.

I tested the following patches on Veyron, Kevin, Samus, Peach Pi and
Peach Pit without noticing any problem, but they would need more
tests.

Waiting for your feedback,
  Enric

Changes in v2:
- Collect acks received.
- Remove '[PATCH 07/10] mfd: cros_ec: Update with SPDX Licence identifier
  and fix description' to avoid conflicts with some tree-wide patches
  that actually updates the Licence identifier.
- Add '[PATCH 10/10] arm/arm64: defconfig: Update configs to use the new
  CROS_EC options' to update the defconfigs after change some config
  symbols.
- Remove the list, and the lock, as are not needed (Greg Kroah-Hartman)
- Remove dev_info in probe, anyway we will see the chardev or not if the
  probe fails (Greg Kroah-Hartman)

Enric Balletbo i Serra (10):
  mfd / platform: cros_ec: Handle chained ECs as platform devices
  mfd / platform: cros_ec: Move cros-ec core driver out from MFD
  mfd / platform: cros_ec: Miscellaneous character device to talk with
    the EC
  mfd: cros_ec: Switch to use the new cros-ec-chardev driver
  mfd / platform: cros_ec: Rename config to a better name
  mfd / platform: cros_ec: Reorganize platform and mfd includes
  mfd: cros_ec: Use kzalloc and cros_ec_cmd_xfer_status helper
  mfd: cros_ec: Add convenience struct to define dedicated CrOS EC MCUs
  mfd: cros_ec: Add convenience struct to define autodetectable CrOS EC
    subdevices
  arm/arm64: defconfig: Update configs to use the new CROS_EC options

 Documentation/ioctl/ioctl-number.txt          |   2 +-
 arch/arm/configs/exynos_defconfig             |   4 +-
 arch/arm/configs/multi_v7_defconfig           |   6 +-
 arch/arm/configs/pxa_defconfig                |   4 +-
 arch/arm64/configs/defconfig                  |   6 +-
 drivers/extcon/Kconfig                        |   2 +-
 drivers/extcon/extcon-usbc-cros-ec.c          |   3 +-
 drivers/hid/Kconfig                           |   2 +-
 drivers/hid/hid-google-hammer.c               |   4 +-
 drivers/i2c/busses/Kconfig                    |   2 +-
 drivers/i2c/busses/i2c-cros-ec-tunnel.c       |   4 +-
 drivers/iio/accel/cros_ec_accel_legacy.c      |   3 +-
 drivers/iio/common/cros_ec_sensors/Kconfig    |   2 +-
 .../common/cros_ec_sensors/cros_ec_sensors.c  |   3 +-
 .../cros_ec_sensors/cros_ec_sensors_core.c    |   3 +-
 drivers/iio/light/cros_ec_light_prox.c        |   3 +-
 drivers/iio/pressure/cros_ec_baro.c           |   3 +-
 drivers/input/keyboard/Kconfig                |   2 +-
 drivers/input/keyboard/cros_ec_keyb.c         |   4 +-
 drivers/media/platform/Kconfig                |   3 +-
 .../media/platform/cros-ec-cec/cros-ec-cec.c  |   4 +-
 drivers/mfd/Kconfig                           |  26 +-
 drivers/mfd/Makefile                          |   4 +-
 drivers/mfd/cros_ec_dev.c                     | 429 +++++-------------
 drivers/platform/chrome/Kconfig               |  48 +-
 drivers/platform/chrome/Makefile              |   2 +
 drivers/{mfd => platform/chrome}/cros_ec.c    |  64 +--
 drivers/platform/chrome/cros_ec_chardev.c     | 253 +++++++++++
 drivers/platform/chrome/cros_ec_debugfs.c     |   3 +-
 drivers/platform/chrome/cros_ec_i2c.c         |  12 +-
 drivers/platform/chrome/cros_ec_lightbar.c    |   3 +-
 drivers/platform/chrome/cros_ec_lpc.c         |   7 +-
 drivers/platform/chrome/cros_ec_lpc_reg.c     |   4 +-
 drivers/platform/chrome/cros_ec_proto.c       |   3 +-
 drivers/platform/chrome/cros_ec_rpmsg.c       |   6 +-
 drivers/platform/chrome/cros_ec_spi.c         |  12 +-
 drivers/platform/chrome/cros_ec_sysfs.c       |   3 +-
 drivers/platform/chrome/cros_ec_trace.c       |   2 +-
 drivers/platform/chrome/cros_ec_trace.h       |   4 +-
 drivers/platform/chrome/cros_ec_vbc.c         |   3 +-
 drivers/platform/chrome/cros_usbpd_logger.c   |   5 +-
 drivers/power/supply/Kconfig                  |   2 +-
 drivers/power/supply/cros_usbpd-charger.c     |   5 +-
 drivers/pwm/Kconfig                           |   2 +-
 drivers/pwm/pwm-cros-ec.c                     |   4 +-
 drivers/rtc/Kconfig                           |   2 +-
 drivers/rtc/rtc-cros-ec.c                     |   3 +-
 .../linux/iio/common/cros_ec_sensors_core.h   |   3 +-
 include/linux/mfd/cros_ec.h                   | 290 ------------
 .../{mfd => platform_data}/cros_ec_commands.h |   0
 include/linux/platform_data/cros_ec_proto.h   | 315 +++++++++++++
 .../uapi/linux/cros_ec_chardev.h              |  20 +-
 sound/soc/codecs/cros_ec_codec.c              |   4 +-
 sound/soc/qcom/Kconfig                        |   2 +-
 54 files changed, 881 insertions(+), 733 deletions(-)
 rename drivers/{mfd => platform/chrome}/cros_ec.c (85%)
 create mode 100644 drivers/platform/chrome/cros_ec_chardev.c
 rename include/linux/{mfd => platform_data}/cros_ec_commands.h (100%)
 create mode 100644 include/linux/platform_data/cros_ec_proto.h
 rename drivers/mfd/cros_ec_dev.h => include/uapi/linux/cros_ec_chardev.h (52%)

-- 
2.20.1
