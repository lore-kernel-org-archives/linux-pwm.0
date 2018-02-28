From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 3/4] ARM: dts: add pwm status for r40.
Date: Wed, 28 Feb 2018 01:54:57 +0000
Message-ID: <0fd023da-214a-c4ef-63f7-0cc41ca716bf@arm.com>
References: <20180225135225.GA14544@arx-s1>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDNZNK75ZIKRBH4Y3DKAKGQE7L4UPZQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180225135225.GA14544@arx-s1>
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

the subject line should mention the BananaPi M2 Ultra board.

Otherwise this looks good, although I wonder if this should somehow
mention "LCD-PWM" (in the commit message?), since this is how this pin
is described in the BananaPi GPIO documentation for this board.
And it seems to be dedicated for this purpose here.

Cheers,
Andre.

On 25/02/18 13:52, hao_zhang wrote:
> This patch adds pwm status for r40.
> 
> Signed-off-by: hao_zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> index 8c5efe2..e4eb074 100644
> --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> @@ -196,6 +196,12 @@
>  	status = "okay";
>  };
>  
> +&pwm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm_ch0_pin>;
> +	status = "okay";
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pb_pins>;
> 
