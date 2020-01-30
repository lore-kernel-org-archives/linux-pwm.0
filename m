From: Prashant Malani <pmalani@chromium.org>
Subject: [PATCH 00/17] platform/chrome: Replace cros_ec_cmd_xfer_status
Date: Thu, 30 Jan 2020 12:30:31 -0800
Message-ID: <20200130203106.201894-1-pmalani@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Prashant Malani <pmalani@chromium.org>, Akshu Agrawal <akshu.agrawal@amd.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Evan Green <evgreen@chromium.org>, Fabien Lahoudere <fabien.lahoudere@collabora.com>, Guenter Roeck <groeck@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.o
List-Id: linux-pwm@vger.kernel.org

Many callers of cros_ec_cmd_xfer_status() use similar setup and cleanup
code, including setting up the cros_ec_command message struct and
copying the received buffer.

This series introduces a replacement function cros_ec_send_cmd_msg() that
performs this setup and teardown, and then updates all call sites that
used xfer_status() to use the new function instead.

The final patch in the series drops cros_ec_cmd_xfer_status() altogether.

Prashant Malani (17):
  platform/chrome: Add EC command msg wrapper
  platform/chrome: chardev: Use send_cmd_msg()
  platform/chrome: proto: Use send_cmd_msg
  platform/chrome: usbpd_logger: Use cmd_send_msg()
  platform/chrome: sensorhub: Use send_cmd_msg()
  platform/chrome: debugfs: Use send_cmd_msg()
  platform/chrome: sysfs: Use send_cmd_msg()
  extcon: cros_ec: Use cros_ec_send_cmd_msg()
  hid: google-hammer: Use cros_ec_send_cmd_msg()
  iio: cros_ec: Use cros_ec_send_cmd_msg()
  ASoC: cros_ec_codec: Use cros_ec_send_cmd_msg()
  power: supply: cros: Use cros_ec_send_cmd_msg()
  pwm: cros-ec: Remove cros_ec_cmd_xfer_status()
  rtc: cros-ec: Use cros_ec_send_cmd_msg()
  media: cros-ec-cec: Use cros_ec_send_cmd_msg()
  i2c: cros-ec-tunnel: Use cros_ec_send_cmd_msg()
  platform/chrome: Drop cros_ec_cmd_xfer_status()

 drivers/extcon/extcon-usbc-cros-ec.c          |  62 ++------
 drivers/hid/hid-google-hammer.c               |  23 +--
 drivers/i2c/busses/i2c-cros-ec-tunnel.c       |  23 ++-
 .../cros_ec_sensors/cros_ec_sensors_core.c    |  43 +++---
 .../media/platform/cros-ec-cec/cros-ec-cec.c  |  39 ++---
 drivers/platform/chrome/cros_ec_chardev.c     |  18 +--
 drivers/platform/chrome/cros_ec_debugfs.c     | 135 ++++++------------
 drivers/platform/chrome/cros_ec_proto.c       |  75 ++++++----
 drivers/platform/chrome/cros_ec_sensorhub.c   |  29 ++--
 drivers/platform/chrome/cros_ec_sysfs.c       | 106 ++++++--------
 drivers/platform/chrome/cros_usbpd_logger.c   |  13 +-
 drivers/power/supply/cros_usbpd-charger.c     |  63 ++------
 drivers/pwm/pwm-cros-ec.c                     |  27 ++--
 drivers/rtc/rtc-cros-ec.c                     |  27 ++--
 include/linux/platform_data/cros_ec_proto.h   |   6 +-
 sound/soc/codecs/cros_ec_codec.c              |  71 +++------
 16 files changed, 276 insertions(+), 484 deletions(-)

-- 
2.25.0.341.g760bfbb309-goog
