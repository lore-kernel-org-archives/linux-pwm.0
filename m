Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from p3plsmtpa06-04.prod.phx3.secureserver.net ([173.201.192.105]:37476
        "EHLO p3plsmtpa06-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbfJUETK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 00:19:10 -0400
From: Jeff LaBundy <jeff@labundy.com>
Date: Sun, 20 Oct 2019 23:11:15 -0500
Message-Id: <1571631083-4962-1-git-send-email-jeff@labundy.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH 0/8] Add support for Azoteq IQS620A/621/622/624/625
To: lee.jones@linaro.org, dmitry.torokhov@gmail.com, jdelvare@suse.com, linux@roeck-us.net, thierry.reding@gmail.com, jic23@kernel.org, devicetree@vger.kernel.org
Cc: linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, Jeff LaBundy <jeff@labundy.com>

This series adds support for six-channel members of the Azoteq ProxFusion
family of sensor devices: IQS620A, IQS621, IQS622, IQS624 and IQS625. Each
device integrates multiple sensor technologies in a single package.

A multi-function device (MFD) driver supports core functions common to all
devices, including device identification, firmware, interrupt handling and
runtime power management. The MFD driver is also responsible for adding all
product-specific sub-devices.

Each device supports self-capacitive, Hall-effect, and (in some cases) mutual-
inductive sensing. These functions represent keys or switches and are supported
by an input driver that covers all five devices. An assortment of pwm, hwmon
and iio drivers support device-specific functions.

This series was tested using the following development hardware: IQS620AEV04,
IQS621EV04, IQS622EV04 and IQS624/5EV04.

Jeff LaBundy (8):
  dt-bindings: mfd: iqs62x: Add bindings
  mfd: Add support for Azoteq IQS620A/621/622/624/625
  input: keyboard: Add support for Azoteq IQS620A/621/622/624/625
  hwmon: Add support for Azoteq IQS620AT temperature sensor
  pwm: Add support for Azoteq IQS620A PWM generator
  iio: light: Add support for Azoteq IQS621 ambient light sensor
  iio: proximity: Add support for Azoteq IQS622 proximity sensor
  iio: position: Add support for Azoteq IQS624/625 angle sensor

 Documentation/devicetree/bindings/mfd/iqs62x.txt | 242 +++++++++
 drivers/hwmon/Kconfig                            |  12 +-
 drivers/hwmon/Makefile                           |   1 +
 drivers/hwmon/iqs620at-temp.c                    |  96 ++++
 drivers/iio/Kconfig                              |   1 +
 drivers/iio/Makefile                             |   1 +
 drivers/iio/light/Kconfig                        |  10 +
 drivers/iio/light/Makefile                       |   1 +
 drivers/iio/light/iqs621-als.c                   | 361 +++++++++++++
 drivers/iio/position/Kconfig                     |  19 +
 drivers/iio/position/Makefile                    |   7 +
 drivers/iio/position/iqs624-pos.c                | 302 +++++++++++
 drivers/iio/proximity/Kconfig                    |  10 +
 drivers/iio/proximity/Makefile                   |   1 +
 drivers/iio/proximity/iqs622-prox.c              | 334 ++++++++++++
 drivers/input/keyboard/Kconfig                   |  10 +
 drivers/input/keyboard/Makefile                  |   1 +
 drivers/input/keyboard/iqs62x-keys.c             | 340 ++++++++++++
 drivers/mfd/Kconfig                              |  13 +
 drivers/mfd/Makefile                             |   2 +
 drivers/mfd/iqs62x-core.c                        | 638 +++++++++++++++++++++++
 drivers/mfd/iqs62x-tables.c                      | 424 +++++++++++++++
 drivers/pwm/Kconfig                              |  10 +
 drivers/pwm/Makefile                             |   1 +
 drivers/pwm/pwm-iqs620a.c                        | 167 ++++++
 include/linux/mfd/iqs62x.h                       | 148 ++++++
 26 files changed, 3151 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/iqs62x.txt
 create mode 100644 drivers/hwmon/iqs620at-temp.c
 create mode 100644 drivers/iio/light/iqs621-als.c
 create mode 100644 drivers/iio/position/Kconfig
 create mode 100644 drivers/iio/position/Makefile
 create mode 100644 drivers/iio/position/iqs624-pos.c
 create mode 100644 drivers/iio/proximity/iqs622-prox.c
 create mode 100644 drivers/input/keyboard/iqs62x-keys.c
 create mode 100644 drivers/mfd/iqs62x-core.c
 create mode 100644 drivers/mfd/iqs62x-tables.c
 create mode 100644 drivers/pwm/pwm-iqs620a.c
 create mode 100644 include/linux/mfd/iqs62x.h

--
2.7.4
