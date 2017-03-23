From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v2 2/4] mvebu: xp: Add pwm properties to .dtsi files
Date: Thu, 23 Mar 2017 17:40:53 +0100
Message-ID: <871stodjze.fsf@free-electrons.com>
References: <20170318154305.28348-1-ralph.sennhauser@gmail.com>
        <20170318154305.28348-3-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170318154305.28348-3-ralph.sennhauser@gmail.com> (Ralph
        Sennhauser's message of "Sat, 18 Mar 2017 16:43:02 +0100")
Sender: linux-gpio-owner@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: linux-gpio@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Imre Kaloz <kaloz@openwrt.org>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "moderated list:ARM/Marvell
        Kirkwood and Armada 370, 375, 38x,..." <linux-arm-kernel@lists.infradead.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi Ralph,
 
 On sam., mars 18 2017, Ralph Sennhauser <ralph.sennhauser@gmail.com> wrote:

It seems that I don't receive the 1st patch of the series.

Also could you refresh my mind to expose why these patchse were not
apply the first time and why we should apply them now?

Thanks,

Gregory


> From: Andrew Lunn <andrew@lunn.ch>
>
> Add properties to the gpio nodes to allow them to be also used as pwm
> lines.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> URL: https://patchwork.ozlabs.org/patch/427294/
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> ---
>  arch/arm/boot/dts/armada-370.dtsi        | 10 ++++++++--
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi | 10 ++++++++--
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi |  8 ++++++--
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi | 10 ++++++++--
>  4 files changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> index cc011c8..aa9fe72 100644
> --- a/arch/arm/boot/dts/armada-370.dtsi
> +++ b/arch/arm/boot/dts/armada-370.dtsi
> @@ -138,24 +138,30 @@
>  
>  			gpio0: gpio@18100 {
>  				compatible = "marvell,orion-gpio";
> -				reg = <0x18100 0x40>;
> +				reg = <0x18100 0x40>, <0x181c0 0x08>;
> +				reg-names = "gpio", "pwm";
>  				ngpios = <32>;
>  				gpio-controller;
>  				#gpio-cells = <2>;
> +				#pwm-cells = <2>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
>  				interrupts = <82>, <83>, <84>, <85>;
> +				clocks = <&coreclk 0>;
>  			};
>  
>  			gpio1: gpio@18140 {
>  				compatible = "marvell,orion-gpio";
> -				reg = <0x18140 0x40>;
> +				reg = <0x18140 0x40>, <0x181c8 0x08>;
> +				reg-names = "gpio", "pwm";
>  				ngpios = <32>;
>  				gpio-controller;
>  				#gpio-cells = <2>;
> +				#pwm-cells = <2>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
>  				interrupts = <87>, <88>, <89>, <90>;
> +				clocks = <&coreclk 0>;
>  			};
>  
>  			gpio2: gpio@18180 {
> diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> index 07c5090..fc3934f 100644
> --- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> @@ -203,24 +203,30 @@
>  		internal-regs {
>  			gpio0: gpio@18100 {
>  				compatible = "marvell,orion-gpio";
> -				reg = <0x18100 0x40>;
> +				reg = <0x18100 0x40>, <0x181c0 0x08>;
> +				reg-names = "gpio", "pwm";
>  				ngpios = <32>;
>  				gpio-controller;
>  				#gpio-cells = <2>;
> +				#pwm-cells = <2>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
>  				interrupts = <82>, <83>, <84>, <85>;
> +				clocks = <&coreclk 0>;
>  			};
>  
>  			gpio1: gpio@18140 {
>  				compatible = "marvell,orion-gpio";
> -				reg = <0x18140 0x40>;
> +				reg = <0x18140 0x40>, <0x181c8 0x08>;
> +				reg-names = "gpio", "pwm";
>  				ngpios = <17>;
>  				gpio-controller;
>  				#gpio-cells = <2>;
> +				#pwm-cells = <2>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
>  				interrupts = <87>, <88>, <89>;
> +				clocks = <&coreclk 0>;
>  			};
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
> index 64e936a..04dda6a 100644
> --- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
> @@ -286,24 +286,28 @@
>  		internal-regs {
>  			gpio0: gpio@18100 {
>  				compatible = "marvell,orion-gpio";
> -				reg = <0x18100 0x40>;
> +				reg = <0x18100 0x40>, <0x181c0 0x08>;
> +				reg-names = "gpio", "pwm";
>  				ngpios = <32>;
>  				gpio-controller;
>  				#gpio-cells = <2>;
> +				#pwm-cells = <2>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
>  				interrupts = <82>, <83>, <84>, <85>;
> +				clocks = <&coreclk 0>;
>  			};
>  
>  			gpio1: gpio@18140 {
>  				compatible = "marvell,orion-gpio";
> -				reg = <0x18140 0x40>;
> +				reg = <0x18140 0x40>, <0x181c8 0x08>;
>  				ngpios = <32>;
>  				gpio-controller;
>  				#gpio-cells = <2>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
>  				interrupts = <87>, <88>, <89>, <90>;
> +				clocks = <&coreclk 0>;
>  			};
>  
>  			gpio2: gpio@18180 {
> diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
> index d1383dd..fb6d28a 100644
> --- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
> @@ -324,24 +324,30 @@
>  		internal-regs {
>  			gpio0: gpio@18100 {
>  				compatible = "marvell,orion-gpio";
> -				reg = <0x18100 0x40>;
> +				reg = <0x18100 0x40>, <0x181c0 0x08>;
> +				reg-names = "gpio", "pwm";
>  				ngpios = <32>;
>  				gpio-controller;
>  				#gpio-cells = <2>;
> +				#pwm-cells = <2>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
>  				interrupts = <82>, <83>, <84>, <85>;
> +				clocks = <&coreclk 0>;
>  			};
>  
>  			gpio1: gpio@18140 {
>  				compatible = "marvell,orion-gpio";
> -				reg = <0x18140 0x40>;
> +				reg = <0x18140 0x40>, <0x181c8 0x08>;
> +				reg-names = "gpio", "pwm";
>  				ngpios = <32>;
>  				gpio-controller;
>  				#gpio-cells = <2>;
> +				#pwm-cells = <2>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
>  				interrupts = <87>, <88>, <89>, <90>;
> +				clocks = <&coreclk 0>;
>  			};
>  
>  			gpio2: gpio@18180 {
> -- 
> 2.10.2
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
