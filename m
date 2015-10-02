From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH v7 0/5] ARM: berlin: PWM support
Date: Fri,  2 Oct 2015 16:59:45 +0200
Message-ID: <1443797990-10809-1-git-send-email-antoine.tenart@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:57167 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752116AbbJBPAD (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Oct 2015 11:00:03 -0400
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

Changes since v6:
        - Used a prescaler_table again
        - Removed the spinlock
        - Used inline function for read/write
        - Always disable the clock in _remvove()
        - Cosmtic updates
	- Reordered the Documentation patch

Changes since v5:
        - Rebased on top of 4.3-rc1
        - Added a call to clk_disable_unprepare() in case of failure

Changes since v4:
        - Reworked _remove()
        - Reworked _enable()

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
  Documentation: bindings: document the Berlin PWM driver
  pwm: add the Berlin pwm controller driver
  ARM: berlin: add a PWM node on the BG2Q
  ARM: berlin: add a PWM node on the BG2
  ARM: berlin: add a PWM node on the BG2CD

 .../devicetree/bindings/pwm/pwm-berlin.txt         |  17 ++
 arch/arm/boot/dts/berlin2.dtsi                     |   7 +
 arch/arm/boot/dts/berlin2cd.dtsi                   |   7 +
 arch/arm/boot/dts/berlin2q.dtsi                    |   7 +
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-berlin.c                           | 221 +++++++++++++++++++++
 7 files changed, 269 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-berlin.txt
 create mode 100644 drivers/pwm/pwm-berlin.c

-- 
2.6.0
