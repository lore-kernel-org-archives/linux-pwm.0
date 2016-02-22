From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Date: Mon, 22 Feb 2016 11:15:09 -0800
Message-ID: <CAD=FV=UCErW3EjYRtwt49_ztNR7cyY4U0o4R_dxdomer-Ac2Dg@mail.gmail.com>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
	<2341981.a79ioYM9Es@diego>
	<20151110173416.GB21727@ulmo>
	<CAD=FV=WL3jYEgVe-m6QcAyQwfJgdX4J5OtKisKwyoKOrTSpEQA@mail.gmail.com>
	<20160125170855.GA10182@ulmo>
	<CAD=FV=Xvxeqo3imUmjukC5iYk3EZkrJ04G7C1B-w4xyr-r6-2Q@mail.gmail.com>
	<20160203145337.GD9650@ulmo>
	<CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ@mail.gmail.com>
	<20160222175929.GA23899@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20160222175929.GA23899@ulmo>
Sender: linux-leds-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, linux-pwm <linux-pwm@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-sunxi@googlegroups.com, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@li>
List-Id: linux-pwm@vger.kernel.org

Thierry,

On Mon, Feb 22, 2016 at 9:59 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
>> This is because only some drivers would be able to read the hardware
>> state?  I'm not sure how we can get away from that.  In all proposals
>> we've talked about (including what you propose below, right?) the PWM
>> regulator will need a PWM driver that can read hardware state.  Only
>> PWM drivers that have been upgraded to support reading hardware state
>> can use the PWM regulator (or at least only those drivers will be able
>> to use the PWM regulator glitch-free).
>
> Yes, the key here is glitch-free. There's no reason whatsoever that the
> rugaltor-pwm driver should be limited to usage with a hardware readout-
> capable PWM driver. If you don't care about glitches, likely because no
> critical components depend on the regulator, you can simply force what
> state you choose on boot.
>
> As a matter of fact, I think that's how regulators work already. If the
> current output voltage doesn't match the specified constraints, then a
> valid value will be forced by the regulator core. If the voltage lies
> within the constraints the core won't touch the regulator. Is this not
> going to "just work" with the PWM regulator?
>
> The problem is somewhat simplified if that's the case. An implementation
> could then fail the regulator_get_voltage() if hardware readout is not
> supported and return the current voltage when readout is possible.

Based on looking at the current code, I believe it just returns 0V
until you call regulator_set_voltage() today.  I don't think that was
always the case.  Back before it was made continuous I think it
returned the voltage that matched with 0% duty cycle.

I haven't dug into what the regulator framework does in the current
system nor what happens if regulator_get_voltage() returns an error.
Perhaps Boris can dig / comment?


>> When we add a new feature then it's expected that only updated drivers
>> will support that feature.
>>
>> We need to make sure that we don't regress / negatively change the
>> behavior for anyone running non-updated drivers.  ...and we should
>> strive to require as few changes to drivers as possible.  ...but if
>> the best we can do requires changes to the PWM driver API then we will
>> certainly have differences depending on the PWM driver.
>
> How so? Drivers should behave consistently, irrespective of the API. Of
> course if you need to change behaviour of the user driver depending on
> the availability of a certain feature, that's perfectly fine.
>
> Furthermore it's out of the question that changes to the API will be
> required. That's precisely the reason why the atomic PWM proposal came
> about. It's an attempt to solve the shortcomings of the current API for
> cases such as Rockchip.

I _think_ we're on the same page here.  If there are shortcomings with
the current API that make it impossible to implement a feature, we've
got to change and/or add to the existing API.  ...but we don't want to
break existing users / drivers.

Note that historically I remember that Linus Torvalds has stated that
there is no stable API within the Linux kernel and that forcing the
in-kernel API to never change was bad for software development.  I
tracked down my memory and found
<http://lwn.net/1999/0211/a/lt-binary.html>.  Linus is rabid about not
breaking userspace, but in general there's no strong requirement to
never change the driver API inside the kernel.  That being said,
changing the driver API causes a lot of churn, so presumably changing
it in a backward compatible way (like adding to the API instead of
changing it) will make things happier.


>> That means that if you call pwm_get_period() right away at boot time
>> you're not getting the current period of the hardware but the period
>> that was specified in the device tree.
>
> Yes.
>
>> So all we need is a new API call that lets you read the hardware
>> values and make sure that the PWM regulator calls that before anyone
>> calls pwm_config().  That's roughly B) above.
>
> Yes. I'm thinking that we should have a pwm_get_state() which retrieves
> the current state of the PWM. For drivers that support hardware readout
> this state should match the hardware state. For other drivers it should
> reflect whatever was specified in DT; essentially what pwm_get_period()
> and friends return today.

Excellent, so pwm_get_period() gets the period as specified in the
device tree (or other board config) and pwm_get_state() returns the
hardware state.  SGTM.


> That way if you want to get the current voltage in the regulator-pwm
> driver you'd simply do a pwm_get_state() and compute the voltage from
> the period and duty cycle. If the PWM driver that you happen to use
> doesn't support hardware readout, you'll get an initial output voltage
> of 0, which is as good as any, really.

Sounds fine to me.  PWM regulator is in charge of calling
pwm_get_state(), which can return 0 (or an error?) if driver (or
underlying hardware) doesn't support hardware readout.  PWM regulator
is in charge of using the resulting period / duty cycle to calculate a
percentage.


>> Sure.  ...but you agree that somehow you need a new API call for this,
>> right?  Somehow the PWM regulator needs to be able to say that it
>> wants the hardware state, not the initial state as specified in the
>> device tree.
>
> The atomic PWM API is this new API. I'm not arguing that we don't need
> new API. What's being discussed is what the API needs to look like to
> support this new use-case and at the same time be maximally compatible
> with existing users.
>
> I think perhaps one question that needs answering to do that is whether
> or not the regulator-pwm driver can guess the correct period. The issue
> that was initially being discussed is what to do with hardware state vs
> initial state (i.e. what's defined in DT). Mark commented in another
> subthread that DT should simply leave out data that doesn't make sense
> to be specified.
>
> However I don't think there's any particularly reasonable period for the
> regulator-pwm use-case, so specifying the period within DT would still
> be necessary. What works for one board may not be the correct (or
> optimal) value for another. Similarly one board may need to invert the
> PWM signal to generate the proper voltage, or require other parameters
> that we haven't even defined yet.
>
> There's also the issue of a voltage table that you need to define in the
> DT for the regulator-pwm device. Does that consist of only duty-cycle
> values, or does it have corresponding period values as well. I'd guess
> that it really only needs the duty cycle given any period. So something
> like this is what I'd expect:
>
>         regulator {
>                 compatible = "regulator-pwm";
>
>                 pwms = <&pwm0 5000>;
>
>                 voltages = <0 0>, <1000000 1000>, ..., <5000000 5000>;
>         };
>
> I think the pwm-regulator binding defines the duty cycle in percent. I
> guess that would work equally well.
>
> And now we've come full circle because, again, we need to differentiate
> between the current hardware state and the initial state. Or, as was
> also discussed previously, alternatively, ignore the period specified in
> DT and just go with what hardware readout defined. In case hardware
> readout isn't supported, the "hardware state" will simply be the
> "initial state".
>
> The objection to the latter alternative was that we shouldn't trust the
> firmware to have set up the regulator correctly. But if it didn't, how
> can we trust that the duty cycle to period ratio is correct? Or the
> other way around: if we trust the duty cycle to period ratio to have
> been setup correctly, why don't we trust the period?

To answer:

* No, PWM regulator can't guess the correct period.

* PWM regulator API is already fine as is.  Period specified in PWM
specifier and table is specified in percentages.

* Firmware may have voltage setup correctly but may not have the
"ideal" period.  Often firmware configures things in a way that works
but is sub-optimal.  Basically the kernel should be able to tell what
voltage the firmware set things up at (so we know not to go lower on
accident), but we shouldn't assume that the firmware values are
perfect.  Said another way: obviously the firmware made values that
were good enough to boot us to where we are (or we wouldn't be even
executing code), but we might want to configure things to reduce noise
on the lines (make HDMI work better?) or optimize power consumption.

--

I _think_ the end result of all this is just:

1. Introduce pwm_get_state() that gets hardware state.  Up for debate
if this returns 0 or ERROR if a driver doesn't implement this.

2. PWM regulator calls pwm_get_state at probe time to get hardware
state, calculates a percentage (and voltage) with this.

3. PWM regulator does nothing else until it is asked to set the
voltage, but uses the voltage calculated from #2 to satisfy any "get
voltage" calls.

4. When asked to set the voltage, PWM regulator uses pwm_get_period()
and calculates a duty cycle based on that, just like it does today.
This uses pwm_config() which includes a duty cycle and period and is
thus "atomic".


Said another way: the only action item from this point of view is just
that we introduce a new pwm_get_state().


Boris: I think that's everything you need, right?

--

Historically there was also a necessity that we were very careful with
the PWM clock because the clock would end up getting disabled
temporarily at bootup (after the PWM probe time but before the PWM
regulator finished probing).  Presumably that's either been solved
already or can be debated totally separately.


-Doug
