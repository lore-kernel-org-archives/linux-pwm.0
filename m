From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: [PATCH 0/4] gpio: mvebu: Add PWM fan support
Date: Thu, 16 Mar 2017 07:42:14 +0100
Message-ID: <20170316064218.9169-1-ralph.sennhauser@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Imre Kaloz <kaloz@openwrt.org>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi everyone

this patch series was originally submitted by Andrew Lunn but got stalled.
I picked up the series and addressed what was disscussed for the earlier
submission with some helpful input from Andrew. Hopefully this time support
for the PWM fan as found on Linksys WRT1900AC (Mamba) will make it in.

Implementing as an MFD was discarded due to backward compatibility. The
original discussion can be read at [1].

Checkpatch complained quite a bit so this series depends on a cleanup
series that got split out so those who should review this one don't have to
wade trough an additional 6 patches ("gpio: mvebu: prepatatory cleanup for
pwm-fan support").

[1] https://patchwork.ozlabs.org/patch/427287/


Andrew Lunn (4):
  gpio: mvebu: Add limited PWM support
  mvebu: xp: Add pwm properties to .dtsi files
  ARM: mvebu: Enable SENSORS_PWM_FAN in defconfig
  mvebu: wrt1900ac: Use pwm-fan rather than gpio-fan

 .../devicetree/bindings/gpio/gpio-mvebu.txt        |  31 +++
 MAINTAINERS                                        |   2 +
 arch/arm/boot/dts/armada-370.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |   8 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  10 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   8 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  10 +-
 arch/arm/configs/mvebu_v7_defconfig                |   2 +
 drivers/gpio/gpio-mvebu.c                          | 274 ++++++++++++++++++++-
 9 files changed, 330 insertions(+), 25 deletions(-)

-- 
2.10.2
