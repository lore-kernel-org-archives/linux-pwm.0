From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 1/4] gpio: mvebu: Add limited PWM support
Date: Thu, 13 Apr 2017 15:14:07 -0500
Message-ID: <20170413201407.j6edqybdx75ufkva@rob-hp-laptop>
References: <20170409180931.4884-1-ralph.sennhauser@gmail.com>
 <20170409180931.4884-2-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170409180931.4884-2-ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Sun, Apr 09, 2017 at 08:09:27PM +0200, Ralph Sennhauser wrote:
> From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> 
> Armada 370/XP devices can 'blink' GPIO lines with a configurable on
> and off period. This can be modelled as a PWM.
> 
> However, there are only two sets of PWM configuration registers for
> all the GPIO lines. This driver simply allows a single GPIO line per
> GPIO chip of 32 lines to be used as a PWM. Attempts to use more return
> EBUSY.
> 
> Due to the interleaving of registers it is not simple to separate the
> PWM driver from the GPIO driver. Thus the GPIO driver has been
> extended with a PWM driver.
> 
> Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> URL: https://patchwork.ozlabs.org/patch/427287/
> URL: https://patchwork.ozlabs.org/patch/427295/
> [Ralph Sennhauser:
>   * Port forward
>   * Merge PWM portion into gpio-mvebu.c
>   * Switch to atomic PWM API
>   * Add new compatible string marvell,armada-370-xp-gpio
>   * Update and merge documentation patch
>   * Update MAINTAINERS]
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Tested-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> ---
>  .../devicetree/bindings/gpio/gpio-mvebu.txt        |  32 ++
>  MAINTAINERS                                        |   2 +

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  drivers/gpio/gpio-mvebu.c                          | 324 ++++++++++++++++++++-
>  3 files changed, 346 insertions(+), 12 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
