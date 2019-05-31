Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:26010 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbfEaJ74 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 31 May 2019 05:59:56 -0400
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 31 May 2019 18:54:57 +0900
Message-Id: <1559296501-30620-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH v3 0/4] pwm: add power management on sysfs and switch to SPDX
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch series is affected from the following email:
https://marc.info/?l=linux-renesas-soc&m=155896668906609&w=2

- The patch 1 adds descriptions into Documentation/pwm.txt.
- The patch 2 is not related to the topic though, switches to
  SPDX identifier of sysfs.c.
- The patch 3 adds suspend/resume support into sysfs.c.
- The patch 4 removes suspend/resume support from pwm-rcar.c.

I'll make for other PWM drivers to remove suspend/resume support
after this patch series is applied.

Changes from v2 [1]:
 - Fix typo in the patch 1.
 - Add comments in the patch 3.
 - Add Reviewed-by Geert-san on the all patches.

Changes from v1 [2]:
 - Save pwm_state of suspend instead of own bool value on the patch 3.
 - Separate functions for suspend and resume on the patch 3.
 - Remove unnecessary condition of child_to_pwm_export() on the patch 3.
 - Add helper functions for suspend/resume into sysfs.c on the patch 3.
 - Add comment about the "roll back" on the patch 3.

[1]
https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=125103

[2]
https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=124235


Yoshihiro Shimoda (4):
  pwm: Add power management descriptions
  pwm: sysfs: Switch to SPDX identifier
  pwm: sysfs: Add suspend/resume support
  pwm: rcar: Remove suspend/resume support

 Documentation/pwm.txt  |   7 +++
 drivers/pwm/pwm-rcar.c |  39 -----------------
 drivers/pwm/sysfs.c    | 113 ++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 110 insertions(+), 49 deletions(-)

-- 
2.7.4
