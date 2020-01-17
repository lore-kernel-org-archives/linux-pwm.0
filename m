From: Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v4 0/7] Add support for Azoteq IQS620A/621/622/624/625
Date: Fri, 17 Jan 2020 02:35:16 +0000
Message-ID: <1579228475-6681-1-git-send-email-jeff@labundy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "knaack.h-Mmb7MZpHnFY@public.gmane.org" <knaack.h-Mmb7MZpHnFY@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org" <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

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

 .../devicetree/bindings/input/iqs62x-keys.yaml     | 132 +++++
 Documentation/devicetree/bindings/mfd/iqs62x.yaml  | 179 ++++++
 .../devicetree/bindings/pwm/iqs620a-pwm.yaml       |  32 ++
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
 drivers/pwm/pwm-iqs620a.c                          | 258 +++++++++
 include/linux/mfd/iqs62x.h                         | 146 +++++
 25 files changed, 3247 insertions(+)
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
