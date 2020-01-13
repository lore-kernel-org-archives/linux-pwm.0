From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v4 0/1] Convert period and duty cycle to u64
Date: Mon, 13 Jan 2020 15:53:30 -0800
Message-ID: <cover.1578959442.git.gurus@codeaurora.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:13327 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728802AbgAMXxg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Jan 2020 18:53:36 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Guru Das Srinagesh <gurus@codeaurora.org>

Reworked the change pushed upstream earlier [1] so as to not add an extension
to an obsolete API. With this change, pwm_ops->apply() can be used to set
pwm_state parameters as usual.

[1] https://lore.kernel.org/lkml/20190916140048.GB7488@ulmo/

Changes from v1:
  - Fixed compilation errors seen when compiling for different archs.

Changes from v2:
  - Fixed %u -> %llu in a dev_dbg in pwm-stm32-lp.c, thanks to kbuild test robot
  - Added a couple of fixes to pwm-imx-tpm.c and pwm-sifive.c

Changes from v3:
  - Rebased to current tip of for-next.

Guru Das Srinagesh (1):
  pwm: Convert period and duty cycle to u64

 drivers/clk/clk-pwm.c                      |  2 +-
 drivers/gpu/drm/i915/display/intel_panel.c |  2 +-
 drivers/hwmon/pwm-fan.c                    |  2 +-
 drivers/media/rc/ir-rx51.c                 |  3 ++-
 drivers/pwm/core.c                         |  4 ++--
 drivers/pwm/pwm-clps711x.c                 |  2 +-
 drivers/pwm/pwm-imx-tpm.c                  |  2 +-
 drivers/pwm/pwm-imx27.c                    |  5 ++---
 drivers/pwm/pwm-sifive.c                   |  2 +-
 drivers/pwm/pwm-sti.c                      |  4 ++--
 drivers/pwm/pwm-stm32-lp.c                 |  2 +-
 drivers/pwm/pwm-sun4i.c                    |  2 +-
 drivers/pwm/sysfs.c                        | 10 +++++-----
 drivers/video/backlight/pwm_bl.c           |  3 ++-
 include/linux/pwm.h                        | 16 ++++++++--------
 15 files changed, 31 insertions(+), 30 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
