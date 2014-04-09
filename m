From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] pwm: mxs: set pwm_chip can_sleep flag
Date: Wed, 9 Apr 2014 11:41:17 +0800
Message-ID: <20140409034115.GB2611@dragon>
References: <1396956597-26159-1-git-send-email-shawn.guo@freescale.com>
 <5343FDD3.3070308@i2se.com>
 <20140408141832.GA8861@piout.net>
 <53442997.70209@i2se.com>
 <20140408231654.GA13898@piout.net>
 <20140408234418.GL16119@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:4135
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932465AbaDIDlg (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Apr 2014 23:41:36 -0400
Content-Disposition: inline
In-Reply-To: <20140408234418.GL16119@n2100.arm.linux.org.uk>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Stefan Wahren <stefan.wahren@i2se.com>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>

On Wed, Apr 09, 2014 at 12:44:18AM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 09, 2014 at 01:16:54AM +0200, Alexandre Belloni wrote:
> > I'm not home, else I'll try on my i.mx28 boards...
> 
> I just tried heartbeat here, on iMX6, and it works fine.  That's with this
> in the DT:

FYI. i.MX28 is known as 'mxs' sub-architecture and uses pwm-mxs driver
rather than pwm-imx which is the one for i.MX6.

Shawn

