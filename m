From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] dt: pwm: lpc32xx: add description of clocks and
 #pwm-cells properties
Date: Fri, 9 Dec 2016 15:41:37 -0600
Message-ID: <20161209214137.2hdugl5rmnwjrus4@rob-hp-laptop>
References: <20161205014237.1689-1-vz@mleia.com>
 <20161205014237.1689-2-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161205014237.1689-2-vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sylvain Lemieux <slemieux.tyco-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Mon, Dec 05, 2016 at 03:42:37AM +0200, Vladimir Zapolskiy wrote:
> NXP LPC32xx SoCs have two simple independent PWM controllers with a single
> output each, in this case there is no need to specify PWM channel argument
> on client side, one cell for setting PWM output frequency is sufficient.
> 
> Another added to the description property 'clocks' has a standard meaning
> of a controller supply clock, in the LPC32xx User's Manual the clock is
> denoted as PWM1_CLK or PWM2_CLK clock.
> 
> Signed-off-by: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> index 74b5bc5..523d796 100644
> --- a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> @@ -3,15 +3,22 @@ LPC32XX PWM controller
>  Required properties:
>  - compatible: should be "nxp,lpc3220-pwm"
>  - reg: physical base address and length of the controller's registers
> +- clocks: clock phandle and clock specifier pair
> +- #pwm-cells: should be 1, the cell is used to specify the period in
> +  nanoseconds.

This use of the cell is a bit odd as the period is s/w config and this 
would typically be a channel selection or such.

What if I want user specified/changed periods?

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
