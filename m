From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v4.21-rc1
Date: Mon, 24 Dec 2018 12:15:08 +0100
Message-ID: <20181224111508.23847-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.21-rc1

for you to fetch changes up to e94b815524f83536415d7d59cc1833ad05934d97:

  dt-bindings: pwm: rcar: Add r8a774c0 support (2018-12-24 12:06:56 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.21-rc1

Not a lot going on this cycle. There's some more cleanup going on and
new driver support that was not quite ready in time for v4.21-rc1, but
here are a few fixes and improvements that are good to go. The Kona PWM
driver can now be built on the Cygnus architecture and the i.MX driver
gained support for hardware readback. Some small fixes are provided for
the clks711x and lpc18xx-sct drivers. Finally, to round things off some
drivers are switched to SPDX license identifiers.

----------------------------------------------------------------
Alexander Shiyan (2):
      pwm: clps711x: Fix period calculation
      pwm: clps711x: Switch to SPDX identifier

Anson Huang (1):
      pwm: imx: Add ipg clock operation

Clément Péron (1):
      pwm: Enable Kona PWM to be built for the Cygnus architecture

Fabrizio Castro (1):
      dt-bindings: pwm: rcar: Add r8a774c0 support

Michal Vokáč (3):
      pwm: imx: Sort include files
      pwm: imx: Use bitops and bitfield macros to define register values
      pwm: imx: Implement get_state() function for hardware readout

Stefan Wahren (1):
      pwm: bcm2835: Switch to SPDX identifier

Uwe Kleine-König (2):
      pwm: lpc18xx-sct: Don't reconfigure PWM in .request and .free
      pwm: Drop legacy wrapper for changing polarity

 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   |   1 +
 drivers/pwm/Kconfig                                |   4 +-
 drivers/pwm/pwm-bcm2835.c                          |   5 +-
 drivers/pwm/pwm-clps711x.c                         |  13 +-
 drivers/pwm/pwm-imx.c                              | 194 +++++++++++++++++----
 drivers/pwm/pwm-lpc18xx-sct.c                      |   3 -
 include/linux/pwm.h                                |  42 -----
 7 files changed, 173 insertions(+), 89 deletions(-)
