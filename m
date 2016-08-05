From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v4.8-rc1
Date: Fri,  5 Aug 2016 17:51:42 +0200
Message-ID: <20160805155142.21247-1-thierry.reding@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34518 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161444AbcHEPvs (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Aug 2016 11:51:48 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 33cdcee04be3b4482be97393167e7561b2584e1e:

  pwm: Fix pwm_apply_args() (2016-06-23 18:37:05 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.8-rc1

for you to fetch changes up to 53de7c26ded7f5e954bfc202dffc43c0dd165337:

  Merge branch 'for-4.8/regulator' into for-next (2016-07-25 16:23:40 +0200)

You'll notice that I've started using several branches to maintain the
PWM subsystem. In order to make fixes available to linux-next early on
I pull in the fixes branch into the for-next branch. The base for this
pull request is that fixes branch (you had already pulled that for 4.7
earlier) so that you don't see the same patches twice. One side-effect
of that is that you'll still see the merge for that branch in the
shortlog below. I haven't found a way to get rid of that, except maybe
by changing my workflow and ask Stephen to separately pull in my fixes
branch into linux-next, so that I don't have to include it in for-next
anymore.

Another alternative would be to redo the merge right before I send out
the pull request and exclude the fixes branch. That, of course, means
what you get is slightly different from what linux-next contains, and
I'd like to avoid that.

I suspect that you don't mind much either way, but in case you do, let
me know what your preference is and I can adapt for the next release
cycle.

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.8-rc1

This set of changes improve some aspects of the atomic API as well as
make use of this new API in the regulator framework to allow properly
dealing with critical regulators controlled by a PWM.

Aside from that there's a bunch of updates and cleanups for existing
drivers, as well as the addition of new drivers for the Broadcom iProc,
STMPE and ChromeOS EC controllers.

----------------------------------------------------------------
Alexandre Courbot (1):
      regulator: pwm: Support for enable GPIO

Andy Shevchenko (2):
      pwm: lpss: pci: Enable PWM module on Intel Edison
      pwm: lpss: Move clk_rate check to ->probe()

Boris Brezillon (13):
      regulator: pwm: Drop unneeded pwm_enable() call
      pwm: Add a helper to prepare a new PWM state
      pwm: Add relative duty cycle manipulation helpers
      regulator: pwm: Adjust PWM config at probe time
      regulator: pwm: Switch to the atomic PWM API
      regulator: pwm: Properly initialize the ->state field
      regulator: pwm: Retrieve correct voltage
      pwm: rockchip: Fix period and duty cycle approximation
      pwm: rockchip: Add support for hardware readout
      pwm: rockchip: Avoid glitches on already running PWMs
      pwm: rockchip: Add support for atomic update
      regulator: pwm: Support extra continuous mode cases
      regulator: pwm: Document pwm-dutycycle-unit and pwm-dutycycle-range

Brian Norris (3):
      mfd: cros_ec: Add EC_PWM function definitions
      dt-bindings: pwm: Add binding for ChromeOS EC PWM
      pwm: Add ChromeOS EC PWM driver

Cooper Jr., Franklin (3):
      pwm: pwm-tiehrpwm: Update DT binding document to use generic node name
      pwm: pwm-ti*: Get the clock from the PWMSS parent when using old bindings
      pwm: pwm-ti*: Remove support for local clock gating

Dan O'Donovan (1):
      pwm: lpss: Fix base_unit calculation for PWM frequency

Douglas Anderson (1):
      regulator: pwm: Fix regulator ramp delay for continuous mode

Guillermo Rodriguez (1):
      pwm: atmel: Fix disabling of PWM channels

Hyong Bin Kim (1):
      pwm: tegra: Avoid overflow when calculating duty cycle

Laxman Dewangan (2):
      dt-bindings: pwm: tegra: Add compatible string for Tegra186
      pwm: tegra: Add support for Tegra186

Lee Jones (2):
      pwm: Add PWM capture support
      pwm: sysfs: Add PWM capture support

Linus Walleij (2):
      dt-bindings: pwm: Add DT bindings for STMPE PWM
      pwm: Add a driver for the STMPE PWM

Mika Westerberg (1):
      pwm: lpss: Prevent on_time_div overflow on lower frequencies

Rohith Seelaboyina (1):
      pwm: tegra: Add support for reset control

Ryo Kodama (1):
      pwm: rcar: Use ARCH_RENESAS

Sylvain Lemieux (1):
      pwm: lpc32xx: Set PWM_PIN_LEVEL bit to default value

Thierry Reding (15):
      Merge branch 'for-4.8/core' into for-4.8/regulator
      pwm: Remove gratuitous blank line
      Merge tag 'pwm-modernization' of git://git.kernel.org/.../broonie/regulator into for-4.8/regulator
      pwm: tegra: Drop NUM_PWM macro
      pwm: tegra: Remove useless padding
      pwm: tegra: Rename mmio_base to regs
      pwm: atmel: Fix checkpatch warnings
      pwm: atmel: Use of_device_get_match_data()
      Merge branch 'for-4.8/mfd' into for-4.8/drivers
      Merge branch 'fixes' into for-next
      Merge branch 'for-4.8/core' into for-next
      Merge branch 'for-4.8/mfd' into for-next
      Merge branch 'for-4.8/capture' into for-next
      Merge branch 'for-4.8/drivers' into for-next
      Merge branch 'for-4.8/regulator' into for-next

Tomeu Vizoso (1):
      mfd: cros_ec: Add cros_ec_cmd_xfer_status() helper

Ulrich Hecht (1):
      dt-bindings: pwm: Add R-Car H3 device tree bindings

Victor(Weiguo) Pan (1):
      pwm: tegra: Allow 100 % duty cycle

Yendapally Reddy Dhananjaya Reddy (2):
      dt-bindings: pwm: Add Broadcom iProc PWM controller binding
      pwm: Add support for Broadcom iProc PWM controller

 Documentation/ABI/testing/sysfs-class-pwm          |   9 +
 .../devicetree/bindings/pwm/brcm,iproc-pwm.txt     |  21 ++
 .../devicetree/bindings/pwm/google,cros-ec-pwm.txt |  23 ++
 .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt |  12 +-
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |   4 +-
 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   |   1 +
 .../devicetree/bindings/pwm/st,stmpe-pwm.txt       |  18 ++
 .../bindings/regulator/pwm-regulator.txt           |  26 +-
 drivers/platform/chrome/cros_ec_proto.c            |  17 ++
 drivers/pwm/Kconfig                                |  26 +-
 drivers/pwm/Makefile                               |   3 +
 drivers/pwm/core.c                                 |  27 ++
 drivers/pwm/pwm-atmel.c                            |  30 +-
 drivers/pwm/pwm-bcm-iproc.c                        | 277 ++++++++++++++++++
 drivers/pwm/pwm-cros-ec.c                          | 260 +++++++++++++++++
 drivers/pwm/pwm-lpc32xx.c                          |   7 +
 drivers/pwm/pwm-lpss-pci.c                         |   1 +
 drivers/pwm/pwm-lpss.c                             |  26 +-
 drivers/pwm/pwm-rockchip.c                         | 178 +++++++++---
 drivers/pwm/pwm-stmpe.c                            | 319 +++++++++++++++++++++
 drivers/pwm/pwm-tegra.c                            |  69 +++--
 drivers/pwm/pwm-tiecap.c                           |  37 +--
 drivers/pwm/pwm-tiehrpwm.c                         |  38 +--
 drivers/pwm/pwm-tipwmss.c                          |  49 ----
 drivers/pwm/pwm-tipwmss.h                          |  39 ---
 drivers/pwm/sysfs.c                                |  17 ++
 drivers/regulator/pwm-regulator.c                  | 196 +++++++++----
 include/linux/mfd/cros_ec.h                        |  15 +
 include/linux/mfd/cros_ec_commands.h               |  31 ++
 include/linux/pwm.h                                | 113 +++++++-
 30 files changed, 1599 insertions(+), 290 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt
 create mode 100644 drivers/pwm/pwm-bcm-iproc.c
 create mode 100644 drivers/pwm/pwm-cros-ec.c
 create mode 100644 drivers/pwm/pwm-stmpe.c
 delete mode 100644 drivers/pwm/pwm-tipwmss.h
