From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] pwm: mxs: set pwm_chip can_sleep flag
Date: Wed, 9 Apr 2014 09:39:14 +0100
Message-ID: <20140409083914.GN16119@n2100.arm.linux.org.uk>
References: <1396956597-26159-1-git-send-email-shawn.guo@freescale.com> <5343FDD3.3070308@i2se.com> <20140408141832.GA8861@piout.net> <53442997.70209@i2se.com> <20140408231654.GA13898@piout.net> <20140408234418.GL16119@n2100.arm.linux.org.uk> <20140409034115.GB2611@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:54660 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932358AbaDIIjt (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Apr 2014 04:39:49 -0400
Content-Disposition: inline
In-Reply-To: <20140409034115.GB2611@dragon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Stefan Wahren <stefan.wahren@i2se.com>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>

On Wed, Apr 09, 2014 at 11:41:17AM +0800, Shawn Guo wrote:
> On Wed, Apr 09, 2014 at 12:44:18AM +0100, Russell King - ARM Linux wrote:
> > On Wed, Apr 09, 2014 at 01:16:54AM +0200, Alexandre Belloni wrote:
> > > I'm not home, else I'll try on my i.mx28 boards...
> > 
> > I just tried heartbeat here, on iMX6, and it works fine.  That's with this
> > in the DT:
> 
> FYI. i.MX28 is known as 'mxs' sub-architecture and uses pwm-mxs driver
> rather than pwm-imx which is the one for i.MX6.

My point being by doing the above test is that the pwm_disable() call
in leds-pwm works correctly with iMX6 and the "troublesome" active-low
flag set at the leds-pwm level.

It wouldn't work on iMX6 if you tried to use the broken inversion on the
PWM output - it would have exactly the effects being reported on iMX28
as setting a duty of 100% would pull the signal low and disabling the PWM
will also pull the signal low (which are the two states heartbeat uses.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
