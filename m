From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 0/3] pwm: sun4i: switch to atomic PWM
Date: Tue, 30 May 2017 21:32:06 +0200
Message-ID: <20170530193209.19247-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:58878 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbdE3TcX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 May 2017 15:32:23 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jonathan Liu <net147@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

Switch to atomic PWM. The main goal is to properly wait for a period before
disabling a channel to ensure the correct level is set on the output.

Changes in v2:
 - fixed remaining checkpatch warnings
 - split the series to ease reviews
 - changed the delay handling to ensure the proper amount of time has elapsed
   before disabling a channel
 - dropped RDY bit handling as it doesn't have any real effect.

Alexandre Belloni (3):
  pwm: sun4i: improve hardware read out
  pwm: sun4i: switch to atomic PWM
  pwm: sun4i: drop legacy callbacks

 drivers/pwm/pwm-sun4i.c | 263 +++++++++++++++++++++++++++---------------------
 1 file changed, 148 insertions(+), 115 deletions(-)

-- 
2.11.0
