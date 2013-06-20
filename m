Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH v2 00/18] Final Samsung PWM support cleanup
Date: Fri, 21 Jun 2013 00:12:45 +0200
Message-Id: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>

Since we now have a proper Samsung PWM clocksource driver in place,
we can proceed with further cleanup of PWM timers support on Samsung SoCs.

This series attempts to achieve this goal by:
 1) moving remaining Samsung platforms to the new clocksource driver
 2) removing old clocksource driver
 3) adding new multiplatform- and DT-aware PWM driver
 4) moving all Samsung platforms to use the new PWM driver
 5) removing old PWM driver
 6) removing all PWM-related code that is not used anymore

Cleaning up the PWM driver is a bit tricky, because the design of current
driver makes it completely unsuitable for DT and multiplatform and would
require a heavy rework to make it usable, breaking any existing Samsung PWM
users by the way. To avoid any breakage I decided to keep the old driver,
add new one, move all platforms to it and then remove the old one.

See particular patches for more detailed descriptions.

On S3C6410-based Tiny6410 (Mini6410-compatible), after enabling pwm-beeper
and Exynos4210-based Origen board (with PWM0 attached to a scope):

Tested-by: Tomasz Figa <tomasz.figa@gmail.com>

Changes since v1:
 - made sure that suspend/resume is handled correctly in both
   clocksource and PWM drivers,
 - fixed incorrect definition of AUTORELOAD bit for channel 4,
 - fixed order of registering PWM device and calling samsung_bl_set(),
   which assumes that PWM device has been already registered,
 - corrected commit messages of several patches,
 - addressed all the valid comments from reviewers, including cleanup
   of most code originally copied from previous PWM driver,
 - rebased on top of current Kgene's for-next,
 - tested on Exynos4210, verifying correct PWM output with a scope.

Needs testing on other platforms as I could only compile test for them.
Tomasz Figa (18):
  ARM: SAMSUNG: Unify base address definitions of timer block
  ARM: SAMSUNG: Add new PWM platform device
  ARM: SAMSUNG: Set PWM platform data
  clocksource: samsung_pwm_timer: Cache clocksource register address
  clocksource: samsung_pwm_timer: Do not use clocksource_mmio
  clocksource: samsung_pwm_timer: Handle suspend/resume correctly
  ARM: SAMSUNG: Move all platforms to new clocksource driver
  ARM: SAMSUNG: Remove old samsung-time driver
  ARM: SAMSUNG: Remove unused PWM timer IRQ chip code
  pwm: samsung: Rename to pwm-samsung-legacy
  pwm: Add new pwm-samsung driver
  ARM: SAMSUNG: Rework private data handling in dev-backlight
  ARM: SAMSUNG: Modify board files to use new PWM platform device
  pwm: Remove superseded pwm-samsung-legacy driver
  ARM: SAMSUNG: Remove old PWM timer platform devices
  ARM: SAMSUNG: Remove pwm-clock infrastructure
  ARM: SAMSUNG: Remove remaining uses of plat/regs-timer.h header
  ARM: SAMSUNG: Remove plat/regs-timer.h header

 arch/arm/Kconfig                                   |   1 -
 arch/arm/mach-s3c24xx/Kconfig                      |  12 +-
 arch/arm/mach-s3c24xx/clock-s3c2410.c              |   1 -
 arch/arm/mach-s3c24xx/clock-s3c2412.c              |   1 -
 arch/arm/mach-s3c24xx/clock-s3c2416.c              |   2 -
 arch/arm/mach-s3c24xx/clock-s3c2443.c              |   2 -
 arch/arm/mach-s3c24xx/common.c                     |  27 +
 arch/arm/mach-s3c24xx/include/mach/map.h           |   2 +
 arch/arm/mach-s3c24xx/mach-h1940.c                 |   4 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c                |   5 +-
 arch/arm/mach-s3c64xx/Kconfig                      |   4 +-
 arch/arm/mach-s3c64xx/clock.c                      |   2 -
 arch/arm/mach-s3c64xx/common.c                     |  32 +-
 arch/arm/mach-s3c64xx/include/mach/irqs.h          |   8 -
 arch/arm/mach-s3c64xx/include/mach/map.h           |   1 +
 arch/arm/mach-s3c64xx/irq-pm.c                     |   2 -
 arch/arm/mach-s3c64xx/mach-crag6410.c              |   4 +-
 arch/arm/mach-s3c64xx/mach-hmt.c                   |   4 +-
 arch/arm/mach-s3c64xx/mach-smartq.c                |   4 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |   5 +-
 arch/arm/mach-s5p64x0/Kconfig                      |   4 +-
 arch/arm/mach-s5p64x0/clock-s5p6440.c              |   2 -
 arch/arm/mach-s5p64x0/clock-s5p6450.c              |   2 -
 arch/arm/mach-s5p64x0/common.c                     |  27 +
 arch/arm/mach-s5p64x0/include/mach/irqs.h          |   2 -
 arch/arm/mach-s5p64x0/include/mach/map.h           |   1 +
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |   5 +-
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |   5 +-
 arch/arm/mach-s5p64x0/pm.c                         |   3 -
 arch/arm/mach-s5pc100/Kconfig                      |   2 +-
 arch/arm/mach-s5pc100/clock.c                      |   2 -
 arch/arm/mach-s5pc100/common.c                     |  28 +
 arch/arm/mach-s5pc100/include/mach/irqs.h          |   2 -
 arch/arm/mach-s5pc100/include/mach/map.h           |   1 +
 arch/arm/mach-s5pc100/mach-smdkc100.c              |   5 +-
 arch/arm/mach-s5pv210/Kconfig                      |   2 +-
 arch/arm/mach-s5pv210/clock.c                      |   1 -
 arch/arm/mach-s5pv210/common.c                     |  28 +
 arch/arm/mach-s5pv210/include/mach/irqs.h          |   2 -
 arch/arm/mach-s5pv210/include/mach/map.h           |   1 +
 arch/arm/mach-s5pv210/mach-smdkv210.c              |   5 +-
 arch/arm/mach-s5pv210/pm.c                         |  10 -
 arch/arm/plat-samsung/Kconfig                      |  14 -
 arch/arm/plat-samsung/Makefile                     |   3 -
 arch/arm/plat-samsung/dev-backlight.c              |  61 +-
 arch/arm/plat-samsung/devs.c                       |  42 +-
 arch/arm/plat-samsung/include/plat/clock.h         |   4 -
 arch/arm/plat-samsung/include/plat/devs.h          |   1 +
 arch/arm/plat-samsung/include/plat/irq-vic-timer.h |  13 -
 arch/arm/plat-samsung/include/plat/irqs.h          |   9 -
 arch/arm/plat-samsung/include/plat/pwm-clock.h     |  81 ---
 arch/arm/plat-samsung/include/plat/pwm-core.h      |  24 +
 arch/arm/plat-samsung/include/plat/regs-timer.h    | 124 ----
 arch/arm/plat-samsung/include/plat/samsung-time.h  |  23 -
 arch/arm/plat-samsung/irq-vic-timer.c              |  98 ---
 arch/arm/plat-samsung/pwm-clock.c                  | 474 --------------
 arch/arm/plat-samsung/s5p-irq.c                    |   4 -
 arch/arm/plat-samsung/samsung-time.c               | 394 ------------
 drivers/clocksource/samsung_pwm_timer.c            |  84 +--
 drivers/pwm/pwm-samsung.c                          | 694 ++++++++++++++-------
 60 files changed, 766 insertions(+), 1644 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/irq-vic-timer.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/pwm-clock.h
 create mode 100644 arch/arm/plat-samsung/include/plat/pwm-core.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-timer.h
 delete mode 100644 arch/arm/plat-samsung/irq-vic-timer.c
 delete mode 100644 arch/arm/plat-samsung/pwm-clock.c
 delete mode 100644 arch/arm/plat-samsung/samsung-time.c

-- 
1.8.2.1
