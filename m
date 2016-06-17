From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 0/4] pwm: add support for ChromeOS EC PWM
Date: Fri, 17 Jun 2016 12:58:11 -0700
Message-ID: <1466193495-95801-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36505 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933385AbcFQT6e (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jun 2016 15:58:34 -0400
Received: by mail-pa0-f50.google.com with SMTP id b5so31247961pas.3
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jun 2016 12:58:34 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>
Cc: linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Brian Norris <briannorris@chromium.org>

Hi,

This is version 3 of my series to support the new ChromeOS EC PWM API, so we
can control, e.g., a PWM backlight when its PWM is attached to the EC. It uses
Boris's latest "atomic" hooks for the PWM API (i.e., the ->apply() callback),
which were recently merged.

It seems nice to have the cros_ec_cmd_xfer_status() helper, which we have
locally in the ChromeOS kernel, and which has been part of another larger patch
series:

https://lkml.org/lkml/2016/4/12/342

So I've picked it into this series as well. Tomeu has acknowledged his USB PD
series is on hold for now, so this should be OK.

Note that after some style bikeshedding, I proposed to put off rewriting the
entire cros_ec_commands.h header at the moment, due to the shared nature of
this file. I plan to follow up with this bug report:

https://bugs.chromium.org/p/chromium/issues/detail?id=621123

As this touches MFD (sort of), drivers/platform/chrome/, and drivers/pwm/, I'm
still not sure who it should all go through: Lee, Thierry, or Olof?

Please review.

Regards,
Brian

Change log (also documented in each patch):

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
 drivers/platform/chrome/cros_ec_proto.c            |  15 ++
 drivers/pwm/Kconfig                                |   7 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-cros-ec.c                          | 246 +++++++++++++++++++++
 include/linux/mfd/cros_ec.h                        |  18 ++
 include/linux/mfd/cros_ec_commands.h               |  31 +++
 7 files changed, 341 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
 create mode 100644 drivers/pwm/pwm-cros-ec.c

-- 
2.8.0.rc3.226.g39d4020
