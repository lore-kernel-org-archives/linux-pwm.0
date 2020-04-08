From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: Re: (EXT) Re: (EXT) Re: [PATCH 1/4] pwm: pca9685: remove unused
 duty_cycle struct element
Date: Wed, 08 Apr 2020 10:00:22 +0200
Message-ID: <405fa9612b52ee9a7c550d2ac5a2df86acb223c1.camel@ew.tq-group.com>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
         <20200226151034.7i3h5blmrwre2yzg@pengutronix.de>
         <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
         <CAGngYiUinGeppRdnsWvX4DBLVcHFBSGWamUKdTC+rTY3kpFWcQ@mail.gmail.com>
         <3ec5c2bd67cd714f86178a1e7143cd247759aaf8.camel@ew.tq-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.tq-group.com ([62.157.118.193]:52846 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgDHIA1 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 8 Apr 2020 04:00:27 -0400
In-Reply-To: <3ec5c2bd67cd714f86178a1e7143cd247759aaf8.camel@ew.tq-group.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Clemens Gruber <clemens.gruber@pqgruber.com>

On Tue, 2020-04-07 at 16:46 +0200, Matthias Schiffer wrote:
> On Fri, 2020-04-03 at 19:47 -0400, Sven Van Asbroeck wrote:
> > On Wed, Feb 26, 2020 at 12:04 PM Matthias Schiffer
> > <matthias.schiffer@ew.tq-group.com> wrote:
> > > 
> > > >  - Is this racy somehow (i.e. can it happen that when going
> > > > from
> > > >    duty_cycle/period = 1000/5000 to duty_cycle/period =
> > > > 4000/10000
> > > > the
> > > >    output is 1000/10000 (or 4000/5000) for one cycle)?
> > > 
> > > It currently is racy. It should be possible to fix that either by
> > > updating all 4 registers in a single I2C write, or by using the
> > > "update
> > > on ACK" mode which requires all 4 registers to be updated before
> > > the
> > > new setting is applied (I'm not sure if this mode would require
> > > using a
> > > single I2C write as well though).
> > 
> > Matthias, did you verify experimentally that changing the period is
> > racy?
> > 
> > Looking at the datasheet and driver code, it shouldn't be. This is
> > because
> > the OFF time is set as a proportion of the counter range. When the
> > period
> > changes from 5000 to 10000, then 5000*20%/5000 and 10000*20%/10000
> > will result in the same 20% ratio (disregarding rounding errors).
> > 
> > This is documented at the beginning of the driver:
> > 
> 
> 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pwm/pwm-pca9685.c?h=v5.6#n25
> > 
> > Should we move that comment to pwm_config(), so future versions of
> > ourselves won't overlook it?
> 
> You are right, this results in the same ratio - the absolute on/off
> times may be wrong for a moment though when the period is changed.
> 
> In the attached image, I have changed the period, but kept the
> absolute
> duty cycle fixed (note: this is in inverted mode, so the duty cycle
> controls the low time). It can be seen that after a too long high
> time
> (chip is in sleep mode) one period with too long low time follows
> (new
> period, old relative duty cycle), before the counter is reprogrammed
> to
> match the previous absolute duty cycle.
> 
> I don't care too much about the details of the behaviour, as I only
> control LEDs using this chip and don't need to change the period
> after
> initial setup, but we should accurately document the shortcomings of
> the hardware and the driver (when we have decided how to fix some of
> the driver issues).
> 
> Matthias

And another kind of race condition that should be possible, although I
haven't seen it in practice:

High and low bits of the OFF counter currently aren't programmed
atomically, so with unlucky timing we get a cycle using new lower 8
bits with old upper 4 bits of the duty cycle.
