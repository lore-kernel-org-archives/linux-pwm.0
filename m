Return-path: <gregory.clement@bootlin.com>
From: Gregory CLEMENT <gregory.clement@bootlin.com>
In-Reply-To: <75637257694de0d4a9e432e1d8270019a4e6328b.1610364681.git.baruch@tkos.co.il>
References: <cover.1610364681.git.baruch@tkos.co.il>
 <75637257694de0d4a9e432e1d8270019a4e6328b.1610364681.git.baruch@tkos.co.il>
Date: Fri, 29 Jan 2021 16:55:10 +0100
Message-ID: <87wnvvsppd.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v7 2/3] arm64: dts: armada: add pwm offsets for ap/cp gpios
To: Baruch Siach <baruch@tkos.co.il>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>
Cc: Baruch Siach <baruch@tkos.co.il>, Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Chris Packham <chris.packham@alliedtelesis.co.nz>, Sascha Hauer <s.hauer@pengutronix.de>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>

Hi Baruch,

> The 'marvell,pwm-offset' property of both GPIO blocks (per CP component)
> point to the same counter registers offset. The driver will decide how
> to use counters A/B.
>
> This is different from the convention of pwm on earlier Armada series
> (370/38x). On those systems the assignment of A/B counters to GPIO
> blocks is coded in both DT and the driver. The actual behaviour of the
> current driver on Armada 8K/7K is the same as earlier systems.
>
> Add also clock properties for base pwm frequency reference.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-ap80x.dtsi |  3 +++
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 10 ++++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> index 12e477f1aeb9..6614472100c2 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> @@ -281,6 +281,9 @@ ap_gpio: gpio@1040 {
>  					gpio-controller;
>  					#gpio-cells = <2>;
>  					gpio-ranges = <&ap_pinctrl 0 0 20>;
> +					marvell,pwm-offset = <0x10c0>;
> +					#pwm-cells = <2>;
> +					clocks = <&ap_clk 3>;
>  				};
>  			};
>  
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> index 994a2fce449a..d774a39334d9 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> @@ -234,12 +234,17 @@ CP11X_LABEL(gpio1): gpio@100 {
>  				gpio-controller;
>  				#gpio-cells = <2>;
>  				gpio-ranges = <&CP11X_LABEL(pinctrl) 0 0 32>;
> +				marvell,pwm-offset = <0x1f0>;
> +				#pwm-cells = <2>;
>  				interrupt-controller;
>  				interrupts = <86 IRQ_TYPE_LEVEL_HIGH>,
>  					<85 IRQ_TYPE_LEVEL_HIGH>,
>  					<84 IRQ_TYPE_LEVEL_HIGH>,
>  					<83 IRQ_TYPE_LEVEL_HIGH>;
>  				#interrupt-cells = <2>;
> +				clock-names = "core", "axi";
> +				clocks = <&CP11X_LABEL(clk) 1 21>,
> +					 <&CP11X_LABEL(clk) 1 17>;
>  				status = "disabled";
>  			};
>  
> @@ -250,12 +255,17 @@ CP11X_LABEL(gpio2): gpio@140 {
>  				gpio-controller;
>  				#gpio-cells = <2>;
>  				gpio-ranges = <&CP11X_LABEL(pinctrl) 0 32 31>;
> +				marvell,pwm-offset = <0x1f0>;
> +				#pwm-cells = <2>;
>  				interrupt-controller;
>  				interrupts = <82 IRQ_TYPE_LEVEL_HIGH>,
>  					<81 IRQ_TYPE_LEVEL_HIGH>,
>  					<80 IRQ_TYPE_LEVEL_HIGH>,
>  					<79 IRQ_TYPE_LEVEL_HIGH>;
>  				#interrupt-cells = <2>;
> +				clock-names = "core", "axi";
> +				clocks = <&CP11X_LABEL(clk) 1 21>,
> +					 <&CP11X_LABEL(clk) 1 17>;
>  				status = "disabled";
>  			};
>  		};
> -- 
> 2.29.2
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
