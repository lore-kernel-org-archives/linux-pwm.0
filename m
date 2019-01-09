Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:55996 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729844AbfAIIWA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Jan 2019 03:22:00 -0500
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed,  9 Jan 2019 17:19:04 +0900
Message-Id: <1547021948-7664-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH v3 0/4] pwm: rcar: Add support "atomic" API and improve calculation
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch series adds support for PWM "atomic" API and improve
the clock calculation.

Changes from v2 [1]:
 - Add Acked-by of Uwe in patch [234]/4.
 - Modify a condition to support normal polarity only.
 - Fix possible to output wrong a duty cycle when disabling in patch 1/4.
 - Fix overflow value on 32-bit arch in patch 4/4.

Changes from v1 [2]:
 - Remove workaround code of output pseudo low level for now because it is
   rejected on the ML.
 - Add a condition for polarity because the HW doesn't support polarity change
   in patch 1/4.
 - Improve the clock calculation in patch 4/4.

[1]
https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=63219

Remarks:
On the email thread of patch 2/4, we discuss about suspend/resume
handling and I suposed to improve it. However, I need more time
how to improve it. So, for now, I don't improve it on this patch series.

[2]
https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=53193


Yoshihiro Shimoda (4):
  pwm: rcar: Add support "atomic" API
  pwm: rcar: Use "atomic" API on rcar_pwm_resume()
  pwm: rcar: remove legacy APIs
  pwm: rcar: improve calculation of divider

 drivers/pwm/pwm-rcar.c | 99 ++++++++++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 51 deletions(-)

-- 
1.9.1
