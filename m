From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH RFC 0/6] PWM fan support on Clearfog gt8k
Date: Thu, 16 Apr 2020 18:49:44 +0200
Message-ID: <20200416164944.GS657811@lunn.ch>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <CACRpkdaL4-Z36aKOVW4o2MtCG9fbqm4gxZN3QjejVRPBZrzxxA@mail.gmail.com>
 <20200416135039.GL657811@lunn.ch>
 <5c7cb0ff-bf49-640a-3c4a-ef71495af7b7@arm.com>
 <20200416144231.GP657811@lunn.ch>
 <628cde2b-0e1b-4c07-4321-8b23d0b34384@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([185.16.172.187]:42144 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgDPQtx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 16 Apr 2020 12:49:53 -0400
Content-Disposition: inline
In-Reply-To: <628cde2b-0e1b-4c07-4321-8b23d0b34384@arm.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Gregory Clement <gregory.clement@bootlin.com>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, linux-pwm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> > It is not really hope. It is very obvious when it is wrong, the whole
> > machine stops dead when you are missing a clock. Very simple to test.
> 
> Heh, that's still what I meant - the driver hopes that carrying on will be
> OK, and the end user is left to pick up the pieces when it isn't ;)

> Obviously that's less of an issue when said end-user is a kernel developer
> making a controlled change during SoC bringup, but perhaps more so for an
> eager inexperienced hacker cobbling together DTS fragments to convince a
> distro kernel to boot on some embedded device

Clocks are SoC level stuff, so it is in the DTSI file, not the DTS
file. An eager inexperienced hacker cobbling together DTS fragment is
not effected. Experienced kernel hackers have put together the DTSI
file and tested it. And if an eager inexperienced hacker does touch
the DTSI file, they probably deserve to get their finger burnt, and
will get a step closer to become an experience kernel hacker.

     Andrew
