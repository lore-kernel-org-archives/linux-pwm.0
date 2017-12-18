From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH v2 0/6] Add PWM and TPU support to r8a7743
Date: Mon, 18 Dec 2017 17:52:02 +0000
Message-ID: <1513619528-12060-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>
List-Id: linux-pwm@vger.kernel.org

Dear All,

this series includes all that is required to add PWM and TPU SoC specific
support for the r8a7743.

Thanks,

Fabrizio Castro (6):
  ARM: shmobile: defconfig: Enable PWM
  dt-bindings: pwm: rcar: Document r8a774[35] PWM bindings
  ARM: dts: r8a7743: Add PWM SoC support
  dt-bindings: pwm: renesas-tpu: Document r8a774[35] support
  pinctrl: sh-pfc: r8a7791: Add tpu groups and function
  ARM: dts: r8a7743: Add TPU support

 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   | 10 ++-
 .../devicetree/bindings/pwm/renesas,tpu-pwm.txt    |  4 +-
 arch/arm/boot/dts/r8a7743.dtsi                     | 87 ++++++++++++++++++++++
 arch/arm/configs/shmobile_defconfig                |  1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c               | 42 ++++++++++-
 5 files changed, 138 insertions(+), 6 deletions(-)

-- 
2.7.4

