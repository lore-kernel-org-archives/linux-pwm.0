From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH 0/5] ARM: berlin: PWM support
Date: Sat, 25 Jul 2015 23:39:33 +0200
Message-ID: <1437860378-9556-1-git-send-email-antoine.tenart@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:53432 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754872AbbGYVjl (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 25 Jul 2015 17:39:41 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, thierry.reding@gmail.com
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi all,

This series adds a driver for the Marvell Berlin PWM controller, which
has 4 channels.

This has been tested on a BG2Q DMP.

Thanks,

Antoine

Antoine Tenart (5):
  pwm: add the Berlin pwm controller driver
  Documentation: bindings: document the Berlin PWM driver
  ARM: berlin: add a PWM node on the BG2Q
  ARM: berlin: add a PWM node on the BG2
  ARM: berlin: add a PWM node on the BG2CD

 .../devicetree/bindings/pwm/pwm-berlin.txt         |  15 ++
 arch/arm/boot/dts/berlin2.dtsi                     |   6 +
 arch/arm/boot/dts/berlin2cd.dtsi                   |   6 +
 arch/arm/boot/dts/berlin2q.dtsi                    |   6 +
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-berlin.c                           | 206 +++++++++++++++++++++
 7 files changed, 249 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-berlin.txt
 create mode 100644 drivers/pwm/pwm-berlin.c

-- 
2.4.6
