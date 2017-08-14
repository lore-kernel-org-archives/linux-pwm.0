From: Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v4 0/8] Support more devices on rockchip rv1108
Date: Mon, 14 Aug 2017 16:31:17 +0800
Message-ID: <1502699477-8063-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.140]:44872 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752166AbdHNIbi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Aug 2017 04:31:38 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: heiko@sntech.de
Cc: devicetree@vger.kernel.org, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, broonie@kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, Andy Yan <andy.yan@rock-chips.com>


This series try to support i2c/spi/pwm/saradc/pmic/watchdog
on rockchip rv1108 soc.

The clk tree, pinctrl, i2c, watchdog and saradc dt-bindings has
been applied. So there are not included in this version.

Changes in v4:
- remove unnecessary property io-channel-ranges of saradc
- order i2c devices by i2c address.

Changes in v3:
- make the compatible string be: "rockchip,rv1108-pwm", "rockchip,rk3288-pwm"
  for rv1108

Changes in v2:
- add compatible string "rockchip,rv1108-pwm"
- add compatible string "rockchip,rv1108-saradc"

Andy Yan (8):
  spi: rockchip: add compatible string for rv1108 spi
  ARM: dts: rockchip: add spi dt node for rv1108
  dt-bindings: pwm: add description for rv1108 pwm
  ARM: dts: rockchip: add pwm dt node for rv1108
  ARM: dts: rockchip: add saradc support for rv1108
  ARM: dts: rockchip: add pwm backlight for rv1108 evb
  ARM: dts: rockchip: add pmic rk805 dt node for rv1108 evb
  ARM: dts: rockchip: add accelerometer bma250e dt node for rv1108 evb

 .../devicetree/bindings/pwm/pwm-rockchip.txt       |   3 +-
 .../devicetree/bindings/spi/spi-rockchip.txt       |   1 +
 arch/arm/boot/dts/rv1108-evb.dts                   | 158 +++++++++++++++++++
 arch/arm/boot/dts/rv1108.dtsi                      | 167 +++++++++++++++++++++
 drivers/spi/spi-rockchip.c                         |   1 +
 5 files changed, 329 insertions(+), 1 deletion(-)

-- 
2.7.4
