From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 0/2] pwm: Miscellaneous fixes for 64-bit support
Date: Mon, 15 Jun 2020 16:16:04 +0200
Message-ID: <20200615141606.2814208-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgFOOQN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 Jun 2020 10:16:13 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Guru Das Srinagesh <gurus@codeaurora.org>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

this contains a couple of fixes for issues that I ran into after
applying Guru's series to convert PWM period and duty-cycle to 64-bit.

Bartlomiej, can you provide an Acked-by on the first patch so that I can
take it through the PWM tree along with the rest of Guru's series?

Thanks,
Thierry

Thierry Reding (2):
  video: ssd1307fb: Print PWM period using 64-bit format specifier
  pwm: iqs620a: Use 64-bit division

 drivers/pwm/pwm-iqs620a.c       | 7 ++++---
 drivers/video/fbdev/ssd1307fb.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.24.1
