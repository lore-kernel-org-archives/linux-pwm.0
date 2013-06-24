Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v3 11/18] pwm: Add new pwm-samsung driver
Date: Mon, 24 Jun 2013 22:32:55 +0200
Message-ID: <3059286.XLVAQe4lge@flatron>
In-Reply-To: <20130624201326.GB7163@mithrandir>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com> <1888817.YsvuAKkSk2@flatron> <20130624201326.GB7163@mithrandir>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>

On Monday 24 of June 2013 22:13:27 Thierry Reding wrote:
> On Mon, Jun 24, 2013 at 08:31:43PM +0200, Tomasz Figa wrote:
> > On Monday 24 of June 2013 19:49:04 Thierry Reding wrote:
> > > On Tue, Jun 25, 2013 at 12:22:42AM +0900, Kukjin Kim wrote:
[snip]
> > > > 
> > > > Just note, checkpatch complains following, so fixed to use
> > > > pr_warn()
> > > > when I applied.
> > > 
> > > Note that you can't apply patches that touch the PWM tree without my
> > > Ack and I already mentioned that the current way this driver is
> > > written isn't acceptable.
> > > 
> > > So either you fix it properly, or if everybody except me thinks we
> > > don't need a proper design for drivers anymore, then the only way
> > > I'll accept this driver into the PWM tree is if you put a really
> > > big comment at the top of the file saying that the driver is badly
> > > designed on purpose and that people shouldn't be using it as a
> > > reference.
> > 
> > Sorry, I don't understand what problem you have with this design. It
> > completely meets all the requirements applicable on hardware platforms
> > it is (and going to be) used on.
> 
> My main problem with it is that there is no design. And as such it sets
> a bad example. If I accept this into the PWM tree as is then what am I
> supposed to tell the next person that comes up with a similarly broken
> driver?

I wouldn't call it no design. It's a simple (trivial) design.

Simple design is often better than a complex one. In this case it indeed 
is, because it doesn't add code that serves no purpose, without any 
functional drawbacks.

> > The only thing it would do in a suboptimal way would be
> > synchronization of register accesses for multiple instances of the
> > driver - one spinlock would be used for all of them. This is
> > insignificant because there is no time critical code in this driver
> > and it is really unlikely that a SoC with multiple instances of this
> > IP block shows up.
> 
> I've had people give me guarantees that this and that would *never*
> happen only to change their minds 6 months down the road. And again,
> even if it was actually true in this case, it isn't a valid excuse for
> setting a bad example.

Well, even if that happens, there is nothing on the way stopping from 
extending this design with something that will work optimally for multiple 
instances. For all currently supported platforms solution used in this 
series is enough.

> > Channel reservation between clocksource and PWM drivers is completely
> > correct, relying on the fact that the former can only use channels
> > _without_ outputs and the latter can only use channels _with_ outputs.
> > Do I have to add that there can't be a channel both with and without
> > output?
> The issue is that you can't really ensure that both the clocksource and
> PWM drivers use the same variant and therefore might be using different
> masks.

Output mask is _not_ a part of the constant variant data. It is stored in 
the same struct, which is to simplify passing SoC-specific parameters from 
platform code to both drivers, but it is not defined as a constant 
anywhere in drivers.

As I already explained in one of my previous replies, it is either parsed 
from DT (samsung,pwm-outputs property) or passed through the variant 
struct as platform_data from board files. It isn't possible for both 
drivers to get different mask values.

> > So the only place for improvement here, without starting
> > overengineering things, is a comment about the purpose of the
> > spinlock and why it can be used in our case.
> 
> I disagree. You actually even had a version with a halfway decent design
> at some point and it was discarded. I don't think I'm asking for all
> that much here. I even gave you the option of admitting that the driver
> was suboptimal. All I request in return is that you mention that in the
> code so that either somebody else might go and clean things up or at
> least that nobody will copy from a bad example.

What about:

/*
 * PWM block is shared between pwm-samsung and samsung_pwm_timer drivers
 * and some registers need access synchronization. If both drivers are
 * compiled in, the spinlock is defined in the clocksource driver,
 * otherwise following definition is used.
 *
 * Currently we do not need any more complex synchronization method 
 * because all the supported SoCs contain only one instance of the PWM 
 * IP. Should this change, both drivers will need to be modified to
 * properly synchronize accesses to particular instances.
 */

Best regards,
Tomasz
