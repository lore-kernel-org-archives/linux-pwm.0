From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v4.1-rc1
Date: Thu, 23 Apr 2015 14:58:48 +0200
Message-ID: <1429793928-31818-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.1-rc1

for you to fetch changes up to c264f1110d27185f8531602f5fce400a6bbce946:

  pwm: Remove __init initializer for pwm_add_table() (2015-04-23 14:50:52 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.1-rc1

Not much has been happening in PWM land lately, so this contains mostly
minor fixes that didn't seem urgent enough for a late pull-request last
cycle.

----------------------------------------------------------------
Gaetan Hug (1):
      pwm: mxs: Fix period divider computation

Krzysztof Kozlowski (1):
      pwm: pca9685: Constify struct regmap_config

Matt Porter (1):
      pwm: imx-pwm: add explicit compatible strings and required clock properties

Nicolas Ferre (1):
      pwm: atmel-hlcdc: Add errata handling for sama5d4

Shobhit Kumar (1):
      pwm: Remove __init initializer for pwm_add_table()

Sjoerd Simons (1):
      pwm: samsung: Fix output race on disabling

 Documentation/devicetree/bindings/pwm/imx-pwm.txt | 12 ++++++++-
 drivers/pwm/core.c                                |  2 +-
 drivers/pwm/pwm-atmel-hlcdc.c                     |  4 +++
 drivers/pwm/pwm-mxs.c                             |  8 ++++--
 drivers/pwm/pwm-pca9685.c                         |  2 +-
 drivers/pwm/pwm-samsung.c                         | 32 ++++++++++++++++++++++-
 6 files changed, 54 insertions(+), 6 deletions(-)
