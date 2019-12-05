From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v5.5-rc1
Date: Thu,  5 Dec 2019 07:10:44 +0100
Message-ID: <20191205061044.1006766-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 40a6b9a00930fd6b59aa2eb6135abc2efe5440c3:

  Revert "pwm: Let pwm_get_state() return the last implemented state" (2019-10-21 16:48:52 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.5-rc1

for you to fetch changes up to f5ff2628867b9c7cb4abb6c6a5a7eea079dad4b6:

  pwm: imx27: Unconditionally write state to hardware (2019-10-21 16:58:09 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.5-rc1

Various changes and minor fixes across a couple of drivers.

----------------------------------------------------------------
Colin Ian King (1):
      pwm: sun4i: Drop redundant assignment to variable pval

Fabrice Gasnier (3):
      dt-bindings: pwm-stm32: Document pinctrl sleep state
      pwm: stm32: Split breakinput apply routine to ease PM support
      pwm: stm32: Add power management support

Ondrej Jirman (1):
      pwm: sun4i: Fix incorrect calculation of duty_cycle/period

Rasmus Villemoes (1):
      pwm: Update comment on struct pwm_ops::apply

Thierry Reding (8):
      dt-bindings: pwm: mediatek: Remove gratuitous compatible string for MT7629
      pwm: stm32: Validate breakinput data from DT
      pwm: stm32: Remove clutter from ternary operator
      pwm: stm32: Pass breakinput instead of its values
      pwm: Read initial hardware state at request time
      pwm: cros-ec: Cache duty cycle value
      pwm: imx27: Cache duty cycle register value
      pwm: imx27: Unconditionally write state to hardware

 .../devicetree/bindings/pwm/pwm-mediatek.txt       |   2 +-
 .../devicetree/bindings/pwm/pwm-stm32.txt          |   8 +-
 drivers/pwm/core.c                                 |   6 +-
 drivers/pwm/pwm-cros-ec.c                          |  58 ++++++++-
 drivers/pwm/pwm-imx27.c                            | 137 ++++++++++++---------
 drivers/pwm/pwm-stm32.c                            | 112 ++++++++++++-----
 drivers/pwm/pwm-sun4i.c                            |   5 +-
 include/linux/mfd/stm32-timers.h                   |  12 +-
 include/linux/pwm.h                                |   5 +-
 9 files changed, 228 insertions(+), 117 deletions(-)
