From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] pwm: Renesas R-Car and TPU fixes
Date: Mon, 16 Mar 2020 11:32:13 +0100
Message-ID: <20200316103216.29383-1-geert+renesas@glider.be>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:54982 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbgCPKcT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 06:32:19 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi all,

This patch series contains two Runtime PM-related fixes for the Renesas
R-Car and Timer Pulse Unit PWM drivers, and a small fix for the TPU
driver.

This has been tested on r8a7791/koelsch.

Thanks for your comments!

Geert Uytterhoeven (3):
  pwm: rcar: Fix late Runtime PM enablement
  pwm: renesas-tpu: Fix late Runtime PM enablement
  pwm: renesas-tpu: Drop confusing registered message

 drivers/pwm/pwm-rcar.c        | 10 +++++++---
 drivers/pwm/pwm-renesas-tpu.c | 11 ++++-------
 2 files changed, 11 insertions(+), 10 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert
