From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: pwm: binding allwinner sun8i.
Date: Wed, 28 Feb 2018 01:51:59 +0000
Message-ID: <56645bca-9f4a-3191-72d8-32b60ebbc26e@arm.com>
References: <20180225135045.GA14508@arx-s1>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDNZNK75ZIKRB3MW3DKAKGQECCKTMWY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180225135045.GA14508@arx-s1>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, Claudiu.Beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi,

On 25/02/18 13:50, hao_zhang wrote:
> This patch adds allwinner sun8i pwm binding documents.
> 
> Signed-off-by: hao_zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-sun8i.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> new file mode 100644
> index 0000000..e8c48be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> @@ -0,0 +1,18 @@
> +Allwinner sun8i R40/V40/T3 SoC PWM controller
> +
> +Required properties:
> +  - compatible: should be one of:
> +    - "allwinner,sun8i-r40-pwm"
> +  - reg: physical base address and length of the controller's registers
> +  - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
> +    the cells format.
> +  - clocks: From common clock binding, handle to the parent clock.

The manual tells me that there are two possible clock sources (24 MHz
OSC and APB1), with actually two bits for encoding the mux source,
allowing for two more potential clock sources.
So can we extend this description to provide up to four clocks, with a
clock-names property telling the driver how this maps to the mux value?
Either we use clock names matching the clocks mentioned in the manual:
	clocks = <&osc24M>, <&ccu CLK_APB1>;
	clock-names = "osc", "apb1";
or we encode the mux values in the clock-names:
	clock-names = "mux-0", "mux-1";
Don't know what's more widely used in those cases, the latter seems to
be more future-proof.
Each channel pair can be configured to use one of the two (or four)
clocks, so we can be more flexible with multiple clocks.


Also, can you please add an "interrupts" property here? You don't need
to use it in the driver right now, but since there are multiple
registers dealing with the interrupts we should have it in the binding.
If in need, we can then add support later.

> +
> +Example:
> +
> +pwm: pwm@1c23400 {
> +	     compatible = "allwinner,sun8i-pwm";

That should match what you wrote above: allwinner,sun8i-r40-pwm.
And I believe this is the right compatible name, since there are
numerous other sun8i SoCs with the sun4i PWM IP, so just sun8i-pwm would
be misleading and confusing.

> +	     reg = <0x01c23400 0x154>;
> +	     clocks = <&osc24M>;

This should then be amended to what I sketched above.

> +	     #pwm-cells = <3>;

And then here please add:
	     interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;

Cheers,
Andre
