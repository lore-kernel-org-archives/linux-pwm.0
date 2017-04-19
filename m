From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 0/5] r8a7795/6 Salvator-X PWM enablement
Date: Wed, 19 Apr 2017 15:24:48 +0200
Message-ID: <1492608293-12435-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: geert@glider.be, horms@verge.net.au
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Hi!

This is a straight port from the BSP, enabling PWM1 and PWM2 on the
Salvator-X boards. For r8a7796 it also adds the required infrastructure
(clock and pins).

Not fully tested because I cannot find my breakout adapter. Looks OK from
the software side, though.

CU
Uli


Ryo Kodama (2):
  clk: renesas: r8a7796: add PWM clock
  arm64: dts: r8a7796-salvator-x: Add PWM device support

Takeshi Kihara (3):
  pinctrl: sh-pfc: r8a7796: Add PWM pins, groups and functions
  arm64: dts: r8a7796: Add PWM device nodes
  arm64: dts: r8a7795-salvator-x: Enable PWM

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  22 +++
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  21 +++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  63 +++++++++
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |   1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c               | 153 +++++++++++++++++++++
 5 files changed, 260 insertions(+)

-- 
2.7.4
