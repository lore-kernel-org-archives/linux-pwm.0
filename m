Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:41637 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727030AbfAHDbG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Jan 2019 22:31:06 -0500
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue,  8 Jan 2019 12:28:10 +0900
Message-Id: <1546918094-13960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH v2 0/4] pwm: rcar: Add support "atomic" API and improve calculation
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch series adds support for PWM "atomic" API and improve
the clock calculation.

Changes from v1 [1]:
 - Remove workaround code of output pseudo low level for now because it is
   rejected on the ML.
 - Add a condition for polarity because the HW doesn't support polarity change
   in patch 1/4.
 - Improve the clock calculation in patch 4/4.

[1]
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
