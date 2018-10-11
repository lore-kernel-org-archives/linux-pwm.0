Return-path: <kernel-bounces@pengutronix.de>
Date: Thu, 11 Oct 2018 14:00:07 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20181011120007.GA22811@ulmo>
References: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
 <20181009075345.GB5565@ulmo>
 <20181009093554.ugfxek3n4wacc7px@pengutronix.de>
 <20181010122607.GA21134@ulmo>
 <20181011101914.dapsvczsd4lteugk@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20181011101914.dapsvczsd4lteugk@pengutronix.de>
Subject: Re: RFC: don't let drivers issue pwm_disable after pwm_config(pwm,
 0, period)
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 11, 2018 at 12:19:14PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Wed, Oct 10, 2018 at 02:26:07PM +0200, Thierry Reding wrote:
> > On Tue, Oct 09, 2018 at 11:35:54AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Oct 09, 2018 at 09:53:45AM +0200, Thierry Reding wrote:
> > > > On Mon, Aug 06, 2018 at 05:51:29PM +0200, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > Hello Thierry,
> > > > >=20
> > > > > (If you have a d=C3=A9j=C3=A0 vu: Yes, I tried to argue this case=
 already in the
> > > > > past, it's just that I'm just faced with a new use case that's br=
oken
> > > > > with the current state.)
> > > > >=20
> > > > > Currently the idiom
> > > > >=20
> > > > > 	pwm_config(mypwm, value, period);
> > > > > 	if (!value)
> > > > > 		pwm_disable(mypwm);
> > > > > 	else
> > > > > 		pwm_enable(mypwm);
> > > > >=20
> > > > > (and it's equivalent:
> > > > >=20
> > > > > 	state.duty_cycle =3D ...
> > > > > 	state.enable =3D state.duty_cycle ? true : false;
> > > > > 	pwm_apply_state(...);
> > > > >=20
> > > > > ) is quite present in the kernel.
> > > > >=20
> > > > > In my eyes this is bad for two reasons:
> > > > >=20
> > > > >  a) if the caller is supposed to call pwm_disable() after configu=
ring the
> > > > >     duty cycle to zero, then why doesn't pwm_config() contains th=
is to
> > > > >     unburden pwm-API users and so reduce open coding this assumpt=
ion?
> > > >=20
> > > > Just to reiterate my thoughts on this: while the config/enable/disa=
ble
> > > > split may seem arbitrary for some use-cases (you may argue most
> > > > use-cases, and you'd probably be right), I think there's value in h=
aving
> > > > the additional flexibility to explicitly turn off the PWM. Also, du=
ty
> > > > cycle of zero doesn't always mean "off". If your PWM is inverted, t=
hen
> > > > the duty cycle of zero actually means "on". And that of course also
> > > > still depends on other components on your board.
> > >=20
> > > Did you notice you didn't argue against me here? We seem to agree that
> > > calling disabling a PWM after setting the duty cycle to zero is bad.
>=20
> You wrote "Also, duty cycle of zero doesn't always mean \"off\"." but
> also don't seem to refuse to change pwm users that do:
>=20
> 	pwm_config(pwm, 0, 100);
> 	pwm_disable(pwm);
>=20
> I interpreted your sentence as confirmation that this sequence isn't
> correct in general.

Yes, it is not correct in general, though it is correct in many cases.

> Where is the difference you care about between duty=3D0 and disabled?

This is described in the kerneldoc of the corresponding functions. In the
case of pwm_enable() it starts the output toggling, whereas pwm_enable()
disables the output toggling. So strictly by going according to the PWM
API a driver should only need to call pwm_config() if the duty cycle
actually changes. If all you do is disable and enable, then pwm_enable()
and pwm_disable() should be good enough. The implicit assumption is that
the configuration will persist across pwm_disable()/pwm_enable(). In
practice this doesn't matter that much because most users will be
setting the duty cycle and enable/disable at the same time. I can easily
imagine other use-cases where you would want to make the different. One
other difference could be that pwm_enable() and pwm_disable() require a
more involved sequence of operations than pwm_config() or vice versa, in
which cases you may want to avoid one or the other if possible.

In addition, we do expose these details to userspace via sysfs, so not
allowing an explicit disable after config(duty=3D0) would break that ABI.

> > I don't see why you think I agree with that. The only thing I'm saying
> > is that pwm_config() shouldn't assume that a duty-cycle of 0 means the
> > same as the PWM being disabled.
>=20
> What is in your view the current difference for the hardware behind the
> PWM?

It depends on the driver implementation, but the kerneldoc is pretty
specific. I many cases I would expect pwm_disable() to allow a bit of
extra power to be saved because clocks could be turned off.

> > > > You may have an inverter somewhere, or you may actually be driving a
> > > > circuit that expects an inverted PWM.
> > > >=20
> > > > So saying that duty-cycle of 0 equals disable is simplifying things=
 too
> > > > much, in my opinion.
> > >=20
> > > Full ack. So let's fix the users to not call pwm_disable after setting
> > > the duty cycle to zero!
> >=20
> > I don't understand why you come to that conclusion. It seems like we at
> > least agree on what the problem is and what potential issues there could
> > be with different setups.
> >=20
> > The point that we don't agree with is how to fix this.
>=20
> ack.
>=20
> > > Really, only the driver knows when it's safe to disable the clock whi=
le
> > > it's expected to keep the pin at a given state. So better don't expec=
t a
> > > certain state after pwm_disable().
> >=20
> > Yes, I agree that only the driver knows when it is safe to do so, but I
> > still fail to understand why we should change the API in order to
> > accomodate the specifics of a particular driver.
>=20
> The incentive to change the API is a combination of:
>=20
>  - The restriction to keep the pin driving at a certain level after
>    disable isn't a natural and obvious property of the hardware.
>    The designers of the imx-pwm for example did it differently.

I would disagree. A pin that you can't keep at a defined level if it
isn't actively driven is a fundamentally useless concept. You said
yourself that the hardware design is problematic because it causes the
pin to change unexpectedly when you disable the PWM. One could argue
that that's a bug in the hardware. However, given that there is a way to
avoid the unexpected change, there is a mechanism outside of PWM to deal
with this use-case. And that's also perfectly fine. Dealing with pins
that aren't actively driven is part of the job of a pinmux controller.

>  - The change removes ambiguity from from the demands on the hardware
>    drivers.

I don't think there's currently any ambiguity. We may not be stating
explicitly that the assumption is for a PWM to be "off" after
pwm_disable(), but it's certainly how everyone has interpreted it. Also
if there's an ambiguity, then that's what should be addressed.

>  - The change doesn't make the API less expressive.

Yes it does. You remove the distinction between duty cycle =3D=3D 0 and
the PWM being disabled.

>  - The change doesn't doesn't complicate anmy pwm hardware driver.

True. It also doesn't simplify any PWM hardware driver.

>  - The change allows to simplify most pwm users.

Yes, the subset that doesn't care about the difference is marginally
simplified. Although if the API was more rigorous about the definition
of pwm_disable(), then PWM users would be even more simplified.

>  - The change simplifies the imx-pwm driver.

True. But you leave out that the change doesn't actually fix your
problem. If your PWM user goes away, it will still want to disable the
PWM because it is no longer in use. However, you don't want that to
mean that the backlight goes to full brightness again. If you unbind
the backlight driver, the backlight should remain off (or turn off if
it isn't already).

> In my experience this is enough to justify such a change.

I would consider the change if it was actually going to fix the issue
that you're seeing. As it is, all your proposal does is paper over one
specific symptom, and I'm sorry, but that's just not good enough.

> > So we already know that currently all users expect that the pin state
> > after disable will be low (because they previously set duty cycle to 0,
> > which is the active equivalent of low).
>=20
> My theory is that most users don't expect this and/or don't make use of
> it. As of 9dcd936c5312 we have 50 pwm drivers
> ($(wc -l drivers/pwm/Makefile) - 3). At most 17 of them handle inversion
> at all. ($(git grep -l PWM_POLARITY_INVERSED drivers/pwm/pwm-* | wc -l),
> and I think there are a few false positive matches, pwm-sun4i.c for
> example). I'd be willing to bet that as of now imx isn't the only driver
> with this problem.

We can speculate about that as much as we want. i.MX is the only one
that this issue has been reported against, so I'm going to have to
assume that it's working fine for all of the others. If it isn't then
people should come forward and report it.

> > Given that stricter definition,
> > the i.MX PWM driver becomes buggy because it doesn't guarantee that pin
> > state. I think the fix for that is for the i.MX PWM driver to make sure
> > the pin state doesn't actually change on ->disable(). If that means the
> > clock needs to remain on, then that's exactly what the driver should be
> > implementing.
>=20
> Yes, if we keep the API "stricter" this is what should be done. This
> doesn't justify to keep the API strict though.

But an API that isn't strict is useless. If the behaviour of a PWM isn't
predictable, how can you use it to drive a backlight. If at any point it
could just go 100% and turn on the backlight to full brightness, how can
anyone use it for anything sensible?

> > Are you aware of this:
> >=20
> > 	http://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D69987
> >=20
> > This seems to address exactly the problem that you're describing. The
> > solution matches what I had expected a fix for this problem to look
> > like. Can you try it and see if that fixes the issue?
>=20
> Right. Apart from bugs in it (for example
> http://patchwork.ozlabs.org/patch/981774/ does never configure the gpio
> as output) this would solve the issue for sure. This doesn't void my
> arguments to relax the PWM API though. Also look at the costs: The patch
> adds 86 lines to the imx driver complicating it considerably.

Now you're just being dramatic. 86 lines of code is not a lot. And I
don't think it's complicated. I'm willing to carry the burden of those
86 lines of code if it fixes the issue for good.

>                                                               Each
> machine that wants to profit of this change has to adapt it's device
> tree to make the additional pinmuxing and gpio known.
> To be fair, my change doesn't fix the gap between pinctrl being active
> and the actual enablement of the pwm. But this could be better solved in
> the pwm framework without touching any hardware driver with pinctrl
> mechanism that are already in place. (Make use of the "init" pinctrl
> state and only switch to "default" when the pwm is configured.)
> There is nothing imx-pwm specific in hooking a gpio and adapting the
> pinmuxing in it. So if you want to go this path, please implement it in
> a generic way such that all pwm devices could benefit.

You're wrong. Judging by all the evidence that we have at this point,
this is exactly an imx-pwm specific issue, therefore the burden is on
the imx-pwm driver to implement a solution for it. If there ever is a
second driver that has this issue we can revisit moving this into the
core. I don't see any reason to do so at this point in time with the
information that we have.

> > It looks as if that also fixes the shutdown problem, so it's better than
> > what you're proposing here yet it doesn't require any API change at all
> > to make it work.
>=20
> I don't care much about the shutdown problem. (Also, if the imx-pwm
> driver is unbound, the gpio is freed, too, so it's only by chance if the
> level is kept.)

Who else do you think would use the GPIO and change the level? If you've
got multiple concurrent users of the pin that's a whole other problem. I
also don't see why you wouldn't want to care about the shutdown problem.
It's annoying if you shut down the device and all of a sudden your
backlight comes back up again, perhaps in the middle of the display
controller shutting down and producing garbage on the screen.

>=20
> > > > What you're currently proposing is unjustified at this point: you're
> > > > trying to work around an issue specific to i.MX by changing an API =
that
> > > > has worked fine for everyone else for a decade.
> > >=20
> > > I don't agree here. The PWM API as it is now would make it necessary
> > > that the imx driver becomes ugly.
> >=20
> > Beauty is very subjective. This doesn't count as an argument. Michal's
> > proposed solution looks perfectly fine.
>=20
> In this case the opposite of ugly is "simple". This is a real argument.
> And this is a reason to apply my idea. It simplifies stuff and solves
> some problems.
>=20
> A framework is good if it is general enough to cover all use cases for
> its users and demands very little from it's implementors. Each callback
> to implement by a hardware driver should be as simple as possible.
> Implying "keep the pin level constant" in .disable makes it more
> complicated for some drivers. So this is a bad restriction that should
> better be dropped if there are no relvant downsides.

Okay, so I'm not suggesting that pwm_disable() keep the pin level
constant. What I was proposing is that it be required to set the pin
level to "off" (whatever that means). And the reason for doing that is
because there are relevant downsides if we leave this undefined, as I
described at length above.

> Sidenote: With the current capabilities of the pwm framework there is no
> technical reason to expose to the hardware drivers that the pwm user uses
> inverted logic. The framework could just apply
>=20
> 	duty =3D period - duty;
>=20
> before calling the hardware specific .config callback and so allow to
> simplify some drivers, reducing complexity to a single place.

No, you're wrong. If you only consider the case of a backlight or an
LED, then yes, you could simplify it that way. However there are other
use-cases that require more fine-grained control and in those cases the
actual edges of the PWM are important.

Also, this has been discussed before and I have said elsewhere that I
have no objection to adding a helper that would simplify this for
consumers that don't care about the difference.

> > > By changing the semantic of the API
> > >=20
> > >  - the i.MX driver can be implemented nicely;
> > >  - the other drivers for "saner" hardware can stay as they are;
> > >  - the API users can still express all their needs;
> > >  - the API stops having two ways to express the same needs;
> >=20
> > Again, duty-cycle =3D 0 is not the same as setting the state to disable=
d.
> >=20
> > Practically they usually have the same effect, but that's just because
> > in the typical use-case we don't care about the subtle differences.
>=20
> I fail to see the subtle difference.

That's okay. I've tried my best to describe it to you in different ways.
If I still haven't been able to convey this, I don't know what else to
say.

> > >  - most API users can be simplified because they can drop
> > >      if (duty =3D=3D 0) pwm_disable()
> > >  - on i.MX the clock can be disabled when not needed saving some ener=
gy;
> >=20
> > That's one reason why we have pwm_disable(). It's what you use to save
> > some energy if you don't need the PWM. Also, you claim that if the clock
> > is disabled the attached backlight will turn on at full brightness, so I
> > fail to see how this would work.
>=20
> As long as you care about the backlight to be off, don't disable the
> pwm. And if in this state the clk can be disabled, then this should be
> done without an additional poke by the hardware driver which is the only
> place that can know for sure that it is safe to do so. There is no good
> reason to let the pwm user have to know that the currently configured
> state might make some energy saving possible and impose the burden on
> him to then call pwm_disable().

This doesn't have anything to do with consumers knowing about potential
energy savings. All we do is give the consumers an opportunity to say: I
need the PWM to be enabled because I want to use the PWM signal now or I
don't really need the PWM signal any more, just stop sending a signal.
This is merely a hint from the consumer. What the driver does with it is
ultimately up to the driver. If the driver wants to disable the clock
when the duty cycle goes to zero because it knows that it is safe to do
so, then by all means, feel free to do that.

> > Also, you leave out the fact that even after all this work that touches
> > all users and all PWM drivers you still don't get fully correct
> > functionality on your devices because when the driver is removed or shut
> > down you run into the same problem.
>=20
> It's ok for me that all bets are off when the driver is removed.

Well, it's not okay for me. Especially if we can do better.

>                                                                  I'm
> happy when I fix the problem during active operation because on the
> machine I currently care about the shutdown problem isn't relevant.

Why is it not relevant? Surely at some point you will want to shut down
that machine. And even if not, imx-pwm is used by others and they do
seem to care about shutdown, so they should have a say in the matter as
well.

> (Also as noted above, even Michal's patch doesn't solve the problem
> formally.)

Now I'm confused, you said above that "Apart from bugs in it ... this
would solve the issue for sure". So which one is it?

> > > Regarding you claim that the API worked fine for a decade: I tried
> > > already in 2013 to address this problem. And even independent of that,
> > > that is not a good reason to not improve stuff.
> >=20
> > My claim was that it has worked fine "for everyone else". I know that
> > this has been an issue on i.MX for a long time and I've done my best to
> > lay out why I think your proposal is not the right way to fix it.
>=20
> I still fail to see a single technical reason to not evolve the API. I
> read from your mails:
>=20
>  - it has been like that for ages
>  - it works for everyone but i.MX
>  - it could be made working for i.MX by involving pinctrl and gpio in
>    the hardware specific pwm driver.
>=20
> Did I miss anything? None of these justifies to keep the status quo in
> my eyes.

I don't understand your logic here. You want to change the API, so the
burden is on you to convince me *why* it needs to be changed. So far you
have not been able to do that, so don't try to turn this around and make
me come up with reasons why it shouldn't change.

Thierry

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlu/O0QACgkQ3SOs138+
s6FHWxAAmJ3zq6pda61QD/26SEaaYwdlgmr57RQc2ameAPff0UkVjEFQqE5Djhp6
Axz9B3Ek+Yv5KojTapjnCFbq39ePOptmn3rGrBqEABS7UL6YTR0qQLBNCFeNl5lH
O31UMQAYIka8WmfLCoMqMT2RItbbund1O5uo/L32lyz6oGMd4N1LOby/v1CSham1
cm1qWygA3pqBHpzaHvqiK4Pig7MjokBHsMmmm8l5Amx60o2qlXHqx1qT/2kUimYS
dWa1XphNhdKFV99NCnSs52U0pRlzZAHjVaFprutTKbERx1HZmaMrX0xl+5fyf77t
j1VOFPdXPDG4p7EzyWKROvChQnwmgwUzxef+oRhcc+TxbNliMGBUrMOZjMiJvsB+
72M1wKOSZ2iEunYDh2mezJfP/7QxE5wxNooG3uUbqihYUQlhm23W1TGn+4VHLgCN
xxxdDZ86oex8PSfq1S0uV8DbsFk73ntHrJzdWYtyfC79ooSU7wGeOhVsfKCUgifm
6Vxjz/1iB3VAP7gyh4zzu/K2XF8Vxg3fSUxOy2N/UYqpKftQnNx4+Pt0hPojbdFS
JmcOFAtka8EQS7XuyyBrJaWnCVqCMFb2mJJzgyOCf2aDqYRazCnkqsaz9+WgCyB9
4VgkcSV5frtN740bhYOqrHlry5IFl9pPJ5m3oHPMR8d67zW2smk=
=Li9q
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
