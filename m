Return-path: <kernel-bounces@pengutronix.de>
Date: Thu, 11 Oct 2018 12:19:14 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: RFC: don't let drivers issue pwm_disable after pwm_config(pwm,
 0, period)
Message-ID: <20181011101914.dapsvczsd4lteugk@pengutronix.de>
References: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
 <20181009075345.GB5565@ulmo>
 <20181009093554.ugfxek3n4wacc7px@pengutronix.de>
 <20181010122607.GA21134@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181010122607.GA21134@ulmo>
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

On Wed, Oct 10, 2018 at 02:26:07PM +0200, Thierry Reding wrote:
> On Tue, Oct 09, 2018 at 11:35:54AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Oct 09, 2018 at 09:53:45AM +0200, Thierry Reding wrote:
> > > On Mon, Aug 06, 2018 at 05:51:29PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > Hello Thierry,
> > > >=20
> > > > (If you have a d=E9j=E0 vu: Yes, I tried to argue this case already=
 in the
> > > > past, it's just that I'm just faced with a new use case that's brok=
en
> > > > with the current state.)
> > > >=20
> > > > Currently the idiom
> > > >=20
> > > > 	pwm_config(mypwm, value, period);
> > > > 	if (!value)
> > > > 		pwm_disable(mypwm);
> > > > 	else
> > > > 		pwm_enable(mypwm);
> > > >=20
> > > > (and it's equivalent:
> > > >=20
> > > > 	state.duty_cycle =3D ...
> > > > 	state.enable =3D state.duty_cycle ? true : false;
> > > > 	pwm_apply_state(...);
> > > >=20
> > > > ) is quite present in the kernel.
> > > >=20
> > > > In my eyes this is bad for two reasons:
> > > >=20
> > > >  a) if the caller is supposed to call pwm_disable() after configuri=
ng the
> > > >     duty cycle to zero, then why doesn't pwm_config() contains this=
 to
> > > >     unburden pwm-API users and so reduce open coding this assumptio=
n?
> > >=20
> > > Just to reiterate my thoughts on this: while the config/enable/disable
> > > split may seem arbitrary for some use-cases (you may argue most
> > > use-cases, and you'd probably be right), I think there's value in hav=
ing
> > > the additional flexibility to explicitly turn off the PWM. Also, duty
> > > cycle of zero doesn't always mean "off". If your PWM is inverted, then
> > > the duty cycle of zero actually means "on". And that of course also
> > > still depends on other components on your board.
> >=20
> > Did you notice you didn't argue against me here? We seem to agree that
> > calling disabling a PWM after setting the duty cycle to zero is bad.

You wrote "Also, duty cycle of zero doesn't always mean \"off\"." but
also don't seem to refuse to change pwm users that do:

	pwm_config(pwm, 0, 100);
	pwm_disable(pwm);

I interpreted your sentence as confirmation that this sequence isn't
correct in general.

Where is the difference you care about between duty=3D0 and disabled?

> I don't see why you think I agree with that. The only thing I'm saying
> is that pwm_config() shouldn't assume that a duty-cycle of 0 means the
> same as the PWM being disabled.

What is in your view the current difference for the hardware behind the
PWM?

> > > You may have an inverter somewhere, or you may actually be driving a
> > > circuit that expects an inverted PWM.
> > >=20
> > > So saying that duty-cycle of 0 equals disable is simplifying things t=
oo
> > > much, in my opinion.
> >=20
> > Full ack. So let's fix the users to not call pwm_disable after setting
> > the duty cycle to zero!
>=20
> I don't understand why you come to that conclusion. It seems like we at
> least agree on what the problem is and what potential issues there could
> be with different setups.
>=20
> The point that we don't agree with is how to fix this.

ack.

> > Really, only the driver knows when it's safe to disable the clock while
> > it's expected to keep the pin at a given state. So better don't expect a
> > certain state after pwm_disable().
>=20
> Yes, I agree that only the driver knows when it is safe to do so, but I
> still fail to understand why we should change the API in order to
> accomodate the specifics of a particular driver.

The incentive to change the API is a combination of:

 - The restriction to keep the pin driving at a certain level after
   disable isn't a natural and obvious property of the hardware.
   The designers of the imx-pwm for example did it differently.

 - The change removes ambiguity from from the demands on the hardware
   drivers.

 - The change doesn't make the API less expressive.

 - The change doesn't doesn't complicate anmy pwm hardware driver.

 - The change allows to simplify most pwm users.

 - The change simplifies the imx-pwm driver.

In my experience this is enough to justify such a change.

> So we already know that currently all users expect that the pin state
> after disable will be low (because they previously set duty cycle to 0,
> which is the active equivalent of low).

My theory is that most users don't expect this and/or don't make use of
it. As of 9dcd936c5312 we have 50 pwm drivers
($(wc -l drivers/pwm/Makefile) - 3). At most 17 of them handle inversion
at all. ($(git grep -l PWM_POLARITY_INVERSED drivers/pwm/pwm-* | wc -l),
and I think there are a few false positive matches, pwm-sun4i.c for
example). I'd be willing to bet that as of now imx isn't the only driver
with this problem.

> Given that stricter definition,
> the i.MX PWM driver becomes buggy because it doesn't guarantee that pin
> state. I think the fix for that is for the i.MX PWM driver to make sure
> the pin state doesn't actually change on ->disable(). If that means the
> clock needs to remain on, then that's exactly what the driver should be
> implementing.

Yes, if we keep the API "stricter" this is what should be done. This
doesn't justify to keep the API strict though.

> Are you aware of this:
>=20
> 	http://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D69987
>=20
> This seems to address exactly the problem that you're describing. The
> solution matches what I had expected a fix for this problem to look
> like. Can you try it and see if that fixes the issue?

Right. Apart from bugs in it (for example
http://patchwork.ozlabs.org/patch/981774/ does never configure the gpio
as output) this would solve the issue for sure. This doesn't void my
arguments to relax the PWM API though. Also look at the costs: The patch
adds 86 lines to the imx driver complicating it considerably. Each
machine that wants to profit of this change has to adapt it's device
tree to make the additional pinmuxing and gpio known.
To be fair, my change doesn't fix the gap between pinctrl being active
and the actual enablement of the pwm. But this could be better solved in
the pwm framework without touching any hardware driver with pinctrl
mechanism that are already in place. (Make use of the "init" pinctrl
state and only switch to "default" when the pwm is configured.)
There is nothing imx-pwm specific in hooking a gpio and adapting the
pinmuxing in it. So if you want to go this path, please implement it in
a generic way such that all pwm devices could benefit.

> It looks as if that also fixes the shutdown problem, so it's better than
> what you're proposing here yet it doesn't require any API change at all
> to make it work.

I don't care much about the shutdown problem. (Also, if the imx-pwm
driver is unbound, the gpio is freed, too, so it's only by chance if the
level is kept.)

> > > What you're currently proposing is unjustified at this point: you're
> > > trying to work around an issue specific to i.MX by changing an API th=
at
> > > has worked fine for everyone else for a decade.
> >=20
> > I don't agree here. The PWM API as it is now would make it necessary
> > that the imx driver becomes ugly.
>=20
> Beauty is very subjective. This doesn't count as an argument. Michal's
> proposed solution looks perfectly fine.

In this case the opposite of ugly is "simple". This is a real argument.
And this is a reason to apply my idea. It simplifies stuff and solves
some problems.

A framework is good if it is general enough to cover all use cases for
its users and demands very little from it's implementors. Each callback
to implement by a hardware driver should be as simple as possible.
Implying "keep the pin level constant" in .disable makes it more
complicated for some drivers. So this is a bad restriction that should
better be dropped if there are no relvant downsides.

Sidenote: With the current capabilities of the pwm framework there is no
technical reason to expose to the hardware drivers that the pwm user uses
inverted logic. The framework could just apply

	duty =3D period - duty;

before calling the hardware specific .config callback and so allow to
simplify some drivers, reducing complexity to a single place.

> > By changing the semantic of the API
> >=20
> >  - the i.MX driver can be implemented nicely;
> >  - the other drivers for "saner" hardware can stay as they are;
> >  - the API users can still express all their needs;
> >  - the API stops having two ways to express the same needs;
>=20
> Again, duty-cycle =3D 0 is not the same as setting the state to disabled.
>=20
> Practically they usually have the same effect, but that's just because
> in the typical use-case we don't care about the subtle differences.

I fail to see the subtle difference.

> >  - most API users can be simplified because they can drop
> >      if (duty =3D=3D 0) pwm_disable()
> >  - on i.MX the clock can be disabled when not needed saving some energy;
>=20
> That's one reason why we have pwm_disable(). It's what you use to save
> some energy if you don't need the PWM. Also, you claim that if the clock
> is disabled the attached backlight will turn on at full brightness, so I
> fail to see how this would work.

As long as you care about the backlight to be off, don't disable the
pwm. And if in this state the clk can be disabled, then this should be
done without an additional poke by the hardware driver which is the only
place that can know for sure that it is safe to do so. There is no good
reason to let the pwm user have to know that the currently configured
state might make some energy saving possible and impose the burden on
him to then call pwm_disable().

> Also, you leave out the fact that even after all this work that touches
> all users and all PWM drivers you still don't get fully correct
> functionality on your devices because when the driver is removed or shut
> down you run into the same problem.

It's ok for me that all bets are off when the driver is removed. I'm
happy when I fix the problem during active operation because on the
machine I currently care about the shutdown problem isn't relevant.
(Also as noted above, even Michal's patch doesn't solve the problem
formally.)

> > Regarding you claim that the API worked fine for a decade: I tried
> > already in 2013 to address this problem. And even independent of that,
> > that is not a good reason to not improve stuff.
>=20
> My claim was that it has worked fine "for everyone else". I know that
> this has been an issue on i.MX for a long time and I've done my best to
> lay out why I think your proposal is not the right way to fix it.

I still fail to see a single technical reason to not evolve the API. I
read from your mails:

 - it has been like that for ages
 - it works for everyone but i.MX
 - it could be made working for i.MX by involving pinctrl and gpio in
   the hardware specific pwm driver.

Did I miss anything? None of these justifies to keep the status quo in
my eyes.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
