From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH RFC 2/6] gpio: mvebu: honour EPROBE_DEFER for
 devm_clk_get()
Date: Sun, 29 Mar 2020 14:34:00 +0100
Message-ID: <20200329133400.GA25745@shell.armlinux.org.uk>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <E1jIVU9-0005h4-QU@rmk-PC.armlinux.org.uk>
 <20200329131659.4hbshjst4ccvje2n@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37584 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgC2NeP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Mar 2020 09:34:15 -0400
Content-Disposition: inline
In-Reply-To: <20200329131659.4hbshjst4ccvje2n@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-gpio@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Sun, Mar 29, 2020 at 03:16:59PM +0200, Uwe Kleine-König wrote:
> On Sun, Mar 29, 2020 at 11:48:09AM +0100, Russell King wrote:
> > Honour deferred probing for devm_clk_get() so that we can get the clock
> > for PWM.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/gpio/gpio-mvebu.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> > index fa5641615db6..ee13b11c5298 100644
> > --- a/drivers/gpio/gpio-mvebu.c
> > +++ b/drivers/gpio/gpio-mvebu.c
> > @@ -1132,6 +1132,9 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	mvchip->clk = devm_clk_get(&pdev->dev, NULL);
> > +	if (mvchip->clk == ERR_PTR(-EPROBE_DEFER))
> > +		return -EPROBE_DEFER;
> > +
> >  	/* Not all SoCs require a clock.*/
> >  	if (!IS_ERR(mvchip->clk))
> >  		clk_prepare_enable(mvchip->clk);
> 
> I'd say the following is the right thing to do here:
> 
> 	mvchip->clk = devm_clk_get_optional(...);
> 	if (IS_ERR(mvchip->clk))
> 		return ...

It's not that simple.  The clock is required for Armada 370, and is
optional for Armada 8040.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
