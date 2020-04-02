From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle
 struct element
Date: Thu, 02 Apr 2020 09:10:25 +0200
Message-ID: <df9591bd009580842e193f28be1eb75d5af1b9f9.camel@ew.tq-group.com>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
         <20200330130743.GB2431644@ulmo>
         <CAHp75Vc_=czuRtyqgnmnYfie50gDnzrNqq3Bt+Gp_42MikX6VA@mail.gmail.com>
         <20200330160238.GD2817345@ulmo> <20200401163640.GA91358@workstation.tuxnet>
         <20200401174540.GA2978178@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.tq-group.com ([62.157.118.193]:53199 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbgDBHK3 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 2 Apr 2020 03:10:29 -0400
In-Reply-To: <20200401174540.GA2978178@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sven Van Asbroeck <TheSven73@gmail.com>

On Wed, 2020-04-01 at 19:45 +0200, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Wed, Apr 01, 2020 at 06:36:40PM +0200, Clemens Gruber wrote:
> > On Mon, Mar 30, 2020 at 06:02:38PM +0200, Thierry Reding wrote:
> > > On Mon, Mar 30, 2020 at 04:18:22PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Mar 30, 2020 at 4:09 PM Thierry Reding <
> > > > thierry.reding@gmail.com> wrote:
> > > > > 
> > > > > On Wed, Feb 26, 2020 at 02:52:26PM +0100, Matthias Schiffer
> > > > > wrote:
> > > > > > duty_cycle was only set, never read.
> > > > > > 
> > > > > > Signed-off-by: Matthias Schiffer <
> > > > > > matthias.schiffer@ew.tq-group.com>
> > > > > > ---
> > > > > >  drivers/pwm/pwm-pca9685.c | 4 ----
> > > > > >  1 file changed, 4 deletions(-)
> > > > > 
> > > > > Applied, thanks.
> > > > 
> > > > I'm not sure this patch is correct.
> > > 
> > > What makes you say that? If you look at the code, the driver sets
> > > this
> > > field to either 0 or some duty cycle value but ends up never
> > > using it.
> > > Why would it be wrong to remove that code?
> > > 
> > > > We already have broken GPIO in this driver. Do we need more
> > > > breakage?
> > > 
> > > My understanding is that nobody was able to pinpoint exactly when
> > > this
> > > regressed, or if this only worked by accident to begin with. It
> > > sounds
> > > like Clemens has a way of testing this driver, so perhaps we can
> > > solve
> > > that GPIO issue while we're at it.
> > > 
> > > The last discussion on this seems to have been around the time
> > > when you
> > > posted a fix for it:
> > > 
> > >     https://patchwork.ozlabs.org/patch/1156012/
> > > 
> > > But then Sven had concerns that that also wasn't guaranteed to
> > > work:
> > > 
> > >     https://lkml.org/lkml/2019/6/2/73
> > > 
> > > So I think we could either apply your patch to restore the old
> > > behaviour
> > > which I assume you tested, so at least it seems to work in
> > > practice,
> > > even if there's still a potential race that Sven pointed out in
> > > the
> > > above link.
> > > 
> > > I'd prefer something alternative because it's obviously confusing
> > > and
> > > completely undocumented. Mika had already proposed something
> > > that's a
> > > little bit better, though still somewhat confusing.
> > > 
> > > Oh... actually reading further through those threads there seems
> > > to be a
> > > patch from Sven that was reviewed by Mika but then nothing
> > > happened:
> > > 
> > > 	https://lkml.org/lkml/2019/6/4/1039
> > > 
> > > with the corresponding patchwork URL:
> > > 
> > > 	https://patchwork.ozlabs.org/patch/1110083/
> > > 
> > > Andy, Clemens, do you have a way of testing the GPIO
> > > functionality of
> > > this driver? If so, it'd be great if you could check the above
> > > patch
> > > from Sven to fix PWM/GPIO interop.
> > 
> > Looks good. Tested it today and I can no longer reproduce the
> > issues
> > when switching between PWM and GPIO modes.
> > It did not apply cleanly on the current mainline or for-next
> > branch, so
> > I'll send a fixed up version of the patch with my Tested-by tag
> > shortly.
> 
> Awesome, thank you!
> 
> > I noticed an unrelated issue when disabling and enabling the
> > channel
> > though, for which I will either send a patch or maybe try to
> > convert the
> > driver to the atomic API first and then look if it is still a
> > problem.
> > (Issue is that if you disable the channel, the LED_OFF counter is
> > cleared, which means you have to reconfigure the duty cycle after
> > reenabling. It's probably better if only the FULL_OFF bit is
> > toggled in
> > enable/disable as it has precedence over the others anyway and then
> > the
> > previous state would not be changed..?)
> 
> Converting to the atomic API would certainly be beneficial because it
> gives you much more control over what you want to program to
> hardware.
> 
> Other than that, yes, if ->enable() called after ->disable() doesn't
> put
> the PWM into the same state that it was before ->disable(), then
> that'd
> be a bug. From what you're saying this will make the driver only work
> if
> there's a ->config() call after ->disable(). That's wrong.
> 
> So yes, setting only that LED_FULL bit in ->disable() and clearing it
> in
> ->enable() sounds like a better option than the current
> implementation.

I think what you're seeing is the same bug that prompted me to send my
patchset - patch 4/4 moves to the atomic API and changes the logic to
fix the interaction between config() and enable()/disable(). As it
seems like 2/4 will have to be reverted though and my 4/4 depends on
the cleanup of 2/4 and 3/4 (and 3/4 and 4/4 still need some work as
well), feel free to have a jab at the issue yourself, as I don't know
when I'll be able to get back to it.

Thanks,
Matthias


> 
> Thierry
> 
> * Unknown Key
> * 0x7F3EB3A1
