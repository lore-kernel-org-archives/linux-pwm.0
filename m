From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4 0/4] pwm: add support for ChromeOS EC PWM
Date: Fri, 15 Jul 2016 16:28:40 -0700
Message-ID: <1468625324-41229-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>
Cc: linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Brian Norris <briannorris@chromium.org>
List-Id: linux-pwm@vger.kernel.org

Hi,

This is the 4th (and final?) version of my series to support the new ChromeOS
EC PWM API, so we can control, e.g., a PWM backlight when its PWM is attached
to the EC. It uses Boris's latest "atomic" hooks for the PWM API (i.e., the
->apply() callback), which were recently merged.

Pulled and adapted the cros_ec_cmd_xfer_status() helper from this patch, with
some minor modifications:

https://lkml.org/lkml/2016/4/12/342

Note that after some style bikeshedding, I proposed to put off rewriting the
entire cros_ec_commands.h header at the moment, due to the shared nature of
this file. Follow up here:

https://bugs.chromium.org/p/chromium/issues/detail?id=621123

As this touches MFD (sort of), drivers/platform/chrome/, and drivers/pwm/, I'm
still not sure who it should all go through: Lee, Thierry, or Olof?

Please review.

Regards,
Brian

Change log (also documented in each patch):

v4:
 * return -EPROTO in cros_ec_cmd_xfer_status(), instead of (-EECRESULT - FOO)
 * log EC error results with dev_dbg()

v3:
 * fix some int->hex
 * fix a small bug in the handling of 'disabled' vs. 'duty_cycle == 0'
 * collect acks, tested-by

v2:
 * drop the "google,max-pwms" property
 * separate the cros_ec vs. PWM abstractions a little more clearly in the driver
 * remove dynamic kzalloc()'s and rely on on-stack memory instead



Brian Norris (3):
  mfd: cros_ec: add EC_PWM function definitions
  doc: dt: pwm: add binding for ChromeOS EC PWM
  pwm: add ChromeOS EC PWM driver

Tomeu Vizoso (1):
  mfd: cros_ec: Add cros_ec_cmd_xfer_status helper

 .../devicetree/bindings/pwm/google,cros-ec-pwm.txt |  23 ++
 drivers/platform/chrome/cros_ec_proto.c            |  17 ++
 drivers/pwm/Kconfig                                |   7 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-cros-ec.c                          | 260 +++++++++++++++++++++
 include/linux/mfd/cros_ec.h                        |  15 ++
 include/linux/mfd/cros_ec_commands.h               |  31 +++
 7 files changed, 354 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
 create mode 100644 drivers/pwm/pwm-cros-ec.c

-- 
2.8.0.rc3.226.g39d4020
