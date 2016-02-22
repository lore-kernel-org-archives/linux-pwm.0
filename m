From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Date: Mon, 22 Feb 2016 18:59:29 +0100
Message-ID: <20160222175929.GA23899@ulmo>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
 <2341981.a79ioYM9Es@diego>
 <20151110173416.GB21727@ulmo>
 <CAD=FV=WL3jYEgVe-m6QcAyQwfJgdX4J5OtKisKwyoKOrTSpEQA@mail.gmail.com>
 <20160125170855.GA10182@ulmo>
 <CAD=FV=Xvxeqo3imUmjukC5iYk3EZkrJ04G7C1B-w4xyr-r6-2Q@mail.gmail.com>
 <20160203145337.GD9650@ulmo>
 <CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ@mail.gmail.com>
Reply-To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-sunxi+bncBDTKFPPJUEHRBBEZVW3AKGQESAJQ6PY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Feb 03, 2016 at 11:04:20AM -0800, Doug Anderson wrote:
> Thierry
> 
> On Wed, Feb 3, 2016 at 6:53 AM, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> A) The software state here is the period and flags (AKA "inverted),
> >> right?  It does seem possible that you could apply the period and
> >> flags while keeping the calculated bootup duty cycle percentage
> >> (presuming that the PWM was actually enabled at probe time and there
> >> was a bootup duty cycle at all).  That would basically say that
> >> whenever you set the period of a PWM then the duty cycle of the PWM
> >> should remain the same percentage.  That actually seems quite sane
> >> IMHO.  It seems much saner than trying to keep the duty cycle "ns"
> >> when the period changes or resetting the PWM to some default when the
> >> period changes.
> >
> > That really depends on the use-case. If you're interested in the output
> > power of the PWM then, yes, this is sane. But it might not be the right
> > answer in other cases.
> 
> Ah, I see.  You're envisioning a device where active time in "ns" is
> more important than the percentage of active time.  Perhaps an LED
> where it's more important to have it on for no more than .1 seconds
> (so we don't drive it too long and burn it out?).  If we slowed down
> the duty cycle and adjusted the period to match, we could get into a
> bad state.

Yes. Granted, the vast majority of users is not in this category, but
it's something that has been brought to my attention in the past and it
works fine with the current API.

> >> B) Alternatively, I'd also say that setting a period without a duty
> >> cycle doesn't make a lot of sense.  ...so you could just apply the
> >> period at the same time that you apply the duty cycle the first time.
> >> Presumably you'd want to "lie" to the callers of the PWM subsystem and
> >> tell them that you already changed the period even though the change
> >> won't really take effect until they actually set the duty cycle.  If
> >> anyone cared to find out the true hardware period we could add a new
> >> pwm_get_hw_period().  ...or since the only reason you'd want to know
> >> the hardware period would be if you're trying to read the current duty
> >> cycle percentage, you could instead add "pwm_get_hw_state()" and have
> >> that return both the hardware period ns and duty cycle ns (which is
> >> the most accurate way to return the "percentage" without using fix or
> >> floating point math).
> >
> > But then you get into a situation where behaviour is dependent on the
> > PWM driver, whereas this is really very specific to one specific use-
> > case.
> 
> This is because only some drivers would be able to read the hardware
> state?  I'm not sure how we can get away from that.  In all proposals
> we've talked about (including what you propose below, right?) the PWM
> regulator will need a PWM driver that can read hardware state.  Only
> PWM drivers that have been upgraded to support reading hardware state
> can use the PWM regulator (or at least only those drivers will be able
> to use the PWM regulator glitch-free).

Yes, the key here is glitch-free. There's no reason whatsoever that the
rugaltor-pwm driver should be limited to usage with a hardware readout-
capable PWM driver. If you don't care about glitches, likely because no
critical components depend on the regulator, you can simply force what
state you choose on boot.

As a matter of fact, I think that's how regulators work already. If the
current output voltage doesn't match the specified constraints, then a
valid value will be forced by the regulator core. If the voltage lies
within the constraints the core won't touch the regulator. Is this not
going to "just work" with the PWM regulator?

The problem is somewhat simplified if that's the case. An implementation
could then fail the regulator_get_voltage() if hardware readout is not
supported and return the current voltage when readout is possible.

> When we add a new feature then it's expected that only updated drivers
> will support that feature.
> 
> We need to make sure that we don't regress / negatively change the
> behavior for anyone running non-updated drivers.  ...and we should
> strive to require as few changes to drivers as possible.  ...but if
> the best we can do requires changes to the PWM driver API then we will
> certainly have differences depending on the PWM driver.

How so? Drivers should behave consistently, irrespective of the API. Of
course if you need to change behaviour of the user driver depending on
the availability of a certain feature, that's perfectly fine.

Furthermore it's out of the question that changes to the API will be
required. That's precisely the reason why the atomic PWM proposal came
about. It's an attempt to solve the shortcomings of the current API for
cases such as Rockchip.

> > In the end the PWM API is as low-level as it is because it needs to be
> > flexible enough to cope with other use-cases. In the general case the
> > simple truth is that it doesn't make sense to set a period without the
> > duty cycle and vice versa. That's why pwm_config() takes both as input
> > parameters. The atomic API is going to take that one step further in
> > that you need to specify the complete state of the PWM when applying.
> 
> I guess this is still showing the strangeness of the device tree
> specifying a period without a duty cycle.  You just said it doesn't
> make sense, but that's exactly what the device tree has.

The device tree specifies the period because there is no way for the
driver (such as pwm-backlight) to "guess" the right one. Furthermore
there is a certain degree of board-specificity to that parameter and
therefore any heuristic trying to come up with a sensible value will
inevitably fail eventually.

> I'd imagine that the only reason that the device tree specifies just
> the period is that it's intended to be there only for clients that
> don't care about the specific duty cycle in terms of seconds but
> _only_ care about the duty cycle in terms of percentage.  Anyone who
> cared about the duty cycle in terms of seconds would presumably also
> care about specifying the period (in terms of seconds) in the same
> place they specify the duty cycle.

Yes, exactly.

> >> > That doesn't really get us closer, though. There is still the issue of
> >> > the user having to deal with two states: the current hardware state and
> >> > the software state as configured in DT or board files.
> >>
> >> I think the only users that need to deal with this are one that need a
> >> seamless transition from bootup settings.  Adding a new API call to
> >> support a new feature like this doesn't seem insane, and anyone who
> >> doesn't want this new feature can just never call the new API.
> >>
> >> The only thing that would "change" from the point of view of old
> >> drivers is that the PWM period wouldn't change at bootup until the
> >> duty cycle was set.  IMHO this is probably a bug fix.  AKA, for a PWM
> >> backlight, imagine:
> >>
> >> 1. Firmware sets period to 20000 ns, duty cycle to 8000 ns (40%)
> >> 2. Linux boots up and sets period to 10000 ns.  Brightness of
> >> backlight instantly goes to 80%.
> >> 3. Eventually something decides to set the backlight duty cycle and it
> >> goes to the proper rate.
> >>
> >> Skipping #2 seems like the right move.  ...or did I misunderstand how
> >> something works?
> >
> > I'm not aware of any code in the PWM subsystem that would do this
> > automatically. If you don't call any of the pwm_*() functions the
> > hardware state should not be modified. The responsibility is with
> > the user drivers.
> 
> Ah, OK.  I must have gotten confused.
> 
> Oh, I see.  So pwm_get_period() is actually "lying" about the hardware
> today!  So what you're saying is that at boot time we grab the period
> out of the device tree but we _don't_ apply it to the hardware, right?
>  I was thinking it would get applied right away...

That's correct. The value retrieved by pwm_get_period() is the one
specified in DT (or a PWM lookup table). It should match the hardware
value after the first call to pwm_config(), though.

> That means that if you call pwm_get_period() right away at boot time
> you're not getting the current period of the hardware but the period
> that was specified in the device tree.

Yes.

> So all we need is a new API call that lets you read the hardware
> values and make sure that the PWM regulator calls that before anyone
> calls pwm_config().  That's roughly B) above.

Yes. I'm thinking that we should have a pwm_get_state() which retrieves
the current state of the PWM. For drivers that support hardware readout
this state should match the hardware state. For other drivers it should
reflect whatever was specified in DT; essentially what pwm_get_period()
and friends return today.

That way if you want to get the current voltage in the regulator-pwm
driver you'd simply do a pwm_get_state() and compute the voltage from
the period and duty cycle. If the PWM driver that you happen to use
doesn't support hardware readout, you'll get an initial output voltage
of 0, which is as good as any, really.

> > That is, it is up to the regulator or backlight driver to apply any new
> > configuration to a PWM channel on boot, or leave it as is. For
> > backlight it's probably fine to simply apply some default, since having
> > the brightness change on boot isn't going to be terribly irritating.
> >
> > With the atomic API it would be possible to avoid even this and have the
> > backlight driver simply read out the current hardware state and apply an
> > equivalent brightness even if the period changed.
> >
> > For the regulator case you'd need to read out the current state and then
> > recompute the values that will yield the same output power given data
> > specified in DT. I think that much is already implemented in Boris'
> > series, and it's really only the details that are being debated.
> >
> > The problematic issue is still that we might have a disparity between
> > the current hardware state and the state initially specified by DT. In
> > the general case the DT will specify the period and polarity of the PWM
> > signal and leave it up to the user driver to determine what a correct
> > duty cycle would be. With the atomic API we'll essentially have two
> > states: the current (hardware) state and the "initial" state, which is
> > what an OS will see as the state to apply. The problem now is that once
> > you have applied the initial state with a duty cycle you've determined,
> > there is no longer a need to keep it around. But there's also no way to
> > know when this is the case. So the controversial part about all this is
> > when to start using the current state rather that the initial state.
> >
> > The most straightforward way to solve this would be to apply the initial
> > configuration on driver probe. That is, when the pwm-regulator driver
> > gets probed it would retrieve the current and initial states, then
> > adjust the current state such that it matches the initial state but with
> > a duty cycle that yields the same output power as the current state, and
> > finally apply the new state. After that, every regulator_set_voltage()
> > call could simply operate on the current state and adjust the duty cycle
> > exclusively.
> >
> > Does that sound reasonable?
> 
> Sure.  ...but you agree that somehow you need a new API call for this,
> right?  Somehow the PWM regulator needs to be able to say that it
> wants the hardware state, not the initial state as specified in the
> device tree.

The atomic PWM API is this new API. I'm not arguing that we don't need
new API. What's being discussed is what the API needs to look like to
support this new use-case and at the same time be maximally compatible
with existing users.

I think perhaps one question that needs answering to do that is whether
or not the regulator-pwm driver can guess the correct period. The issue
that was initially being discussed is what to do with hardware state vs
initial state (i.e. what's defined in DT). Mark commented in another
subthread that DT should simply leave out data that doesn't make sense
to be specified.

However I don't think there's any particularly reasonable period for the
regulator-pwm use-case, so specifying the period within DT would still
be necessary. What works for one board may not be the correct (or
optimal) value for another. Similarly one board may need to invert the
PWM signal to generate the proper voltage, or require other parameters
that we haven't even defined yet.

There's also the issue of a voltage table that you need to define in the
DT for the regulator-pwm device. Does that consist of only duty-cycle
values, or does it have corresponding period values as well. I'd guess
that it really only needs the duty cycle given any period. So something
like this is what I'd expect:

	regulator {
		compatible = "regulator-pwm";

		pwms = <&pwm0 5000>;

		voltages = <0 0>, <1000000 1000>, ..., <5000000 5000>;
	};

I think the pwm-regulator binding defines the duty cycle in percent. I
guess that would work equally well.

And now we've come full circle because, again, we need to differentiate
between the current hardware state and the initial state. Or, as was
also discussed previously, alternatively, ignore the period specified in
DT and just go with what hardware readout defined. In case hardware
readout isn't supported, the "hardware state" will simply be the
"initial state".

The objection to the latter alternative was that we shouldn't trust the
firmware to have set up the regulator correctly. But if it didn't, how
can we trust that the duty cycle to period ratio is correct? Or the
other way around: if we trust the duty cycle to period ratio to have
been setup correctly, why don't we trust the period?

Thierry
--cNdxnHkX5QqsyA0e--
