From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: [PATCH v2 0/4] gpio: mvebu: Add PWM fan support
Date: Sat, 18 Mar 2017 16:43:00 +0100
Message-ID: <20170318154305.28348-1-ralph.sennhauser@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Imre Kaloz <kaloz@openwrt.org>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi everyone

This patch series was originally submitted by Andrew Lunn but got stalled.
I picked up the series and addressed what was discussed for the earlier
submission with some helpful input from Andrew. Hopefully this time support
for the PWM fan as found on Linksys WRT1900AC (Mamba) will make it in.

Implementing as an MFD was discarded due to backward compatibility. The
original discussion can be read at [1].

This series depends on two cleanup series. The first [2] ("gpio: mvebu:
preparatory cleanup for pwm-fan support") got applied but has yet to appear
in linux-next. The second one [3] ("gpio: mvebu: use BIT macro instead of
bit shifting") is still pending review.

[1] https://patchwork.ozlabs.org/patch/427287/
[2] https://lkml.org/lkml/2017/3/16/62
[3] https://lkml.org/lkml/2017/3/17/493

---

Changes v1 -> v2:
  Patch 1/4 gpio: mvebu: Add limited PWM support:
    * use BIT macro (suggested by Linus Walleij)
    * move id from struct mvebu_pwm to struct mvebu_gpio_chip, implement
      blink select as if else and comment on the chip id for code clarity
      (to accommodate Linus Walleijs request for a code clarification /
      comment. If you can word it better I'm all ears.)
    * Move function comment mvebu_pwm_probe into the function itself.

---

Pending:
  * Needs ACK from Thierry Reding to be merged via linux-gpio tree by Linus
    Walleij.

---

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
 drivers/gpio/gpio-mvebu.c                          | 291 +++++++++++++++++++--
 9 files changed, 342 insertions(+), 30 deletions(-)

-- 
2.10.2
