From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: [PATCH v3 0/4] gpio: mvebu: Add PWM fan support
Date: Fri, 24 Mar 2017 15:18:10 +0100
Message-ID: <20170324141815.7252-1-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-gpio@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Alexandre Courbot <gnurou@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Imre Kaloz <kaloz@openwrt.org>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Hi everyone

This patch series was originally submitted by Andrew Lunn but got stalled.
I picked up the series and addressed what was discussed for the earlier
submission with some helpful input from Andrew. Hopefully this time support
for the PWM fan as found on Linksys WRT1900AC (Mamba) will make it in.

Implementing as an MFD was discarded due to backward compatibility. The
original discussion can be read at [1].

This series depends on two cleanup series. The first series [2] ("gpio:
mvebu: preparatory cleanup for pwm-fan support") is in linux next-20170320.
The second one [3] ("gpio: mvebu: use BIT macro instead of bit shifting")
got applied but didn't make it's way into linux-next yet.

See pending items below!

Ralph

[1] https://patchwork.ozlabs.org/patch/427287/
[2] https://lkml.org/lkml/2017/3/16/62
[3] https://lkml.org/lkml/2017/3/17/493

---

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

Pending:
  * npwm = 1? (suggested by Thierry Reding)
    Like Andrew who commented on this item for v1 I'm not yet clear how
    to achieve that. So while a lie a rather convenient one.
  * Tested-by: Andrew Lunn for v1 needs renewing
  * Needs ACK from Thierry Reding to be merged via linux-gpio tree by Linus
    Walleij. (fine with the general approach, requested changes)

---

Andrew Lunn (4):
  gpio: mvebu: Add limited PWM support
  mvebu: xp: Add PWM properties to .dtsi files
  ARM: mvebu: Enable SENSORS_PWM_FAN in defconfig
  mvebu: wrt1900ac: Use pwm-fan rather than gpio-fan

 .../devicetree/bindings/gpio/gpio-mvebu.txt        |  29 ++
 MAINTAINERS                                        |   2 +
 arch/arm/boot/dts/armada-370.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |   8 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  10 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |  10 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  10 +-
 arch/arm/configs/mvebu_v7_defconfig                |   2 +
 drivers/gpio/gpio-mvebu.c                          | 317 ++++++++++++++++++++-
 9 files changed, 373 insertions(+), 25 deletions(-)

-- 
2.10.2
