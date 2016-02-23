From: "'Doug Anderson' via linux-sunxi" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Date: Tue, 23 Feb 2016 10:42:03 -0800
Message-ID: <CAD=FV=VM3cOQ0HqwLANBw9MVBCyFTrSyPe_dGzgPucuMUEWRKA@mail.gmail.com>
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
Reply-To: dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDR6JO4Q7MHRB7GPWK3AKGQE4O52ITY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20160223181448.GA14754-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
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

On Tue, Feb 23, 2016 at 10:14 AM, Thierry Reding
<thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> pwm_get_period(): get the period of the PWM; if the PWM has not yet
>> been configured by software this gets the default period (possibly
>> specified by the device tree).
>
> No. I think we'll need a different construct for the period defined by
> DT or board files. pwm_get_period() is the legacy API to retrieve the
> "current" period, even if it was lying a little before the atomic API.

Ah, got it.  I think I missed that you considered pwm_get_period()
legacy and that you eventually wanted to get rid of it.  OK, then what
you say makes sense.


>> That should work with one minor problem.  If HW readout isn't
>> supported then pwm_get_state() in probe will presumably return 0 for
>> the duty cycle.  That means it will change the voltage.  That's in
>> contrast to how I think things work today where the voltage isn't
>> changed until the first set_voltage() call.  At least the last time I
>> tested things get_voltage() would simply report an incorrect value
>> until the first set_voltage().  I think existing behavior (reporting
>> the wrong value) is better than new behavior (change the value at
>> probe).
>
> That's exactly the point. Reporting a wrong value isn't really a good
> option. Changing the voltage on boot is the only way to make the logical
> state match the hardware state on boot. Chances are that if you don't
> have hardware readout support you probably don't care what state your
> regulator will be in.
>
> Then again, if we don't support hardware readout, setting up the logical
> state with data from DT (or board files) and defaulting the duty cycle
> to 0, we end up with exactly what we had before, even with the atomic
> API, right? Maybe that's okay, too.

IMHO this is a change in behavior that will break existing users.
Anyone using a PWM regulator will suddenly find their voltage changing
at bootup.  Certainly today all users of the PWM regulator don't seem
to mind (apparently) the the voltage is reported incorrectly at bootup
but I bet they'd mind if the voltage suddenly started changing for
them at bootup.

It seems better to preserve existing behavior and print a warning that
the voltage will be reported incorrectly until HW Readout is
supported.

Of course, we're only talking about two real users in mainline here:
Rockchip boards and the "stih407-family".  If we just fix both of
those to support HW Readout before landing the change then I'm fine
with doing what you say.


>> ...and if set_voltage() remains untouched then we can solve my probe
>> problem by renaming pwm_get_state() to pwm_get_hw_state() and having
>> it return an error if HW readout is not supported.  Then we only call
>> pwm_get_args() / pwm_apply_state() when we support HW readout.
>
> The problem is that we make the API clumsy to use. If we don't sync the
> "initial" state (as defined by DT or board files) to hardware at any
> point, then we need to add the pwm_args construct and always stick to
> it. I think it weird to have to use the pwm_args.period instead of the
> current period.
>
> So we're back to square one, really. That's exactly what Mark brought up
> originally.

I had missed the part where you wanted to deprecate pwm_get_period().
Thus my points here aren't really valid.

In my mind the old API was perfectly fine (and actually quite clean /
simple to use) except in the special case of avoiding the PWM
regulator glitches.  With that mindset I think my previous email make
sense.  However, this is your subsystem to maintain and if you think
moving everyone to a new atomic API makes more sense then you're in
the best position to make that decision.  :)


-Doug
