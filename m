From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v4.18-rc1
Date: Wed, 13 Jun 2018 14:16:26 +0200
Message-ID: <20180613121626.17188-1-thierry.reding@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.18-rc1

for you to fetch changes up to 414c52b7899aa9097c2fa8444654a866e1df4a0c:

  pwm: stm32: Fix build warning with CONFIG_DMA_ENGINE disabled (2018-06-06 10:15:55 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.18-rc1

This contains a couple of fixes and cleanups for the Meson and ACPI/LPSS
drivers as well as capture support for STM32. Note that given the cross-
subsystem changes, the STM32 patches were merged through the MFD and PWM
trees, both sharing an immutable branch.

----------------------------------------------------------------
Arnd Bergmann (2):
      pwm: stm32: Enforce dependency on CONFIG_MFD_STM32_TIMERS
      pwm: stm32: Fix build warning with CONFIG_DMA_ENGINE disabled

Fabrice Gasnier (5):
      mfd: stm32-timers: Add support for DMAs
      pwm: stm32: Add capture support
      pwm: stm32: Improve capture by tuning counter prescaler
      pwm: stm32: Use input prescaler to improve period capture
      dt-bindings: mfd: stm32-timers: Add support for dmas

Hans de Goede (2):
      pwm: lpss: platform: Save/restore the ctrl register over a suspend/resume
      ACPI / LPSS: Add missing prv_offset setting for byt/cht PWM devices

Martin Blumenstingl (1):
      pwm: meson: Fix allocation of PWM channel array

Thierry Reding (1):
      Merge tag 'ib-mfd-pwm-v4.18-1' of git://git.kernel.org/.../lee/mfd into for-next

Wolfram Sang (1):
      pwm: simplify getting .drvdata

 .../devicetree/bindings/mfd/stm32-timers.txt       |  20 ++
 drivers/acpi/acpi_lpss.c                           |   2 +
 drivers/mfd/stm32-timers.c                         | 201 +++++++++++++++-
 drivers/pwm/Kconfig                                |   2 +-
 drivers/pwm/pwm-atmel-tcb.c                        |   6 +-
 drivers/pwm/pwm-lpss-platform.c                    |   5 +
 drivers/pwm/pwm-lpss.c                             |  30 +++
 drivers/pwm/pwm-lpss.h                             |   2 +
 drivers/pwm/pwm-meson.c                            |   4 +-
 drivers/pwm/pwm-rcar.c                             |   3 +-
 drivers/pwm/pwm-stm32.c                            | 255 +++++++++++++++++++++
 include/linux/mfd/stm32-timers.h                   |  58 +++++
 12 files changed, 577 insertions(+), 11 deletions(-)
