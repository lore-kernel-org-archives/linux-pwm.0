From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v4 0/4] gpio: mvebu: Add PWM fan support
Date: Thu, 30 Mar 2017 18:03:50 +0200
Message-ID: <87o9wi92ft.fsf@free-electrons.com>
References: <20170327194301.1104-1-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170327194301.1104-1-ralph.sennhauser@gmail.com> (Ralph
        Sennhauser's message of "Mon, 27 Mar 2017 21:42:56 +0200")
Sender: linux-gpio-owner@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Imre Kaloz <kaloz@openwrt.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Ralph,
 
 On lun., mars 27 2017, Ralph Sennhauser <ralph.sennhauser@gmail.com> wrote:

[...]
> Andrew Lunn (4):
>   gpio: mvebu: Add limited PWM support

>   mvebu: xp: Add PWM properties to .dtsi files
>   ARM: mvebu: Enable SENSORS_PWM_FAN in defconfig
>   mvebu: wrt1900ac: Use pwm-fan rather than gpio-fan

I didn't see any big problem with this 3 patches, I will applied them
once the first one will be applied on the gpio tree or at least acked.

Thanks,

Gregory

>
>  .../devicetree/bindings/gpio/gpio-mvebu.txt        |  32 ++
>  MAINTAINERS                                        |   2 +
>  arch/arm/boot/dts/armada-370.dtsi                  |  16 +-
>  arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |   8 +-
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  14 +-
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi           |  16 +-
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  16 +-
>  arch/arm/configs/mvebu_v7_defconfig                |   2 +
>  drivers/gpio/gpio-mvebu.c                          | 324 ++++++++++++++++++++-
>  9 files changed, 394 insertions(+), 36 deletions(-)
>
> -- 
> 2.10.2
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
