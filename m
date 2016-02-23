From: "'Doug Anderson' via linux-sunxi" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Date: Tue, 23 Feb 2016 09:35:48 -0800
Message-ID: <CAD=FV=UvxG3MYD4MKQJqN7W68uMjd-s+FH-e8tkrLCpS0RLmZQ@mail.gmail.com>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
	<2341981.a79ioYM9Es@diego>
	<20151110173416.GB21727@ulmo>
	<CAD=FV=WL3jYEgVe-m6QcAyQwfJgdX4J5OtKisKwyoKOrTSpEQA@mail.gmail.com>
	<20160125170855.GA10182@ulmo>
	<CAD=FV=Xvxeqo3imUmjukC5iYk3EZkrJ04G7C1B-w4xyr-r6-2Q@mail.gmail.com>
	<20160203145337.GD9650@ulmo>
	<CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ@mail.gmail.com>
	<20160222175929.GA23899@ulmo>
	<CAD=FV=UCErW3EjYRtwt49_ztNR7cyY4U0o4R_dxdomer-Ac2Dg@mail.gmail.com>
	<20160223143859.GA27656@ulmo>
Reply-To: dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDR6JO4Q7MHRB5NQWK3AKGQE6KGZYQA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20160223143859.GA27656@ulmo>
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

On Tue, Feb 23, 2016 at 6:38 AM, Thierry Reding
<thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> > Furthermore it's out of the question that changes to the API will be
>> > required. That's precisely the reason why the atomic PWM proposal came
>> > about. It's an attempt to solve the shortcomings of the current API for
>> > cases such as Rockchip.
>>
>> I _think_ we're on the same page here.  If there are shortcomings with
>> the current API that make it impossible to implement a feature, we've
>> got to change and/or add to the existing API.  ...but we don't want to
>> break existing users / drivers.
>>
>> Note that historically I remember that Linus Torvalds has stated that
>> there is no stable API within the Linux kernel and that forcing the
>> in-kernel API to never change was bad for software development.  I
>> tracked down my memory and found
>> <http://lwn.net/1999/0211/a/lt-binary.html>.  Linus is rabid about not
>> breaking userspace, but in general there's no strong requirement to
>> never change the driver API inside the kernel.  That being said,
>> changing the driver API causes a lot of churn, so presumably changing
>> it in a backward compatible way (like adding to the API instead of
>> changing it) will make things happier.
>
> I didn't say anything about stable API. All I said is that new API
> should be well-thought-out. Those are two very different things.

I guess I just misunderstood "it's out of the question that changes to
the API will be required".  In any case, I think everyone's on the
same page here, so no need to debate further.  :)


>> >> So all we need is a new API call that lets you read the hardware
>> >> values and make sure that the PWM regulator calls that before anyone
>> >> calls pwm_config().  That's roughly B) above.
>> >
>> > Yes. I'm thinking that we should have a pwm_get_state() which retrieves
>> > the current state of the PWM. For drivers that support hardware readout
>> > this state should match the hardware state. For other drivers it should
>> > reflect whatever was specified in DT; essentially what pwm_get_period()
>> > and friends return today.
>>
>> Excellent, so pwm_get_period() gets the period as specified in the
>> device tree (or other board config) and pwm_get_state() returns the
>> hardware state.  SGTM.
>
> That's not quite what I was thinking. If hardware readout is supported
> then whatever we report back should be the current hardware state unless
> we're explicitly asked for something else. If we start mixing the state
> and legacy APIs this way, we'll get into a situation where drivers that
> support hardware readout behave differently than drivers that don't.
>
> For example: A PWM device that's controlled by a driver that supports
> hardware readout has a current period of 50000 ns and the firmware set
> the period to 25000 ns. pwm_get_period() for this PWM device will return
> 50000 ns. If you reconfigure the PWM to generate a PWM signal with a
> period of 30000 ns, pwm_get_period() would still return 50000 ns.
>
> A driver that doesn't support hardware readout, on the contrary, would
> return 50000 ns from pwm_get_period() on the first call, but after you
> have reconfigured it using pwm_config() it will return the new period.

Ah, right!  I forgot that the existing API will be updated if you've
reconfigured the period via pwm_config().  Ugh, you're right that's a
little ugly then.

So do we define it as:

pwm_get_state(): always get the hardware state w/ no caching (maybe
even pwm_get_raw_state() or pwm_get_hw_state())

pwm_get_period(): get the period of the PWM; if the PWM has not yet
been configured by software this gets the default period (possibly
specified by the device tree).


Is that OK?  That is well defined and doesn't change the existing
behavior of pwm_get_period().


>> > That way if you want to get the current voltage in the regulator-pwm
>> > driver you'd simply do a pwm_get_state() and compute the voltage from
>> > the period and duty cycle. If the PWM driver that you happen to use
>> > doesn't support hardware readout, you'll get an initial output voltage
>> > of 0, which is as good as any, really.
>>
>> Sounds fine to me.  PWM regulator is in charge of calling
>> pwm_get_state(), which can return 0 (or an error?) if driver (or
>> underlying hardware) doesn't support hardware readout.  PWM regulator
>> is in charge of using the resulting period / duty cycle to calculate a
>> percentage.
>
> I'm not sure if pwm_get_state() should ever return an error. For drivers
> that support hardware readout, the resulting state should match what's
> programmed to the hardware.
>
> But for drivers without hardware readout support pwm_get_state() still
> makes sense because after a pwm_apply_state() the internal logical state
> would again match hardware.

I guess it depends on how you define things.  With my above
definitions it seems clearest if pwm_get_state() returns an error if
hardware readout is not supported.  If we call it pwm_get_hw_state()
it's even clearer that it should return an error.


> The simplest way to get rid of this would be to change the core to apply
> an initial configuration on probe. However that's probably going to
> break your use-case again (it would set a 0 duty cycle because it isn't
> configured in DT).

Right, so we can't do that.


> To allow your use-case to work we'd need to deal with two states: the
> current hardware state and the "initial" state as defined by DT.
> Unfortunately the PWM specifier in DT is not a full definition, it is
> more like a partial initial configuration. The problem with that, and
> I think that's what Mark was originally objecting to, is that it isn't
> clear when to use the "initial" state and when to use the read hardware
> state. After the first pwm_apply_state() you wouldn't ever have to use
> the "initial" state again, because it's the same as the current state
> (modulo the duty cycle).
>
> Also for drivers such as clk-pwm the usefulness of the "initial" state
> is reduced even more, because it doesn't even need the period specified
> in DT. It uses only the flags (if at all).
>
> Perhaps to avoid this confusion a new type of object, e.g. pwm_args,
> could be introduced to hold configuration arguments given in the PWM
> specifier (in DT) or the PWM lookup table (in board files).
>
> It would then be the responsibility of the users to deal with that
> information in a sensible way. In (almost?) all cases I would expect
> that to be to program the PWM device in the user's ->probe(). In the
> case of regulator-pwm I'd expect that ->probe() would do something
> along these lines (error handling excluded):
>
>         struct pwm_state state;
>         struct pwm_args args;
>         unsigned int ratio;
>
>         pwm = pwm_get(...);
>
>         pwm_get_state(pwm, &state);
>         pwm_get_args(pwm, &args);
>
>         ratio = (state.duty_cycle * 100) / state.period;
>
>         state.duty_cycle = (ratio * args.period) / 100;
>         state.period = args.period;
>         state.flags = args.flags;
>
>         pwm_apply_state(pwm, &state);
>
> The ->set_voltage() implementation would then never need to care about
> the PWM args, but rather do something like this:
>
>         struct pwm_state state;
>         unsigned int ratio;
>
>         pwm_get_state(pwm, &state);
>
>         state.duty_cycle = (ratio * state.period) / 100;
>
>         pwm_apply_state(pwm, &state);
>
> Does that sound about right?

That should work with one minor problem.  If HW readout isn't
supported then pwm_get_state() in probe will presumably return 0 for
the duty cycle.  That means it will change the voltage.  That's in
contrast to how I think things work today where the voltage isn't
changed until the first set_voltage() call.  At least the last time I
tested things get_voltage() would simply report an incorrect value
until the first set_voltage().  I think existing behavior (reporting
the wrong value) is better than new behavior (change the value at
probe).

I'm curious, though.  In your proposal, how does pwm_get_period()
behave?  To be backward compatible, I'd imagine that even in your
proposal we'd have the same definition as I had above:

pwm_get_period(): get the period of the PWM; if the PWM has not yet
been configured by software this gets the default period (possibly
specified by the device tree).


If you have a different definition of pwm_get_period() in your
proposal, please let me know!  If my definition matches your thoughts
then I think we can actually just not touch the "set_voltage" call.
It can always use pwm_get_period() and always use pwm_config() just
like today.

...and if set_voltage() remains untouched then we can solve my probe
problem by renaming pwm_get_state() to pwm_get_hw_state() and having
it return an error if HW readout is not supported.  Then we only call
pwm_get_args() / pwm_apply_state() when we support HW readout.


Thus, if HW readout:

* In probe, we read HW state (pwm_get_hw_state) and atomically adjust
(pwm_apply_state) based on arguments (pwm_get_args).

* In set_voltage we use pwm_get_period which will return the period we
applied in pwm_apply_state() and use pwm_config() to change the duty
cycle.


If no HW readout, no behavior change at all from today:

* In probe we don't do anything to change the PWM

* Upon the first set_voltage we use pwm_get_period() to get the period
as specified in DT and use pwm_config() to change the duty cycle.


That seems pretty sane to me.  What do you think?

-Doug
