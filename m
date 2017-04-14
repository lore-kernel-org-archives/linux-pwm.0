From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: [PATCH v5 0/4] gpio: mvebu: Add PWM fan support
Date: Fri, 14 Apr 2017 17:40:51 +0200
Message-ID: <20170414154056.32055-1-ralph.sennhauser@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: Ralph Sennhauser <ralph.sennhauser@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi everyone,

With the bike shedding fixes as Thierry called them out of the way and
the ACK by Rob for the bindings this version could be merged.

The only thing still sort of open is whether to use npwm=1 and giving up
the sysfs use case. Though an ACK was given for this implementation
already I think we should give Thierry a chance to speak up once more if
he so wishes.

Thanks
Ralph

---

Notes:

  About npwm = 1:
    The only way I can think of to achieve that requires reading the
    GPIO line from the device tree. This would prevent a user to
    dynamically choose a line. Which is fine for the fan found on Mamba
    but let's take some development board with freely accessible GPIOs
    and suddenly we limit the use of this driver (sysfs). Given the
    above, npwm = ngpio with only one usable at a time is a closer /
    more appropriate description of the situation. The downside is
    some "wasted" space and not meeting the expectation that all PWMs
    are usable concurrently, only one per chip at any given time.

  About the new compatible string:
    Orion was chosen for the SoC variant for the same reason as in
    commit 5f79c651e81e ("arm: mvebu: use global interrupts for GPIOs on
    Armada XP").
    The "pwm" property remains optional for the new compatible string so
    the compatiple string "marvell,armada-370-xp-gpio" can be used by
    all and not just the first two GPIO chips.

  About extending the driver for use with a third GPIO chip:
    It's possible to add an extra node "mvebugpiopwmctrl" to configure a
    different assignment without requiring changes to the current
    bindings. The current implementation doesn't prevent a fan to be
    used as gpio-fan connect to the 3rd chip.

---

Changes v5->v6:
  Patch 1/4 gpio: mvebu: Add limited PWM support:
    * more uppercase for GPIO / PWM in prose  (suggested by Thierry
      Reding)
    * use a variable for register set A/B selection value (suggested by
      Thierry Reding)
    * Don't set pwm_chip base to gpio_chip base, use hwpwm instead.
      (suggested by Thierry Reding)
    * use pointer to gpio_desc instead of boolen used (suggested by
      Thierry Reding)
    * check a bit earlier for working clock (suggested by Thierry
      Reding)
    * Add Acked-by: Thierry Reding <thierry.reding@gmail.com>
    * Acked-by: Rob Herring <robh@kernel.org>

Changes v4->v5:
  All
    * add Tested-by: Andrew Lunn <andrew@lunn.ch>, thanks
  Patch 2/4 mvebu: xp: Add PWM properties to .dtsi files
    * keep the old compatible stings, we don't have to drop them (suggested by Gregory CLEMENT)
    * subject starts with ARM: dts: mvebu: (suggested by Gregory CLEMENT)
  Patch 4/4 mvebu: wrt1900ac: Use pwm-fan rather than gpio-fan
    * subject starts with ARM: dts: armada-xp: (suggested by Gregory CLEMENT)

Changes v3->v4:
  Patch 1/4 gpio: mvebu: Add limited PWM support:
    * braces for both branches in if statement if one needs it. (suggested
      by Andrew Lunn)
    * introduce compatible string marvell,armada-370-xp-gpio (suggest by
      Rob Herring)
    * fix mvebu_pwmreg_blink_on_duration -> mvebu_pwmreg_blink_off_duration
      for period callculation in mvebu_pwm_get_state()
  Patch 4/4 mvebu: wrt1900ac: Use pwm-fan rather than gpio-fan
    * Drop flags from pwms for Mamba, as no longer used (suggested by
      Andrew Lunn)
    * Use again #pwm-cell = 2, the second cell is actually the period.

Changes v2->v3:
  Patch 1/4 gpio: mvebu: Add limited PWM support:
    * drop pin from mvebu_pwn, can be infered (suggested by Thierry Reding)
    * rename pwm to mvpwm so pwm can be used for pwm_device as in the API,
      avoids some mental gymnastic.
    * drop id from struct mvebu_gpio_chip, select blink counter in
      mvebu_pwm_probe for all lines instead. We do not care about the
      unused ones. I think a clear improvement in readability.
      Makes coming up with a good comment simple as well.
    * Switch to new atomic PWM API (suggested by Thierry Reding)
    * rename use mvebu_gpioreg_blink_select to
      mvebu_gpioreg_blink_counter_select.
    * mark *_suspend() / *_resume() as __maybe_unused (suggested by Linus
      Walleij)
    * document #pwm-cells = 1 (suggested by Thierry Reding)
  Patch 2/4 mvebu: xp: Add PWM properties to .dtsi files
    * add missing reg-names / #pwm-cell properties to
      armada-xp-mv78260.dtsi gpio1 node
    * set pwm-cells = 1 (suggested by Thierry Reding)
  All:
    * always uppercase GPIO/PWM in prose (suggested by Thierry Reding)

Changes v1 -> v2:
  Patch 1/4 gpio: mvebu: Add limited PWM support:
    * use BIT macro (suggested by Linus Walleij)
    * move id from struct mvebu_pwm to struct mvebu_gpio_chip, implement
      blink select as if else and comment on the chip id for code clarity
      (to accommodate Linus Walleijs request for a code clarification /
      comment. If you can word it better I'm all ears.)
    * Move function comment mvebu_pwm_probe into the function itself.

---

Andrew Lunn (4):
  gpio: mvebu: Add limited PWM support
  ARM: dts: mvebu: Add PWM properties to .dtsi files
  ARM: mvebu: Enable SENSORS_PWM_FAN in defconfig
  ARM: dts: armada-xp: Use pwm-fan rather than gpio-fan

 .../devicetree/bindings/gpio/gpio-mvebu.txt        |  32 ++
 MAINTAINERS                                        |   2 +
 arch/arm/boot/dts/armada-370.dtsi                  |  19 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |   8 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  16 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |  19 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  19 +-
 arch/arm/configs/mvebu_v7_defconfig                |   2 +
 drivers/gpio/gpio-mvebu.c                          | 327 ++++++++++++++++++++-
 9 files changed, 408 insertions(+), 36 deletions(-)

-- 
2.10.2

