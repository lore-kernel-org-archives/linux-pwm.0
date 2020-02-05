From: Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v2 00/17] platform/chrome: Replace
	cros_ec_cmd_xfer_status
Date: Wed,  5 Feb 2020 10:59:53 -0800
Message-ID: <20200205190028.183069-1-pmalani@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: linux-kernel@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Neil Armstrong <narmstrong@baylibre.com>, "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Guenter Roeck <groeck@chromium.org>, Fabien Lahoudere <fabien.lahoudere@collabora.com>, Rushikesh S Kadam <rushikesh.s.kadam@intel.com>, Cheng-Yi Chiang <cychiang@chromium.org>, "open list:REAL TIME CLOCK RTC SUBSYSTEM" <linux-rtc@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee.jones@linaro.org>, Takashi Iwai <tiwai@suse.com>, Sebastian Reichel <sebastian.reichel@collabora.com>, Evan Green <evgreen@chromium.org>, Chanwoo Choi <cw0>
List-Id: linux-pwm@vger.kernel.org

Many callers of cros_ec_cmd_xfer_status() use similar setup and cleanup
code, including setting up the cros_ec_command message struct and
copying the received buffer.

This series introduces a replacement function cros_ec_cmd() that
performs this setup and teardown, and then updates all call sites that
used xfer_status() to use the new function instead.

The final patch in the series drops cros_ec_cmd_xfer_status() altogether.

Changes in v2:
- Renamed new function to cros_ec_cmd()
- Added a "result" pointer argument, for call-sites that are interested
  in the EC command result.
- Updated subsequent patches to new function name and parameter list.
- Used C99 element setting to initialize some structs directly rather
  than zeroing them, then setting them.

v1: https://lkml.org/lkml/2020/1/30/802

Prashant Malani (17):
  platform/chrome: Add EC command msg wrapper
  platform/chrome: chardev: Use cros_ec_cmd()
  platform/chrome: proto: Use cros_ec_cmd()
  platform/chrome: usbpd_logger: Use cros_ec_cmd()
  platform/chrome: sensorhub: Use cros_ec_cmd()
  platform/chrome: debugfs: Use cros_ec_cmd()
  platform/chrome: sysfs: Use cros_ec_cmd()
  extcon: cros_ec: Use cros_ec_cmd()
  hid: google-hammer: Use cros_ec_cmd()
  iio: cros_ec: Use cros_ec_cmd()
  ASoC: cros_ec_codec: Use cros_ec_cmd()
  power: supply: cros: Use cros_ec_cmd()
  pwm: cros-ec: Remove cros_ec_cmd_xfer_status()
  rtc: cros-ec: Use cros_ec_cmd()
  media: cros-ec-cec: Use cros_ec_cmd()
  i2c: cros-ec-tunnel: Use cros_ec_cmd()
  platform/chrome: Drop cros_ec_cmd_xfer_status()

 drivers/extcon/extcon-usbc-cros-ec.c          |  61 ++------
 drivers/hid/hid-google-hammer.c               |  23 +--
 drivers/i2c/busses/i2c-cros-ec-tunnel.c       |  22 ++-
 .../cros_ec_sensors/cros_ec_sensors_core.c    |  25 ++--
 .../media/platform/cros-ec-cec/cros-ec-cec.c  |  45 +++---
 drivers/platform/chrome/cros_ec_chardev.c     |  17 +--
 drivers/platform/chrome/cros_ec_debugfs.c     | 131 ++++++------------
 drivers/platform/chrome/cros_ec_proto.c       |  76 ++++++----
 drivers/platform/chrome/cros_ec_sensorhub.c   |  30 ++--
 drivers/platform/chrome/cros_ec_sysfs.c       | 103 ++++++--------
 drivers/platform/chrome/cros_usbpd_logger.c   |  12 +-
 drivers/power/supply/cros_usbpd-charger.c     |  58 ++------
 drivers/pwm/pwm-cros-ec.c                     |  59 +++-----
 drivers/rtc/rtc-cros-ec.c                     |  27 ++--
 include/linux/platform_data/cros_ec_proto.h   |   5 +-
 sound/soc/codecs/cros_ec_codec.c              | 119 ++++++----------
 16 files changed, 277 insertions(+), 536 deletions(-)

-- 
2.25.0.341.g760bfbb309-goog
