From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v4.5-rc1
Date: Thu, 21 Jan 2016 15:12:48 +0100
Message-ID: <1453385568-31748-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35893 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759175AbcAUOMv (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Jan 2016 09:12:51 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.5-rc1

for you to fetch changes up to ff01c944cfa939f3474c28d88223213494aedf0b:

  pwm: Mark all devices as "might sleep" (2016-01-21 15:04:59 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.5-rc1

This set of changes contains a new driver for OMAP (using the dual-mode
timers) as well as an assortment of fixes all across the board.

----------------------------------------------------------------
Andy Shevchenko (1):
      pwm: lpss: Select core part automatically

Dan Carpenter (1):
      pwm: omap-dmtimer: Potential NULL dereference on error

Mika Westerberg (2):
      pwm: lpss: Remove ->free() callback
      pwm: lpss: Rework the sequence of programming PWM_SW_UPDATE

Neil Armstrong (1):
      pwm: Add PWM driver for OMAP using dual-mode timers

Ryo Kodama (1):
      pwm: rcar: Improve accuracy of frequency division setting

Stefan Agner (1):
      pwm: fsl-ftm: Fix clock enable/disable when using PM

Stefan Wahren (3):
      pwm: bcm2835: Calculate scaler in ->config()
      pwm: bcm2835: Prevent division by zero
      pwm: bcm2835: Fix email address specification

Thierry Reding (1):
      pwm: Mark all devices as "might sleep"

Vegard Nossum (1):
      pwm: add HAS_IOMEM dependency to PWM_FSL_FTM

Vladimir Zapolskiy (6):
      dt: lpc32xx: pwm: correct LPC32xx PWM device node example
      dt: lpc32xx: pwm: update documentation of LPC32xx PWM device
      pwm: lpc32xx: correct number of PWM channels from 2 to 1
      pwm: lpc32xx: make device usable with common clock framework
      pwm: lpc32xx: fix and simplify duty cycle and period calculations
      pwm: lpc32xx: return ERANGE, if requested period is not supported

qipeng.zha (1):
      pwm: lpss: Update PWM setting for Broxton

 .../devicetree/bindings/pwm/lpc32xx-pwm.txt        |   9 +-
 .../devicetree/bindings/pwm/pwm-omap-dmtimer.txt   |  18 ++
 drivers/pwm/Kconfig                                |  25 +-
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |   2 +-
 drivers/pwm/pwm-bcm2835.c                          |  18 +-
 drivers/pwm/pwm-fsl-ftm.c                          |  58 ++--
 drivers/pwm/pwm-lpc32xx.c                          |  59 ++--
 drivers/pwm/pwm-lpss.c                             |  57 ++--
 drivers/pwm/pwm-lpss.h                             |   1 +
 drivers/pwm/pwm-omap-dmtimer.c                     | 327 +++++++++++++++++++++
 drivers/pwm/pwm-rcar.c                             |   2 +-
 include/linux/platform_data/pwm_omap_dmtimer.h     |  69 +++++
 13 files changed, 539 insertions(+), 107 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
 create mode 100644 drivers/pwm/pwm-omap-dmtimer.c
 create mode 100644 include/linux/platform_data/pwm_omap_dmtimer.h
