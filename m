From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Date: Mon, 25 Jan 2016 10:51:20 -0800
Message-ID: <CAD=FV=Xvxeqo3imUmjukC5iYk3EZkrJ04G7C1B-w4xyr-r6-2Q@mail.gmail.com>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
	<2341981.a79ioYM9Es@diego>
	<20151110173416.GB21727@ulmo>
	<CAD=FV=WL3jYEgVe-m6QcAyQwfJgdX4J5OtKisKwyoKOrTSpEQA@mail.gmail.com>
	<20160125170855.GA10182@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34668 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757063AbcAYSvW (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Jan 2016 13:51:22 -0500
Received: by mail-yk0-f177.google.com with SMTP id a85so171964832ykb.1
        for <linux-pwm@vger.kernel.org>; Mon, 25 Jan 2016 10:51:21 -0800 (PST)
In-Reply-To: <20160125170855.GA10182@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, linux-pwm <linux-pwm@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-sunxi@googlegroups.com, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@li>

Hi,

On Mon, Jan 25, 2016 at 9:08 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> I really don't understand this design decision. I presume that the PWM
> controlling this system-critical logic is driven by the SoC? So if the
> regulator is system-critical, doesn't that make it a chicken and egg
> problem? How can the SoC turn the PWM on if it doesn't have power? But
> perhaps I'm completely misunderstanding what you're saying. Perhaps if
> somebody could summarize how exactly this works, it would help better
> understand the requirements or what's the correct thing to do.

Sure, here's how the dang thing works, as I understand it.

First, an overview of PWM regulator in general (maybe you know this,
but to get us on the same page).  There's an external regulator on the
system.  Looking on at least one board I see a TLV62565 specifically.

From the docs of TLV62565, I see it describe the situation as the chip
being able to provide an adjustable output voltage configurable via an
external resistor divider.  In simplified terms words you can adjust
the output voltage of the regulator by tweaking the inputs to one of
its pins.  I'm just a software guy so I can't explain all the details
of it, but the net-net of the situation is is that you can hook this
configuration pin up to the output of a PWM (with a bunch of well
balanced resistors and capacitors) and then you can set the voltage
based on the output of the PWM.


OK, so what happens at bootup?  At bootup most of the pins of the
rk3288 (including the PWM) are configured as inputs with a pull.  The
particular pin hooked up to this PWM has a pulldown.  Remember that
we've got this nicely balanced set of resistors and capacitors hooked
up to the output of our PWM pin?  So what happens when we have this
pin configured as an input?  As I understand it / remember it:

* input w/ no pull: equivalent to 50% duty cycle on the PWM
* input w/ pull down: equivalent to slightly higher voltage than 50%
duty cycle on the PWM
* input w/ pull up: equivalent to slightly lower voltage than 50% duty
cycle on the PWM

On our particular board that means that the rail comes up with roughly
1.1V.  If you drive the PWM at 100% (or set the pin to output high)
you get .86V and if you drive the PWM at 0% (or set the pin to output
low) you get 1.36V.

Now, 1.1V is plenty of voltage to boot the system.  In fact most of
the logic within the SoC can run as low as 0.95V I think.  ...but 0.86
V is not enough to run the logic parts of the system (even at their
default bootup frequencies) 1.1V is _definitely_ not enough to run the
SDRAM memory controller at full speed.


So the bootloader wants to run the system fast so it can boot fast.
It increases the CPU rails (as is typical for a bootloader) and moves
the ARM CPU to 1.8GHz (from the relatively slow boot frequency) and
also raises the logic rail to 1.2V (or I think 1.15 V on systems w/
different memory configs) and inits the SDRAM controller to run at
full speed.  Then it boots Linux.

Note: apparently in U-Boot they actually boot system slower (this was
at least true 1.5 years ago with some reference U-Boot Rockchip
provided).  If I understand correctly they _didn't_ init the SDRAM
controller as full speed in the bootloader and just left the logic
rail at its bootup default.  If everyone had done that then our job
would be "easier" because we wouldn't need to read in the voltage
provided by the bootloader (by reading the PWM and cros-referencing
with our table), though even in that case we'd have to be very careful
not to glitch the line (since .86 V is too low).  Of course all of
those systems are stuck running at a very slow memory speed until
Linux gets DDR Frequency support for Rockchip whereas systems with our
bootloader not only boot faster but also get to use the full memory
speed even without any Linux DDRFreq drivers.


In any case: I think I've demonstrated how a critical system rail can
be using a PWM regulator and how glitching that PWM regulator at boot
time can be catastrophic.  Possibly it's not critical to be able to
"read" the voltage that that bootloader left things configured at
(it's mostly nice for debugging purposes), but it's definitely
important to make sure we don't set it to some default and important
to never glitch it.  Said another way, presumably a DDR Freq driver
would be able to switch the memory controller frequency sanely by
reading the memory controller frequency and using that to figure out
whether it needed to up the logic rail before or after the DDR Freq
change.


>> If there's already been off-list discussion and Boris already knows
>> what the next steps are then my apologies and I'll wait patiently for
>> the next series.  ;)
>
> I don't think we reached a conclusion on this. And to be honest, I'm not
> sure what the right way forward is in this situation. So in order to
> make some forward progress I suggest we start a discussion, hopefully
> that will clarify the situation and help lead to the conclusion. Let me
> recap where we are:
>
> Boris' series has two goals: 1) allow seamless hand-off from firmware to
> kernel of a PWM channel and 2) apply changes to a regulator in a single
> atomic operation. To achieve this the concept of PWM state is introduced
> which encapsulates the settings of a PWM channel. On driver probe the
> current state will be read from hardware and when one or more parameters
> are to be changed, the current state is duplicated, the new values set
> in the state and the new state applied.

At at even higher level the goal is to support PWM regulator for a
system-critical rail without ever glitching.  If we could solve that
problem in some other way that would also be fine too, I think.


> The problem that we've encountered is that since the PWM parameters are
> specified in DT (or board files), there is the possibility of the PWM
> hardware state and the board parameters disagreeing. To resolve such
> situations there must be a point in time where both hardware state and
> software state must be synchronized. Now the most straightforward way to
> do that would be to simply apply the software state and be done with it.
> However the software state initially lacks the duty cycle because it is
> a parameter that usually depends on the use-case (for backlight for
> instance it controls the brightness, for regulators it controls the
> output voltage, ...).

Excuse me for not knowing all details that have been talked about before, but...

A) The software state here is the period and flags (AKA "inverted),
right?  It does seem possible that you could apply the period and
flags while keeping the calculated bootup duty cycle percentage
(presuming that the PWM was actually enabled at probe time and there
was a bootup duty cycle at all).  That would basically say that
whenever you set the period of a PWM then the duty cycle of the PWM
should remain the same percentage.  That actually seems quite sane
IMHO.  It seems much saner than trying to keep the duty cycle "ns"
when the period changes or resetting the PWM to some default when the
period changes.


B) Alternatively, I'd also say that setting a period without a duty
cycle doesn't make a lot of sense.  ...so you could just apply the
period at the same time that you apply the duty cycle the first time.
Presumably you'd want to "lie" to the callers of the PWM subsystem and
tell them that you already changed the period even though the change
won't really take effect until they actually set the duty cycle.  If
anyone cared to find out the true hardware period we could add a new
pwm_get_hw_period().  ...or since the only reason you'd want to know
the hardware period would be if you're trying to read the current duty
cycle percentage, you could instead add "pwm_get_hw_state()" and have
that return both the hardware period ns and duty cycle ns (which is
the most accurate way to return the "percentage" without using fix or
floating point math).


Both of the above options seems like it could be sensible.  The 2nd
seems cleaner because it doesn't require you to recalculate /
approximate the old duty cycle using a new period, but it's slightly
uglier because it no longer returns the true hardware state from
pwm_get_period().


> Applying the software state as-is also means that there's no reason at
> all to read out the hardware state in the first place, because it will
> simply be discarded.

Pretty sure we can't discard the hardware duty cycle at bootup, as per above.


> An alternative would be to discard the software state and trust the
> hardware to be configured correctly. That's somewhat risky because we
> don't know if the hardware is properly configured. Or Linux might have
> different requirements from the firmware and hence needs to configure
> the PWM differently.

Doesn't seem like a good idea either.


> Neither of the above are very attractive options. The best I've been
> able to come up with so far is to completely remove this decision from
> the PWM subsystem and let users handle this. That is, a PWM regulator
> driver would have to have all the knowledge about how to configure the
> PWM for its needs. So upon probe, the PWM regulator driver would inspect
> the current state of the PWM and adjust if necessary, then apply again.
> Ideally of course it wouldn't have to do anything because the hardware
> PWM state would match the software configuration. The idea here is that
> the PWM regulator driver knows exactly what duty cycle to configure to
> obtain the desired output voltage.

I think this is like my suggestion B), right?  AKA the PWM regulator
would be the sole caller of pwm_get_hw_state() and it would use this
to figure out the existing duty cycle percentage.  Then it would
translate that into "ns" and would set the duty cycle.  Upon the first
set of the duty cycle both the period and duty cycle would be applied
at the same time.



> That doesn't really get us closer, though. There is still the issue of
> the user having to deal with two states: the current hardware state and
> the software state as configured in DT or board files.

I think the only users that need to deal with this are one that need a
seamless transition from bootup settings.  Adding a new API call to
support a new feature like this doesn't seem insane, and anyone who
doesn't want this new feature can just never call the new API.

The only thing that would "change" from the point of view of old
drivers is that the PWM period wouldn't change at bootup until the
duty cycle was set.  IMHO this is probably a bug fix.  AKA, for a PWM
backlight, imagine:

1. Firmware sets period to 20000 ns, duty cycle to 8000 ns (40%)
2. Linux boots up and sets period to 10000 ns.  Brightness of
backlight instantly goes to 80%.
3. Eventually something decides to set the backlight duty cycle and it
goes to the proper rate.

Skipping #2 seems like the right move.  ...or did I misunderstand how
something works?


> Like I said, I'm on the fence about this, so I'd appreciate any comments
> and perhaps insight from user subsystem maintainers on how they'd like
> this to look, or how this has been done with other resources (GPIOs,
> ...?)

-Doug
