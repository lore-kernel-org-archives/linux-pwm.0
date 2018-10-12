Return-path: <kernel-bounces@pengutronix.de>
Date: Fri, 12 Oct 2018 11:45:57 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: RFC: don't let drivers issue pwm_disable after pwm_config(pwm,
 0, period)
Message-ID: <20181012094557.ktasxus2zrbsp5rx@pengutronix.de>
References: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
 <20181009075345.GB5565@ulmo>
 <20181009093554.ugfxek3n4wacc7px@pengutronix.de>
 <20181010122607.GA21134@ulmo>
 <20181011101914.dapsvczsd4lteugk@pengutronix.de>
 <20181011120007.GA22811@ulmo>
 <c11b425a-0907-d489-81a9-92289dc51028@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c11b425a-0907-d489-81a9-92289dc51028@ysoft.com>
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Gavin Schenk <g.schenk@eckelmann.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>
List-ID: <linux-pwm.vger.kernel.org>

On Thu, Oct 11, 2018 at 01:15:44PM +0000, Vokáč Michal wrote:
> Uwe, Thierry,
> just a few comments as I am not able to dive deeper into your discussion.
> 
> On 11.10.2018 14:00, Thierry Reding wrote:
> > On Thu, Oct 11, 2018 at 12:19:14PM +0200, Uwe Kleine-König wrote:
> >> Hello Thierry,
> >>
> >> On Wed, Oct 10, 2018 at 02:26:07PM +0200, Thierry Reding wrote:
> >>> On Tue, Oct 09, 2018 at 11:35:54AM +0200, Uwe Kleine-König wrote:
> >>>> On Tue, Oct 09, 2018 at 09:53:45AM +0200, Thierry Reding wrote:
> >>>>> On Mon, Aug 06, 2018 at 05:51:29PM +0200, Uwe Kleine-König wrote:
> >>>>>> Hello Thierry,
> >>>>>>
> >>>>>> (If you have a déjà vu: Yes, I tried to argue this case already in the
> >>>>>> past, it's just that I'm just faced with a new use case that's broken
> >>>>>> with the current state.)
> >>>>>>
> >>>>>> Currently the idiom
> >>>>>>
> >>>>>> 	pwm_config(mypwm, value, period);
> >>>>>> 	if (!value)
> >>>>>> 		pwm_disable(mypwm);
> >>>>>> 	else
> >>>>>> 		pwm_enable(mypwm);
> >>>>>>
> >>>>>> (and it's equivalent:
> >>>>>>
> >>>>>> 	state.duty_cycle = ...
> >>>>>> 	state.enable = state.duty_cycle ? true : false;
> >>>>>> 	pwm_apply_state(...);
> >>>>>>
> >>>>>> ) is quite present in the kernel.
> >>>>>>
> >>>>>> In my eyes this is bad for two reasons:
> >>>>>>
> >>>>>>   a) if the caller is supposed to call pwm_disable() after configuring the
> >>>>>>      duty cycle to zero, then why doesn't pwm_config() contains this to
> >>>>>>      unburden pwm-API users and so reduce open coding this assumption?
> >>>>>
> >>>>> Just to reiterate my thoughts on this: while the config/enable/disable
> >>>>> split may seem arbitrary for some use-cases (you may argue most
> >>>>> use-cases, and you'd probably be right), I think there's value in having
> >>>>> the additional flexibility to explicitly turn off the PWM. Also, duty
> >>>>> cycle of zero doesn't always mean "off". If your PWM is inverted, then
> >>>>> the duty cycle of zero actually means "on". And that of course also
> >>>>> still depends on other components on your board.
> >>>>
> >>>> Did you notice you didn't argue against me here? We seem to agree that
> >>>> calling disabling a PWM after setting the duty cycle to zero is bad.
> >>
> >> You wrote "Also, duty cycle of zero doesn't always mean \"off\"." but
> >> also don't seem to refuse to change pwm users that do:
> >>
> >> 	pwm_config(pwm, 0, 100);
> >> 	pwm_disable(pwm);
> >>
> >> I interpreted your sentence as confirmation that this sequence isn't
> >> correct in general.
> > 
> > Yes, it is not correct in general, though it is correct in many cases.
> > 
> >> Where is the difference you care about between duty=0 and disabled?
> > 
> > This is described in the kerneldoc of the corresponding functions. In the
> > case of pwm_enable() it starts the output toggling, whereas pwm_enable()
> > disables the output toggling. So strictly by going according to the PWM
> > API a driver should only need to call pwm_config() if the duty cycle
> > actually changes. If all you do is disable and enable, then pwm_enable()
> > and pwm_disable() should be good enough. The implicit assumption is that
> > the configuration will persist across pwm_disable()/pwm_enable(). In
> > practice this doesn't matter that much because most users will be
> > setting the duty cycle and enable/disable at the same time. I can easily
> > imagine other use-cases where you would want to make the different. One
> > other difference could be that pwm_enable() and pwm_disable() require a
> > more involved sequence of operations than pwm_config() or vice versa, in
> > which cases you may want to avoid one or the other if possible.
> > 
> > In addition, we do expose these details to userspace via sysfs, so not
> > allowing an explicit disable after config(duty=0) would break that ABI.
> > 
> >>> I don't see why you think I agree with that. The only thing I'm saying
> >>> is that pwm_config() shouldn't assume that a duty-cycle of 0 means the
> >>> same as the PWM being disabled.
> >>
> >> What is in your view the current difference for the hardware behind the
> >> PWM?
> > 
> > It depends on the driver implementation, but the kerneldoc is pretty
> > specific. I many cases I would expect pwm_disable() to allow a bit of
> > extra power to be saved because clocks could be turned off.
> > 
> >>>>> You may have an inverter somewhere, or you may actually be driving a
> >>>>> circuit that expects an inverted PWM.
> >>>>>
> >>>>> So saying that duty-cycle of 0 equals disable is simplifying things too
> >>>>> much, in my opinion.
> >>>>
> >>>> Full ack. So let's fix the users to not call pwm_disable after setting
> >>>> the duty cycle to zero!
> >>>
> >>> I don't understand why you come to that conclusion. It seems like we at
> >>> least agree on what the problem is and what potential issues there could
> >>> be with different setups.
> >>>
> >>> The point that we don't agree with is how to fix this.
> >>
> >> ack.
> >>
> >>>> Really, only the driver knows when it's safe to disable the clock while
> >>>> it's expected to keep the pin at a given state. So better don't expect a
> >>>> certain state after pwm_disable().
> >>>
> >>> Yes, I agree that only the driver knows when it is safe to do so, but I
> >>> still fail to understand why we should change the API in order to
> >>> accomodate the specifics of a particular driver.
> >>
> >> The incentive to change the API is a combination of:
> >>
> >>   - The restriction to keep the pin driving at a certain level after
> >>     disable isn't a natural and obvious property of the hardware.
> >>     The designers of the imx-pwm for example did it differently.
> > 
> > I would disagree. A pin that you can't keep at a defined level if it
> > isn't actively driven is a fundamentally useless concept. You said
> > yourself that the hardware design is problematic because it causes the
> > pin to change unexpectedly when you disable the PWM. One could argue
> > that that's a bug in the hardware. However, given that there is a way to
> > avoid the unexpected change, there is a mechanism outside of PWM to deal
> > with this use-case. And that's also perfectly fine. Dealing with pins
> > that aren't actively driven is part of the job of a pinmux controller.
> > 
> >>   - The change removes ambiguity from from the demands on the hardware
> >>     drivers.
> > 
> > I don't think there's currently any ambiguity. We may not be stating
> > explicitly that the assumption is for a PWM to be "off" after
> > pwm_disable(), but it's certainly how everyone has interpreted it. Also
> > if there's an ambiguity, then that's what should be addressed.
> > 
> >>   - The change doesn't make the API less expressive.
> > 
> > Yes it does. You remove the distinction between duty cycle == 0 and
> > the PWM being disabled.
> > 
> >>   - The change doesn't doesn't complicate anmy pwm hardware driver.
> > 
> > True. It also doesn't simplify any PWM hardware driver.
> > 
> >>   - The change allows to simplify most pwm users.
> > 
> > Yes, the subset that doesn't care about the difference is marginally
> > simplified. Although if the API was more rigorous about the definition
> > of pwm_disable(), then PWM users would be even more simplified.
> > 
> >>   - The change simplifies the imx-pwm driver.
> > 
> > True. But you leave out that the change doesn't actually fix your
> > problem. If your PWM user goes away, it will still want to disable the
> > PWM because it is no longer in use. However, you don't want that to
> > mean that the backlight goes to full brightness again. If you unbind
> > the backlight driver, the backlight should remain off (or turn off if
> > it isn't already).
> > 
> >> In my experience this is enough to justify such a change.
> > 
> > I would consider the change if it was actually going to fix the issue
> > that you're seeing. As it is, all your proposal does is paper over one
> > specific symptom, and I'm sorry, but that's just not good enough.
> > 
> >>> So we already know that currently all users expect that the pin state
> >>> after disable will be low (because they previously set duty cycle to 0,
> >>> which is the active equivalent of low).
> >>
> >> My theory is that most users don't expect this and/or don't make use of
> >> it. As of 9dcd936c5312 we have 50 pwm drivers
> >> ($(wc -l drivers/pwm/Makefile) - 3). At most 17 of them handle inversion
> >> at all. ($(git grep -l PWM_POLARITY_INVERSED drivers/pwm/pwm-* | wc -l),
> >> and I think there are a few false positive matches, pwm-sun4i.c for
> >> example). I'd be willing to bet that as of now imx isn't the only driver
> >> with this problem.
> > 
> > We can speculate about that as much as we want. i.MX is the only one
> > that this issue has been reported against, so I'm going to have to
> > assume that it's working fine for all of the others. If it isn't then
> > people should come forward and report it.
> > 
> >>> Given that stricter definition,
> >>> the i.MX PWM driver becomes buggy because it doesn't guarantee that pin
> >>> state. I think the fix for that is for the i.MX PWM driver to make sure
> >>> the pin state doesn't actually change on ->disable(). If that means the
> >>> clock needs to remain on, then that's exactly what the driver should be
> >>> implementing.
> >>
> >> Yes, if we keep the API "stricter" this is what should be done. This
> >> doesn't justify to keep the API strict though.
> > 
> > But an API that isn't strict is useless. If the behaviour of a PWM isn't
> > predictable, how can you use it to drive a backlight. If at any point it
> > could just go 100% and turn on the backlight to full brightness, how can
> > anyone use it for anything sensible?
> > 
> >>> Are you aware of this:
> >>>
> >>> 	http://patchwork.ozlabs.org/project/linux-pwm/list/?series=69987
> >>>
> >>> This seems to address exactly the problem that you're describing. The
> >>> solution matches what I had expected a fix for this problem to look
> >>> like. Can you try it and see if that fixes the issue?
> >>
> >> Right. Apart from bugs in it (for example
> >> http://patchwork.ozlabs.org/patch/981774/ does never configure the gpio
> >> as output)
> 
> It is a RFC and the past discussion about it was mostly theoretical than
> about technical details. So I thought that nobody would really expect
> excellent technical solution at this point. I just tried to do my best
> and tested dozens of variations of [enabled/disabled/inverted/non-
> inverted/ bootloader/device-tree/sysfs] configurations to be sure how it
> affects current users and how it improves the situation.

I replied to the mail and pointed out a few other things now. This is
easier than to talk about your patch in this discussion.
 
> Regarding the GPIO output configuration. Yes, the pin is configured as
> input in the imx_pwm_init_pinctrl_info() function. At this stage you
> do not really know how to configure the pin. Configuring it as input
> is the safest option I think.

Did it work without setting the gpio as output in your tests?

> I thought that the pin is configured as output whenever gpiod_set_value()
> is called. None of the other examples/usages in kernel I looked at used
> the gpiod_direction_output()

Maybe they use devm_gpio_request_one or similar that return your gpio's
direction already configured?

> >> Sidenote: With the current capabilities of the pwm framework there is no
> >> technical reason to expose to the hardware drivers that the pwm user uses
> >> inverted logic. The framework could just apply
> >>
> >> 	duty = period - duty;
> >>
> 
> I prefer to utilize as much HW capabilities as possible. And it seems
> like most PWM chips support HW output inversion (to some extent) so to
> me it seems perfectly OK that that information can be propagated from
> the upper SW levels to the lowest one.

If the hardware capability is useful I fully agree. But if inversion can
be accomplished by a chip that doesn't support inversion in hardware by
just using duty = period - duty (and so can be accomplished by a chip
that has inversion support without making use of it) then the drivers
shouldn't be confronted with it.

(I'm not sure if inversion is really relevant with the current status
quo, as the expectations are not documented in a place I'm aware of.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
