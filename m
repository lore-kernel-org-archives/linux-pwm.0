From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH RFC 0/6] PWM fan support on Clearfog gt8k
Date: Thu, 16 Apr 2020 15:55:17 +0100
Message-ID: <20200416145517.GK25745@shell.armlinux.org.uk>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <CACRpkdaL4-Z36aKOVW4o2MtCG9fbqm4gxZN3QjejVRPBZrzxxA@mail.gmail.com>
 <20200416135039.GL657811@lunn.ch>
 <5c7cb0ff-bf49-640a-3c4a-ef71495af7b7@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5c7cb0ff-bf49-640a-3c4a-ef71495af7b7@arm.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Gregory Clement <gregory.clement@bootlin.com>, linux-pwm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, Apr 16, 2020 at 03:37:40PM +0100, Robin Murphy wrote:
> On 2020-04-16 2:50 pm, Andrew Lunn wrote:
> [...]
> > Clocking with Marvell devices has always been interesting. Core IP
> > like this gets reused between different generations of SoCs. The
> > original Orion5x had no clock control at all. Latter SoCs have had
> > more and more complex clock trees. So care has to be taken to not
> > change old behaviour when adding support for new clocks.
> 
> FWIW, that sounds like a good argument for encoding the clock requirements
> of each variant in the of_match_data, so the driver doesn't have to simply
> trust the DT and hope.

Please read my patches.  This is exactly what I'm doing.  I'm preserving
as closely as possible the current driver behaviour while adding support
for the Armada 8040 PWM while keeping compatibility with older DT.

And I'm doing that by keying off the match data, exactly as you're
suggesting above.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
