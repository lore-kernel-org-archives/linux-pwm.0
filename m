From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: pwm: Add generic
 "pwm-channels" property
Date: Mon, 5 Mar 2018 17:53:00 -0600
Message-ID: <20180305235300.fvelyl7vqcjc4u5f@rob-hp-laptop>
References: <20180228013732.8506-1-andre.przywara@arm.com>
Reply-To: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDJIP47K7MERBXVQ67KAKGQEGHRRGCA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20180228013732.8506-1-andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Feb 28, 2018 at 01:37:32AM +0000, Andre Przywara wrote:
> Many PWM drivers seem to hardcode the number of PWM channels
> (brcm,iproc-pwm, brcm,kona-pwm.txt). If this is only one device
> supported by the binding, that's probably OK, but for instance for
> sun4i-pwm I see one or two channels, depending on the particular SoC.
> amlogic,meson-gxbb-pwm seems to deduce the number of channels from the
> number of input clocks, and pwm-st has a vendor-specific property for
> that (st,pwm-num-chan).
> To cover all those cases more elegantly in (future) bindings, add a new
> generic property to specify the number of PWM channels a particular
> controller implements.
> For instance the sun4i-pwm driver could be extended to support this for
> future SoCs as well.
> 
> Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
> 
> ---
> Hi,
> 
> while looking at the bindings for PWM drivers, I was wondering if we
> should have a generic property to note the number of implemented
> channels? We have something for instance for DMA controllers
> (dma-channels), so adding this to PWM controller bindings sounds
> natural.
> In particular the new sun8i-pwm IP seems to be scalable to a number of
> channels, judging from the register and bit layout and from the bit
> assignment in the manual. I have the gut feeling we will meet this fella
> again in another Allwinner SoC with a different number of channels.

Often this should be implied by the compatible string. However, there 
are no doubt some cases that may need this. One I could think of is the 
PWM controller has more channels than are pinned out.

Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> 
> Thanks!
> Andre.
> 
>  Documentation/devicetree/bindings/pwm/pwm.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
> index 8556263b8502..770f3aee17af 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> @@ -60,10 +60,16 @@ Example with optional PWM specifier for inverse polarity
>  PWM controller nodes must specify the number of cells used for the
>  specifier using the '#pwm-cells' property.
>  
> +A specific controller binding might specify the implemented number of
> +PWM channels using this generic property:
> +	pwm-channels = <8>;
> +This property holds a single 32 bit integer.
> +
>  An example PWM controller might look like this:
>  
>  	pwm: pwm@7000a000 {
>  		compatible = "nvidia,tegra20-pwm";
>  		reg = <0x7000a000 0x100>;
>  		#pwm-cells = <2>;
> +		pwm-channels = <4>;
>  	};
> -- 
> 2.14.1
> 
