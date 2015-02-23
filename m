From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 0/7] Add PWM support to mvebu gpio driver
Date: Mon, 23 Feb 2015 16:48:11 +0100
Message-ID: <20150223154811.GA27057@lunn.ch>
References: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
 <54EB349C.2070700@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:47764 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753046AbbBWPvO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 23 Feb 2015 10:51:14 -0500
Content-Disposition: inline
In-Reply-To: <54EB349C.2070700@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linus.walleij@linaro.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, kaloz@openwrt.org, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org

On Mon, Feb 23, 2015 at 03:09:32PM +0100, Gregory CLEMENT wrote:
> Hi Andrew,
> 
> On 10/01/2015 00:34, Andrew Lunn wrote:
> > This patchset starts out with some cleanups and fixes for the mvebu
> > gpio driver. Then new functionality is added. The Armada 370 and XP
> > SoC has the ability to "blink" the gpio lines at a configuration on
> > and off duration. So simple PWM support is added. However only a
> > single gpio line per gpio chip can be used as a PWM line due to
> > limitations of the hardware. The last patch shows one example of how
> > this could be used, converting a gpio-fan into a pwm-fan, so allowing
> > finer control over its rotation speed, and hence noise. This last
> > patch is not expected to be accepted, since the device is not yet in
> > mainline.
> > 
> > Andrew Lunn (7):
> >   gpio: mvebu: checkpatch fixes
> >   gpio: mvebu: Fix probe cleanup on error
> >   gpio: mvebu: Add limited PWM support
> >   DT: bindings: Extend mvebu gpio documentation with PWM
> >   mvebu: xp: Add pwm properties to .dtsi files
> >   arm: mvebu: Enable PWM in defconfig
> >   mvebu: wrt1900ac: Use pwm-fan rather than gpio-fan
> > 
> 
> What is the status of this series?
> I saw that the 2 first patches have been merged but what about the patch 3 and 4?
> 
> Do you plan to send a new series?

Yes, i plan to rebase onto -rc and resend, addressing the comments i
received.

	Andrew
