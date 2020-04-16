From: Russell King - ARM Linux admin <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH RFC 0/6] PWM fan support on Clearfog gt8k
Date: Thu, 16 Apr 2020 17:37:48 +0100
Message-ID: <20200416163748.GL25745@shell.armlinux.org.uk>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <CACRpkdaL4-Z36aKOVW4o2MtCG9fbqm4gxZN3QjejVRPBZrzxxA@mail.gmail.com>
 <20200416135039.GL657811@lunn.ch>
 <5c7cb0ff-bf49-640a-3c4a-ef71495af7b7@arm.com>
 <20200416145517.GK25745@shell.armlinux.org.uk>
 <010ccb32-42f1-cc32-0527-e608fc91a879@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <010ccb32-42f1-cc32-0527-e608fc91a879-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, "open list:GPIO SUBSYSTEM" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gregory Clement <gregory.clement-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe Kleine-Konig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Thu, Apr 16, 2020 at 04:55:44PM +0100, Robin Murphy wrote:
> On 2020-04-16 3:55 pm, Russell King - ARM Linux admin wrote:
> > On Thu, Apr 16, 2020 at 03:37:40PM +0100, Robin Murphy wrote:
> > > On 2020-04-16 2:50 pm, Andrew Lunn wrote:
> > > [...]
> > > > Clocking with Marvell devices has always been interesting. Core IP
> > > > like this gets reused between different generations of SoCs. The
> > > > original Orion5x had no clock control at all. Latter SoCs have had
> > > > more and more complex clock trees. So care has to be taken to not
> > > > change old behaviour when adding support for new clocks.
> > > 
> > > FWIW, that sounds like a good argument for encoding the clock requirements
> > > of each variant in the of_match_data, so the driver doesn't have to simply
> > > trust the DT and hope.
> > 
> > Please read my patches.  This is exactly what I'm doing.  I'm preserving
> > as closely as possible the current driver behaviour while adding support
> > for the Armada 8040 PWM while keeping compatibility with older DT.
> > 
> > And I'm doing that by keying off the match data, exactly as you're
> > suggesting above.
> 
> AFAICS you're encoding the *PWM capability* in the match data and using that
> to extend the existing behaviour, which comprises using soc_variant to maybe
> treat the stashed error code as fatal somewhere else much later if
> CONFIG_PWM happens to be enabled, and is subtle enough that at least two
> reviewers overlooked or failed to make sense of it.
> 
> Compare and contrast with how self-contained and obvious this is:
> 
> -	mvchip->clk = devm_clk_get(&pdev->dev, NULL);
> -	/* Not all SoCs require a clock.*/
> -	if (!IS_ERR(mvchip->clk))
> -		clk_prepare_enable(mvchip->clk);
> 
> +	/* Not all SoCs require a clock.*/
> +	if (data->needs_clock)
> +		mvchip->clk = devm_clk_get(&pdev->dev, NULL);
> +		if (IS_ERR(mvchip->clk))
> +			return PTR_ERR(mvchip_clk);
> +		clk_prepare_enable(mvchip->clk);
> +	}
> 
> If achieving the same end result by very different and roundabout means
> constitutes "exactly the same thing", does me having written this email mean
> that my house is exactly the same as the Arm office and someone else will be
> along to clean the kitchen shortly? Here's hoping... :D

What if we have a platform where DT mentions the clock, and relies
on it being enabled as per how the driver is coded today?  I don't
know if that's true or not, I don't have the hardware to test.

So, while we can make improvements as you describe above, it's
dangerous to do so because we don't have the information to know
whether what's being proposed is correct or not.  Hence, it's safer
to do the minimum amount of changes, and not do gratuitous potential
regression causing cleanups as you're suggesting.

If we want to clean up the driver in potentially regression causing
ways, that can be done at a later date.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
