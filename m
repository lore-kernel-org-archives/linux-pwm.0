From: YH Huang <yh.huang@mediatek.com>
Subject: [PATCH v5 0/3] Add MediaTek display PWM driver
Date: Mon, 13 Jul 2015 17:04:51 +0800
Message-ID: <1436778294-47635-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com
List-Id: linux-pwm@vger.kernel.org

This patch series add the use of display PWM driver, documentation 
and device tree for Mediatek SoCs. The driver is used to support 
the backlight of the panel. This is based on v4.2-rc1.

The clock definitions (CLK_MM_DISP_PWM*) are added by James Liao's patch: 
clk: mediatek: Add subsystem clocks of MT8173

Change in v5:
1. Configure PWM output via pinctrl
2. Fix the parameter name in dtsi

YH Huang (3):
  dt-bindings: pwm: add MediaTek display PWM bindings
  pwm: add MediaTek display PWM driver support
  arm64: dts: mt8173: add MT8173 display PWM driver support node

 .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |  29 +++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |  15 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  22 ++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-mtk-disp.c                         | 256 +++++++++++++++++++++
 6 files changed, 333 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
 create mode 100644 drivers/pwm/pwm-mtk-disp.c

--
1.8.1.1.dirty
