From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: Re: [PATCH v4 2/4] mvebu: xp: Add PWM properties to .dtsi files
Date: Thu, 30 Mar 2017 18:14:49 +0200
Message-ID: <20170330181449.27508830@gmail.com>
References: <20170327194301.1104-1-ralph.sennhauser@gmail.com>
        <20170327194301.1104-3-ralph.sennhauser@gmail.com>
        <87wpb693az.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36441 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933356AbdC3QOz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 Mar 2017 12:14:55 -0400
In-Reply-To: <87wpb693az.fsf@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Imre Kaloz <kaloz@openwrt.org>, Andrew Lunn <andrew@lunn.ch>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 30 Mar 2017 17:45:08 +0200
Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Ralph,
>  
>  On lun., mars 27 2017, Ralph Sennhauser <ralph.sennhauser@gmail.com>
> wrote:
> 
> The title should start by ARM: dts: mvebu:
> 
> If there is no need to have a v5 then I wil take care of modifying the
> title while applying it.

Noted.

> 
> 
> > From: Andrew Lunn <andrew@lunn.ch>
> >
> > Add properties to the GPIO nodes to allow them to be also used as
> > PWM lines.
> >
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > URL: https://patchwork.ozlabs.org/patch/427294/
> > [Ralph Sennhauser:
> >   * Use new compatible string marvell,armada-370-xp-gpio
> >   * Add missing reg-names / #pwm-cell properties to
> > armada-xp-mv78260.dtsi 'gpio1' node]
> > Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> > ---
> >  arch/arm/boot/dts/armada-370.dtsi        | 16 +++++++++++-----
> >  arch/arm/boot/dts/armada-xp-mv78230.dtsi | 14 ++++++++++----
> >  arch/arm/boot/dts/armada-xp-mv78260.dtsi | 16 +++++++++++-----
> >  arch/arm/boot/dts/armada-xp-mv78460.dtsi | 16 +++++++++++-----
> >  4 files changed, 43 insertions(+), 19 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/armada-370.dtsi
> > b/arch/arm/boot/dts/armada-370.dtsi index cc011c8..e30b076 100644
> > --- a/arch/arm/boot/dts/armada-370.dtsi
> > +++ b/arch/arm/boot/dts/armada-370.dtsi
> > @@ -137,29 +137,35 @@
> >  			};
> >  
> >  			gpio0: gpio@18100 {
> > -				compatible = "marvell,orion-gpio";
> > -				reg = <0x18100 0x40>;
> > +				compatible =
> > "marvell,armada-370-xp-gpio";  
> 
> I think we should keep the "marvell,orion-gpio" too because the
> hardware is still compatible with it. Morever it will allow to use a
> recent dtb with an old kernel.

And it will remain compatible. Apart from not collecting compatible
strings there is no reason to drop them right now, so will add them back
for a (possible) v5.

Thanks
Ralph
