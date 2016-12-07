From: Sylvain Lemieux <slemieux.tyco-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] dt: pwm: lpc32xx: add description of clocks and
 #pwm-cells properties
Date: Wed, 07 Dec 2016 12:56:49 -0500
Message-ID: <1481133409.9248.1.camel@localhost>
References: <20161205014237.1689-1-vz@mleia.com>
         <20161205014237.1689-2-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161205014237.1689-2-vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Mon, 2016-12-05 at 03:42 +0200, Vladimir Zapolskiy wrote:
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
Reviewed-by: Sylvain Lemieux <slemieux.tyco-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
