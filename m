From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v4.14-rc1
Date: Mon, 11 Sep 2017 14:14:42 +0200
Message-ID: <20170911121442.1243-1-thierry.reding@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35646 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbdIKMOq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Sep 2017 08:14:46 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.14-rc1

for you to fetch changes up to 7755daf5e7e82499a4cdd7c2ad2be2578cc1df20:

  Merge branch 'for-4.14/drivers' into for-next (2017-08-21 10:39:16 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.14-rc1

The changes for this release include a new driver for the PWM controller
found on SoCs of the ZTX ZX family. Support for an old SH-Mobile SoC has
been dropped and the Rockchip and MediaTek drivers gain support for more
generations.

Other than that there are a bunch of coding style fixes, minor bug fixes
and cleanup as well as documentation patches.

----------------------------------------------------------------
Andy Yan (1):
      dt-bindings: pwm: Add description for rv1108 PWM

Arvind Yadav (1):
      pwm: vt8500: Undo preparation of a clock source.

Bartlomiej Zolnierkiewicz (2):
      pwm: samsung: Remove redundant checks from pwm_samsung_config()
      pwm: pwm-samsung: fix suspend/resume support

David Wu (6):
      pwm: rockchip: Add APB and function both clocks support
      pwm: rockchip: Remove the judge from return value of pwm_config()
      pwm: rockchip: Use pwm_apply() instead of pwm_enable()
      pwm: rockchip: Move the configuration of polarity
      pwm: rockchip: Use same PWM ops for each IP
      pwm: rockchip: Add rk3328 support

Johan Hovold (2):
      pwm: tiehrpwm: Fix runtime PM imbalance at unbind
      pwm: tiehrpwm: fix clock imbalance in probe error path

Philipp Zabel (2):
      pwm: hibvt: Explicitly request exclusive reset control
      pwm: tegra: Explicitly request exclusive reset control

Rob Herring (1):
      pwm: Convert to using %pOF instead of full_name

Shawn Guo (2):
      dt-bindings: pwm: Add bindings doc for ZTE ZX PWM controller
      pwm: Add ZTE ZX PWM device driver

Simon Horman (1):
      pwm: renesas-tpu: Remove support for SH7372

Stefan Wahren (2):
      dt-bindings: pwm: bcm2835: Increase pwm-cells
      pwm: bcm2835: Support for polarity setting via DT

Sven Van Asbroeck (1):
      pwm: pca9685: clarify pca9685_set_sleep_mode() interface.

Thierry Reding (5):
      pwm: tiecap: Miscellaneous coding style fixups
      pwm: tiecap: Set driver data before runtime PM enable
      pwm: tiehrpwm: Miscellaneous coding style fixups
      pwm: tiehrpwm: Set driver data before runtime PM enable
      Merge branch 'for-4.14/drivers' into for-next

Vignesh R (2):
      pwm: Kconfig: Enable pwm-tiecap to be built for Keystone
      dt-bindings: pwm: tiecap: Add TI 66AK2G SoC specific compatible

Zhi Mao (5):
      pwm: mediatek: Fix Kconfig description
      pwm: mediatek: Fix PWM source clock selection
      pwm: mediatek: Fix clock control issue
      dt-bindings: pwm: Add MT2712/MT7622 information
      pwm: mediatek: Disable clock on PWM configuration failure

 .../devicetree/bindings/pwm/pwm-bcm2835.txt        |   4 +-
 .../devicetree/bindings/pwm/pwm-mediatek.txt       |   6 +-
 .../devicetree/bindings/pwm/pwm-rockchip.txt       |  11 +-
 .../devicetree/bindings/pwm/pwm-tiecap.txt         |   1 +
 Documentation/devicetree/bindings/pwm/pwm-zx.txt   |  22 ++
 .../devicetree/bindings/pwm/renesas,tpu-pwm.txt    |   1 -
 drivers/pwm/Kconfig                                |  13 +-
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-bcm2835.c                          |   2 +
 drivers/pwm/pwm-hibvt.c                            |   2 +-
 drivers/pwm/pwm-mediatek.c                         |  78 ++++--
 drivers/pwm/pwm-meson.c                            |   2 +-
 drivers/pwm/pwm-pca9685.c                          |  14 +-
 drivers/pwm/pwm-renesas-tpu.c                      |   1 -
 drivers/pwm/pwm-rockchip.c                         | 281 ++++++++++----------
 drivers/pwm/pwm-samsung.c                          |  70 ++---
 drivers/pwm/pwm-tegra.c                            |   2 +-
 drivers/pwm/pwm-tiecap.c                           |  90 ++++---
 drivers/pwm/pwm-tiehrpwm.c                         | 122 +++++----
 drivers/pwm/pwm-vt8500.c                           |   1 +
 drivers/pwm/pwm-zx.c                               | 282 +++++++++++++++++++++
 21 files changed, 699 insertions(+), 307 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-zx.txt
 create mode 100644 drivers/pwm/pwm-zx.c
