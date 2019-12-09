Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-mw2nam12on2065.outbound.protection.outlook.com ([40.107.244.65]:11831
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbfLIAig (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 8 Dec 2019 19:38:36 -0500
From: Jeff LaBundy <jeff@labundy.com>
Date: Mon, 9 Dec 2019 00:38:31 +0000
Message-ID: <1575851866-18919-1-git-send-email-jeff@labundy.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH v2 0/7] Add support for Azoteq IQS620A/621/622/624/625
To: "lee.jones@linaro.org" <lee.jones@linaro.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "jic23@kernel.org" <jic23@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Jeff LaBundy <jeff@labundy.com>

This series adds support for the Azoteq IQS620A, IQS621, IQS622, IQS624 and
IQS625 multi-function sensors. Each device integrates numerous sensing tech=
-
nologies in a single package.

A multi-function device (MFD) driver supports core functions common to all
devices, including device identification, firmware, interrupt handling and
runtime power management. The MFD driver is also responsible for adding all
product-specific sub-devices.

Each device supports self-capacitive, Hall-effect, and (in some cases) mutu=
al-
inductive sensing. These functions represent keys or switches and are suppo=
rted
by an input driver that covers all five devices. An assortment of pwm and i=
io
drivers supports device-specific functions including ambient light and angu=
lar
position sensing.

This series was tested using the following development hardware: IQS620AEV0=
4,
IQS621EV04, IQS622EV04 and IQS624/5EV04.

Jeff LaBundy (7):
  dt-bindings: Add bindings for Azoteq IQS620A/621/622/624/625
  mfd: Add support for Azoteq IQS620A/621/622/624/625
  input: keyboard: Add support for Azoteq IQS620A/621/622/624/625
  pwm: Add support for Azoteq IQS620A PWM generator
  iio: temperature: Add support for Azoteq IQS620AT temperature sensor
  iio: light: Add support for Azoteq IQS621/622 ambient light sensors
  iio: position: Add support for Azoteq IQS624/625 angle sensors

 .../devicetree/bindings/input/iqs62x-keys.yaml     | 126 ++++
 Documentation/devicetree/bindings/mfd/iqs62x.yaml  | 177 ++++++
 .../devicetree/bindings/pwm/iqs620a-pwm.yaml       |  30 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/light/Kconfig                          |  10 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/iqs621-als.c                     | 614 +++++++++++++++++=
+++
 drivers/iio/position/Kconfig                       |  19 +
 drivers/iio/position/Makefile                      |   7 +
 drivers/iio/position/iqs624-pos.c                  | 284 +++++++++
 drivers/iio/temperature/Kconfig                    |  10 +
 drivers/iio/temperature/Makefile                   |   1 +
 drivers/iio/temperature/iqs620at-temp.c            |  97 ++++
 drivers/input/keyboard/Kconfig                     |  10 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/iqs62x-keys.c               | 340 +++++++++++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   3 +
 drivers/mfd/iqs62x-core.c                          | 639 +++++++++++++++++=
++++
 drivers/mfd/iqs62x-tables.c                        | 438 ++++++++++++++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-iqs620a.c                          | 206 +++++++
 include/linux/mfd/iqs62x.h                         | 146 +++++
 25 files changed, 3185 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/iqs62x-keys.yam=
l
 create mode 100644 Documentation/devicetree/bindings/mfd/iqs62x.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
 create mode 100644 drivers/iio/light/iqs621-als.c
 create mode 100644 drivers/iio/position/Kconfig
 create mode 100644 drivers/iio/position/Makefile
 create mode 100644 drivers/iio/position/iqs624-pos.c
 create mode 100644 drivers/iio/temperature/iqs620at-temp.c
 create mode 100644 drivers/input/keyboard/iqs62x-keys.c
 create mode 100644 drivers/mfd/iqs62x-core.c
 create mode 100644 drivers/mfd/iqs62x-tables.c
 create mode 100644 drivers/pwm/pwm-iqs620a.c
 create mode 100644 include/linux/mfd/iqs62x.h

--
2.7.4
