From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 2/4] mvebu: xp: Add PWM properties to .dtsi files
Date: Thu, 30 Mar 2017 17:45:08 +0200
Message-ID: <87wpb693az.fsf@free-electrons.com>
References: <20170327194301.1104-1-ralph.sennhauser@gmail.com>
        <20170327194301.1104-3-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170327194301.1104-3-ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> (Ralph
        Sennhauser's message of "Mon, 27 Mar 2017 21:42:58 +0200")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi Ralph,
 
 On lun., mars 27 2017, Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

The title should start by ARM: dts: mvebu:

If there is no need to have a v5 then I wil take care of modifying the
title while applying it.


> From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
>
> Add properties to the GPIO nodes to allow them to be also used as PWM
> lines.
>
> Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> URL: https://patchwork.ozlabs.org/patch/427294/
> [Ralph Sennhauser:
>   * Use new compatible string marvell,armada-370-xp-gpio
>   * Add missing reg-names / #pwm-cell properties to armada-xp-mv78260.dtsi
>     'gpio1' node]
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/boot/dts/armada-370.dtsi        | 16 +++++++++++-----
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi | 14 ++++++++++----
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi | 16 +++++++++++-----
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi | 16 +++++++++++-----
>  4 files changed, 43 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> index cc011c8..e30b076 100644
> --- a/arch/arm/boot/dts/armada-370.dtsi
> +++ b/arch/arm/boot/dts/armada-370.dtsi
> @@ -137,29 +137,35 @@
>  			};
>  
>  			gpio0: gpio@18100 {
> -				compatible = "marvell,orion-gpio";
> -				reg = <0x18100 0x40>;
> +				compatible = "marvell,armada-370-xp-gpio";

I think we should keep the "marvell,orion-gpio" too because the hardware
is still compatible with it. Morever it will allow to use a recent dtb
with an old kernel.


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
> -				compatible = "marvell,orion-gpio";
> -				reg = <0x18140 0x40>;
> +				compatible = "marvell,armada-370-xp-gpio";

Same here and for all the others...

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
