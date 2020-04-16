From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH RFC 0/6] PWM fan support on Clearfog gt8k
Date: Thu, 16 Apr 2020 15:53:52 +0100
Message-ID: <20200416145352.GJ25745@shell.armlinux.org.uk>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <CACRpkdaL4-Z36aKOVW4o2MtCG9fbqm4gxZN3QjejVRPBZrzxxA@mail.gmail.com>
 <20200416081412.GG25745@shell.armlinux.org.uk>
 <CACRpkdYFBGvQX3i4P1+cF5ExXOSKieT6cJNPTNuKFxEhtJVEjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729215AbgDPOyF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Apr 2020 10:54:05 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdYFBGvQX3i4P1+cF5ExXOSKieT6cJNPTNuKFxEhtJVEjQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, linux-pwm@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Thu, Apr 16, 2020 at 02:08:36PM +0200, Linus Walleij wrote:
> On Thu, Apr 16, 2020 at 10:14 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> > On Thu, Apr 16, 2020 at 09:51:37AM +0200, Linus Walleij wrote:
> 
> > > The gpio changes all look fine to me +/- fixes for review comments.
> >
> > I think Uwe is incorrect for his GPIO comments; the clock is only
> > optional on A8040.  We know this because A8040 has worked fine
> > without PWM support without the clock, whereas for Armada 370,
> > the driver has hard-failed if the clock is not present.
> 
> It's fine. You are running the hardware and it should work for you.
> I usually go by the IETF motto "rough consensus and running code".
> 
> > About the only change I would make is to move the check introduced
> > in patch 2 into patch 3 instead, inside the MVEBU_PWM_SOC_VARIANT_A8K
> > case, so that deferring for the clock works (which is necessary for
> > the PWM driver to be useful.)
> 
> OK let's go with this.

Well, it turns out to not be particularly nice to do that.  The best
I can come up with is:

        mvchip->clk = devm_clk_get(&pdev->dev, NULL);
        if (soc_variant->pwm && IS_ENABLED(CONFIG_PWM) &&
            mvchip->clk == ERR_PTR(-EPROBE_DEFER))
                return -EPROBE_DEFER;

Doing it in mvebu_pwm_probe() means that we have to deal with unwinding
the very complex probing (tearing down all the interrupt functionality
and GPIO stuff) which the driver currently does not do, even on failure.

Is this a shoddy driver that doesn't clean up after itself...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
