From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v5.2-rc1
Date: Fri, 10 May 2019 13:12:03 +0200
Message-ID: <20190510111203.14436-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.2-rc1

for you to fetch changes up to f41efceb46e697a750e93c19e4579dc50697effe:

  pwm: meson: Add clock source configuration for Meson G12A (2019-05-09 17:29:31 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.2-rc1

Nothing out of the ordinary this cycle. The bulk of this is a collection
of fixes for existing drivers and some cleanups. There's one new driver
for i.MX SoCs and addition of support for some new variants to existing
drivers.

----------------------------------------------------------------
Anson Huang (3):
      pwm: imx27: Use devm_platform_ioremap_resource() to simplify code
      dt-bindings: pwm: Add i.MX TPM PWM binding
      pwm: Add i.MX TPM PWM driver support

Bichao Zheng (1):
      pwm: meson: Don't disable PWM when setting duty repeatedly

Christoph Vogtländer (1):
      pwm: tiehrpwm: Update shadow register for disabling PWMs

Martin Blumenstingl (2):
      pwm: meson: Consider 128 a valid pre-divider
      pwm: meson: Use the spin-lock only to protect register modifications

Nathan Chancellor (1):
      pwm: img: Turn final 'else if' into 'else' in img_pwm_config

Neil Armstrong (2):
      dt-bindings: pwm: Update bindings for the Meson G12A Family
      pwm: meson: Add clock source configuration for Meson G12A

Phong Hoang (1):
      pwm: Fix deadlock warning when removing PWM device

Uwe Kleine-König (3):
      pwm: sysfs: fix typo "its" -> "it's"
      pwm: Clear chip_data in pwm_put()
      pwm: samsung: Don't uses devm_*() functions in ->request()

Vignesh Raghavendra (2):
      dt-bindings: pwm: tiehrpwm: Add TI AM654 SoC specific compatible
      pwm: tiehrpwm: Enable compilation for ARCH_K3

 .../devicetree/bindings/pwm/imx-tpm-pwm.txt        |  22 +
 .../devicetree/bindings/pwm/pwm-meson.txt          |   3 +
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |   1 +
 drivers/pwm/Kconfig                                |  16 +-
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |  11 +-
 drivers/pwm/pwm-berlin.c                           |   1 -
 drivers/pwm/pwm-img.c                              |   2 +-
 drivers/pwm/pwm-imx-tpm.c                          | 449 +++++++++++++++++++++
 drivers/pwm/pwm-imx27.c                            |   4 +-
 drivers/pwm/pwm-meson.c                            |  64 ++-
 drivers/pwm/pwm-pca9685.c                          |   1 -
 drivers/pwm/pwm-samsung.c                          |   5 +-
 drivers/pwm/pwm-tiehrpwm.c                         |   2 +
 drivers/pwm/sysfs.c                                |  16 +-
 include/linux/pwm.h                                |   5 -
 16 files changed, 552 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
 create mode 100644 drivers/pwm/pwm-imx-tpm.c
