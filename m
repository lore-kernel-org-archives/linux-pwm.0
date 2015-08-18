From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH v4 0/5] ARM: berlin: PWM support
Date: Tue, 18 Aug 2015 13:38:03 +0200
Message-ID: <1439897888-10921-1-git-send-email-antoine.tenart@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:33565 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751295AbbHRLiK (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Aug 2015 07:38:10 -0400
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

Changes since v3:
	- Use readl_relaxed
	- Reworked the clk enable / clk disable calls
	- Removed BERLIN_PWM_DISABLE

Changes since v2:
        - Reworked the prescaler/tcnt calculation
        - Added an input clock
        - Updated the documentation
        - Reordered the pwm node
        - Added some definition for BIT()

Changes since v1:
        - Added a sentinel in berlin_pwm_match[]

Antoine Tenart (5):
  pwm: add the Berlin pwm controller driver
  Documentation: bindings: document the Berlin PWM driver
  ARM: berlin: add a PWM node on the BG2Q
  ARM: berlin: add a PWM node on the BG2
  ARM: berlin: add a PWM node on the BG2CD

 .../devicetree/bindings/pwm/pwm-berlin.txt         |  19 ++
 arch/arm/boot/dts/berlin2.dtsi                     |   7 +
 arch/arm/boot/dts/berlin2cd.dtsi                   |   7 +
 arch/arm/boot/dts/berlin2q.dtsi                    |   7 +
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-berlin.c                           | 218 +++++++++++++++++++++
 7 files changed, 268 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-berlin.txt
 create mode 100644 drivers/pwm/pwm-berlin.c

-- 
2.5.0
