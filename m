From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Date: Wed, 3 Feb 2016 15:53:37 +0100
Message-ID: <20160203145337.GD9650@ulmo>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
 <2341981.a79ioYM9Es@diego>
 <20151110173416.GB21727@ulmo>
 <CAD=FV=WL3jYEgVe-m6QcAyQwfJgdX4J5OtKisKwyoKOrTSpEQA@mail.gmail.com>
 <20160125170855.GA10182@ulmo>
 <CAD=FV=Xvxeqo3imUmjukC5iYk3EZkrJ04G7C1B-w4xyr-r6-2Q@mail.gmail.com>
Reply-To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Return-path: <linux-sunxi+bncBDTKFPPJUEHRB45IZC2QKGQE4IDK33Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=Xvxeqo3imUmjukC5iYk3EZkrJ04G7C1B-w4xyr-r6-2Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-pwm <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel@lists>
List-Id: linux-pwm@vger.kernel.org

--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Jan 25, 2016 at 10:51:20AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jan 25, 2016 at 9:08 AM, Thierry Reding
> <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > I really don't understand this design decision. I presume that the PWM
> > controlling this system-critical logic is driven by the SoC? So if the
> > regulator is system-critical, doesn't that make it a chicken and egg
> > problem? How can the SoC turn the PWM on if it doesn't have power? But
> > perhaps I'm completely misunderstanding what you're saying. Perhaps if
> > somebody could summarize how exactly this works, it would help better
> > understand the requirements or what's the correct thing to do.
> 
> Sure, here's how the dang thing works, as I understand it.
> 
> First, an overview of PWM regulator in general (maybe you know this,
> but to get us on the same page).  There's an external regulator on the
> system.  Looking on at least one board I see a TLV62565 specifically.
> 
> From the docs of TLV62565, I see it describe the situation as the chip
> being able to provide an adjustable output voltage configurable via an
> external resistor divider.  In simplified terms words you can adjust
> the output voltage of the regulator by tweaking the inputs to one of
> its pins.  I'm just a software guy so I can't explain all the details
> of it, but the net-net of the situation is is that you can hook this
> configuration pin up to the output of a PWM (with a bunch of well
> balanced resistors and capacitors) and then you can set the voltage
> based on the output of the PWM.
> 
> 
> OK, so what happens at bootup?  At bootup most of the pins of the
> rk3288 (including the PWM) are configured as inputs with a pull.  The
> particular pin hooked up to this PWM has a pulldown.  Remember that
> we've got this nicely balanced set of resistors and capacitors hooked
> up to the output of our PWM pin?  So what happens when we have this
> pin configured as an input?  As I understand it / remember it:
> 
> * input w/ no pull: equivalent to 50% duty cycle on the PWM
> * input w/ pull down: equivalent to slightly higher voltage than 50%
> duty cycle on the PWM
> * input w/ pull up: equivalent to slightly lower voltage than 50% duty
> cycle on the PWM
> 
> On our particular board that means that the rail comes up with roughly
> 1.1V.  If you drive the PWM at 100% (or set the pin to output high)
> you get .86V and if you drive the PWM at 0% (or set the pin to output
> low) you get 1.36V.
> 
> Now, 1.1V is plenty of voltage to boot the system.  In fact most of
> the logic within the SoC can run as low as 0.95V I think.  ...but 0.86
> V is not enough to run the logic parts of the system (even at their
> default bootup frequencies) 1.1V is _definitely_ not enough to run the
> SDRAM memory controller at full speed.
> 
> 
> So the bootloader wants to run the system fast so it can boot fast.
> It increases the CPU rails (as is typical for a bootloader) and moves
> the ARM CPU to 1.8GHz (from the relatively slow boot frequency) and
> also raises the logic rail to 1.2V (or I think 1.15 V on systems w/
> different memory configs) and inits the SDRAM controller to run at
> full speed.  Then it boots Linux.
> 
> Note: apparently in U-Boot they actually boot system slower (this was
> at least true 1.5 years ago with some reference U-Boot Rockchip
> provided).  If I understand correctly they _didn't_ init the SDRAM
> controller as full speed in the bootloader and just left the logic
> rail at its bootup default.  If everyone had done that then our job
> would be "easier" because we wouldn't need to read in the voltage
> provided by the bootloader (by reading the PWM and cros-referencing
> with our table), though even in that case we'd have to be very careful
> not to glitch the line (since .86 V is too low).  Of course all of
> those systems are stuck running at a very slow memory speed until
> Linux gets DDR Frequency support for Rockchip whereas systems with our
> bootloader not only boot faster but also get to use the full memory
> speed even without any Linux DDRFreq drivers.
> 
> 
> In any case: I think I've demonstrated how a critical system rail can
> be using a PWM regulator and how glitching that PWM regulator at boot
> time can be catastrophic.  Possibly it's not critical to be able to
> "read" the voltage that that bootloader left things configured at
> (it's mostly nice for debugging purposes), but it's definitely
> important to make sure we don't set it to some default and important
> to never glitch it.  Said another way, presumably a DDR Freq driver
> would be able to switch the memory controller frequency sanely by
> reading the memory controller frequency and using that to figure out
> whether it needed to up the logic rail before or after the DDR Freq
> change.

Thanks for going into so much detail, this helps a lot in understanding
the actual problem we need to solve.

> > The problem that we've encountered is that since the PWM parameters are
> > specified in DT (or board files), there is the possibility of the PWM
> > hardware state and the board parameters disagreeing. To resolve such
> > situations there must be a point in time where both hardware state and
> > software state must be synchronized. Now the most straightforward way to
> > do that would be to simply apply the software state and be done with it.
> > However the software state initially lacks the duty cycle because it is
> > a parameter that usually depends on the use-case (for backlight for
> > instance it controls the brightness, for regulators it controls the
> > output voltage, ...).
> 
> Excuse me for not knowing all details that have been talked about before, but...
> 
> A) The software state here is the period and flags (AKA "inverted),
> right?  It does seem possible that you could apply the period and
> flags while keeping the calculated bootup duty cycle percentage
> (presuming that the PWM was actually enabled at probe time and there
> was a bootup duty cycle at all).  That would basically say that
> whenever you set the period of a PWM then the duty cycle of the PWM
> should remain the same percentage.  That actually seems quite sane
> IMHO.  It seems much saner than trying to keep the duty cycle "ns"
> when the period changes or resetting the PWM to some default when the
> period changes.

That really depends on the use-case. If you're interested in the output
power of the PWM then, yes, this is sane. But it might not be the right
answer in other cases.

> B) Alternatively, I'd also say that setting a period without a duty
> cycle doesn't make a lot of sense.  ...so you could just apply the
> period at the same time that you apply the duty cycle the first time.
> Presumably you'd want to "lie" to the callers of the PWM subsystem and
> tell them that you already changed the period even though the change
> won't really take effect until they actually set the duty cycle.  If
> anyone cared to find out the true hardware period we could add a new
> pwm_get_hw_period().  ...or since the only reason you'd want to know
> the hardware period would be if you're trying to read the current duty
> cycle percentage, you could instead add "pwm_get_hw_state()" and have
> that return both the hardware period ns and duty cycle ns (which is
> the most accurate way to return the "percentage" without using fix or
> floating point math).

But then you get into a situation where behaviour is dependent on the
PWM driver, whereas this is really very specific to one specific use-
case.

In the end the PWM API is as low-level as it is because it needs to be
flexible enough to cope with other use-cases. In the general case the
simple truth is that it doesn't make sense to set a period without the
duty cycle and vice versa. That's why pwm_config() takes both as input
parameters. The atomic API is going to take that one step further in
that you need to specify the complete state of the PWM when applying.

> Both of the above options seems like it could be sensible.  The 2nd
> seems cleaner because it doesn't require you to recalculate /
> approximate the old duty cycle using a new period, but it's slightly
> uglier because it no longer returns the true hardware state from
> pwm_get_period().
> 
> 
> > Applying the software state as-is also means that there's no reason at
> > all to read out the hardware state in the first place, because it will
> > simply be discarded.
> 
> Pretty sure we can't discard the hardware duty cycle at bootup, as per above.
> 
> 
> > An alternative would be to discard the software state and trust the
> > hardware to be configured correctly. That's somewhat risky because we
> > don't know if the hardware is properly configured. Or Linux might have
> > different requirements from the firmware and hence needs to configure
> > the PWM differently.
> 
> Doesn't seem like a good idea either.
> 
> 
> > Neither of the above are very attractive options. The best I've been
> > able to come up with so far is to completely remove this decision from
> > the PWM subsystem and let users handle this. That is, a PWM regulator
> > driver would have to have all the knowledge about how to configure the
> > PWM for its needs. So upon probe, the PWM regulator driver would inspect
> > the current state of the PWM and adjust if necessary, then apply again.
> > Ideally of course it wouldn't have to do anything because the hardware
> > PWM state would match the software configuration. The idea here is that
> > the PWM regulator driver knows exactly what duty cycle to configure to
> > obtain the desired output voltage.
> 
> I think this is like my suggestion B), right?  AKA the PWM regulator
> would be the sole caller of pwm_get_hw_state() and it would use this
> to figure out the existing duty cycle percentage.  Then it would
> translate that into "ns" and would set the duty cycle.  Upon the first
> set of the duty cycle both the period and duty cycle would be applied
> at the same time.

Yes and no. I think the PWM regulator would need to get the current
hardware state and derive the output power from duty cycle and period.
It would then need to rescale to whatever new period it wants to use
to ensure the same output power is used.

> > That doesn't really get us closer, though. There is still the issue of
> > the user having to deal with two states: the current hardware state and
> > the software state as configured in DT or board files.
> 
> I think the only users that need to deal with this are one that need a
> seamless transition from bootup settings.  Adding a new API call to
> support a new feature like this doesn't seem insane, and anyone who
> doesn't want this new feature can just never call the new API.
> 
> The only thing that would "change" from the point of view of old
> drivers is that the PWM period wouldn't change at bootup until the
> duty cycle was set.  IMHO this is probably a bug fix.  AKA, for a PWM
> backlight, imagine:
> 
> 1. Firmware sets period to 20000 ns, duty cycle to 8000 ns (40%)
> 2. Linux boots up and sets period to 10000 ns.  Brightness of
> backlight instantly goes to 80%.
> 3. Eventually something decides to set the backlight duty cycle and it
> goes to the proper rate.
> 
> Skipping #2 seems like the right move.  ...or did I misunderstand how
> something works?

I'm not aware of any code in the PWM subsystem that would do this
automatically. If you don't call any of the pwm_*() functions the
hardware state should not be modified. The responsibility is with
the user drivers.

That is, it is up to the regulator or backlight driver to apply any new
configuration to a PWM channel on boot, or leave it as is. For
backlight it's probably fine to simply apply some default, since having
the brightness change on boot isn't going to be terribly irritating.

With the atomic API it would be possible to avoid even this and have the
backlight driver simply read out the current hardware state and apply an
equivalent brightness even if the period changed.

For the regulator case you'd need to read out the current state and then
recompute the values that will yield the same output power given data
specified in DT. I think that much is already implemented in Boris'
series, and it's really only the details that are being debated.

The problematic issue is still that we might have a disparity between
the current hardware state and the state initially specified by DT. In
the general case the DT will specify the period and polarity of the PWM
signal and leave it up to the user driver to determine what a correct
duty cycle would be. With the atomic API we'll essentially have two
states: the current (hardware) state and the "initial" state, which is
what an OS will see as the state to apply. The problem now is that once
you have applied the initial state with a duty cycle you've determined,
there is no longer a need to keep it around. But there's also no way to
know when this is the case. So the controversial part about all this is
when to start using the current state rather that the initial state.

The most straightforward way to solve this would be to apply the initial
configuration on driver probe. That is, when the pwm-regulator driver
gets probed it would retrieve the current and initial states, then
adjust the current state such that it matches the initial state but with
a duty cycle that yields the same output power as the current state, and
finally apply the new state. After that, every regulator_set_voltage()
call could simply operate on the current state and adjust the duty cycle
exclusively.

Does that sound reasonable?

Thierry
--uxuisgdDHaNETlh8--
