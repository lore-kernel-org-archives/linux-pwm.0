From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 2/4] ARM: dtsi: add pwm node for sun8i.
Date: Wed, 28 Feb 2018 01:53:49 +0000
Message-ID: <b8af4f6a-c2df-7382-9a1c-9c1a9ea5f8c4@arm.com>
References: <20180225135134.GA14529@arx-s1>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDNZNK75ZIKRBW4X3DKAKGQEI23KV3Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180225135134.GA14529@arx-s1>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, Claudiu.Beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi,

The subject line should mention the R40, there are far too many sun8i SoCs.

On 25/02/18 13:51, hao_zhang wrote:
> This patch adds pwm node for sun8i.
> 
> Signed-off-by: hao_zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> index 173dcc1..99a0261 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -295,6 +295,11 @@
>  				bias-pull-up;
>  			};
>  
> +			pwm_ch0_pin: pwm-ch0-pin {
> +				pins = "PB2";
> +				function = "pwm";
> +			};
> +
>  			uart0_pb_pins: uart0-pb-pins {
>  				pins = "PB22", "PB23";
>  				function = "uart0";
> @@ -306,6 +311,14 @@
>  			reg = <0x01c20c90 0x10>;
>  		};
>  
> +		pwm: pwm@1c23400 {
> +			     compatible = "allwinner,sun8i-r40-pwm";
> +			     reg = <0x01c23400 0x154>;

Following my comments on the binding document:
			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;

> +			     clocks = <&osc24M>;

And possibly multiple clocks here (though I fail to find the APB1 clock
being exposed by our CCU).

Cheers,
Andre.

> +			     #pwm-cells = <3>;
> +			     status = "disabled";
> +		};
> +
>  		uart0: serial@1c28000 {
>  			compatible = "snps,dw-apb-uart";
>  			reg = <0x01c28000 0x400>;
> 
