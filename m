From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v7 00/13] Convert period and duty cycle to u64
Date: Mon,  9 Mar 2020 12:35:03 -0700
Message-ID: <cover.1583782035.git.gurus@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Guru Das Srinagesh <gurus@codeaurora.org>
List-Id: linux-pwm@vger.kernel.org

Changes from v6:
  - Split out the driver changes out into separate patches, one patch per file
    for ease of reviewing.

Changes from v5:
  - Dropped the conversion of struct pwm_capture to u64 for reasons mentioned
    in https://www.spinics.net/lists/linux-pwm/msg11541.html

Changes from v4:
  - Split the patch into two: one for changes to the drivers, and the actual
    switch to u64 for ease of reverting should the need arise.
  - Re-examined the patch and made the following corrections:
      * intel_panel.c:
	DIV64_U64_ROUND_UP -> DIV_ROUND_UP_ULL (as only the numerator would be
	64-bit in this case).
      * pwm-sti.c:
	do_div -> div_u64 (do_div is optimized only for x86 architectures, and
	div_u64's comment block suggests to use this as much as possible).

Changes from v3:
  - Rebased to current tip of for-next.

Changes from v2:
  - Fixed %u -> %llu in a dev_dbg in pwm-stm32-lp.c, thanks to kbuild test robot
  - Added a couple of fixes to pwm-imx-tpm.c and pwm-sifive.c

Changes from v1:
  - Fixed compilation errors seen when compiling for different archs.

Reworked the change pushed upstream earlier [1] so as to not add an extension
to an obsolete API. With this change, pwm_ops->apply() can be used to set
pwm_state parameters as usual.

[1] https://lore.kernel.org/lkml/20190916140048.GB7488@ulmo/

Guru Das Srinagesh (13):
  clk: pwm: Use 64-bit division macros for period and duty cycle
  drm/i915: Use 64-bit division macros for period and duty cycle
  hwmon: pwm-fan: Use 64-bit division macros for period and duty cycle
  ir-rx51: Use 64-bit division macros for period and duty cycle
  pwm: clps711x: Use 64-bit division macros for period and duty cycle
  pwm: pwm-imx-tpm: Use 64-bit division macros for period and duty cycle
  pwm: imx27: Use 64-bit division macros for period and duty cycle
  pwm: sifive: Use 64-bit division macros for period and duty cycle
  pwm: sti: Use 64-bit division macros for period and duty cycle
  pwm: stm32-lp: Use %llu format specifier for period
  pwm: sun4i: Use 64-bit division macros for period and duty cycle
  backlight: pwm_bl: Use 64-bit division macros for period and duty
    cycle
  pwm: core: Convert period and duty cycle to u64

 drivers/clk/clk-pwm.c                      |  2 +-
 drivers/gpu/drm/i915/display/intel_panel.c |  2 +-
 drivers/hwmon/pwm-fan.c                    |  2 +-
 drivers/media/rc/ir-rx51.c                 |  3 ++-
 drivers/pwm/core.c                         |  4 ++--
 drivers/pwm/pwm-clps711x.c                 |  2 +-
 drivers/pwm/pwm-imx-tpm.c                  |  2 +-
 drivers/pwm/pwm-imx27.c                    |  5 ++---
 drivers/pwm/pwm-sifive.c                   |  2 +-
 drivers/pwm/pwm-sti.c                      |  5 +++--
 drivers/pwm/pwm-stm32-lp.c                 |  2 +-
 drivers/pwm/pwm-sun4i.c                    |  2 +-
 drivers/pwm/sysfs.c                        |  8 ++++----
 drivers/video/backlight/pwm_bl.c           |  3 ++-
 include/linux/pwm.h                        | 12 ++++++------
 15 files changed, 29 insertions(+), 27 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
