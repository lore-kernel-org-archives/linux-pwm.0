Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v3 11/18] pwm: Add new pwm-samsung driver
Date: Mon, 24 Jun 2013 23:17:03 +0200
Message-ID: <1405696.in3RSSDWnX@flatron>
In-Reply-To: <20130624205342.GE7163@mithrandir>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com> <3059286.XLVAQe4lge@flatron> <20130624205342.GE7163@mithrandir>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>

On Monday 24 of June 2013 22:53:42 Thierry Reding wrote:
> On Mon, Jun 24, 2013 at 10:32:55PM +0200, Tomasz Figa wrote:
> > On Monday 24 of June 2013 22:13:27 Thierry Reding wrote:
> > > On Mon, Jun 24, 2013 at 08:31:43PM +0200, Tomasz Figa wrote:
> [...]
> 
> > > > Channel reservation between clocksource and PWM drivers is
> > > > completely
> > > > correct, relying on the fact that the former can only use channels
> > > > _without_ outputs and the latter can only use channels _with_
> > > > outputs.
> > > > Do I have to add that there can't be a channel both with and
> > > > without
> > > > output?
> > > 
> > > The issue is that you can't really ensure that both the clocksource
> > > and
> > > PWM drivers use the same variant and therefore might be using
> > > different
> > > masks.
> > 
> > Output mask is _not_ a part of the constant variant data. It is stored
> > in the same struct, which is to simplify passing SoC-specific
> > parameters from platform code to both drivers, but it is not defined
> > as a constant anywhere in drivers.
> > 
> > As I already explained in one of my previous replies, it is either
> > parsed from DT (samsung,pwm-outputs property) or passed through the
> > variant struct as platform_data from board files. It isn't possible
> > for both drivers to get different mask values.
> 
> But samsung_pwm_set_platdata() and samsung_pwm_clocksource_init() can
> still be called with different variants, can't they?

Sure, they can be, but the question is who would even want to call them 
this way? We are on kernel level, we have assumptions here and we don't 
break those assumptions.

> Furthermore the
> variants aren't read-only and therefore can be modified at any point in
> time. So it is indeed possible for them to get different mask values.

Again, who would be willing to do something like this? We are not in 
userspace.

> Granted, it may be unlikely that they will but it wouldn't be all that
> difficult to write the driver in a way to make it really impossible and
> at the same time make sure that both driver share the same variant
> information.

Sure, it wouldn't. If I'm not mistaken, I already acomplished this in one 
or two of the versions I posted long time ago, but was it really worth all 
the added drawbacks?

Keep in mind that originally, when I started my work on this, I thought 
exactly the same as you - let's design something scalable and sane. 
However, sometimes it's necessary to ask the question if that's really 
what is needed.

> > > > So the only place for improvement here, without starting
> > > > overengineering things, is a comment about the purpose of the
> > > > spinlock and why it can be used in our case.
> > > 
> > > I disagree. You actually even had a version with a halfway decent
> > > design at some point and it was discarded. I don't think I'm asking
> > > for all that much here. I even gave you the option of admitting
> > > that the driver was suboptimal. All I request in return is that you
> > > mention that in the code so that either somebody else might go and
> > > clean things up or at least that nobody will copy from a bad
> > > example.
> > 
> > What about:
> > 
> > /*
> > 
> >  * PWM block is shared between pwm-samsung and samsung_pwm_timer
> >  drivers
> >  * and some registers need access synchronization. If both drivers are
> >  * compiled in, the spinlock is defined in the clocksource driver,
> >  * otherwise following definition is used.
> >  *
> >  * Currently we do not need any more complex synchronization method
> >  * because all the supported SoCs contain only one instance of the PWM
> >  * IP. Should this change, both drivers will need to be modified to
> >  * properly synchronize accesses to particular instances.
> >  */
> 
> I see that you can't be persuaded. And everybody else seems to be okay
> with it so... have it your way. I'm probably going to regret this.

This was just a proposal. Do you want anything else to be added to the 
comment or anything to be changed?

Sure, an alternative would be getting rid of the hacky shared spinlock, 
but do we really need that? Do we really want to have something in the 
kernel that we don't need? I'm just trying to avoid this.

Best regards,
Tomasz
