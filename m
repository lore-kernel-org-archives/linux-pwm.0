From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH 2/2] pwm: pca9685: fix prescaler initialization
Date: Thu, 19 Jan 2017 15:49:25 +0100
Message-ID: <20170119144925.GA1660@archie.localdomain>
References: <20161213155251.28684-1-clemens.gruber@pqgruber.com>
 <20161213155251.28684-2-clemens.gruber@pqgruber.com>
 <20170118105735.GM18989@ulmo.ba.sec>
 <1484737764.2133.193.camel@linux.intel.com>
 <20170118135325.GA2498@archie.localdomain>
 <1484748118.2133.206.camel@linux.intel.com>
 <20170118142533.GA17640@archie.localdomain>
 <1484829279.2133.236.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([178.189.19.235]:15133 "EHLO
        mail.pqgruber.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752656AbdASOvh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Jan 2017 09:51:37 -0500
Content-Disposition: inline
In-Reply-To: <1484829279.2133.236.camel@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Thu, Jan 19, 2017 at 02:34:39PM +0200, Andy Shevchenko wrote:
> On Wed, 2017-01-18 at 15:25 +0100, Clemens Gruber wrote:
> > Yes, that's what this patch tries to solve by verifying that the
> > external setting (the prescale register) is set to its hardware
> > default
> > value of 0x1E (corresponding to a period of 1/200 Hz).
> > If it is not 0x1E, the driver will reconfigure the prescaler according
> > to the desired period at the time of the next configuration.
> 
> Yes, and my question is what is possible go wrong if you just enforce
> prescaler to be 1/200Hz?

If we enforce a default of 1 / 200 Hz, we have to go through the SLEEP
mode and udelay for 0.5ms once for our default and then again for the
user, if he does not want a period of 1 / 200 Hz.
-> Number of prescaler changes: 1 or 2

I think it is better as it is now + my patch applied: We verify if the
prescaler is already set to 1 / 200 Hz.
Then, as soon as the user configures his PWM channels, we either do not
have to change the prescaler at all (if he wants 1 / 200 Hz) or do it
once at the time of configuration.
-> Number of prescaler changes: 0 or 1

What's the advantage of enforcing the prescaler to 1 / 200 Hz in the
probe function when we do not know yet if 1 / 200 Hz is the period the
user is going to configure?

Thanks,
Clemens
