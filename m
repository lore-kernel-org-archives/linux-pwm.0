From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH 0/3] leds: pwm: some cleanups
Date: Fri, 24 Jan 2020 17:54:06 +0100
Message-ID: <20200124165409.12422-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:38328 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387670AbgAXQyP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jan 2020 11:54:15 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: Jeff LaBundy <jeff@labundy.com>, Dan Murphy <dmurphy@ti.com>, Thierry Reding <thierry.reding@gmail.com>, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org

Hello,

note that this series is only compile tested, as I don't have a hardware
that uses this driver.

Best regards
Uwe

Uwe Kleine-König (3):
  leds: pwm: simplify if condition
  leds: pwm: convert to atomic PWM API
  leds: pwm: don't set the brightness during .probe

 drivers/leds/leds-pwm.c | 47 ++++++++++-------------------------------
 1 file changed, 11 insertions(+), 36 deletions(-)

-- 
2.24.0
