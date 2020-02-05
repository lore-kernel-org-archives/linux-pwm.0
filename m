From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v5.6-rc1
Date: Wed,  5 Feb 2020 15:25:11 +0100
Message-ID: <20200205142511.2172050-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38649 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgBEOZP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Feb 2020 09:25:15 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.6-rc1

for you to fetch changes up to 9871abffc81048e20f02e15d6aa4558a44ad53ea:

  pwm: Remove set but not set variable 'pwm' (2020-01-20 15:40:49 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.6-rc1

This set of changes are mostly cleanups and minor improvements with some
new chip support for some drivers.

----------------------------------------------------------------
Anson Huang (1):
      pwm: imx27: Eliminate error message for defer probe

Clément Péron (3):
      pwm: sun4i: Prefer "mod" clock to unnamed
      pwm: sun4i: Always calculate params when applying new parameters
      pwm: sun4i: Move pwm_calculate() out of spin_lock()

Fabrice Gasnier (1):
      pwm: stm32: Remove automatic output enable

Florian Fainelli (1):
      pwm: bcm2835: Allow building for ARCH_BRCMSTB

Gustavo A. R. Silva (1):
      pwm: sun4i: Fix inconsistent IS_ERR and PTR_ERR

Jernej Skrabec (4):
      pwm: sun4i: Add an optional probe for reset line
      pwm: sun4i: Add an optional probe for bus clock
      pwm: sun4i: Add support to output source clock directly
      pwm: sun4i: Add support for H6 PWM

Krzysztof Kozlowski (1):
      pwm: Fix minor Kconfig whitespace issues

Rasmus Villemoes (5):
      pwm: mxs: Implement ->apply()
      pwm: mxs: Remove legacy methods
      pwm: mxs: Add support for inverse polarity
      dt-bindings: pwm: mxs-pwm: Increase #pwm-cells
      pwm: mxs: Avoid a division in mxs_pwm_apply()

Thierry Reding (5):
      pwm: Read initial hardware state at request time
      pwm: cros-ec: Cache duty cycle value
      pwm: imx27: Cache duty cycle register value
      pwm: imx27: Unconditionally write state to hardware
      pwm: sun4i: Initialize variables before use

Uwe Kleine-König (14):
      pwm: atmel: Add a hint where to find hardware documentation
      pwm: atmel: Use a constant for maximum prescale value
      pwm: atmel: Replace loop in prescale calculation by ad-hoc calculation
      pwm: atmel: Document known weaknesses of both hardware and software
      pwm: atmel: Use register accessors for channels
      pwm: atmel: Implement .get_state()
      pwm: rcar: Drop useless call to pwm_get_state()
      pwm: rcar: Document inability to set duty_cycle = 0
      pwm: Implement tracing for .get_state() and .apply_state()
      pwm: omap-dmtimer: Remove PWM chip in .remove before making it unfunctional
      pwm: omap-dmtimer: Simplify error handling
      pwm: omap-dmtimer: put_device() after of_find_device_by_node()
      pwm: omap-dmtimer: Allow compiling with COMPILE_TEST
      pwm: sun4i: Narrow scope of local variable

yu kuai (1):
      pwm: Remove set but not set variable 'pwm'

 Documentation/devicetree/bindings/pwm/mxs-pwm.txt |   4 +-
 drivers/pwm/Kconfig                               |   9 +-
 drivers/pwm/core.c                                |  13 +-
 drivers/pwm/pwm-atmel.c                           |  87 ++++++++--
 drivers/pwm/pwm-cros-ec.c                         |  58 ++++++-
 drivers/pwm/pwm-imx27.c                           | 147 +++++++++-------
 drivers/pwm/pwm-mxs.c                             | 101 ++++++-----
 drivers/pwm/pwm-omap-dmtimer.c                    |  54 ++++--
 drivers/pwm/pwm-pca9685.c                         |   4 -
 drivers/pwm/pwm-rcar.c                            |   5 +-
 drivers/pwm/pwm-stm32.c                           |   4 +-
 drivers/pwm/pwm-sun4i.c                           | 194 ++++++++++++++++++----
 include/trace/events/pwm.h                        |  58 +++++++
 13 files changed, 539 insertions(+), 199 deletions(-)
 create mode 100644 include/trace/events/pwm.h
