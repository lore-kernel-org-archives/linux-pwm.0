From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v4.19-rc1
Date: Thu, 23 Aug 2018 15:31:37 +0200
Message-ID: <20180823133137.32199-1-thierry.reding@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.19-rc1

for you to fetch changes up to 8cdc43afbb2cb58692c49fab0b13e2d9439c0642:

  pwm: mediatek: Add MT7628 support (2018-08-20 11:36:07 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.19-rc1

This contains mostly minor bug fixes as well as some new chip support
for existing drivers.

----------------------------------------------------------------
David Rivshin (1):
      pwm: omap-dmtimer: Return -EPROBE_DEFER if no dmtimer platform data

Enric Balletbo i Serra (1):
      pwm: cros-ec: Switch to SPDX identifier

Fabio Estevam (2):
      pwm: imx: Switch to SPDX identifier
      pwm: mxs: Switch to SPDX identifier

Fabrice Gasnier (1):
      pwm: stm32-lp: Remove useless loop in stm32_pwm_lp_remove()

Jerome Brunet (1):
      pwm: meson: Fix mux clock names

John Crispin (2):
      dt-bindings: pwm: Add MT7628 information
      pwm: mediatek: Add MT7628 support

Thomas Hebb (1):
      pwm: berlin: Don't use broken prescaler values

Vignesh R (2):
      pwm: tiehrpwm: Don't use emulation mode bits to control PWM output
      pwm: tiehrpwm: Fix disabling of output of PWMs

Yoshihiro Shimoda (1):
      dt-bindings: pwm: rcar: Add bindings for R-Car E3 support

shenwei.wang@nxp.com (4):
      pwm: fsl-ftm: Added a dedicated IP interface clock
      pwm: fsl-ftm: Added the support of per-compatible data
      pwm: fsl-ftm: Enable support for the new SoC i.MX8QM
      dt-bindings: pwm: fsl-ftm: Add compatible string for i.MX8QM

 .../devicetree/bindings/pwm/pwm-fsl-ftm.txt        |  5 +-
 .../devicetree/bindings/pwm/pwm-mediatek.txt       |  4 +-
 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   |  1 +
 drivers/pwm/Kconfig                                |  2 +-
 drivers/pwm/pwm-berlin.c                           | 45 +++++++++--------
 drivers/pwm/pwm-cros-ec.c                          |  9 ++--
 drivers/pwm/pwm-fsl-ftm.c                          | 57 +++++++++++++++++++---
 drivers/pwm/pwm-imx.c                              |  5 +-
 drivers/pwm/pwm-mediatek.c                         | 19 +++++++-
 drivers/pwm/pwm-meson.c                            |  3 +-
 drivers/pwm/pwm-mxs.c                              |  8 +--
 drivers/pwm/pwm-omap-dmtimer.c                     |  5 +-
 drivers/pwm/pwm-stm32-lp.c                         |  4 +-
 drivers/pwm/pwm-tiehrpwm.c                         | 14 ++----
 14 files changed, 115 insertions(+), 66 deletions(-)
