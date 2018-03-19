From: Harald Geyer <harald@ccbib.org>
Subject: Re: [v2,4/4] dts: sunxi: A64: Add PWM controllers
Date: Mon, 19 Mar 2018 19:15:17 +0100
Message-ID: <E1exzJV-0000LZ-EY@stardust.g4.wien.funkfeuer.at>
References: <20180318232847.14278-5-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20180318232847.14278-5-andre.przywara@arm.com>
Content-ID: <1335.1521483316.1@stardust.g4.wien.funkfeuer.at>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Rob Herring <rob.herring@linaro.org>, Maxime Ripard <maxime.ripard@bootlin.com>, linux-sunxi@googlegroups.com, linux-pwm@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Andre Przywara writes:
> The Allwinner A64 SoC features two PWM controllers, which are fully
> compatible to the one used in the A13 and H3 chips.
> Add the respective device nodes (one for the "normal" PWM, the other for
> the one in the CPUS domain) and the pin their output is connected to.
> On the A64 the "normal" PWM is muxed together with one of the MDIO pins
> used to communicate with the Ethernet PHY, so it won't be usable on many
> boards. But the Pinebook laptop uses this pin for controlling the LCD
> backlight.

for the entire series:
Tested-by: Harald Geyer <harald@ccbib.org> on Teres-I (only the "normal" PWM)

Thanks for your work,
Harald

> The CPUS PWM pin however is routed to the "RPi2" header, at the same
> location as the PWM pin on the RaspberryPi.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 28 +++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index d783d164b9c3..fda1783b1c86 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -321,6 +321,11 @@
>  				bias-pull-up;
>  			};
>  
> +			pwm_pin: pwm_pin {
> +				pins = "PD22";
> +				function = "pwm";
> +			};
> +
>  			rmii_pins: rmii_pins {
>  				pins = "PD10", "PD11", "PD13", "PD14", "PD17",
>  				       "PD18", "PD19", "PD20", "PD22", "PD23";
> @@ -537,6 +542,15 @@
>  			#interrupt-cells = <3>;
>  		};
>  
> +		pwm: pwm@1c21400 {
> +			compatible = "allwinner,sun50i-a64-pwm",
> +				     "allwinner,sun5i-a13-pwm";
> +			reg = <0x01c21400 0x400>;
> +			clocks = <&osc24M>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
>  		rtc: rtc@1f00000 {
>  			compatible = "allwinner,sun6i-a31-rtc";
>  			reg = <0x01f00000 0x54>;
> @@ -563,6 +577,15 @@
>  			#reset-cells = <1>;
>  		};
>  
> +		r_pwm: pwm@1f03800 {
> +			compatible = "allwinner,sun50i-a64-pwm",
> +				     "allwinner,sun5i-a13-pwm";
> +			reg = <0x01f03800 0x400>;
> +			clocks = <&osc24M>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
>  		r_pio: pinctrl@1f02c00 {
>  			compatible = "allwinner,sun50i-a64-r-pinctrl";
>  			reg = <0x01f02c00 0x400>;
> @@ -578,6 +601,11 @@
>  				pins = "PL0", "PL1";
>  				function = "s_rsb";
>  			};
> +
> +			r_pwm_pin: pwm {
> +				pins = "PL10";
> +				function = "s_pwm";
> +			};
>  		};
>  
>  		r_rsb: rsb@1f03400 {

-- 
If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via CLAM to xASPBtezLNqj4cUe8MT5nZjthRSEjrRQXN
or via peercoin to P98LRdhit3gZbHDBe7ta5jtXrMJUms4p7w
