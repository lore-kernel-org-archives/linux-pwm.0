From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v5.4-rc1
Date: Fri, 27 Sep 2019 18:31:04 +0200
Message-ID: <20190927163104.1456471-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 6cf9481b440da6d6d86bd8e4c99a8b553b9d1271:

  pwm: Fallback to the static lookup-list when acpi_pwm_get fails (2019-08-08 13:17:38 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.4-rc1

for you to fetch changes up to da635e7abe3f4ec9a8270ca4f5ba946d1a43f678:

  MAINTAINERS: Add myself as reviewer for the PWM subsystem (2019-09-26 13:27:51 +0200)

Just in case you're wondering, the start commit above corresponds to the
pwm/for-5.3-rc4 tag that you pulled into v5.3-rc4.

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.4-rc1

Besides one new driver being added for the PWM controller found in
various Spreadtrum SoCs, this series of changes brings a slew of, mostly
minor, fixes and cleanups for existing drivers, as well as some
enhancements to the core code.

Lastly, Uwe is added to the PWM subsystem entry of the MAINTAINERS file,
making official his role as a reviewer.

----------------------------------------------------------------
Anson Huang (1):
      pwm: mxs: Use devm_platform_ioremap_resource() to simplify code

Baolin Wang (2):
      dt-bindings: pwm: sprd: Add Spreadtrum PWM documentation
      pwm: sprd: Add Spreadtrum PWM support

Ding Xiang (1):
      pwm: sifive: Remove redundant error message

Fabien Parent (2):
      dt-bindings: pwm: mediatek: Add documentation for MT8516
      pwm: mediatek: Add MT8516 SoC support

Fabrice Gasnier (1):
      pwm: stm32-lp: Add check in case requested period cannot be achieved

Kamel Bouhara (1):
      pwm: atmel: Remove platform_device_id and use only dt bindings

Ryder Lee (1):
      dt-bindings: pwm: Update bindings for MT7629 SoC

Sam Shih (6):
      pwm: mediatek: Drop the check for of_device_get_match_data()
      pwm: mediatek: Remove the has_clks field
      pwm: mediatek: Allocate the clks array dynamically
      pwm: mediatek: Use pwm_mediatek as common prefix
      pwm: mediatek: Update license and switch to SPDX tag
      pwm: mediatek: Add MT7629 compatible string

Stefan Wahren (3):
      pwm: bcm2835: Suppress error message for invalid period_ns
      pwm: bcm2835: Fix period_ns range check
      pwm: bcm2835: Suppress error message during deferred probe

Stephen Boyd (1):
      pwm: Remove dev_err() usage after platform_get_irq()

Thierry Reding (2):
      pwm: atmel: Remove unneeded check for match data
      pwm: atmel: Consolidate driver data initialization

Uwe Kleine-König (12):
      pwm: jz4740: Document known limitations
      pwm: imx: Document known limitations
      pwm: rockchip: Set polarity unconditionally in .get_state()
      pwm: Introduce local struct pwm_chip in pwm_apply_state()
      pwm: Let pwm_get_state() return the last implemented state
      pwm: rockchip: Don't update the state for the caller of pwm_apply_state()
      pwm: sun4i: Don't update the state for the caller of pwm_apply_state()
      pwm: fsl-ftm: Don't update the state for the caller of pwm_apply_state()
      pwm: Ensure pwm_apply_state() doesn't modify the state argument
      MAINTAINERS: Add a selection of PWM related keywords to the PWM entry
      MAINTAINERS: Add patchwork link for PWM entry
      MAINTAINERS: Add myself as reviewer for the PWM subsystem

Yoshihiro Shimoda (1):
      pwm: rcar: Remove a redundant condition in rcar_pwm_apply()

 .../devicetree/bindings/pwm/pwm-mediatek.txt       |   2 +
 Documentation/devicetree/bindings/pwm/pwm-sprd.txt |  40 +++
 MAINTAINERS                                        |   3 +
 drivers/gpio/gpio-mvebu.c                          |   2 +-
 drivers/pwm/Kconfig                                |  13 +-
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |  40 +--
 drivers/pwm/pwm-atmel-hlcdc.c                      |   2 +-
 drivers/pwm/pwm-atmel.c                            |  49 +---
 drivers/pwm/pwm-bcm-iproc.c                        |   2 +-
 drivers/pwm/pwm-bcm2835.c                          |  19 +-
 drivers/pwm/pwm-cros-ec.c                          |   2 +-
 drivers/pwm/pwm-fsl-ftm.c                          |   8 +-
 drivers/pwm/pwm-hibvt.c                            |   2 +-
 drivers/pwm/pwm-imx-tpm.c                          |   4 +-
 drivers/pwm/pwm-imx27.c                            |   6 +-
 drivers/pwm/pwm-jz4740.c                           |   7 +-
 drivers/pwm/pwm-lpss.c                             |   2 +-
 drivers/pwm/pwm-mediatek.c                         | 231 +++++++--------
 drivers/pwm/pwm-meson.c                            |   4 +-
 drivers/pwm/pwm-mxs.c                              |   4 +-
 drivers/pwm/pwm-rcar.c                             |   4 +-
 drivers/pwm/pwm-rockchip.c                         |  18 +-
 drivers/pwm/pwm-sifive.c                           |   6 +-
 drivers/pwm/pwm-sprd.c                             | 309 +++++++++++++++++++++
 drivers/pwm/pwm-sti.c                              |   4 +-
 drivers/pwm/pwm-stm32-lp.c                         |   8 +-
 drivers/pwm/pwm-stm32.c                            |   4 +-
 drivers/pwm/pwm-sun4i.c                            |  10 +-
 drivers/pwm/pwm-zx.c                               |   2 +-
 include/linux/pwm.h                                |   4 +-
 31 files changed, 576 insertions(+), 236 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.txt
 create mode 100644 drivers/pwm/pwm-sprd.c
