From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v4.9-rc1
Date: Wed, 12 Oct 2016 19:08:16 +0200
Message-ID: <20161012170816.8684-1-thierry.reding@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34465 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754624AbcJLRKu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Oct 2016 13:10:50 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.9-rc1

for you to fetch changes up to dc8e6e1e8f2d2719dd396708b0f56d8b73c9ea52:

  Merge branch 'for-4.9/drivers' into for-next (2016-09-08 10:59:30 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.9-rc1

This set of changes contains support for PWM signal capture in the STi
driver as well as support for the PWM controller found on Meson SoCs.
There's also support added for the MediaTek MT2701 and SunXi H3 to the
existing drivers.

Other than that there's a fair set of miscellaneous cleanups and fixes
across the board.

----------------------------------------------------------------
Arnd Bergmann (1):
      pwm: meson: Handle unknown ID values

Brian Norris (1):
      pwm: cros-ec: Add __packed to prevent padding

David Hsu (1):
      pwm: Unexport children before chip removal

Jisheng Zhang (1):
      pwm: berlin: Add suspend/resume support

Jyri Sarha (1):
      pwm: pwm-tipwmss: Remove all runtime PM gets/puts

Lee Jones (11):
      dt-bindings: pwm: sti: Update DT bindings for capture support
      pwm: sti: Rename channel => device
      pwm: sti: Reorganise register names in preparation for new functionality
      pwm: sti: Only request clock rate when needed
      pwm: sti: Supply PWM capture register addresses and bit locations
      pwm: sti: Supply PWM Capture clock handling
      pwm: sti: Initialise PWM capture device data
      pwm: sti: Add support for PWM capture interrupts
      pwm: sti: Add PWM capture callback
      pwm: sti: It's now valid for number of PWM channels to be zero
      pwm: sti: Take the opportunity to conduct a little house keeping

Milo Kim (1):
      pwm: sunxi: Add H3 support

Neil Armstrong (2):
      dt-bindings: pwm: Add bindings for Meson PWM Controller
      pwm: Add support for Meson PWM Controller

Paul Kocialkowski (1):
      pwm: twl: Reliably disable TWL6030 PWMs

Seung-Woo Kim (1):
      pwm: samsung: Fix to use lowest div for large enough modulation bits

Thierry Reding (2):
      Merge branch 'for-4.9/core' into for-next
      Merge branch 'for-4.9/drivers' into for-next

Weiqing Kong (2):
      dt-bindings: pwm: Add MediaTek display PWM bindings
      pwm: Add MediaTek MT2701 display PWM driver support

oliver@schinagl.nl (1):
      pwm: lpc-18xx: use pwm_set_chip_data

 .../devicetree/bindings/pwm/pwm-meson.txt          |  23 +
 .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |   3 +-
 Documentation/devicetree/bindings/pwm/pwm-st.txt   |   8 +-
 .../devicetree/bindings/pwm/pwm-sun4i.txt          |   1 +
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |   2 +
 drivers/pwm/pwm-berlin.c                           |  84 ++++
 drivers/pwm/pwm-cros-ec.c                          |   4 +-
 drivers/pwm/pwm-lpc18xx-sct.c                      |  12 +-
 drivers/pwm/pwm-meson.c                            | 529 +++++++++++++++++++++
 drivers/pwm/pwm-mtk-disp.c                         |  87 +++-
 drivers/pwm/pwm-samsung.c                          |  15 +-
 drivers/pwm/pwm-sti.c                              | 483 +++++++++++++++----
 drivers/pwm/pwm-sun4i.c                            |   9 +
 drivers/pwm/pwm-tipwmss.c                          |  19 -
 drivers/pwm/pwm-twl.c                              |  16 +
 drivers/pwm/sysfs.c                                |  18 +
 include/linux/pwm.h                                |   5 +
 19 files changed, 1183 insertions(+), 145 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-meson.txt
 create mode 100644 drivers/pwm/pwm-meson.c
