From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v5 0/4] gpio: mvebu: Add PWM fan support
Date: Wed, 12 Apr 2017 11:11:17 +0200
Message-ID: <87bms2gfd6.fsf@free-electrons.com>
References: <20170409180931.4884-1-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:50389 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbdDLJLp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2017 05:11:45 -0400
In-Reply-To: <20170409180931.4884-1-ralph.sennhauser@gmail.com> (Ralph
        Sennhauser's message of "Sun, 9 Apr 2017 20:09:26 +0200")
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi all,
 
 On dim., avril 09 2017, Ralph Sennhauser <ralph.sennhauser@gmail.com> wrote:

> Hi Therry,
>
> Resending this as v5 with some minor changes since v4. What is missing is
> an ACK from you so Linus can merge the driver and Gregory the dts
> changes. For this driver to make it into 4.12 it would be nice to have
> it in next soon. I hope you can make some room in your schedule to have
> another look at this series.

If the other maintainer agree I can apply the arm-soc related patch (2,
3 and 4) to my mvebu branches. Actually even if the gpio driver is not
merged yet, these patches won't hurt. The only things I would like to
check is that the binding won't change.

Thanks,

Gregory

>
> Thanks
> Ralph
>
> ---
>
> Notes:
>
>   About npwm = 1:
>     The only way I can think of to achieve that requires reading the
>     GPIO line from the device tree. This would prevent a user to
>     dynamically choose a line. Which is fine for the fan found on Mamba
>     but let's take some development board with freely accessible GPIOs
>     and suddenly we limit the use of this driver. Given the above, npwm
>     = ngpio with only one usable at a time is a more accurate
>     description of the situation. The only downside is some "wasted"
>     space.
>
>   About the new compatible string:
>     Orion was chosen for the SoC variant for the same reason as in
>     commit 5f79c651e81e ("arm: mvebu: use global interrupts for GPIOs on
>     Armada XP").
>     The "pwm" property remains optional for the new compatible string so
>     the compatiple string "marvell,armada-370-xp-gpio" can be used by
>     all and not just the first two GPIO chips. A property to select "Set
>     A" / "Set B" registers could be invented though.
>
> ---
>
> Pending:
>   * Needs ACK from Thierry Reding to be merged via linux-gpio tree by Linus
>     Walleij. (fine with the general approach, requested changes which
>     should have been taken care of now)
>
> ---
>
> Changes v4->v5:
>   All
>     * add Tested-by: Andrew Lunn <andrew@lunn.ch>, thanks
>   Patch 2/4 mvebu: xp: Add PWM properties to .dtsi files
>     * keep the old compatible stings, we don't have to drop them,
>       therefore keep them (suggested by Gregory CLEMENT)
>     * subject starts with ARM: dts: mvebu: (suggested by Gregory CLEMENT)
>   Patch 4/4 mvebu: wrt1900ac: Use pwm-fan rather than gpio-fan
>     * subject starts with ARM: dts: armada-xp: (suggested by Gregory CLEMENT)
>
> Changes v3->v4:
>   Patch 1/4 gpio: mvebu: Add limited PWM support:
>     * braces for both branches in if statement if one needs it. (suggested
>       by Andrew Lunn)
>     * introduce compatible string marvell,armada-370-xp-gpio (suggest by
>       Rob Herring)
>     * fix mvebu_pwmreg_blink_on_duration -> mvebu_pwmreg_blink_off_duration
>       for period callculation in mvebu_pwm_get_state()
>   Patch 4/4 mvebu: wrt1900ac: Use pwm-fan rather than gpio-fan
>     * Drop flags from pwms for Mamba, as no longer used (suggested by
>       Andrew Lunn)
>     * Use again #pwm-cell = 2, the second cell is actually the period.
>
> Changes v2->v3:
>   Patch 1/4 gpio: mvebu: Add limited PWM support:
>     * drop pin from mvebu_pwn, can be infered (suggested by Thierry Reding)
>     * rename pwm to mvpwm so pwm can be used for pwm_device as in the API,
>       avoids some mental gymnastic.
>     * drop id from struct mvebu_gpio_chip, select blink counter in
>       mvebu_pwm_probe for all lines instead. We do not care about the
>       unused ones. I think a clear improvement in readability.
>       Makes coming up with a good comment simple as well.
>     * Switch to new atomic PWM API (suggested by Thierry Reding)
>     * rename use mvebu_gpioreg_blink_select to
>       mvebu_gpioreg_blink_counter_select.
>     * mark *_suspend() / *_resume() as __maybe_unused (suggested by Linus
>       Walleij)
>     * document #pwm-cells = 1 (suggested by Thierry Reding)
>   Patch 2/4 mvebu: xp: Add PWM properties to .dtsi files
>     * add missing reg-names / #pwm-cell properties to
>       armada-xp-mv78260.dtsi gpio1 node
>     * set pwm-cells = 1 (suggested by Thierry Reding)
>   All:
>     * always uppercase GPIO/PWM in prose (suggested by Thierry Reding)
>
> Changes v1 -> v2:
>   Patch 1/4 gpio: mvebu: Add limited PWM support:
>     * use BIT macro (suggested by Linus Walleij)
>     * move id from struct mvebu_pwm to struct mvebu_gpio_chip, implement
>       blink select as if else and comment on the chip id for code clarity
>       (to accommodate Linus Walleijs request for a code clarification /
>       comment. If you can word it better I'm all ears.)
>     * Move function comment mvebu_pwm_probe into the function itself.
>
> ---
>
> Andrew Lunn (4):
>   gpio: mvebu: Add limited PWM support
>   ARM: dts: mvebu: Add PWM properties to .dtsi files
>   ARM: mvebu: Enable SENSORS_PWM_FAN in defconfig
>   ARM: dts: armada-xp: Use pwm-fan rather than gpio-fan
>
>  .../devicetree/bindings/gpio/gpio-mvebu.txt        |  32 ++
>  MAINTAINERS                                        |   2 +
>  arch/arm/boot/dts/armada-370.dtsi                  |  19 +-
>  arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |   8 +-
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  16 +-
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi           |  19 +-
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  19 +-
>  arch/arm/configs/mvebu_v7_defconfig                |   2 +
>  drivers/gpio/gpio-mvebu.c                          | 324 ++++++++++++++++++++-
>  9 files changed, 405 insertions(+), 36 deletions(-)
>
> -- 
> 2.10.2
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
