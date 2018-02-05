From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v4.16-rc1
Date: Mon,  5 Feb 2018 14:03:05 +0100
Message-ID: <20180205130305.25069-1-thierry.reding@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.16-rc1

for you to fetch changes up to bccaa3f917c90917a758020dfbdd9027290a7c4e:

  pwm: meson: Add clock source configuration for Meson-AXG (2017-12-05 09:51:36 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.16-rc1

The Meson PWM controller driver gains support for the AXG series and a
minor bug is fixed for the STMPE driver.

To round things off, the class is now set for PWM channels exported via
sysfs which allows non-root access, provided that the system has been
configured accordingly.

----------------------------------------------------------------
Axel Lin (1):
      pwm: stmpe: Fix wrong register offset for hwpwm=2 case

Gottfried Haider (1):
      pwm: Set class for exported channels in sysfs

Jian Hu (2):
      dt-bindings: pwm: Update bindings for the Meson-AXG
      pwm: meson: Add clock source configuration for Meson-AXG

 .../devicetree/bindings/pwm/pwm-meson.txt          |  2 ++
 drivers/pwm/pwm-meson.c                            | 26 ++++++++++++++++++++++
 drivers/pwm/pwm-stmpe.c                            |  2 +-
 drivers/pwm/sysfs.c                                |  1 +
 4 files changed, 30 insertions(+), 1 deletion(-)
