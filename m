From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v5.8-rc1
Date: Fri, 12 Jun 2020 15:50:49 +0200
Message-ID: <20200612135049.2341678-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFLNu4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jun 2020 09:50:56 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.8-rc1

for you to fetch changes up to f5641d053d46a9a18fe13f2ecb4a7b4a66d9cdf7:

  pwm: Add missing "CONFIG_" prefix (2020-06-04 19:09:28 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.8-rc1

Nothing too exciting for this cycle. A couple of fixes across the board,
and Lee volunteered to help with patch review.

----------------------------------------------------------------
Christophe JAILLET (1):
      pwm: Add missing '\n' in log messages

Hans de Goede (1):
      pwm: lpss: Fix get_state runtime-pm reference handling

Jeff LaBundy (1):
      pwm: Add support for Azoteq IQS620A PWM generator

Kees Cook (1):
      pwm: Add missing "CONFIG_" prefix

Navid Emamdoost (1):
      pwm: img: Call pm_runtime_put() in pm_runtime_get_sync() failed case

Paul Cercueil (4):
      pwm: jz4740: Drop dependency on MACH_INGENIC
      pwm: jz4740: Enhance precision in calculation of duty cycle
      pwm: jz4740: Make PWM start with the active part
      pwm: jz4740: Add support for the JZ4725B

Peter Vasil (1):
      pwm: sun4i: Support direct clock output on Allwinner A64

Rasmus Villemoes (1):
      pwm: rockchip: Simplify rockchip_pwm_get_state()

Sandipan Patra (1):
      pwm: tegra: Support dynamic clock frequency configuration

Thierry Reding (1):
      MAINTAINERS: Add Lee Jones as reviewer for the PWM subsystem

Uwe Kleine-König (1):
      pwm: imx27: Fix rounding behavior

Yoshihiro Shimoda (1):
      dt-bindings: pwm: rcar: add r8a77961 support

 .../devicetree/bindings/pwm/renesas,pwm-rcar.yaml  |   1 +
 MAINTAINERS                                        |   1 +
 drivers/pwm/Kconfig                                |  12 +-
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |   4 +-
 drivers/pwm/pwm-img.c                              |   8 +-
 drivers/pwm/pwm-imx27.c                            |  20 +-
 drivers/pwm/pwm-iqs620a.c                          | 270 +++++++++++++++++++++
 drivers/pwm/pwm-jz4740.c                           |  55 +++--
 drivers/pwm/pwm-lpss.c                             |  15 +-
 drivers/pwm/pwm-rockchip.c                         |   7 +-
 drivers/pwm/pwm-sun4i.c                            |   9 +
 drivers/pwm/pwm-tegra.c                            |  80 +++++-
 13 files changed, 438 insertions(+), 45 deletions(-)
 create mode 100644 drivers/pwm/pwm-iqs620a.c
