From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v4.10-rc1
Date: Thu, 15 Dec 2016 11:44:11 +0100
Message-ID: <20161215104411.18257-1-thierry.reding@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.10-rc1

for you to fetch changes up to d09f00810850dd6e6eac8895b62bc3fc35435431:

  pwm: Add PWM driver for HiSilicon BVT SOCs (2016-11-29 16:50:12 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.10-rc1

This is a very tiny pull request, with just a new driver for HiSilicon
BVT SoCs and a cleanup for the Amlogic Meson driver.

There are other patches on the list, but my timing was really bad this
time and I ended up not having the time to look at them in enough detail
to be comfortable merging them.

----------------------------------------------------------------
Javier Martinez Canillas (1):
      pwm: meson: Remove unneeded platform MODULE_ALIAS

yuanjian (1):
      pwm: Add PWM driver for HiSilicon BVT SOCs

 .../devicetree/bindings/pwm/pwm-hibvt.txt          |  21 ++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-hibvt.c                            | 271 +++++++++++++++++++++
 drivers/pwm/pwm-meson.c                            |   1 -
 5 files changed, 302 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
 create mode 100644 drivers/pwm/pwm-hibvt.c
