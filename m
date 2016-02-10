From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/3] STMPE PWM driver
Date: Wed, 10 Feb 2016 09:54:25 +0100
Message-ID: <1455094468-25521-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33128 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbcBJIyi (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Feb 2016 03:54:38 -0500
Received: by mail-lf0-f49.google.com with SMTP id m1so7451103lfg.0
        for <linux-pwm@vger.kernel.org>; Wed, 10 Feb 2016 00:54:37 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>

This adds a driver for the STMPE 24xx PWMs and shows how to add it
to the device tree.

If the patches are all right and get ACK from the right maintainers,
I'd like patch 1 and 2 to be merged to the PWM tree while I will take
patch 3 to ARM SoC, it is merely an illustration here.

Linus Walleij (3):
  pwm: add DT bindings for the STMPE PWM
  pwm: add a driver for the STMPE PWM
  ARM: nomadik: add STMPE PWM to the NHK15 device tree

 .../devicetree/bindings/pwm/st,stmpe-pwm.txt       |  18 ++
 arch/arm/boot/dts/ste-nomadik-nhk15.dts            |  24 ++
 drivers/mfd/stmpe.c                                |  37 +++
 drivers/pwm/Kconfig                                |   7 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-stmpe.c                            | 297 +++++++++++++++++++++
 6 files changed, 384 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt
 create mode 100644 drivers/pwm/pwm-stmpe.c

-- 
2.4.3
