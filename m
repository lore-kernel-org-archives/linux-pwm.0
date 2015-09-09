From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v4.3-rc1
Date: Wed,  9 Sep 2015 15:25:54 +0200
Message-ID: <1441805154-8876-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34809 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406AbbIINZ7 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Sep 2015 09:25:59 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.3-rc1

for you to fetch changes up to 7a5938201834a9c25155176d0f5942d48336b244:

  ARM: at91: pwm: atmel-hlcdc: Add at91sam9n12 errata (2015-09-09 15:16:01 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.3-rc1

This set of changes introduces the beginnings of a new API that's based
around the concept of states that can be atomically applied. Drivers go
to various lengths to implement something similar, which indicates that
the core should really be providing the necessary framework.

On top of that, there is a bit of cleanup as well as improved kerneldoc
and integration into the device-drivers DocBook.

Regarding drivers there is a new one for the NXP LPC18xx family of SoCs
and a couple of fixes for existing drivers (pca9685, Broadcom Kona and
Atmel HLCDC).

----------------------------------------------------------------
Ariel D'Alessandro (2):
      pwm: NXP LPC18xx PWM/SCT driver
      pwm: Add NXP LPC18xx PWM/SCT DT binding documentation

Boris Brezillon (4):
      pwm: Add the pwm_is_enabled() helper
      pwm: Constify PWM device where possible
      pwm: Add pwm_get_polarity() helper function
      pwm: Make use of pwm_get_xxx() helpers where appropriate

Clemens Gruber (2):
      pwm-pca9685: Fix several driver bugs
      pwm-pca9685: Support changing the output frequency

Jonathan Richardson (1):
      pwm: kona: Modify settings application sequence

Josh Wu (1):
      ARM: at91: pwm: atmel-hlcdc: Add at91sam9n12 errata

Krzysztof Kozlowski (1):
      pwm: pca9685: Drop owner assignment

Thierry Reding (5):
      pwm: sysfs: Properly convert from enum to string
      pwm: sysfs: Remove unnecessary padding
      pwm: Remove useless whitespace
      pwm: Clean up kerneldoc
      pwm: Add to device-drivers documentation

 Documentation/DocBook/device-drivers.tmpl          |  27 ++
 .../devicetree/bindings/pwm/lpc1850-sct-pwm.txt    |  20 +
 drivers/pwm/Kconfig                                |  12 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |  49 ++-
 drivers/pwm/pwm-atmel-hlcdc.c                      |   5 +
 drivers/pwm/pwm-atmel-tcb.c                        |   2 +-
 drivers/pwm/pwm-atmel.c                            |   6 +-
 drivers/pwm/pwm-bcm-kona.c                         |  54 ++-
 drivers/pwm/pwm-ep93xx.c                           |   4 +-
 drivers/pwm/pwm-imx.c                              |   5 +-
 drivers/pwm/pwm-lpc18xx-sct.c                      | 465 +++++++++++++++++++++
 drivers/pwm/pwm-mxs.c                              |   4 +-
 drivers/pwm/pwm-pca9685.c                          |  90 +++-
 drivers/pwm/pwm-renesas-tpu.c                      |   2 +-
 drivers/pwm/pwm-rockchip.c                         |   2 +-
 drivers/pwm/pwm-tegra.c                            |   6 +-
 drivers/pwm/pwm-tiecap.c                           |  10 +-
 drivers/pwm/pwm-tiehrpwm.c                         |   6 +-
 drivers/pwm/sysfs.c                                |  29 +-
 include/linux/pwm.h                                |  99 +++--
 21 files changed, 802 insertions(+), 96 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/lpc1850-sct-pwm.txt
 create mode 100644 drivers/pwm/pwm-lpc18xx-sct.c
