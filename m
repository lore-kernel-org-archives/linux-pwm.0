From: Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/4] gpio: mvebu: Add limited PWM support
Date: Fri, 24 Mar 2017 23:21:15 +0100
Message-ID: <20170324232115.3d97aff2@gmail.com>
References: <20170318154305.28348-1-ralph.sennhauser@gmail.com>
        <20170318154305.28348-2-ralph.sennhauser@gmail.com>
        <20170324151829.awmhshsent4ngqb5@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170324151829.awmhshsent4ngqb5@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "open list:PWM SUBSYSTEM" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Fri, 24 Mar 2017 10:18:29 -0500
Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> On Sat, Mar 18, 2017 at 04:43:01PM +0100, Ralph Sennhauser wrote:
> > From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> > 
> > Armada 370/XP devices can 'blink' gpio lines with a configurable on
> > and off period. This can be modelled as a PWM.
> > 
> > However, there are only two sets of PWM configuration registers for
> > all the gpio lines. This driver simply allows a single gpio line per
> > gpio chip of 32 lines to be used as a PWM. Attempts to use more
> > return EBUSY.
> > 
> > Due to the interleaving of registers it is not simple to separate
> > the PWM driver from the gpio driver. Thus the gpio driver has been
> > extended with a PWM driver.
> > 
> > Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> > URL: https://patchwork.ozlabs.org/patch/427287/
> > URL: https://patchwork.ozlabs.org/patch/427295/
> > [Ralph Sennhauser:
> >   * port forward
> >   * merge pwm portion into gpio-mvebu.c
> >   * merge documentation patch
> >   * update MAINTAINERS]
> > Signed-off-by: Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  .../devicetree/bindings/gpio/gpio-mvebu.txt        |  31 +++
> >  MAINTAINERS                                        |   2 +
> >  drivers/gpio/gpio-mvebu.c                          | 291
> > +++++++++++++++++++-- 3 files changed, 307 insertions(+), 17
> > deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> > b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt index
> > a6f3bec..86932e3 100644 ---
> > a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt +++
> > b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt @@ -38,6
> > +38,23 @@ Required properties:
> >  - #gpio-cells: Should be two. The first cell is the pin number. The
> >    second cell is reserved for flags, unused at the moment.
> >  
> > +Optional properties:
> > +
> > +In order to use the gpio lines in PWM mode, some additional
> > optional +properties are required. Only Armada 370 and XP support
> > these properties. +
> > +- reg: an additional register set is needed, for the GPIO Blink
> > +  Counter on/off registers.
> > +
> > +- reg-names: Must contain an entry "pwm" corresponding to the
> > +  additional register range needed for pwm operation.
> > +
> > +- #pwm-cells: Should be two. The first cell is the pin number.
> > The  
> 
> s/pin number/gpio line/ ?

Better indeed.

> 
> > +  second cell is reserved for flags and should be set to 0, so it
> > has a
> > +  known value. It then becomes possible to use it in the future.
> > +
> > +- clocks: Must be a phandle to the clock for the gpio controller.
> > +
> >  Example:
> >  
> >  		gpio0: gpio@d0018100 {
> > @@ -51,3 +68,17 @@ Example:
> >  			#interrupt-cells = <2>;
> >  			interrupts = <16>, <17>, <18>, <19>;
> >  		};
> > +
> > +		gpio1: gpio@18140 {
> > +			compatible = "marvell,orion-gpio";  
> 
> If only 370 and XP support this, I'd expect a compatible string for
> one of them here.

Commit 5f79c651e81e ("arm: mvebu: use global interrupts for GPIOs on
Armada XP") changes it from "marvell,armadaxp-gpio". The commit message
says for 3.8 basically leaving it open for a "fix" later.

Adding Thomas Petazzoni as the author.

Thomas, would you happen to know if this is still how it's supposed to
be for now?

Thanks
Ralph


> 
> > +			reg = <0x18140 0x40>, <0x181c8 0x08>;
> > +			reg-names = "gpio", "pwm";
> > +			ngpios = <17>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			#pwm-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +			interrupts = <87>, <88>, <89>;
> > +			clocks = <&coreclk 0>;
> > +		};  

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
