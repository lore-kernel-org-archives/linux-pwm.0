From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: (EXT) Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle
 struct element
Date: Fri, 3 Apr 2020 19:47:58 -0400
Message-ID: <CAGngYiUinGeppRdnsWvX4DBLVcHFBSGWamUKdTC+rTY3kpFWcQ@mail.gmail.com>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226151034.7i3h5blmrwre2yzg@pengutronix.de> <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43902 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgDCXsL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Apr 2020 19:48:11 -0400
In-Reply-To: <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Clemens Gruber <clemens.gruber@pqgruber.com>

On Wed, Feb 26, 2020 at 12:04 PM Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> >  - Is this racy somehow (i.e. can it happen that when going from
> >    duty_cycle/period = 1000/5000 to duty_cycle/period = 4000/10000
> > the
> >    output is 1000/10000 (or 4000/5000) for one cycle)?
>
> It currently is racy. It should be possible to fix that either by
> updating all 4 registers in a single I2C write, or by using the "update
> on ACK" mode which requires all 4 registers to be updated before the
> new setting is applied (I'm not sure if this mode would require using a
> single I2C write as well though).

Matthias, did you verify experimentally that changing the period is racy?

Looking at the datasheet and driver code, it shouldn't be. This is because
the OFF time is set as a proportion of the counter range. When the period
changes from 5000 to 10000, then 5000*20%/5000 and 10000*20%/10000
will result in the same 20% ratio (disregarding rounding errors).

This is documented at the beginning of the driver:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pwm/pwm-pca9685.c?h=v5.6#n25

Should we move that comment to pwm_config(), so future versions of
ourselves won't overlook it?
