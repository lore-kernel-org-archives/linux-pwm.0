From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 RESEND] pwm: Add CLPS711X PWM support
Date: Tue, 25 Feb 2014 16:33:01 +0100
Message-ID: <5560556.tENBsUTXbt@wuerfel>
References: <1393342067-9086-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393342067-9086-1-git-send-email-shc_work-JGs/UdohzUI@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Tuesday 25 February 2014 19:27:47 Alexander Shiyan wrote:
> Add a new driver for the ARM CLPS711X Pulse Width Modulator (PWM) interface.
> This CPU contain two 4-bit PWM outputs with constant period, based on CPU
> PLL frequency. PWM polarity is determined by hardware by power on reset.
> 
> Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>

Looks good, just one comment

> +++ b/Documentation/devicetree/bindings/pwm/cirrus-clps711x-pwm.txt
> @@ -0,0 +1,15 @@
> +* Cirris Logic CLPS711X PWM controller
> +
> +Required properties:
> +- compatible: Should be "cirrus,clps711x-pwm".
> +- reg: Physical base address and length of the controller's registers.
> +- clocks: phandle to the PWM reference clock.
> +- #pwm-cells: Should be 1. The cell specifies the index of the channel.
> +
> +Example:
> +	pwm: pwm@80000400 {
> +		compatible = "cirrus,clps711x-pwm";
> +		reg = <0x80000400 0x4>;
> +		clocks = <&clks 8>;
> +		#pwm-cells = <1>;
> +	};

We really want to avoid wildcards in compatible strings. Can you call this
"cirrus,cs89712-pwm" to match the first SoC that came with this hardware?
Obviously if there was some chip before that (I'm not familiar with the
model numbers), use that instead.

You can either list all chips you know that have this in the driver,
or you use "cirrus,cs89712-pwm" as the fallback, and use the name of
the SoC you have as the more specific string.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
