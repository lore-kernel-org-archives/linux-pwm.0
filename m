From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v4.12-rc1
Date: Tue,  9 May 2017 17:59:11 +0200
Message-ID: <20170509155911.31267-1-thierry.reding@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33830 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755343AbdEIP7P (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 May 2017 11:59:15 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.12-rc1

for you to fetch changes up to 97512ceafaacf8cdb96d6a36ae55e8335c0a9e55:

  Merge branch 'for-4.12/drivers' into for-next (2017-04-13 17:41:50 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.12-rc1

Adds a new driver for the PWM controller found on MediaTek SoCs and
extends support for the Atmel PWM controller to include the SAMA5D2.

Some existing drivers have been migrated to the atomic API and a few
others see miscellaneous improvements.

----------------------------------------------------------------
Andy Shevchenko (1):
      pwm: lpss: Split Tangier configuration

Boris Brezillon (2):
      pwm: atmel-hlcdc: Convert to the atomic PWM API
      pwm: atmel-hlcdc: Implement the suspend/resume hooks

Claudiu Beznea (2):
      pwm: atmel: Switch to atomic PWM
      pwm: atmel: Enable PWM on sama5d2

David Wu (1):
      pwm: rockchip: State of PWM clock should synchronize with PWM enabled state

Hans de Goede (1):
      pwm: lpss: Set enable-bit before waiting for update-bit to go low

John Crispin (2):
      dt-bindings: pwm: Add MediaTek PWM bindings
      pwm: Add MediaTek PWM support

Laxman Dewangan (5):
      pwm: tegra: Use DIV_ROUND_CLOSEST_ULL() instead of local implementation
      pwm: tegra: Increase precision in PWM rate calculation
      pwm: tegra: Add DT binding details to configure pin in suspends/resume
      pwm: tegra: Add support to configure pin state in suspends/resume
      pwm: tegra: Read PWM clock source rate in driver init

Sven Van Asbroeck (1):
      pwm: pca9685: Fix GPIO-only operation

Thierry Reding (3):
      pwm: tegra: Avoid potential overflow for short periods
      Merge branch 'for-4.11/fixes' into for-next
      Merge branch 'for-4.12/drivers' into for-next

kbuild test robot (1):
      pwm: mediatek: Don't explicitly set .owner

 .../devicetree/bindings/pwm/atmel-pwm.txt          |   1 +
 .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt |  45 ++++
 .../devicetree/bindings/pwm/pwm-mediatek.txt       |  34 +++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-atmel-hlcdc.c                      | 260 +++++++++----------
 drivers/pwm/pwm-atmel.c                            | 276 ++++++++++-----------
 drivers/pwm/pwm-lpss-pci.c                         |  10 +-
 drivers/pwm/pwm-lpss-platform.c                    |   1 +
 drivers/pwm/pwm-lpss.c                             |  19 +-
 drivers/pwm/pwm-lpss.h                             |   1 +
 drivers/pwm/pwm-mediatek.c                         | 219 ++++++++++++++++
 drivers/pwm/pwm-pca9685.c                          | 112 ++++++---
 drivers/pwm/pwm-rockchip.c                         |  40 ++-
 drivers/pwm/pwm-tegra.c                            |  37 ++-
 15 files changed, 742 insertions(+), 323 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
 create mode 100644 drivers/pwm/pwm-mediatek.c
