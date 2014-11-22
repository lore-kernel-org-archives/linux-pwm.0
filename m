From: naidu.tellapati@gmail.com
Subject: [PATCH RESEND v4 0/4] Initial support for ImgTec PWM DAC and PDM DAC
Date: Sat, 22 Nov 2014 07:23:28 +0530
Message-ID: <1416621212-11701-1-git-send-email-Naidu.Tellapati@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:57687 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbaKVBx5 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Nov 2014 20:53:57 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, abrestic@chromium.org, gregkh@linuxfoundation.org, arnd@arndb.de, James.Hartley@imgtec.com, Ezequiel.Garcia@imgtec.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Arul.Ramasamy@imgtec.com, Sai.Masarapu@imgtec.com, Naidu Tellapati <Naidu.Tellapati@imgtec.com>

=46rom: Naidu Tellapati <Naidu.Tellapati@imgtec.com>

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

I am re-sending the series with gmail SMTP as we had some problems with
the mail server we used in the previous rounds.

Please review and provide your comments.

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
 Documentation/devicetree/bindings/pwm/img-pwm.txt  |   23 +
 drivers/misc/Kconfig                               |   12 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/img-pdm.c                             |  676 ++++++++++++=
++++++++
 drivers/pwm/Kconfig                                |   12 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-img.c                              |  270 ++++++++
 include/linux/img_pdm.h                            |   35 +
 9 files changed, 1084 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/img-pdm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/img-pwm.txt
 create mode 100644 drivers/misc/img-pdm.c
 create mode 100644 drivers/pwm/pwm-img.c
 create mode 100644 include/linux/img_pdm.h

