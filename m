From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v4.11-rc1
Date: Tue, 28 Feb 2017 23:31:55 +0100
Message-ID: <20170228223155.1878-1-thierry.reding@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.11-rc1

for you to fetch changes up to 38b0a526ec33314ee1d9926e3a347078f63eac8e:

  Merge branch 'for-4.11/drivers' into for-next (2017-02-10 15:15:56 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.11-rc1

This set contains mostly fixes to existing drivers as well as cleanup of
code that's not been in active use for a while.

----------------------------------------------------------------
Andy Shevchenko (4):
      pwm: lpss: Avoid potential overflow of base_unit
      pwm: lpss: Allow duty cycle to be 0
      pwm: lpss: Switch to new atomic API
      pwm: lpss: Do not export board infos for different PWM types

Bhumika Goyal (1):
      pwm: constify pwm_ops structures

Clemens Gruber (1):
      pwm: pca9685: Fix period change with same duty cycle

Hans de Goede (3):
      pwm: Don't hold pwm_lookup_lock longer than necessary
      pwm: Try to load modules during pwm_get()
      acpi: lpss: call pwm_add_table() for BSW PWM device

Ilkka Koskinen (1):
      pwm: lpss: Avoid reconfiguring while UPDATE bit is still enabled

Lothar Wassmann (2):
      pwm: Print error messages with pr_err() instead of pr_debug()
      pwm: Make the PWM_POLARITY flag in DTB optional

Lukasz Majewski (8):
      pwm: imx: Add separate set of PWM ops for v1 and v2
      pwm: imx: Rewrite v1 code to facilitate switch to atomic PWM
      pwm: imx: Move PWMv2 software reset code to a separate function
      pwm: imx: Move PWMv2 wait for fifo slot code to a separate function
      pwm: imx: Provide atomic PWM support for i.MX PWMv2
      pwm: imx: Remove redundant i.MX PWMv2 code
      pwm: imx: doc: Update imx-pwm.txt documentation entry
      pwm: imx: Add polarity inversion support to i.MX's PWMv2

Mika Westerberg (2):
      pwm: pca9685: Allow any of the 16 PWMs to be used as a GPIO
      pwm: lpss: Add Intel Gemini Lake PCI ID

Sascha Hauer (1):
      pwm: imx: Remove ipg clock and enable per clock when required

Scott Branden (1):
      pwm: bcm-iproc: Update dependencies for compile-test

Thierry Reding (7):
      leds: pwm: Remove atomic code paths
      pwm: Remove pwm_can_sleep()
      pwm: Remove .can_sleep from struct pwm_chip
      Merge branch 'for-4.11/core' into for-4.11/acpi
      Merge branch 'for-4.11/core' into for-next
      Merge branch 'for-4.11/acpi' into for-next
      Merge branch 'for-4.11/drivers' into for-next

 Documentation/devicetree/bindings/pwm/imx-pwm.txt |   6 +-
 drivers/acpi/acpi_lpss.c                          |  14 ++
 drivers/leds/leds-pwm.c                           |  16 +-
 drivers/pwm/Kconfig                               |   4 +-
 drivers/pwm/core.c                                |  70 +++---
 drivers/pwm/pwm-atmel-hlcdc.c                     |   1 -
 drivers/pwm/pwm-atmel.c                           |   1 -
 drivers/pwm/pwm-bcm-kona.c                        |   1 -
 drivers/pwm/pwm-berlin.c                          |   1 -
 drivers/pwm/pwm-bfin.c                            |   2 +-
 drivers/pwm/pwm-brcmstb.c                         |   1 -
 drivers/pwm/pwm-fsl-ftm.c                         |   1 -
 drivers/pwm/pwm-imx.c                             | 272 ++++++++++------------
 drivers/pwm/pwm-lp3943.c                          |   1 -
 drivers/pwm/pwm-lpss-pci.c                        |  22 ++
 drivers/pwm/pwm-lpss-platform.c                   |  21 ++
 drivers/pwm/pwm-lpss.c                            | 132 +++++------
 drivers/pwm/pwm-lpss.h                            |   4 -
 drivers/pwm/pwm-mxs.c                             |   2 +-
 drivers/pwm/pwm-pca9685.c                         | 176 ++++++++++++--
 drivers/pwm/pwm-pxa.c                             |   2 +-
 drivers/pwm/pwm-sti.c                             |   1 -
 drivers/pwm/pwm-sun4i.c                           |   1 -
 drivers/pwm/pwm-twl-led.c                         |   1 -
 drivers/pwm/pwm-twl.c                             |   1 -
 drivers/pwm/pwm-vt8500.c                          |   2 +-
 drivers/staging/greybus/pwm.c                     |   1 -
 include/linux/pwm.h                               |  33 ++-
 28 files changed, 480 insertions(+), 310 deletions(-)
