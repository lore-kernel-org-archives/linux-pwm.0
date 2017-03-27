From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: [PATCH v4 0/4] gpio: mvebu: Add PWM fan support
Date: Mon, 27 Mar 2017 21:42:56 +0200
Message-ID: <20170327194301.1104-1-ralph.sennhauser@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36138 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbdC0TnM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Mar 2017 15:43:12 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Imre Kaloz <kaloz@openwrt.org>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi everyone

This patch series was originally submitted by Andrew Lunn but got
stalled.  I picked up the series and addressed what was discussed for
the earlier submission with some helpful input from Andrew. Hopefully
this time support for the PWM fan as found on Linksys WRT1900AC (Mamba)
will make it in.

Implementing as an MFD was discarded due to backward compatibility. The
original discussion can be read at [1].

This series depends on two cleanup series. The first series [2] ("gpio:
mvebu: preparatory cleanup for pwm-fan support") is in linux
next-20170320.  The second one [3] ("gpio: mvebu: use BIT macro instead
of bit shifting") is in linux-20170327.

Ralph

[1] https://patchwork.ozlabs.org/patch/427287/
[2] https://lkml.org/lkml/2017/3/16/62
[3] https://lkml.org/lkml/2017/3/17/493


---

Notes:

  About npwm = 1:
    The only way I can think of to achieve that requires reading the
    GPIO line from the device tree. This would prevent a user to
    dynamically choose a line. Which is fine for the fan found on Mamba
    but let's take some development board with freely accessible GPIOs
    and suddenly we limit the use of this driver. Given the above, npwm
    = ngpio with only one usable at a time is a more accurate
    description of the situation. The only downside is some "wasted"
    space.

  About the new compatible string:
    Orion was chosen for the SoC variant for the same reason as in
    commit 5f79c651e81e ("arm: mvebu: use global interrupts for GPIOs on
    Armada XP"). I decided having the first two chips be
    "marvell,armada-370-xp-gpio" and keep "marvell,orion-gpio" for the
    third one for some SoCs just to be able to require the PWM property
    for this compatible string. Therefore the properties remain
    optional and if defined for any other than the first two chips it's
    an error.

---

Pending:
  * npwm = 1? I vote no if that counts. ;) (suggested by Thierry Reding)
  * Tested-by: Andrew Lunn for v1 needs renewing
  * Needs ACK from Thierry Reding to be merged via linux-gpio tree by Linus
    Walleij. (fine with the general approach, requested changes which
    should have been taken care of now)

---

Changes v3->v4:
  Patch 1/4 gpio: mvebu: Add limited PWM support:
    * braces for both branches in if statement if one needs it. (suggested
      by Andrew Lunn)
    * introduce compatible string marvell,armada-370-xp-gpio (suggest by
      Thierry Reding)
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
  mvebu: xp: Add PWM properties to .dtsi files
  ARM: mvebu: Enable SENSORS_PWM_FAN in defconfig
  mvebu: wrt1900ac: Use pwm-fan rather than gpio-fan

 .../devicetree/bindings/gpio/gpio-mvebu.txt        |  32 ++
 MAINTAINERS                                        |   2 +
 arch/arm/boot/dts/armada-370.dtsi                  |  16 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |   8 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  14 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |  16 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  16 +-
 arch/arm/configs/mvebu_v7_defconfig                |   2 +
 drivers/gpio/gpio-mvebu.c                          | 324 ++++++++++++++++++++-
 9 files changed, 394 insertions(+), 36 deletions(-)

-- 
2.10.2
