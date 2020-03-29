From: Russell King - ARM Linux admin <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH RFC 2/6] gpio: mvebu: honour EPROBE_DEFER for
 devm_clk_get()
Date: Sun, 29 Mar 2020 19:22:36 +0100
Message-ID: <20200329182236.GC25745@shell.armlinux.org.uk>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <E1jIVU9-0005h4-QU@rmk-PC.armlinux.org.uk>
 <20200329131659.4hbshjst4ccvje2n@pengutronix.de>
 <20200329133400.GA25745@shell.armlinux.org.uk>
 <20200329180056.cwju3zqviwnwwjd6@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200329180056.cwju3zqviwnwwjd6-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gregory Clement <gregory.clement-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Sun, Mar 29, 2020 at 08:00:56PM +0200, Uwe Kleine-König wrote:
> Hello Russell,
> 
> On Sun, Mar 29, 2020 at 02:34:00PM +0100, Russell King - ARM Linux admin wrote:
> > On Sun, Mar 29, 2020 at 03:16:59PM +0200, Uwe Kleine-König wrote:
> > > On Sun, Mar 29, 2020 at 11:48:09AM +0100, Russell King wrote:
> > > > diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> > > > index fa5641615db6..ee13b11c5298 100644
> > > > --- a/drivers/gpio/gpio-mvebu.c
> > > > +++ b/drivers/gpio/gpio-mvebu.c
> > > > @@ -1132,6 +1132,9 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
> > > >  	}
> > > >  
> > > >  	mvchip->clk = devm_clk_get(&pdev->dev, NULL);
> > > > +	if (mvchip->clk == ERR_PTR(-EPROBE_DEFER))
> > > > +		return -EPROBE_DEFER;
> > > > +
> > > >  	/* Not all SoCs require a clock.*/
> > > >  	if (!IS_ERR(mvchip->clk))
> > > >  		clk_prepare_enable(mvchip->clk);
> > > 
> > > I'd say the following is the right thing to do here:
> > > 
> > > 	mvchip->clk = devm_clk_get_optional(...);
> > > 	if (IS_ERR(mvchip->clk))
> > > 		return ...
> > 
> > It's not that simple.  The clock is required for Armada 370, and is
> > optional for Armada 8040.
> 
> I'd say it is still the right approach here. On Armada 370 the dtb then
> has a clk and on Armada 8040 it doesn't. So if with
> devm_clk_get_optional() something goes wrong that's because the dtb is
> wrong. And in fact the handling is even better than with your suggested
> patch as every error (but EPROBE_DEFER) is ignored instead of passed to
> the caller with your (and the existing) approach.

Sort of.  Every error is currently treated as "no clock", and only
later does such an error become fatal in the driver _if_ PWM is
configured into the kernel and we're running on Armada 370.  If PWM
is disabled in the kernel, or on some other SoC, then the driver
doesn't care whether getting the clock reported any kind of error.

Your proposal is to always treat any error getting the clock,
irrespective of whether there is PWM or not, as a fatal error for
the driver.

That is an entirely seperate functional change.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
