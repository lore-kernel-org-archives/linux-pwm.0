From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH 0/4] pwm: add support for ChromeOS EC PWM
Date: Fri, 27 May 2016 18:39:12 -0700
Message-ID: <1464399556-17222-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36034 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbcE1BkA (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 27 May 2016 21:40:00 -0400
Received: by mail-pf0-f174.google.com with SMTP id f144so33569881pfa.3
        for <linux-pwm@vger.kernel.org>; Fri, 27 May 2016 18:40:00 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>
Cc: linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Sameer Nanda <snanda@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Brian Norris <briannorris@chromium.org>

Hi,

This series adds support for the new ChromeOS EC PWM API, so we can control,
e.g., the backlight when it's attached to the EC. It uses Boris's latest
"atomic" hooks for the PWM API (i.e., the ->apply() callback), which were
recently merged.

It seems nice to have the cros_ec_cmd_xfer_status() helper, which we have
locally in the ChromeOS kernel, and which has been part of another larger patch
series:

https://lkml.org/lkml/2016/4/12/342

So I've picked it into this series as well. Obviously, I don't care which one
is taken, but AFAICT, Tomeu's USB PD series isn't extremely active right now.

As this touches MFD (sort of), drivers/platform/chrome/, and drivers/pwm/, I'm
not sure who it should all go through: Lee, Thierry, or Olof?

Anyway, please review.

Regards,
Brian

Brian Norris (3):
  mfd: cros_ec: add EC_PWM function definitions
  doc: dt: pwm: add binding for ChromeOS EC PWM
  pwm: add ChromeOS EC PWM driver

Tomeu Vizoso (1):
  mfd: cros_ec: Add cros_ec_cmd_xfer_status helper

 .../devicetree/bindings/pwm/google,cros-ec-pwm.txt |  25 +++
 drivers/platform/chrome/cros_ec_proto.c            |  15 ++
 drivers/pwm/Kconfig                                |   7 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-cros-ec.c                          | 230 +++++++++++++++++++++
 include/linux/mfd/cros_ec.h                        |  18 ++
 include/linux/mfd/cros_ec_commands.h               |  31 +++
 7 files changed, 327 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
 create mode 100644 drivers/pwm/pwm-cros-ec.c

-- 
2.8.0.rc3.226.g39d4020
