Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:25351 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725865AbfE2Hwy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 May 2019 03:52:54 -0400
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 29 May 2019 16:47:58 +0900
Message-Id: <1559116082-9851-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH 0/4] pwm: add power management on sysfs and switch to SPDX
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch series is affected from the following email:
https://marc.info/?l=linux-renesas-soc&m=155896668906609&w=2

- The patch 1 adds descriptions into Documentation/pwm.txt.
- The patch 2 is not related to the topic though, switches to
  SPDX identifier of sysfs.c.
- The patch 3 adds suspend/resume support into sysfs.c.
- The patch 4 removes suspend/resume support from pwm-rcar.c.

This is the first trial so that I didn't make patches for other
PWM drivers to remove suspend/resume support.

Yoshihiro Shimoda (4):
  pwm: Add power management descriptions
  pwm: sysfs: Switch to SPDX identifier
  pwm: sysfs: Add suspend/resume support
  pwm: rcar: Remove suspend/resume support

 Documentation/pwm.txt  |  7 +++++
 drivers/pwm/pwm-rcar.c | 39 --------------------------
 drivers/pwm/sysfs.c    | 75 +++++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 72 insertions(+), 49 deletions(-)

-- 
2.7.4
