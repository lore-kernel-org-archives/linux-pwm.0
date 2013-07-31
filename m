Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v4 00/20] Samsung PWM support cleanup
Date: Wed, 31 Jul 2013 21:03:03 +0200
Message-ID: <6035387.7ekicDUVuU@flatron>
In-Reply-To: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>

Hi Kukjin,

Since I think we already got all the necessary Acks, do you want me to 
send you a pull request or you already have this series applied (I can't 
see it in your tree on kernel.org)?

Best regards,
Tomasz

On Saturday 20 of July 2013 02:04:12 Tomasz Figa wrote:
> Since we now have a proper Samsung PWM clocksource driver in place,
> we can proceed with further cleanup of PWM timers support on Samsung
> SoCs.
> 
> This series attempts to achieve this goal by:
>  1) fixing up few things in samsung_pwm_timer clocksource driver,
>  2) moving remaining Samsung platforms to the new clocksource driver,
>  3) removing old clocksource driver,
>  4) adding new multiplatform- and DT-aware PWM driver,
>  5) moving all Samsung platforms to use the new PWM driver,
>  6) removing old PWM driver,
>  7) removing all PWM-related code that is not used anymore.
> 
> Cleaning up the PWM driver is a bit tricky, because the design of
> current driver makes it completely unsuitable for DT and multiplatform
> and would require a heavy rework to make it usable, breaking any
> existing Samsung PWM users by the way. To avoid any breakage this
> series first renames the old driver, then adds new one using original
> name, migrates all platforms to use it and then finally removes the old
> driver.
> 
> See particular patches for more detailed descriptions.
> 
> [On S3C6410-based Tiny6410 (Mini6410-compatible) with pwm-beeper,
> SMDK6410 with PWM backlight and Exynos4210-based Origen board (with
> PWM0 attached to a scope)]
> Tested-by: Tomasz Figa <tomasz.figa@gmail.com>
> 
> [On S3C2440-based Mini2440 board]
> Tested-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
> 
> [On a s3c2416 based machine]
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> 
> [Also not sure on what boards, but still]
> Tested-by: Mark Brown <broonie@linaro.org>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> 
> Changes since v3:
>  - added two extra clocksource driver fixes to the series (patches 1,
> 2), - added comment explaining why only a simple synchronization is
> needed between clocksource and PWM drivers,
>  - some stylistic fixes,
>  - rebased to 3.11-rc1.
> Changes since v2:
>  - replaced __raw_{readl,writel} with {readl,writel},
>  - corrected some commit messages,
>  - used git format-patch -M to detect rename.
> Changes since v1:
>  - made sure that suspend/resume is handled correctly in both
>    clocksource and PWM drivers,
>  - fixed incorrect definition of AUTORELOAD bit for channel 4,
>  - fixed order of registering PWM device and calling samsung_bl_set(),
>    which assumes that PWM device has been already registered,
>  - corrected commit messages of several patches,
>  - addressed all the valid comments from reviewers, including cleanup
>    of most code originally copied from previous PWM driver,
>  - rebased on top of current Kgene's for-next,
>  - tested on Exynos4210, verifying correct PWM output with a scope.
> 
> Tomasz Figa (20):
>   clocksource: samsung_pwm_timer: Do not request PWM mem region
>   clocksource: samsung_pwm_timer: Correct definition of AUTORELOAD bit
>   clocksource: samsung_pwm_timer: Cache clocksource register address
>   clocksource: samsung_pwm_timer: Do not use clocksource_mmio
>   clocksource: samsung_pwm_timer: Handle suspend/resume correctly
>   ARM: SAMSUNG: Unify base address definitions of timer block
>   ARM: SAMSUNG: Add new PWM platform device
>   ARM: SAMSUNG: Set PWM platform data
>   ARM: SAMSUNG: Move all platforms to new clocksource driver
>   ARM: SAMSUNG: Remove old samsung-time driver
>   ARM: SAMSUNG: Remove unused PWM timer IRQ chip code
>   pwm: samsung: Rename to pwm-samsung-legacy
>   pwm: Add new pwm-samsung driver
>   ARM: SAMSUNG: Rework private data handling in dev-backlight
>   ARM: SAMSUNG: Modify board files to use new PWM platform device
>   pwm: Remove superseded pwm-samsung-legacy driver
>   ARM: SAMSUNG: Remove old PWM timer platform devices
>   ARM: SAMSUNG: Remove pwm-clock infrastructure
>   ARM: SAMSUNG: Remove remaining uses of plat/regs-timer.h header
>   ARM: SAMSUNG: Remove plat/regs-timer.h header
> 
>  arch/arm/Kconfig                                   |  11 +-
>  arch/arm/mach-s3c24xx/Kconfig                      |   6 -
>  arch/arm/mach-s3c24xx/clock-s3c2410.c              |   1 -
>  arch/arm/mach-s3c24xx/clock-s3c2412.c              |   1 -
>  arch/arm/mach-s3c24xx/clock-s3c2416.c              |   2 -
>  arch/arm/mach-s3c24xx/clock-s3c2443.c              |   2 -
>  arch/arm/mach-s3c24xx/common.c                     |  27 +
>  arch/arm/mach-s3c24xx/include/mach/map.h           |   2 +
>  arch/arm/mach-s3c24xx/mach-h1940.c                 |   4 +-
>  arch/arm/mach-s3c24xx/mach-rx1950.c                |   5 +-
>  arch/arm/mach-s3c64xx/Kconfig                      |   2 -
>  arch/arm/mach-s3c64xx/clock.c                      |   2 -
>  arch/arm/mach-s3c64xx/common.c                     |  32 +-
>  arch/arm/mach-s3c64xx/include/mach/irqs.h          |   8 -
>  arch/arm/mach-s3c64xx/include/mach/map.h           |   1 +
>  arch/arm/mach-s3c64xx/irq-pm.c                     |   2 -
>  arch/arm/mach-s3c64xx/mach-crag6410.c              |   4 +-
>  arch/arm/mach-s3c64xx/mach-hmt.c                   |   4 +-
>  arch/arm/mach-s3c64xx/mach-smartq.c                |   4 +-
>  arch/arm/mach-s3c64xx/mach-smdk6410.c              |   5 +-
>  arch/arm/mach-s5p64x0/Kconfig                      |   2 -
>  arch/arm/mach-s5p64x0/clock-s5p6440.c              |   2 -
>  arch/arm/mach-s5p64x0/clock-s5p6450.c              |   2 -
>  arch/arm/mach-s5p64x0/common.c                     |  27 +
>  arch/arm/mach-s5p64x0/include/mach/irqs.h          |   2 -
>  arch/arm/mach-s5p64x0/include/mach/map.h           |   1 +
>  arch/arm/mach-s5p64x0/mach-smdk6440.c              |   5 +-
>  arch/arm/mach-s5p64x0/mach-smdk6450.c              |   5 +-
>  arch/arm/mach-s5p64x0/pm.c                         |   3 -
>  arch/arm/mach-s5pc100/Kconfig                      |   1 -
>  arch/arm/mach-s5pc100/clock.c                      |   2 -
>  arch/arm/mach-s5pc100/common.c                     |  28 +
>  arch/arm/mach-s5pc100/include/mach/irqs.h          |   2 -
>  arch/arm/mach-s5pc100/include/mach/map.h           |   1 +
>  arch/arm/mach-s5pc100/mach-smdkc100.c              |   5 +-
>  arch/arm/mach-s5pv210/Kconfig                      |   1 -
>  arch/arm/mach-s5pv210/clock.c                      |   1 -
>  arch/arm/mach-s5pv210/common.c                     |  28 +
>  arch/arm/mach-s5pv210/include/mach/irqs.h          |   2 -
>  arch/arm/mach-s5pv210/include/mach/map.h           |   1 +
>  arch/arm/mach-s5pv210/mach-smdkv210.c              |   5 +-
>  arch/arm/mach-s5pv210/pm.c                         |  10 -
>  arch/arm/plat-samsung/Kconfig                      |  14 -
>  arch/arm/plat-samsung/Makefile                     |   3 -
>  arch/arm/plat-samsung/dev-backlight.c              |  61 +-
>  arch/arm/plat-samsung/devs.c                       |  42 +-
>  arch/arm/plat-samsung/include/plat/clock.h         |   4 -
>  arch/arm/plat-samsung/include/plat/devs.h          |   1 +
>  arch/arm/plat-samsung/include/plat/irq-vic-timer.h |  13 -
>  arch/arm/plat-samsung/include/plat/irqs.h          |   9 -
>  arch/arm/plat-samsung/include/plat/pwm-clock.h     |  81 ---
>  arch/arm/plat-samsung/include/plat/pwm-core.h      |  24 +
>  arch/arm/plat-samsung/include/plat/regs-timer.h    | 124 ----
>  arch/arm/plat-samsung/include/plat/samsung-time.h  |  23 -
>  arch/arm/plat-samsung/irq-vic-timer.c              |  98 ---
>  arch/arm/plat-samsung/pwm-clock.c                  | 474 --------------
> arch/arm/plat-samsung/s5p-irq.c                    |   4 -
>  arch/arm/plat-samsung/samsung-time.c               | 394 ------------
>  drivers/clocksource/Kconfig                        |   1 -
>  drivers/clocksource/samsung_pwm_timer.c            |  98 +--
>  drivers/pwm/pwm-samsung.c                          | 701
> ++++++++++++++------- 61 files changed, 768 insertions(+), 1662
> deletions(-)
>  delete mode 100644 arch/arm/plat-samsung/include/plat/irq-vic-timer.h
>  delete mode 100644 arch/arm/plat-samsung/include/plat/pwm-clock.h
>  create mode 100644 arch/arm/plat-samsung/include/plat/pwm-core.h
>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-timer.h
>  delete mode 100644 arch/arm/plat-samsung/irq-vic-timer.c
>  delete mode 100644 arch/arm/plat-samsung/pwm-clock.c
>  delete mode 100644 arch/arm/plat-samsung/samsung-time.c
