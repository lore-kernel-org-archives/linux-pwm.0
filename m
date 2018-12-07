Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:22042 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725967AbeLGIcC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Dec 2018 03:32:02 -0500
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri,  7 Dec 2018 17:29:28 +0900
Message-Id: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH 0/5] pwm: rcar: Add support "atomic" API and workaround
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds support for PWM "atomic" API.

This patch also adds a workaround to output "pseudo" low level.
Otherwise, the PWM backlight driver doesn't work correctly, especially
it cannot output maximum brightness actually.

Yoshihiro Shimoda (5):
  pwm: rcar: add rcar_pwm_calc_counter() to calculate PWMCNT value only
  pwm: rcar: Add support "atomic" API
  pwm: rcar: Use "atomic" API on rcar_pwm_resume()
  pwm: rcar: remove legacy APIs
  pwm: rcar: add workaround to output "pseudo" low level

 drivers/pwm/pwm-rcar.c | 108 ++++++++++++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 46 deletions(-)

-- 
1.9.1
