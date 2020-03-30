From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: (EXT) Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle
 struct element
Date: Mon, 30 Mar 2020 17:12:31 +0200
Message-ID: <20200330151231.GA1650@workstation.tuxnet>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226151034.7i3h5blmrwre2yzg@pengutronix.de>
 <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([52.59.78.55]:57178 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgC3PMe (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 30 Mar 2020 11:12:34 -0400
Content-Disposition: inline
In-Reply-To: <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com

Hi,

On Wed, Feb 26, 2020 at 06:03:02PM +0100, Matthias Schiffer wrote:
> As it turns out, this driver is broken in yet another way I didn't find
> before: For changing the global prescaler the chip needs to be put into
> sleep mode, but the driver doesn't follow the restart sequence
> described in the datasheet when waking it back up. In consequence,
> changing the period of one PWM does not only modify the period of all
> PWMs (which is bad enough, but can't be avoided with this hardware),
> but it also leaves all PWMs disabled...

I am unable to reproduce this: If I set a specific duty cycle on a
channel and then change the period, the channel stays active.
I can see the brightness of an LED decrease if I increase the period.

This is expected, because after the SLEEP bit is set, we wait for
500usecs and then write to the LED ON/OFF registers.
This leaves the channel enabled with the new period (but with old
duty_ns value => different ratio)

A few years ago, I played around with the idea of remembering the
duty_ns to period_ns ratio and setting it accordingly after a period
change, possibly also with a shortcut of setting the RESTART bit if the
ratio did not change. Maybe after the switch to the atomic API, this
would be a nice improvement.

Best regards,
Clemens
