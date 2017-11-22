From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v4.15-rc1
Date: Wed, 22 Nov 2017 11:47:48 +0100
Message-ID: <20171122104748.31958-1-thierry.reding@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.15-rc1

for you to fetch changes up to f83e2ae2606b3754a5b9dfe9dd792c453698df6c:

  pwm: stm32-lp: Remove pwm_is_enabled() check before calling pwm_disable() (2017-11-15 11:02:06 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.15-rc1

The changes for this release include power management improvements for
the pwm-img driver, support for the backup mode on pwm-atmel-tcb as well
as support for more hardware with the R-Car and Mediatek drivers.

To round things off there's a bit of cleanup for sunxi and stm32-lp.

----------------------------------------------------------------
Axel Lin (1):
      pwm: stm32-lp: Remove pwm_is_enabled() check before calling pwm_disable()

Corentin Labbe (1):
      pwm: sunxi: Use of_device_get_match_data()

Ed Blake (2):
      pwm: img: Add suspend / resume handling
      pwm: img: Add runtime PM

Romain Izard (1):
      pwm: atmel-tcb: Support backup mode

Yoshihiro Shimoda (1):
      dt-bindings: pwm: Add R-Car D3 device tree bindings

Zhi Mao (1):
      pwm: mediatek: Add MT2712/MT7622 support

 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   |   1 +
 drivers/pwm/pwm-atmel-tcb.c                        |  63 +++++++-
 drivers/pwm/pwm-img.c                              | 160 ++++++++++++++++++---
 drivers/pwm/pwm-mediatek.c                         |  53 +++++--
 drivers/pwm/pwm-stm32-lp.c                         |   3 +-
 drivers/pwm/pwm-sun4i.c                            |   8 +-
 6 files changed, 252 insertions(+), 36 deletions(-)
