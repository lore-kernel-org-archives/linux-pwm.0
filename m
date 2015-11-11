From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v4.4-rc1
Date: Wed, 11 Nov 2015 16:32:29 +0100
Message-ID: <1447255949-5464-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38649 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbbKKPcc (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2015 10:32:32 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba=
357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pw=
m.git tags/pwm/for-4.4-rc1

for you to fetch changes up to 5dcd7b42f1d06c62b5589441e69cc77c26c8b725=
:

  pwm: sunxi: Fix whitespace issue (2015-11-10 13:06:47 +0100)

Note that one of the patches included in this pull request is against
arch/unicore32. I've included it here because I couldn't get a response
from Guan Xuetao and I consider the change low-risk. Equivalent patches
have been merged and tested in Samsung and PXA trees. The goal is to
finally get rid of legacy code paths that have repeatedly been causing
headaches.

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.4-rc1

This round contains a couple of new drivers for the Marvell Berlin
family of SoCs, various SoCs from Renesas and Broadcom as well as the
backlight PWM present on MediaTek SoCs.

=46urther existing drivers are extended to support a wider range of
hardware.

The remaining patches are minor fixes and cleanups across the board.

----------------------------------------------------------------
Andy Shevchenko (1):
      pwm-pca9685: enable ACPI device found on Galileo Gen2

Antoine T=C3=A9nart (2):
      pwm: Add Berlin PWM controller DT binding
      pwm: Add support for the Berlin PWM controller

=46lorian Fainelli (2):
      Documentation: dt: add Broadcom BCM7038 PWM controller binding
      pwm: Add Broadcom BCM7038 PWM controller support

Hans de Goede (1):
      pwm: sun4i: Add support for PWM controller on sun5i SoCs

Jonathan Richardson (1):
      pwm: Set enable state properly on failed call to enable

Luis de Bethencourt (1):
      pwm: atmel-hlcdc: Fix module autoload for OF platform driver

Mika Westerberg (3):
      pwm: lpss: Add support for multiple PWMs
      pwm: lpss: Support all four PWMs on Intel Broxton
      pwm: lpss: Add more Intel Broxton IDs

Nicolas Ferre (1):
      pwm: atmel-hlcdc: add sama5d2 SoC support.

Olliver Schinagl (3):
      pwm: sysfs: Remove unnecessary temporary variable
      pwm: sysfs: Make use of the DEVICE_ATTR_[RW][WO] macro's
      pwm: sunxi: Fix whitespace issue

Qipeng Zha (1):
      pwm: lpss: Add support for runtime PM

Thierry Reding (2):
      pwm: Return -ENODEV if no PWM lookup match is found
      unicore32: nb0916: Use PWM lookup table

Vignesh R (1):
      pwm: tipwmss: Enable on TI DRA7x and AM437x

YH Huang (2):
      dt-bindings: pwm: Add MediaTek display PWM bindings
      pwm: Add MediaTek display PWM driver support

Yoshihiro Shimoda (3):
      pwm: Add device tree binding document for R-Car PWM Timer
      pwm: Add support for R-Car PWM Timer
      pwm: pwm-rcar: Revise the device tree binding document about comp=
atible

 .../devicetree/bindings/pwm/brcm,bcm7038-pwm.txt   |  20 ++
 .../devicetree/bindings/pwm/pwm-berlin.txt         |  17 +
 .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |  42 +++
 .../devicetree/bindings/pwm/pwm-sun4i.txt          |   2 +
 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   |  26 ++
 arch/unicore32/kernel/puv3-nb0916.c                |  10 +-
 drivers/pwm/Kconfig                                |  49 ++-
 drivers/pwm/Makefile                               |   4 +
 drivers/pwm/core.c                                 |  37 ++-
 drivers/pwm/pwm-atmel-hlcdc.c                      |   4 +
 drivers/pwm/pwm-berlin.c                           | 219 +++++++++++++
 drivers/pwm/pwm-brcmstb.c                          | 343 +++++++++++++=
++++++++
 drivers/pwm/pwm-lpss-pci.c                         |  37 ++-
 drivers/pwm/pwm-lpss-platform.c                    |   7 +
 drivers/pwm/pwm-lpss.c                             |  62 ++--
 drivers/pwm/pwm-lpss.h                             |   2 +
 drivers/pwm/pwm-mtk-disp.c                         | 243 +++++++++++++=
++
 drivers/pwm/pwm-pca9685.c                          |  20 +-
 drivers/pwm/pwm-rcar.c                             | 274 +++++++++++++=
+++
 drivers/pwm/pwm-sun4i.c                            |  27 +-
 drivers/pwm/sysfs.c                                |  75 +++--
 include/linux/pwm.h                                |   3 +
 22 files changed, 1441 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,bcm7038-=
pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-berlin.tx=
t
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.=
txt
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,pwm-r=
car.txt
 create mode 100644 drivers/pwm/pwm-berlin.c
 create mode 100644 drivers/pwm/pwm-brcmstb.c
 create mode 100644 drivers/pwm/pwm-mtk-disp.c
 create mode 100644 drivers/pwm/pwm-rcar.c
