From: Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 6/6] arm64: dts: allwinner: h6: Add PWM node
Date: Sat, 27 Jul 2019 12:51:17 +0200
Message-ID: <20190727105117.rcud3x6oskc43zso@flea.home>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-7-jernej.skrabec@siol.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190726184045.14669-7-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: thierry.reding@gmail.com, wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-pwm@vger.kernel.org

On Fri, Jul 26, 2019 at 08:40:45PM +0200, Jernej Skrabec wrote:
> Allwinner H6 PWM is similar to that in A20 except that it has additional
> bus clock and reset line.
>
> Note that first PWM channel is connected to output pin and second
> channel is used internally, as a clock source to AC200 co-packaged chip.
> This means that any combination of these two channels can be used and
> thus it doesn't make sense to add pinctrl nodes at this point.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index e8bed58e7246..c1abd805cfdc 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -229,6 +229,16 @@
>  			status = "disabled";
>  		};
>
> +		pwm: pwm@300a000 {
> +			compatible = "allwinner,sun50i-h6-pwm";
> +			reg = <0x0300a000 0x400>;
> +			clocks = <&osc24M>, <&ccu CLK_BUS_PWM>;
> +			clock-names = "pwm", "bus";

We always have the bus clock first, so I'd really like to keep
that. We also usually use mod for the second clock, and not the name
of the device itself.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
