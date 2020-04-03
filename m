From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: (EXT) Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle
 struct element
Date: Fri, 3 Apr 2020 19:50:07 -0400
Message-ID: <CAGngYiUe-tihBJUcXQ738_5aA9pzgp_-NSs4iCrz3eWO6rMukA@mail.gmail.com>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226151034.7i3h5blmrwre2yzg@pengutronix.de> <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
 <20200330151231.GA1650@workstation.tuxnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36779 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgDCXuS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Apr 2020 19:50:18 -0400
In-Reply-To: <20200330151231.GA1650@workstation.tuxnet>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

On Mon, Mar 30, 2020 at 11:12 AM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> On Wed, Feb 26, 2020 at 06:03:02PM +0100, Matthias Schiffer wrote:
> > As it turns out, this driver is broken in yet another way I didn't find
> > before: For changing the global prescaler the chip needs to be put into
> > sleep mode, but the driver doesn't follow the restart sequence
> > described in the datasheet when waking it back up. In consequence,
> > changing the period of one PWM does not only modify the period of all
> > PWMs (which is bad enough, but can't be avoided with this hardware),
> > but it also leaves all PWMs disabled...
>
> I am unable to reproduce this: If I set a specific duty cycle on a
> channel and then change the period, the channel stays active.
> I can see the brightness of an LED decrease if I increase the period.

What happens when pwm channels 0 and 1 are both enabled, and
you change the pwm period of channel 0. Does channel 1 remain
on?
