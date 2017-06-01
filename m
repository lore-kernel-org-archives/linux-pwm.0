From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCHv2 0/2] gpio: mvebu: fixes for PWM/blink
Date: Thu,  1 Jun 2017 14:18:24 +0200
Message-ID: <20170601121826.14685-1-richard.genoud@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35251 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdFAMSs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Jun 2017 08:18:48 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Richard Genoud <richard.genoud@gmail.com>

These are 2 fixes for gpio-mvebu, related to the PWM support introduced
by commit 757642f9a584 ("gpio: mvebu: Add limited PWM support")
As that commit was merged in 4.12-rc1, I guess these commits are 4.12
material.

Changes from v1:
 - Add tags Fixes: and Reviewed-by:
 - Add some comments to motivate the mvpwm->chip->base = -1 choice
instead of mvpwm->chip->base = mvchip->chip.base

Richard Genoud (2):
  gpio: mvebu: fix blink counter register selection
  gpio: mvebu: fix gpio bank registration when pwm is used

 drivers/gpio/gpio-mvebu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)
