Return-path: <kernel-bounces@pengutronix.de>
Date: Thu, 11 Oct 2018 22:34:50 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: RFC: don't let drivers issue pwm_disable after pwm_config(pwm,
 0, period)
Message-ID: <20181011203450.muo4eoj4mnqo634a@pengutronix.de>
References: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
 <20181009075345.GB5565@ulmo>
 <20181009093554.ugfxek3n4wacc7px@pengutronix.de>
 <20181010122607.GA21134@ulmo>
 <20181011101914.dapsvczsd4lteugk@pengutronix.de>
 <20181011120007.GA22811@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181011120007.GA22811@ulmo>
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

Hello Thierry,

On Thu, Oct 11, 2018 at 02:00:07PM +0200, Thierry Reding wrote:
> On Thu, Oct 11, 2018 at 12:19:14PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Wed, Oct 10, 2018 at 02:26:07PM +0200, Thierry Reding wrote:
> > > On Tue, Oct 09, 2018 at 11:35:54AM +0200, Uwe Kleine-K=F6nig wrote:
> > > > On Tue, Oct 09, 2018 at 09:53:45AM +0200, Thierry Reding wrote:
> > > > > On Mon, Aug 06, 2018 at 05:51:29PM +0200, Uwe Kleine-K=F6nig wrot=
e:
> > You wrote "Also, duty cycle of zero doesn't always mean \"off\"." but
> > also don't seem to refuse to change pwm users that do:

Just noticed the above has a "n't" to much. I don't think you
misunderstood my point because of that though.
=20
> > 	pwm_config(pwm, 0, 100);
> > 	pwm_disable(pwm);
> >=20
> > I interpreted your sentence as confirmation that this sequence isn't
> > correct in general.
>=20
> Yes, it is not correct in general, though it is correct in many cases.

Can you point out where it would not be correct?

> > Where is the difference you care about between duty=3D0 and disabled?
>=20
> This is described in the kerneldoc of the corresponding functions. In the
> case of pwm_enable() it starts the output toggling, whereas pwm_enable()

s/pwm_enable()$/pwm_disable/ I assume.

> disables the output toggling. So strictly by going according to the PWM
> API a driver should only need to call pwm_config() if the duty cycle
> actually changes. If all you do is disable and enable, then pwm_enable()
> and pwm_disable() should be good enough.

Not sure we're looking on the same kerneldoc. pwm_disable only
specifies:

	pwm_disable() - stop a PWM output toggling

. If you call pwm_disable() for an i.MX device it doesn't toggle any
more. OK, after configuring the pwm as inverted and 0% duty (or not
inverted and 100% duty) you get an additional edge, but I do think it's
a bit bold to deduce that the pin should keep it's state from the above
specification.

> The implicit assumption is that the configuration will persist across
> pwm_disable()/pwm_enable(). In practice this doesn't matter that much
> because most users will be setting the duty cycle and enable/disable
> at the same time. I can easily imagine other use-cases where you would
> want to make the different. One other difference could be that
> pwm_enable() and pwm_disable() require a more involved sequence of
> operations than pwm_config() or vice versa, in which cases you may
> want to avoid one or the other if possible.

OK, A PWM user that has to switch between say 50% duty cycle and a
constant value can use pwm_enable() and pwm_disable() to change between
these states (after calling pwm_config(pwm, period / 2, period) once).

Similarly it can use

	pwm_config(pwm, 0, period);

and

	pwm_config(pwm, period / 2, period);

to toggle.

I confirm, with my suggestion the first alternative would go away. This
isn't a big loss though because the second stays around.

Now as you refuse to remove this first alternative there should be a
relevant semantic difference between the two. There are only a single
difference I see: With the first way (using pwm_enable() and
pwm_disable()) the PWM user doesn't control if the PWM stops at 0 or 1,
using the 2nd approach the PWM has to stop at 0.

Currently power consumption might be another difference, but you stated
below this wasn't relevant.

> In addition, we do expose these details to userspace via sysfs, so not
> allowing an explicit disable after config(duty=3D0) would break that ABI.

I wouldn't have a big problem with that even if the "strict" expectation
would be documented explicitly. The documentation for
/sys/class/pwm/pwmchipN/pwmX/enable only states:

	Enable/disable the PWM signal.

which I wouldn't consider to break with my suggestion.

> > What is in your view the current difference for the hardware behind the
> > PWM?
>=20
> It depends on the driver implementation, but the kerneldoc is pretty
> specific. I many cases I would expect pwm_disable() to allow a bit of
> extra power to be saved because clocks could be turned off.

With my approach that expectation is given. With your's it is not in
every case because of the ambiguity of pwm_disable. On i.MX the clock
can only be disabled if the caller doesn't care about the resulting pin
state. The hardware driver however cannot know if this is the case and
so must keep the clock on even in the cases where it would be ok to
disable it.

> > > > Really, only the driver knows when it's safe to disable the clock w=
hile
> > > > it's expected to keep the pin at a given state. So better don't exp=
ect a
> > > > certain state after pwm_disable().
> > >=20
> > > Yes, I agree that only the driver knows when it is safe to do so, but=
 I
> > > still fail to understand why we should change the API in order to
> > > accomodate the specifics of a particular driver.
> >=20
> > The incentive to change the API is a combination of:
> >=20
> >  - The restriction to keep the pin driving at a certain level after
> >    disable isn't a natural and obvious property of the hardware.
> >    The designers of the imx-pwm for example did it differently.
>=20
> I would disagree. A pin that you can't keep at a defined level if it
> isn't actively driven is a fundamentally useless concept. You said
> yourself that the hardware design is problematic because it causes the
> pin to change unexpectedly when you disable the PWM.

It's only unexpected if you are used to the strict API design.

And if you don't agree to this point, I'm missing ambition on your side.
If the strict API is only suitable for "sane" pwm hardware instead of
being general enough to also cover some of the "stranger" designs,
that's what I call useless.

> One could argue that that's a bug in the hardware.=20

And one could argue further that it's a shortcoming of the PWM framework
that it is unable to handle it better, though it easily could.

> However, given that there is a way to avoid the unexpected change,
> there is a mechanism outside of PWM to deal with this use-case. And
> that's also perfectly fine. Dealing with pins that aren't actively
> driven is part of the job of a pinmux controller.
>=20
> >  - The change removes ambiguity from from the demands on the hardware
> >    drivers.
>=20
> I don't think there's currently any ambiguity. We may not be stating
> explicitly that the assumption is for a PWM to be "off" after
> pwm_disable(), but it's certainly how everyone has interpreted it. Also
> if there's an ambiguity, then that's what should be addressed.

"off" isn't a clear definition. For you it is (assuming I understood you
right) "stop immediately and keep driving the current level". For the
imx hardware designer it is, "stop toggling, output a 0". For others it
might be: "Stop driving the pin".

The ambiguity is that sometimes the PWM is disabled with the need to
keep the output driving at a certain level. And sometimes the PWM is
disabled and the output doesn't matter. In both cases pwm_disable() is
used and the driver cannot know in which of the two cases we are and if
it's ok to release the pin or not.

> >  - The change doesn't make the API less expressive.
>=20
> Yes it does. You remove the distinction between duty cycle =3D=3D 0 and
> the PWM being disabled.

Currently there is no distinction that is relevant for PWM users. (If
you don't agree, please provide an example.) In both cases the output is
constant 0 (assuming a non-inverted PWM).

The PWM user can still request that constant 0 with the laxer API. The
only difference in the strict API is that

	pwm_config(pwm, 0, 100)

doesn't disable the clock and

	pwm_disable(pwm)

does. There is no good reason however for a driver of a "sane" PWM to
not disable the clock in reply to pwm_config(pwm, 0, 100) though.

If you don't agree, can you show me a single PWM user that cares about
the distinction?

> >  - The change doesn't doesn't complicate any pwm hardware driver.
>=20
> True. It also doesn't simplify any PWM hardware driver.

see "The change simplifies the imx-pwm driver." below that you
confirmed.

> >  - The change allows to simplify most pwm users.
>=20
> Yes, the subset that doesn't care about the difference is marginally
> simplified. Although if the API was more rigorous about the definition
> of pwm_disable(), then PWM users would be even more simplified.

I cannot follow. How should/could the API be more rigorous to simplify
PWM users? Is this off-topic for the current discussion?

> >  - The change simplifies the imx-pwm driver.
>=20
> True. But you leave out that the change doesn't actually fix your
> problem. If your PWM user goes away, it will still want to disable the
> PWM because it is no longer in use. However, you don't want that to
> mean that the backlight goes to full brightness again. If you unbind
> the backlight driver, the backlight should remain off (or turn off if
> it isn't already).

This advantage isn't about "solving my problems". It is about
simplification (as I wrote).

> > In my experience this is enough to justify such a change.
>=20
> I would consider the change if it was actually going to fix the issue
> that you're seeing. As it is, all your proposal does is paper over one
> specific symptom, and I'm sorry, but that's just not good enough.

Correct, it doesn't completely fix the issue. It improves the situation
considerably though and has the advantages that you confirmed above.

> > > So we already know that currently all users expect that the pin state
> > > after disable will be low (because they previously set duty cycle to =
0,
> > > which is the active equivalent of low).
> >=20
> > My theory is that most users don't expect this and/or don't make use of
> > it. As of 9dcd936c5312 we have 50 pwm drivers
> > ($(wc -l drivers/pwm/Makefile) - 3). At most 17 of them handle inversion
> > at all. ($(git grep -l PWM_POLARITY_INVERSED drivers/pwm/pwm-* | wc -l),
> > and I think there are a few false positive matches, pwm-sun4i.c for
> > example). I'd be willing to bet that as of now imx isn't the only driver
> > with this problem.
>=20
> We can speculate about that as much as we want. i.MX is the only one
> that this issue has been reported against, so I'm going to have to
> assume that it's working fine for all of the others. If it isn't then
> people should come forward and report it.

You really assume that all the drivers that don't make use of
PWM_POLARITY_INVERSED (33 of 50 + imx at least, probably more) behave as
you expect when the PWM user does:

	pwm_apply_state(pwm, { .period =3D 100; .duty_cycle=3D0; polarity=3DPWM_PO=
LARITY_INVERSED; enabled=3Dfalse; })

? I'd say your assumption that all are working fine is treading on thin
ice. The effect maybe is only that the i.MX users use more corners of
the PWM API and/or are more open to report actual problems.

Also if there are two ways to implement something, one works for 49
different hardware implementations and one for 50 this is already a good
reason to stick to the latter.

> > > Given that stricter definition,
> > > the i.MX PWM driver becomes buggy because it doesn't guarantee that p=
in
> > > state. I think the fix for that is for the i.MX PWM driver to make su=
re
> > > the pin state doesn't actually change on ->disable(). If that means t=
he
> > > clock needs to remain on, then that's exactly what the driver should =
be
> > > implementing.
> >=20
> > Yes, if we keep the API "stricter" this is what should be done. This
> > doesn't justify to keep the API strict though.
>=20
> But an API that isn't strict is useless. If the behaviour of a PWM isn't
> predictable, how can you use it to drive a backlight. If at any point it
> could just go 100% and turn on the backlight to full brightness, how can
> anyone use it for anything sensible?

As long as I don't call pwm_disable() (or pwm_config(pwm, period,
period)) it must not go to 100%.

> > > Are you aware of this:
> > >=20
> > > 	http://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D69987
> > >=20
> > > This seems to address exactly the problem that you're describing. The
> > > solution matches what I had expected a fix for this problem to look
> > > like. Can you try it and see if that fixes the issue?
> >=20
> > Right. Apart from bugs in it (for example
> > http://patchwork.ozlabs.org/patch/981774/ does never configure the gpio
> > as output) this would solve the issue for sure. This doesn't void my
> > arguments to relax the PWM API though. Also look at the costs: The patch
> > adds 86 lines to the imx driver complicating it considerably.
>=20
> Now you're just being dramatic. 86 lines of code is not a lot. And I
> don't think it's complicated. I'm willing to carry the burden of those
> 86 lines of code if it fixes the issue for good.

Right, the complexity doesn't come with the 86 lines of code. With my
approach the pwm-imx driver only has to care about its 6 registers. With
Michal's patch it suddenly has to care about gpio and pinmuxing.

> >                                                               Each
> > machine that wants to profit of this change has to adapt it's device
> > tree to make the additional pinmuxing and gpio known.
> > To be fair, my change doesn't fix the gap between pinctrl being active
> > and the actual enablement of the pwm. But this could be better solved in
> > the pwm framework without touching any hardware driver with pinctrl
> > mechanism that are already in place. (Make use of the "init" pinctrl
> > state and only switch to "default" when the pwm is configured.)
> > There is nothing imx-pwm specific in hooking a gpio and adapting the
> > pinmuxing in it. So if you want to go this path, please implement it in
> > a generic way such that all pwm devices could benefit.
>=20
> You're wrong. Judging by all the evidence that we have at this point,
> this is exactly an imx-pwm specific issue, therefore the burden is on
> the imx-pwm driver to implement a solution for it.

You're the first maintainer I met with this attitude. Whenever I
implemented something in a driver specific way fixing an issue that
other drivers might have to, I was requested to find a generic solution
without the need to analyse if other drivers are affected or not.

There are some subsystems (e.g. tty/serial) where there is much stuff
implemented in each driver even though some things could well be
implemented in a generic way (e.g. rs485 handling). This is really a big
mess.

> > > It looks as if that also fixes the shutdown problem, so it's better t=
han
> > > what you're proposing here yet it doesn't require any API change at a=
ll
> > > to make it work.
> >=20
> > I don't care much about the shutdown problem. (Also, if the imx-pwm
> > driver is unbound, the gpio is freed, too, so it's only by chance if the
> > level is kept.)
>=20
> Who else do you think would use the GPIO and change the level? If you've
> got multiple concurrent users of the pin that's a whole other problem. I
> also don't see why you wouldn't want to care about the shutdown problem.
> It's annoying if you shut down the device and all of a sudden your
> backlight comes back up again, perhaps in the middle of the display
> controller shutting down and producing garbage on the screen.

If someone on my machine is able to unbind the backlight driver making
the display flicker I have much more and graver problems than the
flickering display. And I didn't test (as I currently don't have an
affected device on my desk) but I think machine shutdown is no problem.

> > Sidenote: With the current capabilities of the pwm framework there is no
> > technical reason to expose to the hardware drivers that the pwm user us=
es
> > inverted logic. The framework could just apply
> >=20
> > 	duty =3D period - duty;
> >=20
> > before calling the hardware specific .config callback and so allow to
> > simplify some drivers, reducing complexity to a single place.
>=20
> No, you're wrong. If you only consider the case of a backlight or an
> LED, then yes, you could simplify it that way. However there are other
> use-cases that require more fine-grained control and in those cases the
> actual edges of the PWM are important.

Can you please point out such a use case that is also possible to
implement with the current API?
=20
> Also, this has been discussed before and I have said elsewhere that I
> have no objection to adding a helper that would simplify this for
> consumers that don't care about the difference.

I suggest a compromise below, maybe we can agree on that one.

> > > > By changing the semantic of the API
> > > >=20
> > > >  - the i.MX driver can be implemented nicely;
> > > >  - the other drivers for "saner" hardware can stay as they are;
> > > >  - the API users can still express all their needs;
> > > >  - the API stops having two ways to express the same needs;
> > >=20
> > > Again, duty-cycle =3D 0 is not the same as setting the state to disab=
led.
> > >=20
> > > Practically they usually have the same effect, but that's just because
> > > in the typical use-case we don't care about the subtle differences.
> >=20
> > I fail to see the subtle difference.
>=20
> That's okay. I've tried my best to describe it to you in different ways.
> If I still haven't been able to convey this, I don't know what else to
> say.

I reread your explanation several times and fail to understand it. It
would be very helpful if you could come up with a scenario where it's
obvious that the distinction is needed. You're writing about "typical
use-cases" and "value in having the additional flexibility" without
providing a use-case that is atypical or actually need the flexibility.

Maybe I don't understand the semantic you're giving to the calls or
we're using the same words to describe different things. I try
to describe the semantic of pwm_disable of the strict API in my words,
can you please confirm or correct that?:

	pwm_disable stops toggling the PWM pin at whatever state the pin
	currently is. Given a duty cycle between 0% and 100% (exclusive)
	that means the pin stops at an undefined level. If the duty
	cycle is 0% or 100% it stops (for an uninverted PWM) at 0 or 1
	respectively (and vice versa for an inverted one).

The semantic of pwm_enable in my understanding is:

	pwm_enable for an uninverted PWM starts with $duty_cycle
	nanoseconds at 0 and then is 1 for $period - $duty_cycle
	nanoseconds. Then repeat.
	For an inverted it is first 1 for $duty_cycle nanoseconds and
	then 0 for the rest of the period.

I think pwm_config is to be defined like this:

	pwm_config changes period and duty cycle without any
	specification about how the transition should be done.

All calls should be synchronous, that is should only return when the
change is actually "on the pin".

> > > >  - most API users can be simplified because they can drop
> > > >      if (duty =3D=3D 0) pwm_disable()
> > > >  - on i.MX the clock can be disabled when not needed saving some en=
ergy;
> > >=20
> > > That's one reason why we have pwm_disable(). It's what you use to save
> > > some energy if you don't need the PWM. Also, you claim that if the cl=
ock
> > > is disabled the attached backlight will turn on at full brightness, s=
o I
> > > fail to see how this would work.
> >=20
> > As long as you care about the backlight to be off, don't disable the
> > pwm. And if in this state the clk can be disabled, then this should be
> > done without an additional poke by the hardware driver which is the only
> > place that can know for sure that it is safe to do so. There is no good
> > reason to let the pwm user have to know that the currently configured
> > state might make some energy saving possible and impose the burden on
> > him to then call pwm_disable().
>=20
> This doesn't have anything to do with consumers knowing about potential
> energy savings. All we do is give the consumers an opportunity to say: I
> need the PWM to be enabled because I want to use the PWM signal now or I
> don't really need the PWM signal any more, just stop sending a signal.

There are two different degrees of "I don't need the PWM signal any
more". In the first case you still care about the output level and in
the other you don't. Currently the API doesn't give the PWM user the
possibility to specify which of the two are intended.

> This is merely a hint from the consumer. What the driver does with it is
> ultimately up to the driver. If the driver wants to disable the clock
> when the duty cycle goes to zero because it knows that it is safe to do
> so, then by all means, feel free to do that.

How should the driver know it is safe if the PWM user doesn't have a way
to tell if he cares about the output level?

> > > Also, you leave out the fact that even after all this work that touch=
es
> > > all users and all PWM drivers you still don't get fully correct
> > > functionality on your devices because when the driver is removed or s=
hut
> > > down you run into the same problem.
> >=20
> > It's ok for me that all bets are off when the driver is removed.
>=20
> Well, it's not okay for me. Especially if we can do better.

Fine, then lets give a way to PWM users to specify if we have to care
about the pin state after disable or not.

> >                                                                  I'm
> > happy when I fix the problem during active operation because on the
> > machine I currently care about the shutdown problem isn't relevant.
>=20
> Why is it not relevant? Surely at some point you will want to shut down
> that machine.

Does a shutdown do anything with a running pwm software wise? The
leds-pwm driver doesn't have a shutdown hook. The pwm_bl driver calls
pwm_free in some legacy configuration but otherwise does nothing that
would undo it's pwm_backlight_power_off() in the shutdown hook. So I'm
convinced shutdown is fine here.

> And even if not, imx-pwm is used by others and they do
> seem to care about shutdown, so they should have a say in the matter as
> well.

Note that my suggestion doesn't make things worse for those users who
care. I'm used to that it's good enough if a patch improves the
situation for some users and doesn't make it worse for the others.

> > (Also as noted above, even Michal's patch doesn't solve the problem
> > formally.)
>=20
> Now I'm confused, you said above that "Apart from bugs in it ... this
> would solve the issue for sure". So which one is it?

I'm sure that you must not assume that after

	gpio_direction_output(gpio, 0);
	gpio_free(gpio);

the line still drives the 0. In most cases this will be the case, but if
this makes the GPIO switch to being an input that should be correct
behaviour, too. That's why I wrote "formally" above.

Michal's patch solves the gap at startup and when the PWM user calls
disable() formally. At unbind when the gpio is freed it's "only" in
practise.

> > > > Regarding you claim that the API worked fine for a decade: I tried
> > > > already in 2013 to address this problem. And even independent of th=
at,
> > > > that is not a good reason to not improve stuff.
> > >=20
> > > My claim was that it has worked fine "for everyone else". I know that
> > > this has been an issue on i.MX for a long time and I've done my best =
to
> > > lay out why I think your proposal is not the right way to fix it.
> >=20
> > I still fail to see a single technical reason to not evolve the API. I
> > read from your mails:
> >=20
> >  - it has been like that for ages
> >  - it works for everyone but i.MX
> >  - it could be made working for i.MX by involving pinctrl and gpio in
> >    the hardware specific pwm driver.
> >=20
> > Did I miss anything? None of these justifies to keep the status quo in
> > my eyes.
>=20
> I don't understand your logic here. You want to change the API, so the
> burden is on you to convince me *why* it needs to be changed.

Changing the API isn't *needed*. But it's the simplest way to fix some
(not all) issues I see. Additionally it simplifies some things.

> So far you have not been able to do that, so don't try to turn this
> around and make me come up with reasons why it shouldn't change.

I listed several reasons to change the API, for some you confirmed them
to be valid. You listed some for keeping the API as is. As I'm
convinced my suggestion is good and your reasons are smaller (or even
bad), I try to argue against them.

The above question was my try to summarize your reasons and to make sure
the list is complete. I didn't try to turn anything around and if that
was your impression that's a misunderstanding.

With my current understanding the list of reasons to stick to the status
quo is:

 - it has been like that for ages
   (which is a poor reason to oppose to change);
 - it works for everyone but i.MX
   (which I doubt and with my replacement it works for all drivers and
   users as now including i.MX and maybe others that have the same issue
   without us knowing it currently);
 - it could be made working for i.MX by involving pinctrl and gpio in
   the hardware specific pwm driver (which is ridiculous because my
   solution is simpler); and
 - we're changing API
   (which I'd say is ok given that the specification isn't very specific
   and breaking the API for good reasons is not nice but acceptable IMHO)

In my eyes in the above list there is one valid reason to not change
(the last one). If you don't agree to change the userspace API we could
keep that constant and only change the kernel-internal API (which is a
bit ugly though).

The list of reasons in favour of a change are:

 - the pwm-imx driver can stay/become easier as with the stricter API;
 - ambiguity removed
   (hw drivers know in .disable if they can put the pin at a previously
   "forbidden" value)
 - users can be simplified by dropping some pwm_disable()

So now how can we come to a conclusion? Here are my suggestions for a
compromise:

What about adding a new callback that we could for example call
"disable_lax" that implements disabling the PWM without the guarantee to
put the pin in the "off" state?

We could also introduce a callback "freeze" (or disable_strict) that is
supposed to implement the "strict" disable. Then there is an objective
way to determine when all drivers are adapted to the updated model.

Do you agree to my suggestion that pwm_config(pwm, 0, period) or similar
should already imply disabling clocks if possible without the need to
explicitly call pwm_disable() afterwards?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
