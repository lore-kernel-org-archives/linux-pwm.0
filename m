From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v5.3-rc1
Date: Fri, 28 Jun 2019 14:00:02 +0200
Message-ID: <20190628120002.19597-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.3-rc1

for you to fetch changes up to 3d25025ce9c2f364ea4ee76f1461c8714b9c0b6d:

  pwm: fsl-ftm: Make sure to unlock mutex on failure (2019-06-26 11:39:25 +0200)

I'm sending this out early for this cycle because I have travel plans
that will likely intersect with the merge window.

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.3-rc1

This set of changes contains a new driver for SiFive SoCs as well as
enhancements to the core (device links are used to track dependencies
between PWM providers and consumers, support for PWM controllers via
ACPI, sysfs will now suspend/resume PWMs that it has claimed) and
various existing drivers.

----------------------------------------------------------------
Claudiu Beznea (1):
      pwm: atmel-hlcdc: Add compatible for SAM9X60 HLCDC's PWM

Fabrice Gasnier (5):
      dt-bindings: pwm: stm32-lp: Document pin control sleep state
      pwm: stm32-lp: Add power management support
      pwm: Add consumer device link
      dt-bindings: pwm: stm32: Add #pwm-cells
      pwm: stm32: Use 3 cells ->of_xlate()

Martin Blumenstingl (14):
      pwm: meson: Unify the parameter list of meson_pwm_{enable, disable}
      pwm: meson: Use devm_clk_get_optional() to get the input clock
      pwm: meson: Use GENMASK and FIELD_PREP for the lo and hi values
      pwm: meson: Change MISC_CLK_SEL_WIDTH to MISC_CLK_SEL_MASK
      pwm: meson: Don't duplicate the polarity internally
      pwm: meson: Pass struct pwm_device to meson_pwm_calc()
      pwm: meson: Add the meson_pwm_channel data to struct meson_pwm
      pwm: meson: Add the per-channel register offsets and bits in a struct
      pwm: meson: Move pwm_set_chip_data() to meson_pwm_request()
      pwm: meson: Simplify the calculation of the pre-divider and count
      pwm: meson: Read the full hardware state in meson_pwm_get_state()
      pwm: meson: Don't cache struct pwm_state internally
      pwm: meson: Add support PWM_POLARITY_INVERSED when disabling
      pwm: meson: Add documentation to the driver

Neil Armstrong (2):
      pwm: meson: Update with SPDX Licence identifier
      pwm: meson: Fix the G12A AO clock parents order

Nikolaus Voss (2):
      pwm: Add support referencing PWMs from ACPI
      leds: pwm: Support ACPI via firmware-node framework

Patrick Havelange (2):
      pwm: fsl-ftm: More relaxed permissions for updating period
      pwm: fsl-ftm: Use write protection for prescaler & polarity

Paul Cercueil (4):
      dt-bindings: pwm: jz47xx: Remove unused compatible strings
      pwm: jz4740: Remove unused devicetree compatible strings
      pwm: jz4740: Apply configuration atomically
      pwm: jz4740: Force TCU2 channels to return to their init level

Sean Young (1):
      pwm: bcm2835: Improve precision of PWM

Thierry Reding (1):
      pwm: fsl-ftm: Make sure to unlock mutex on failure

Yash Shah (2):
      pwm: sifive: Add DT documentation for SiFive PWM Controller
      pwm: sifive: Add a driver for SiFive SoC PWM

Yoshihiro Shimoda (3):
      pwm: Add power management descriptions
      pwm: sysfs: Add suspend/resume support
      pwm: rcar: Remove suspend/resume support

 .../devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt |   5 +-
 .../devicetree/bindings/pwm/pwm-sifive.txt         |  33 ++
 .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |   9 +-
 .../devicetree/bindings/pwm/pwm-stm32.txt          |   3 +
 Documentation/pwm.txt                              |   7 +
 drivers/leds/leds-pwm.c                            |  45 ++-
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 | 172 ++++++++-
 drivers/pwm/pwm-atmel-hlcdc.c                      |   1 +
 drivers/pwm/pwm-bcm2835.c                          |   8 +-
 drivers/pwm/pwm-fsl-ftm.c                          | 383 ++++++++++----------
 drivers/pwm/pwm-jz4740.c                           |  49 ++-
 drivers/pwm/pwm-meson.c                            | 386 ++++++++++-----------
 drivers/pwm/pwm-rcar.c                             |  39 ---
 drivers/pwm/pwm-sifive.c                           | 339 ++++++++++++++++++
 drivers/pwm/pwm-stm32-lp.c                         |  25 ++
 drivers/pwm/pwm-stm32.c                            |   2 +
 drivers/pwm/sysfs.c                                | 102 ++++++
 include/linux/pwm.h                                |  16 +-
 20 files changed, 1154 insertions(+), 482 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
 create mode 100644 drivers/pwm/pwm-sifive.c
