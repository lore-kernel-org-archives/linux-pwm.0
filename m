From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v4.20-rc1
Date: Fri,  2 Nov 2018 14:23:59 +0100
Message-ID: <20181102132359.11720-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.20-rc1

for you to fetch changes up to 2153bbc12f77fb2203276befc0f0dddbfb023bb1:

  pwm: lpss: Only set update bit if we are actually changing the settings (2018-10-16 13:16:15 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.20-rc1

This series contains a number of improvements to existing drivers, such
as LPSS. Some drivers, such as renesas-tpu and rcar get support for more
SoC generations. To round things off this fixes an issue with the sysfs
interface.

----------------------------------------------------------------
Biju Das (2):
      dt-bindings: pwm: rcar: Add r8a7744 support
      dt-bindings: pwm: renesas-tpu: Document r8a7744 support

Fabrice Gasnier (2):
      Revert "pwm: Set class for exported channels in sysfs"
      pwm: Send a uevent on the pwmchip device upon channel sysfs (un)export

Fabrizio Castro (1):
      dt-bindings: pwm: rcar: Add r8a774a1 support

Hans de Goede (8):
      ACPI / PM: Export acpi_device_get_power() for use by modular build drivers
      pwm: lpss: Add ACPI HID for second PWM controller on Cherry Trail devices
      pwm: lpss: Move struct pwm_lpss_chip definition to the header file
      pwm: lpss: Check PWM powerstate after resume on Cherry Trail devices
      pwm: lpss: Release runtime-pm reference from the driver's remove callback
      pwm: lpss: Add get_state callback
      pwm: lpss: Force runtime-resume on suspend on Cherry Trail
      pwm: lpss: Only set update bit if we are actually changing the settings

Sergei Shtylyov (3):
      dt-bindings: pwm: renesas: tpu: Fix "compatible" prop description
      dt-bindings: pwm: renesas: pwm-rcar: Document R8A779{7|8}0 bindings
      dt-bindings: pwm: renesas: tpu: Document R8A779{7|8}0 bindings

Thierry Reding (1):
      pwm: tegra: Remove gratuituous blank line

Vignesh R (2):
      dt-bindings: pwm: tiecap: Add TI AM654 SoC specific compatible
      pwm: Enable TI ECAP driver for ARCH_K3

Wolfram Sang (1):
      pwm: Use SPDX identifier for Renesas drivers

 .../devicetree/bindings/pwm/pwm-tiecap.txt         |  1 +
 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   |  4 ++
 .../devicetree/bindings/pwm/renesas,tpu-pwm.txt    | 10 +++-
 drivers/acpi/device_pm.c                           |  1 +
 drivers/pwm/Kconfig                                |  5 +-
 drivers/pwm/pwm-lpss-platform.c                    | 24 +++++++--
 drivers/pwm/pwm-lpss.c                             | 61 +++++++++++++++++-----
 drivers/pwm/pwm-lpss.h                             | 14 ++++-
 drivers/pwm/pwm-rcar.c                             |  5 +-
 drivers/pwm/pwm-renesas-tpu.c                      | 10 +---
 drivers/pwm/pwm-tegra.c                            |  1 -
 drivers/pwm/sysfs.c                                | 12 ++++-
 12 files changed, 110 insertions(+), 38 deletions(-)
