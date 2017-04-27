From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v2 0/8] r8a7795/6 Salvator-X PWM enablement
Date: Thu, 27 Apr 2017 16:37:35 +0200
Message-ID: <1493303863-23719-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: geert@glider.be, horms@verge.net.au
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Hi!

Here's the revised series enabling PWMs on r8a7795 and r8a7796 Salvator-X
boards.

This revision addresses the issues found by Geert and adds Laurent's
backlight support patch, including a version for r8a7796.

CU
Uli

Changes since v1:
- PWM clock is S0D12, not S3D4
- dts: fix register lengths, add resets
- only enable one set of pins for each PWM
- add backlight support


Laurent Pinchart (1):
  arm64: dts: r8a7795: salvator-x: Add panel backlight support

Ryo Kodama (2):
  clk: renesas: r8a7796: add PWM clock
  arm64: dts: r8a7796-salvator-x: Add PWM device support

Takeshi Kihara (3):
  pinctrl: sh-pfc: r8a7796: Add PWM pins, groups and functions
  arm64: dts: r8a7796: Add PWM device nodes
  arm64: dts: r8a7795-salvator-x: Enable PWM2

Ulrich Hecht (2):
  arm64: dts: r8a7796: salvator-x: Add panel backlight support
  dt-bindings: pwm: Add R-Car M3-W device tree bindings

 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   |   1 +
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  34 +++++
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  35 +++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  70 ++++++++++
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |   1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c               | 153 +++++++++++++++++++++
 6 files changed, 294 insertions(+)

-- 
2.7.4
