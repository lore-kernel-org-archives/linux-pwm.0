Return-Path: <Milo.Kim@ti.com>
From: "Kim, Milo" <Milo.Kim@ti.com>
Subject: [PATCH 0/3] LP3943 MFD driver for a GPIO expander and a PWM
 generator
Date: Tue, 16 Jul 2013 02:38:14 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F82E815BC@DQHE06.ent.ti.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-pwm.vger.kernel.org>
To: "sameo@linux.intel.com" <sameo@linux.intel.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

LP3943 is an integrated device capable of driving 16 output channels.
It supports a GPIO expander and a PWM generator.
LP3493 registers are controlled via the I2C interface.

Patch-set consists of three parts - MFD, GPIO and PWM
Device tree documentation is updated also.

Milo Kim (3):
  mfd: add LP3943 MFD driver
  gpio: add LP3943 I2C GPIO expander driver
  pwm: add LP3943 PWM driver

 Documentation/devicetree/bindings/mfd/lp3943.txt |   23 +++
 drivers/gpio/Kconfig                             |    6 +
 drivers/gpio/Makefile                            |    1 +
 drivers/gpio/gpio-lp3943.c                       |  224 ++++++++++++++++++=
++++
 drivers/mfd/Kconfig                              |    8 +
 drivers/mfd/Makefile                             |    1 +
 drivers/mfd/lp3943.c                             |  206 ++++++++++++++++++=
++
 drivers/pwm/Kconfig                              |   10 +
 drivers/pwm/Makefile                             |    1 +
 drivers/pwm/pwm-lp3943.c                         |  192 ++++++++++++++++++=
+
 include/linux/mfd/lp3943.h                       |   98 ++++++++++
 11 files changed, 770 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/lp3943.txt
 create mode 100644 drivers/gpio/gpio-lp3943.c
 create mode 100644 drivers/mfd/lp3943.c
 create mode 100644 drivers/pwm/pwm-lp3943.c
 create mode 100644 include/linux/mfd/lp3943.h

--=20
1.7.9.5


Best Regards,
Milo
