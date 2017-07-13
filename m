From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v4.13-rc1
Date: Thu, 13 Jul 2017 15:01:05 +0200
Message-ID: <20170713130105.18537-1-thierry.reding@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.13-rc1

for you to fetch changes up to 5ec8c48a6235175f7ff59ed1acbe91d4d0398026:

  Merge branch 'for-4.13/drivers' into for-next (2017-07-06 17:16:47 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.13-rc1

This release cycle's changes include mostly updates and cleanups to
existing drivers along with a few cleanups to the core, documentation
and device tree bindings.

----------------------------------------------------------------
Alexandre Belloni (3):
      pwm: sun4i: Improve hardware read out
      pwm: sun4i: Switch to atomic PWM
      pwm: sun4i: Drop legacy callbacks

Arvind Yadav (1):
      pwm: hibvt: Constify hibvt_pwm_ops

Fabrice GASNIER (1):
      dt-bindings: pwm: Update STM32 timers clock names

Jerome Brunet (4):
      pwm: Silently error out on EPROBE_DEFER
      pwm: meson: Add compatible for the gxbb ao PWMs
      dt-bindings: pwm: meson: Add compatible for gxbb ao PWMs
      pwm: meson: Improve PWM calculation precision

Laxman Dewangan (1):
      pwm: tegra: Set maximum pwm clock source per SoC tapeout

Markus Elfring (1):
      pwm: bfin: Remove unneeded error message

Mauro Carvalho Chehab (1):
      pwm: Standardize document format

Nick Vaccaro (1):
      pwm: cros-ec: Fix transposed param settings

Thierry Reding (3):
      Merge branch 'for-4.13/core' into for-next
      Merge branch 'for-4.13/dt' into for-next
      Merge branch 'for-4.13/drivers' into for-next

Ulrich Hecht (1):
      dt-bindings: pwm: Add R-Car M3-W device tree bindings

 .../devicetree/bindings/pwm/pwm-meson.txt          |   4 +-
 .../devicetree/bindings/pwm/pwm-stm32.txt          |   2 +-
 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   |   1 +
 Documentation/pwm.txt                              |  46 ++--
 drivers/pwm/core.c                                 |   4 +-
 drivers/pwm/pwm-bfin.c                             |   4 +-
 drivers/pwm/pwm-cros-ec.c                          |   4 +-
 drivers/pwm/pwm-hibvt.c                            |   2 +-
 drivers/pwm/pwm-meson.c                            |  48 +++-
 drivers/pwm/pwm-sun4i.c                            | 263 ++++++++++++---------
 drivers/pwm/pwm-tegra.c                            |  18 +-
 11 files changed, 244 insertions(+), 152 deletions(-)
