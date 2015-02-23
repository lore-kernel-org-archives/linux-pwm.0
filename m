From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 0/7] Add PWM support to mvebu gpio driver
Date: Mon, 23 Feb 2015 15:09:32 +0100
Message-ID: <54EB349C.2070700@free-electrons.com>
References: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
Sender: linux-gpio-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: linus.walleij@linaro.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, kaloz@openwrt.org, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Andrew,

On 10/01/2015 00:34, Andrew Lunn wrote:
> This patchset starts out with some cleanups and fixes for the mvebu
> gpio driver. Then new functionality is added. The Armada 370 and XP
> SoC has the ability to "blink" the gpio lines at a configuration on
> and off duration. So simple PWM support is added. However only a
> single gpio line per gpio chip can be used as a PWM line due to
> limitations of the hardware. The last patch shows one example of how
> this could be used, converting a gpio-fan into a pwm-fan, so allowing
> finer control over its rotation speed, and hence noise. This last
> patch is not expected to be accepted, since the device is not yet in
> mainline.
> 
> Andrew Lunn (7):
>   gpio: mvebu: checkpatch fixes
>   gpio: mvebu: Fix probe cleanup on error
>   gpio: mvebu: Add limited PWM support
>   DT: bindings: Extend mvebu gpio documentation with PWM
>   mvebu: xp: Add pwm properties to .dtsi files
>   arm: mvebu: Enable PWM in defconfig
>   mvebu: wrt1900ac: Use pwm-fan rather than gpio-fan
> 

What is the status of this series?
I saw that the 2 first patches have been merged but what about the patch 3 and 4?

Do you plan to send a new series?

The patches 5 and 6 are good candidates to for to the mvebu tree but of course only
if the patch 3 is merged.

Thanks,

Gregory




>  .../devicetree/bindings/gpio/gpio-mvebu.txt        |  31 ++++
>  arch/arm/boot/dts/armada-370.dtsi                  |  10 +-
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  10 +-
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   8 +-
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  10 +-
>  arch/arm/boot/dts/armada-xp-wrt1900ac.dts          |   8 +-
>  arch/arm/configs/mvebu_v7_defconfig                |   1 +
>  drivers/gpio/Kconfig                               |   5 +
>  drivers/gpio/Makefile                              |   1 +
>  drivers/gpio/gpio-mvebu-pwm.c                      | 202 +++++++++++++++++++++
>  drivers/gpio/gpio-mvebu.c                          | 133 +++++++-------
>  drivers/gpio/gpio-mvebu.h                          |  79 ++++++++
>  12 files changed, 421 insertions(+), 77 deletions(-)
>  create mode 100644 drivers/gpio/gpio-mvebu-pwm.c
>  create mode 100644 drivers/gpio/gpio-mvebu.h
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
