From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v4.7-rc1
Date: Wed, 25 May 2016 17:34:15 +0200
Message-ID: <20160525153415.32722-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35725 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbcEYPeV (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 25 May 2016 11:34:21 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc=
69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pw=
m.git tags/pwm/for-4.7-rc1

for you to fetch changes up to 18c588786c08458f5d965d8735ab48f9e51e0b4b=
:

  Merge branch 'for-4.7/pwm-atomic' into for-next (2016-05-17 14:57:58 =
+0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.7-rc1

This set of changes introduces an atomic API to the PWM subsystem. This
is influenced by the DRM atomic API that was introduced a while back,
though it is obviously a lot simpler. The fundamental idea remains the
same, though: drivers provide a single callback to implement the atomic
configuration of a PWM channel.

As a side-effect the PWM subsystem gains the ability for initial state
retrieval, so that the logical state mirrors that of the hardware. Many
use-cases don't care about this, but for others it is essential.

These new features require changes in all users, which these patches
take care of. The core is transitioned to use the atomic callback if
available and provides a fallback mechanism for other drivers.

Changes to transition users and drivers to the atomic API are postponed
to v4.8.

----------------------------------------------------------------
Boris BREZILLON (4):
      pwm: rcar: Make use of pwm_is_enabled()
      backlight: pwm_bl: Remove useless call to pwm_set_period()
      backlight: lm3630a_bl: Stop messing with the pwm->period field
      pwm: Get rid of pwm->lock

Boris Brezillon (25):
      pwm: Introduce the pwm_args concept
      regulator: pwm: Use pwm_get_args() where appropriate
      pwm: Fix pwm_apply_args() call sites
      pwm: Use pwm_get/set_xxx() helpers where appropriate
      clk: pwm: Use pwm_get_args() where appropriate
      hwmon: pwm-fan: Use pwm_get_args() where appropriate
      input: misc: max77693: Use pwm_get_args() where appropriate
      leds: pwm: Use pwm_get_args() where appropriate
      regulator: pwm: Use pwm_get_args() where appropriate
      fbdev: ssd1307fb: Use pwm_get_args() where appropriate
      backlight: pwm_bl: Use pwm_get_args() where appropriate
      backlight: lp8788: Explicitly apply PWM config extracted from pwm=
_args
      backlight: lp855x: Explicitly apply PWM config extracted from pwm=
_args
      backlight: lm3630a: explicitly apply PWM config extracted from pw=
m_args
      input: misc: max8997: Explicitly apply PWM config extracted from =
pwm_args
      input: misc: pwm-beeper: Explicitly apply PWM config extracted fr=
om pwm_args
      drm: i915: Explicitly apply PWM config extracted from pwm_args
      ARM: Explicitly apply PWM config extracted from pwm_args
      pwm: Keep PWM state in sync with hardware state
      pwm: Introduce the pwm_state concept
      pwm: Move the enabled/disabled info into pwm_state
      pwm: Add hardware readout infrastructure
      pwm: Add core infrastructure to allow atomic updates
      pwm: Update documentation
      pwm: Switch to the atomic API

Heiko St=C3=BCbner (1):
      pwm: Add information about polarity, duty cycle and period to deb=
ugfs

Thierry Reding (8):
      Merge branch 'for-4.7/pwm-args' into for-4.7/pwm-regulator
      pwm: Add missing newline
      pwm: Use kcalloc() instead of kzalloc()
      Merge branch 'for-4.7/pwm-args' into for-4.7/pwm-atomic
      Merge branch 'for-4.7/pwm-cleanup' into for-next
      Merge branch 'for-4.7/pwm-args' into for-next
      Merge branch 'for-4.7/pwm-regulator' into for-next
      Merge branch 'for-4.7/pwm-atomic' into for-next

 Documentation/pwm.txt                |  30 +++-
 arch/arm/mach-s3c24xx/mach-rx1950.c  |   6 +
 drivers/clk/clk-pwm.c                |  17 +-
 drivers/gpu/drm/i915/intel_panel.c   |   6 +
 drivers/hwmon/pwm-fan.c              |  26 ++-
 drivers/input/misc/max77693-haptic.c |  17 +-
 drivers/input/misc/max8997_haptic.c  |   6 +
 drivers/input/misc/pwm-beeper.c      |   6 +
 drivers/leds/leds-pwm.c              |  11 +-
 drivers/pwm/core.c                   | 223 ++++++++++++++---------
 drivers/pwm/pwm-clps711x.c           |   2 +-
 drivers/pwm/pwm-crc.c                |   2 +-
 drivers/pwm/pwm-lpc18xx-sct.c        |   2 +-
 drivers/pwm/pwm-omap-dmtimer.c       |   2 +-
 drivers/pwm/pwm-pxa.c                |   2 +-
 drivers/pwm/pwm-rcar.c               |   2 +-
 drivers/pwm/pwm-sun4i.c              |   3 +-
 drivers/pwm/sysfs.c                  |  70 ++++++--
 drivers/regulator/pwm-regulator.c    |  20 ++-
 drivers/video/backlight/lm3630a_bl.c |   9 +-
 drivers/video/backlight/lp855x_bl.c  |   6 +
 drivers/video/backlight/lp8788_bl.c  |   6 +
 drivers/video/backlight/pwm_bl.c     |  14 +-
 drivers/video/fbdev/ssd1307fb.c      |  11 +-
 include/linux/pwm.h                  | 338 +++++++++++++++++++++++++++=
--------
 25 files changed, 630 insertions(+), 207 deletions(-)
