From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH RFC 0/6] PWM fan support on Clearfog gt8k
Date: Thu, 16 Apr 2020 15:29:44 +0100
Message-ID: <20200416142944.GH25745@shell.armlinux.org.uk>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <CACRpkdaL4-Z36aKOVW4o2MtCG9fbqm4gxZN3QjejVRPBZrzxxA@mail.gmail.com>
 <20200416135039.GL657811@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200416135039.GL657811@lunn.ch>
Sender: linux-gpio-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-pwm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

On Thu, Apr 16, 2020 at 03:50:39PM +0200, Andrew Lunn wrote:
> On Thu, Apr 16, 2020 at 09:51:37AM +0200, Linus Walleij wrote:
> > On Sun, Mar 29, 2020 at 12:46 PM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > 
> > > This series adds support for the fan PWM output on the Clearfog GT8K
> > > platform, and can potentially be extended to the Macchiatobin.
> > 
> > The gpio changes all look fine to me +/- fixes for review comments.
> > 
> > Could the MVEBU maintainers provide some feedback?
> 
> Hi Linus
> 
> I took a quick look at this when it was first posted. I also wrote the
> PWM support in this driver. The hardware is mostly a GPIO driver, but
> it has some basic PWM facilities. It is not possible to cleanly split
> it into two drivers, which is why it has the current structure. And
> the PWM maintainers ask that the PWM parts be listed in MAINTAINERS as
> such, so they got to know about any changes.
> 
> Clocking with Marvell devices has always been interesting. Core IP
> like this gets reused between different generations of SoCs. The
> original Orion5x had no clock control at all. Latter SoCs have had
> more and more complex clock trees. So care has to be taken to not
> change old behaviour when adding support for new clocks. So Russell
> 2/6 patch looks good to me, and Uwe request could break on some
> SoCs. It would need testing on a lot of SoCs, with and without PWM
> support. 
> 
> I assume Russell will at some point repost without the RFC tag. At
> that point i will take a second look and add Reviewed-by.

I said in the cover message "The cooling maps are experimental".
They work reasonably well for me with the fan I have (a noctua fan)
but other people may find them to be problematical, so one of the
reasons for sending it as RFC is to get people to test and see how
well it works.

I may have had greater success getting people to test if I'd added
maps for the Macchiatobin, but that wasn't my target system. That's
relatively easy to do - it's the same pin as on the gt8k, so merely
putting the same DT changes onto Macchiatobin would allow testing
with those settings.

Whether that's correct for my Macchiatobin server setup is an
entirely separate problem - where the fan PWM controls front panel
fans and there's a bigger fanless heatsink on the Armada 8040 (as
per the first revision of the Macchiatobin boards).  As the boards
ship without a PWM controllable fan, it would be of limited use.

So, really, I think the DT configuration of the PWM parameters is
"for the user" and not actually for mainline kernels - which
brings with it the problems of understanding control systems,
stability of such systems, feedback, and how to configure the
thermal subsystem... which is not easy.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
