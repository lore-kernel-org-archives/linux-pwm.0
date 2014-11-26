From: Naidu Tellapati <naidu.tellapati@gmail.com>
Subject: [PATCH v5 0/4] Initial support for ImgTec PWM DAC and PDM DAC
Date: Wed, 26 Nov 2014 20:54:16 +0530
Message-ID: <1417015460-11908-1-git-send-email-Naidu.Tellapati@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:63375 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663AbaKZPYq (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Nov 2014 10:24:46 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, abrestic@chromium.org, gregkh@linuxfoundation.org, arnd@arndb.de, James.Hartley@imgtec.com, Ezequiel.Garcia@imgtec.com
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Arul.Ramasamy@imgtec.com, Sai.Masarapu@imgtec.com, Naidu Tellapati <Naidu.Tellapati@gmail.com>

The Pistachio SOC from Imagination Technologies includes =E2=80=93 4x P=
DM blocks
and 1x =E2=80=9Cbasic PWM=E2=80=9D block with four output channels. The=
se share 4 MFIO pins,
each PWM channel being muxed with each PDM block output (0-3 muxed with=
 0-3)
using the CR_PERIP_PWM_PDM_CONTROL register in the peripheral wrapper
register bank (offset 0x140). The PDM and PWM outputs are used to contr=
ol
targets such as LCD backlight.

The PWM driver uses Linux PWM framework. Since the PDM does not fit int=
o PWM
framework we have implemented it as a MISC driver.

The series is based on v3.18-rc5.

Changes from v4:

 * Removed CR_prefix from the defined macros.

 * Folded same data type varibles in one line.
=20
 * Removed cr-periph property from PWM DT binding document.

 * Removed regmap_update_bits from img_pwm_enable and img_pwm_disable f=
unctions.

 * Addressed few more comments given in v4.

Changes from v3:

 * Addressed couple of comments given in v3.

Changes from v2:

 * Added depends on MIPS || COMPILE_TEST.

 * Corrected the logic while calculating time base steps.

 * Addressed few other minor comments given in v2.

Changes from v1:

 * Used regmap_update_bits at some places in the driver.

 * Placed some #defines next to their register.

 * Added depends on HAS_IOMEM in Kconfig.

 * Removed unnecessary paragraph from file header.

 * Defined register masks in a readable way.

 * Renamed clk-names with clock-names.

 * Added system interface clock in DT binding document.

 * Addressed few other minor review comments given in v1.

Naidu Tellapati (4):
  pwm: Imagination Technologies PWM DAC driver
  DT: pwm: Add binding document for IMG PWM DAC
  pdm: Imagination Technologies PDM DAC driver
  DT: pdm: Add binding document for IMG PDM DAC

 Documentation/devicetree/bindings/misc/img-pdm.txt |   54 ++
 Documentation/devicetree/bindings/pwm/img-pwm.txt  |   21 +
 drivers/misc/Kconfig                               |   16 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/img-pdm.c                             |  653 ++++++++++++=
++++++++
 drivers/pwm/Kconfig                                |   12 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-img.c                              |  240 +++++++
 include/linux/img_pdm.h                            |   52 ++
 9 files changed, 1050 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/img-pdm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/img-pwm.txt
 create mode 100644 drivers/misc/img-pdm.c
 create mode 100644 drivers/pwm/pwm-img.c
 create mode 100644 include/linux/img_pdm.h

