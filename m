Return-Path: <root@danube-imgworks.hb.imgtec.org>
From: naidu.tellapati@imgtec.com
Subject: [PATCH v2 0/4] Initial support for ImgTec PWM DAC and PDM DAC 
Date: Fri, 14 Nov 2014 21:07:36 +0530
Message-Id: <1415979460-1093-1-git-send-email-naidu.tellapati@imgtec.com>
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com, abrestic@chromium.org, gregkh@linuxfoundation.org, arnd@arndb.de, James.Hartley@imgtec.com, Ezequiel.Garcia@imgtec.com
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, arul.ramasamy@imgtec.com, Sai.Masarapu@imgtec.com, Naidu Tellapati <Naidu.Tellapati@imgtec.com>

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
 Documentation/devicetree/bindings/pwm/img-pwm.txt  |   23 +
 drivers/misc/Kconfig                               |   11 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/img-pdm.c                             |  657 ++++++++++++++++++++
 drivers/pwm/Kconfig                                |   11 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-img.c                              |  307 +++++++++
 include/linux/img_pdm.h                            |   52 ++
 9 files changed, 1117 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/img-pdm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/img-pwm.txt
 create mode 100644 drivers/misc/img-pdm.c
 create mode 100755 drivers/pwm/pwm-img.c
 create mode 100644 include/linux/img_pdm.h
