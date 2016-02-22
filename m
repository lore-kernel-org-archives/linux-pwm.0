From: "'Doug Anderson' via linux-sunxi" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Date: Mon, 22 Feb 2016 08:27:37 -0800
Message-ID: <CAD=FV=UEfLa=rZuSAHJ8t6X=1RE_wd4b2fbrzavgbT3KnMLrBg@mail.gmail.com>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
	<2341981.a79ioYM9Es@diego>
	<20151110173416.GB21727@ulmo>
	<CAD=FV=WL3jYEgVe-m6QcAyQwfJgdX4J5OtKisKwyoKOrTSpEQA@mail.gmail.com>
	<20160125170855.GA10182@ulmo>
	<CAD=FV=Xvxeqo3imUmjukC5iYk3EZkrJ04G7C1B-w4xyr-r6-2Q@mail.gmail.com>
	<20160203145337.GD9650@ulmo>
	<CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ@mail.gmail.com>
Reply-To: dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDR6JO4Q7MHRB6XNVS3AKGQEAVKWGFA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-pwm <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel@l>
List-Id: linux-pwm@vger.kernel.org

Thierry,

On Wed, Feb 3, 2016 at 11:04 AM, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> Thierry
>
> On Wed, Feb 3, 2016 at 6:53 AM, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> A) The software state here is the period and flags (AKA "inverted),
>>> right?  It does seem possible that you could apply the period and
>>> flags while keeping the calculated bootup duty cycle percentage
>>> (presuming that the PWM was actually enabled at probe time and there
>>> was a bootup duty cycle at all).  That would basically say that
>>> whenever you set the period of a PWM then the duty cycle of the PWM
>>> should remain the same percentage.  That actually seems quite sane
>>> IMHO.  It seems much saner than trying to keep the duty cycle "ns"
>>> when the period changes or resetting the PWM to some default when the
>>> period changes.
>>
>> That really depends on the use-case. If you're interested in the output
>> power of the PWM then, yes, this is sane. But it might not be the right
>> answer in other cases.
>
> Ah, I see.  You're envisioning a device where active time in "ns" is
> more important than the percentage of active time.  Perhaps an LED
> where it's more important to have it on for no more than .1 seconds
> (so we don't drive it too long and burn it out?).  If we slowed down
> the duty cycle and adjusted the period to match, we could get into a
> bad state.
>
>
>>> B) Alternatively, I'd also say that setting a period without a duty
>>> cycle doesn't make a lot of sense.  ...so you could just apply the
>>> period at the same time that you apply the duty cycle the first time.
>>> Presumably you'd want to "lie" to the callers of the PWM subsystem and
>>> tell them that you already changed the period even though the change
>>> won't really take effect until they actually set the duty cycle.  If
>>> anyone cared to find out the true hardware period we could add a new
>>> pwm_get_hw_period().  ...or since the only reason you'd want to know
>>> the hardware period would be if you're trying to read the current duty
>>> cycle percentage, you could instead add "pwm_get_hw_state()" and have
>>> that return both the hardware period ns and duty cycle ns (which is
>>> the most accurate way to return the "percentage" without using fix or
>>> floating point math).
>>
>> But then you get into a situation where behaviour is dependent on the
>> PWM driver, whereas this is really very specific to one specific use-
>> case.
>
> This is because only some drivers would be able to read the hardware
> state?  I'm not sure how we can get away from that.  In all proposals
> we've talked about (including what you propose below, right?) the PWM
> regulator will need a PWM driver that can read hardware state.  Only
> PWM drivers that have been upgraded to support reading hardware state
> can use the PWM regulator (or at least only those drivers will be able
> to use the PWM regulator glitch-free).
>
> When we add a new feature then it's expected that only updated drivers
> will support that feature.
>
> We need to make sure that we don't regress / negatively change the
> behavior for anyone running non-updated drivers.  ...and we should
> strive to require as few changes to drivers as possible.  ...but if
> the best we can do requires changes to the PWM driver API then we will
> certainly have differences depending on the PWM driver.
>
>
>> In the end the PWM API is as low-level as it is because it needs to be
>> flexible enough to cope with other use-cases. In the general case the
>> simple truth is that it doesn't make sense to set a period without the
>> duty cycle and vice versa. That's why pwm_config() takes both as input
>> parameters. The atomic API is going to take that one step further in
>> that you need to specify the complete state of the PWM when applying.
>
> I guess this is still showing the strangeness of the device tree
> specifying a period without a duty cycle.  You just said it doesn't
> make sense, but that's exactly what the device tree has.
>
> I'd imagine that the only reason that the device tree specifies just
> the period is that it's intended to be there only for clients that
> don't care about the specific duty cycle in terms of seconds but
> _only_ care about the duty cycle in terms of percentage.  Anyone who
> cared about the duty cycle in terms of seconds would presumably also
> care about specifying the period (in terms of seconds) in the same
> place they specify the duty cycle.
>
>
>>> I think this is like my suggestion B), right?  AKA the PWM regulator
>>> would be the sole caller of pwm_get_hw_state() and it would use this
>>> to figure out the existing duty cycle percentage.  Then it would
>>> translate that into "ns" and would set the duty cycle.  Upon the first
>>> set of the duty cycle both the period and duty cycle would be applied
>>> at the same time.
>>
>> Yes and no. I think the PWM regulator would need to get the current
>> hardware state and derive the output power from duty cycle and period.
>> It would then need to rescale to whatever new period it wants to use
>> to ensure the same output power is used.
>
> Right.  We all agree that somehow this needs to happen, it's just a
> question of the implementation.
>
>
>>> > That doesn't really get us closer, though. There is still the issue of
>>> > the user having to deal with two states: the current hardware state and
>>> > the software state as configured in DT or board files.
>>>
>>> I think the only users that need to deal with this are one that need a
>>> seamless transition from bootup settings.  Adding a new API call to
>>> support a new feature like this doesn't seem insane, and anyone who
>>> doesn't want this new feature can just never call the new API.
>>>
>>> The only thing that would "change" from the point of view of old
>>> drivers is that the PWM period wouldn't change at bootup until the
>>> duty cycle was set.  IMHO this is probably a bug fix.  AKA, for a PWM
>>> backlight, imagine:
>>>
>>> 1. Firmware sets period to 20000 ns, duty cycle to 8000 ns (40%)
>>> 2. Linux boots up and sets period to 10000 ns.  Brightness of
>>> backlight instantly goes to 80%.
>>> 3. Eventually something decides to set the backlight duty cycle and it
>>> goes to the proper rate.
>>>
>>> Skipping #2 seems like the right move.  ...or did I misunderstand how
>>> something works?
>>
>> I'm not aware of any code in the PWM subsystem that would do this
>> automatically. If you don't call any of the pwm_*() functions the
>> hardware state should not be modified. The responsibility is with
>> the user drivers.
>
> Ah, OK.  I must have gotten confused.
>
> Oh, I see.  So pwm_get_period() is actually "lying" about the hardware
> today!  So what you're saying is that at boot time we grab the period
> out of the device tree but we _don't_ apply it to the hardware, right?
>  I was thinking it would get applied right away...
>
> That means that if you call pwm_get_period() right away at boot time
> you're not getting the current period of the hardware but the period
> that was specified in the device tree.
>
> So all we need is a new API call that lets you read the hardware
> values and make sure that the PWM regulator calls that before anyone
> calls pwm_config().  That's roughly B) above.
>
>
>> That is, it is up to the regulator or backlight driver to apply any new
>> configuration to a PWM channel on boot, or leave it as is. For
>> backlight it's probably fine to simply apply some default, since having
>> the brightness change on boot isn't going to be terribly irritating.
>>
>> With the atomic API it would be possible to avoid even this and have the
>> backlight driver simply read out the current hardware state and apply an
>> equivalent brightness even if the period changed.
>>
>> For the regulator case you'd need to read out the current state and then
>> recompute the values that will yield the same output power given data
>> specified in DT. I think that much is already implemented in Boris'
>> series, and it's really only the details that are being debated.
>>
>> The problematic issue is still that we might have a disparity between
>> the current hardware state and the state initially specified by DT. In
>> the general case the DT will specify the period and polarity of the PWM
>> signal and leave it up to the user driver to determine what a correct
>> duty cycle would be. With the atomic API we'll essentially have two
>> states: the current (hardware) state and the "initial" state, which is
>> what an OS will see as the state to apply. The problem now is that once
>> you have applied the initial state with a duty cycle you've determined,
>> there is no longer a need to keep it around. But there's also no way to
>> know when this is the case. So the controversial part about all this is
>> when to start using the current state rather that the initial state.
>>
>> The most straightforward way to solve this would be to apply the initial
>> configuration on driver probe. That is, when the pwm-regulator driver
>> gets probed it would retrieve the current and initial states, then
>> adjust the current state such that it matches the initial state but with
>> a duty cycle that yields the same output power as the current state, and
>> finally apply the new state. After that, every regulator_set_voltage()
>> call could simply operate on the current state and adjust the duty cycle
>> exclusively.
>>
>> Does that sound reasonable?
>
> Sure.  ...but you agree that somehow you need a new API call for this,
> right?  Somehow the PWM regulator needs to be able to say that it
> wants the hardware state, not the initial state as specified in the
> device tree.

I'm hoping we can get your latest thoughts on this topic so that Boris
can make forward progress.  It would be nice to get to some resolution
somehow.  The unfortunate part about having only one back-and-forth
exchange every few weeks is that I'm worried that we'll forget what we
already talked about and have the same discussions over and over
again.  :(

-Doug
