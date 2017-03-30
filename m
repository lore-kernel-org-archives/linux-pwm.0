From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 4/4] mvebu: wrt1900ac: Use pwm-fan rather than gpio-fan
Date: Thu, 30 Mar 2017 18:01:53 +0200
Message-ID: <87shlu92j2.fsf@free-electrons.com>
References: <20170327194301.1104-1-ralph.sennhauser@gmail.com>
        <20170327194301.1104-5-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170327194301.1104-5-ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> (Ralph
        Sennhauser's message of "Mon, 27 Mar 2017 21:43:00 +0200")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi Ralph,
 
 On lun., mars 27 2017, Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

Here again the title should start with ARM: dts: armada-xp.

As for the other patch if there is no need for a v5 I will fix it while
appliig it.

Thanks,

Gregory

> From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
>
> The mvebu GPIO driver can also perform PWM on some pins. Use the pwm-fan
> driver to control the fan of the WRT1900AC, giving us finer grained control
> over its speed and hence noise.
>
> Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> URL: https://patchwork.ozlabs.org/patch/427291/
> [Ralph Sennhauser: drop flags paramter from pwms, no longer used]
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/boot/dts/armada-xp-linksys-mamba.dts | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
> index 9efcf59..6d705f5 100644
> --- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
> +++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
> @@ -308,13 +308,11 @@
>  		};
>  	};
>  
> -	gpio_fan {
> +	pwm_fan {
>  		/* SUNON HA4010V4-0000-C99 */
> -		compatible = "gpio-fan";
> -		gpios = <&gpio0 24 0>;
>  
> -		gpio-fan,speed-map = <0    0
> -				      4500 1>;
> +		compatible = "pwm-fan";
> +		pwms = <&gpio0 24 4000>;
>  	};
>  
>  	dsa {
> -- 
> 2.10.2
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
