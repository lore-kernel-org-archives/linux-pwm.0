From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Date: Thu, 25 Feb 2016 15:14:03 -0800
Message-ID: <CAD=FV=VckTVD8b1g+f0G2kMeoTjvY0pAGhoDnWQN_dAmqSxBxg@mail.gmail.com>
References: <20151110173416.GB21727@ulmo>
	<CAD=FV=WL3jYEgVe-m6QcAyQwfJgdX4J5OtKisKwyoKOrTSpEQA@mail.gmail.com>
	<20160125170855.GA10182@ulmo>
	<CAD=FV=Xvxeqo3imUmjukC5iYk3EZkrJ04G7C1B-w4xyr-r6-2Q@mail.gmail.com>
	<20160203145337.GD9650@ulmo>
	<CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ@mail.gmail.com>
	<20160222175929.GA23899@ulmo>
	<CAD=FV=UCErW3EjYRtwt49_ztNR7cyY4U0o4R_dxdomer-Ac2Dg@mail.gmail.com>
	<20160223143859.GA27656@ulmo>
	<CAD=FV=UvxG3MYD4MKQJqN7W68uMjd-s+FH-e8tkrLCpS0RLmZQ@mail.gmail.com>
	<20160223181448.GA14754@ulmo.nvidia.com>
	<CAD=FV=VM3cOQ0HqwLANBw9MVBCyFTrSyPe_dGzgPucuMUEWRKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:35550 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbcBYXOG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 25 Feb 2016 18:14:06 -0500
Received: by mail-vk0-f54.google.com with SMTP id e6so62436674vkh.2
        for <linux-pwm@vger.kernel.org>; Thu, 25 Feb 2016 15:14:04 -0800 (PST)
In-Reply-To: <CAD=FV=VM3cOQ0HqwLANBw9MVBCyFTrSyPe_dGzgPucuMUEWRKA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, linux-pwm <linux-pwm@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-sunxi@googlegroups.com, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@li>

Thierry,

On Tue, Feb 23, 2016 at 10:42 AM, Doug Anderson <dianders@google.com> wrote:
> Thierry,
>
> On Tue, Feb 23, 2016 at 10:14 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
>>> pwm_get_period(): get the period of the PWM; if the PWM has not yet
>>> been configured by software this gets the default period (possibly
>>> specified by the device tree).
>>
>> No. I think we'll need a different construct for the period defined by
>> DT or board files. pwm_get_period() is the legacy API to retrieve the
>> "current" period, even if it was lying a little before the atomic API.
>
> Ah, got it.  I think I missed that you considered pwm_get_period()
> legacy and that you eventually wanted to get rid of it.  OK, then what
> you say makes sense.
>
>
>>> That should work with one minor problem.  If HW readout isn't
>>> supported then pwm_get_state() in probe will presumably return 0 for
>>> the duty cycle.  That means it will change the voltage.  That's in
>>> contrast to how I think things work today where the voltage isn't
>>> changed until the first set_voltage() call.  At least the last time I
>>> tested things get_voltage() would simply report an incorrect value
>>> until the first set_voltage().  I think existing behavior (reporting
>>> the wrong value) is better than new behavior (change the value at
>>> probe).
>>
>> That's exactly the point. Reporting a wrong value isn't really a good
>> option. Changing the voltage on boot is the only way to make the logical
>> state match the hardware state on boot. Chances are that if you don't
>> have hardware readout support you probably don't care what state your
>> regulator will be in.
>>
>> Then again, if we don't support hardware readout, setting up the logical
>> state with data from DT (or board files) and defaulting the duty cycle
>> to 0, we end up with exactly what we had before, even with the atomic
>> API, right? Maybe that's okay, too.
>
> IMHO this is a change in behavior that will break existing users.
> Anyone using a PWM regulator will suddenly find their voltage changing
> at bootup.  Certainly today all users of the PWM regulator don't seem
> to mind (apparently) the the voltage is reported incorrectly at bootup
> but I bet they'd mind if the voltage suddenly started changing for
> them at bootup.
>
> It seems better to preserve existing behavior and print a warning that
> the voltage will be reported incorrectly until HW Readout is
> supported.
>
> Of course, we're only talking about two real users in mainline here:
> Rockchip boards and the "stih407-family".  If we just fix both of
> those to support HW Readout before landing the change then I'm fine
> with doing what you say.
>
>
>>> ...and if set_voltage() remains untouched then we can solve my probe
>>> problem by renaming pwm_get_state() to pwm_get_hw_state() and having
>>> it return an error if HW readout is not supported.  Then we only call
>>> pwm_get_args() / pwm_apply_state() when we support HW readout.
>>
>> The problem is that we make the API clumsy to use. If we don't sync the
>> "initial" state (as defined by DT or board files) to hardware at any
>> point, then we need to add the pwm_args construct and always stick to
>> it. I think it weird to have to use the pwm_args.period instead of the
>> current period.
>>
>> So we're back to square one, really. That's exactly what Mark brought up
>> originally.
>
> I had missed the part where you wanted to deprecate pwm_get_period().
> Thus my points here aren't really valid.
>
> In my mind the old API was perfectly fine (and actually quite clean /
> simple to use) except in the special case of avoiding the PWM
> regulator glitches.  With that mindset I think my previous email make
> sense.  However, this is your subsystem to maintain and if you think
> moving everyone to a new atomic API makes more sense then you're in
> the best position to make that decision.  :)

So just to summarize:

* Add pwm_get_state(), pwm_apply_state(), pwm_get_args().
pwm_get_state() initially returns 0 for duty cycle if driver doesn't
support readout.

* Re-implement pwm_get_period() (and maybe other similar functions)
atop pwm_get_state() as you describe earlier in the thread.

* Document pwm_get_period() (and maybe other similar functions) as deprecated.

* Fix drivers for all current 2 users of PWM regulator to support
hardware readout.

* Update PWM regulator as you described earlier in the thread (Feb 23).

* If PWM regulator is ever used on a new board whose PWM doesn't
support hardware readout, the voltage will change at probe time.


Did I get all that right?  Thanks!

-Doug
