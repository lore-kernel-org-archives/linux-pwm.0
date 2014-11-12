Return-Path: <root@danube-imgworks.hb.imgtec.org>
From: Naidu.Tellapati@imgtec.com
Subject: [PATCH 0/4] Initial support for ImgTec PWM DAC and PDM DAC
Date: Wed, 12 Nov 2014 18:07:49 +0530
Message-Id: <1415795873-4816-1-git-send-email-Naidu.Tellapati@imgtec.com>
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org, James.Hartley@imgtec.com, abrestic@chromium.org, Ezequiel.Garcia@imgtec.com
Cc: Arul.Ramasamy@imgtec.com, Sai.Masarapu@imgtec.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Naidu Tellapati <Naidu.Tellapati@imgtec.com>

From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>

The Pistachio SOC from Imagination Technologies includes ��������� 4x PDM blocks
and 1x ���������basic PWM��������� block with four output channels. These share 4 MFIO pins,
each PWM channel being muxed with each PDM block output (0-3 muxed with 0-3)
using the CR_PERIP_PWM_PDM_CONTROL register in the peripheral wrapper
register bank (offset 0x140). The PDM and PWM outputs are used to control
targets such as LCD backlight.

The PWM driver uses Linux PWM framework. Since the PDM does not fit into PWM
framework we have implemented it as a MISC driver.

The series is based on v3.18-rc4.

Naidu Tellapati (4):
  pwm: Imagination Technologies PWM DAC driver
  DT: pwm: Add binding document for IMG PWM DAC
  pdm: Imagination Technologies PDM DAC driver
  DT: pdm: Add binding document for IMG PDM DAC

 Documentation/devicetree/bindings/misc/img-pdm.txt |   54 ++
 Documentation/devicetree/bindings/pwm/img-pwm.txt  |   22 +
 drivers/misc/Kconfig                               |   10 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/img-pdm.c                             |  657 ++++++++++++++++++++
 drivers/pwm/Kconfig                                |   10 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-img.c                              |  294 +++++++++
 include/linux/img_pdm.h                            |   52 ++
 9 files changed, 1101 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/img-pdm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/img-pwm.txt
 create mode 100644 drivers/misc/img-pdm.c
 create mode 100755 drivers/pwm/pwm-img.c
 create mode 100644 include/linux/img_pdm.h
