Return-path: <kernel-bounces@pengutronix.de>
Date: Thu, 9 Aug 2018 17:23:30 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: RFC: don't let drivers issue pwm_disable after pwm_config(pwm,
 0, period)
Message-ID: <20180809152329.s6othcezo4enj3xg@pengutronix.de>
References: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
 <20180809113054.GH21639@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180809113054.GH21639@ulmo>
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
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

Hello Thierry,

On Thu, Aug 09, 2018 at 01:30:54PM +0200, Thierry Reding wrote:
> On Mon, Aug 06, 2018 at 05:51:29PM +0200, Uwe Kleine-K=F6nig wrote:
> > (If you have a d=E9j=E0 vu: Yes, I tried to argue this case already in =
the
> > past, it's just that I'm just faced with a new use case that's broken
> > with the current state.)
> >=20
> > Currently the idiom
> >=20
> > 	pwm_config(mypwm, value, period);
> > 	if (!value)
> > 		pwm_disable(mypwm);
> > 	else
> > 		pwm_enable(mypwm);
> >=20
> > (and it's equivalent:
> >=20
> > 	state.duty_cycle =3D ...
> > 	state.enable =3D state.duty_cycle ? true : false;
> > 	pwm_apply_state(...);
> >=20
> > ) is quite present in the kernel.
> >=20
> > In my eyes this is bad for two reasons:
> >=20
> >  a) if the caller is supposed to call pwm_disable() after configuring t=
he
> >     duty cycle to zero, then why doesn't pwm_config() contains this to
> >     unburden pwm-API users and so reduce open coding this assumption?
>=20
> That's because it's not true in all cases. pwm_disable() is not
> equivalent to setting the duty cycle to zero. Many users don't care
> about the difference, but that doesn't mean it should be assumed to
> be always the case.

I cannot follow you. You're saying that pwm_disable() is not the same as
duty-cycle :=3D 0. That's different from what I said. I only talked about
pwm_disable() after config(pwm, duty=3D0, period).

Actually the current semantic of pwm_disable isn't clear to me. Is it:
"Freeze the pin in the current state"? If so, this isn't possible to
implement for some hardware I know. If it's like that, the pin state is
undefined after pwm_disable unless the duty-cycle was 0% or 100%
before, right?

> >  b) it is actually wrong in at least two cases:
> >     - On i.MX28 pwm_config(mypwm, 0, period) only programs a register
> >       and only after the current period is elapsed this is clocked into
> >       the hardware. So it is very likely that when pwm_disable() is
> >       called the period is still not over, and then the clk is disabled
> >       and the period never ends resulting in the pwm pin being frozen in
> >       whatever state it happend to be when the clk was stopped.
>=20
> So that's a driver bug then. By definition, after the call to
> pwm_config() completes, the hardware should be in the configured state.
> If a device doesn't allow the programming to happen immediately, then it
> is up to the driver to ensure it waits long enough for the settings to
> have been properly applied.

Unfortunately there is no way (that I know of at least) to notice when a
period is over, so only an unconditional delay/sleep is the way out
here.
=20
> >     - on i.MX6 if a pwm is inverted pwm_config(mypwm, 0, period)
> >       correctly ensures the PWM pin to stay at 1. But then pwm_disable()
> >       puts it to 0. In the current case this implies that the backlight
> >       is fully enabled instead of off.
>=20
> Again, that's a driver bug. pwm_disable() isn't supposed to change the
> pin polarity. It's not supposed to change the pin level.

So the disable callback must look as follows:

	def imx_pwm_disable(pwm):
	    state =3D pwm_get_state(...)
	    if state.polarity =3D=3D PWM_POLARITY_INVERSED:
	        return

	    hw_access_to_disable_pwm()

(Alternatively the pin could be configured to gpio, the right level set
and the hw disable unconditionally.)

And actually because for an inverted polarity after setting the
duty_cycle to 100% it is possible to already disable the hardware in the
config callback. And for the users that config for duty=3D0 but don't call
pwm_disable() the symmetric case could be handled, too, so the config
callback optimally looks like:

	def imx_pwm_config(chip, duty, period):
	    state =3D pwm_get_state(...)
	    if (duty =3D=3D 0 and not state.polarity =3D=3D PWM_POLARITY_INVERSED)=
 ||
	       (duty =3D=3D period and state.polarity =3D=3D PWM_POLARITY_INVERSED=
):
	        hw_access_to_disable_pwm()
	    else:
	        hw_access_to_config(duty, period)

The obvious downsides are:

  a) if pwm_disable() was called because the user doesn't need the pwm to
     toggle any more, it stays enabled.
  b) pwm_disable() after pwm_config() that allows to disable the
     hardware, is a noop

So it would be much saner from the backend implementations POV if the
PWM-API user doesn't call pwm_disable() if he cares about the output
level of the pin. And I cannot imagine any pwm implementation where this
requirement would make the implementation worse.

Unless I miss something currently there is no user-visible effect of
calling pwm_disable after duty was set to 0. So as an API-user I cannot
differentiate between

 - set the output to low; and
 - don't care about the pwm pin state, turn off and save power

All downsides could be fixed if the only way to set the output to low
would be

	pwm_config(pwm, 0, period);

and pwm_disable() would imply to turn off with no guarantees about the pin
state.

This would simplify some drivers but not complicate any.

This would make the API more expressive because it allows to
differentiate between "output low" and "power off".

The only downside I see is that all users must be reviewed and
eventually fixed for the slightly different semantic. Parts of that was
already done in my patch in the previous mail.

> > Both issues are hard (or at least ugly) to fix. The IMHO most sane
> > approach is to not let PWM-API-users care about power saving when they
> > still care about the output level and update the samantic of
> > pwm_disable() (and struct pwm_state::enabled =3D=3D 0) to mean: "Stop
> > toggling, I don't care about the level of the output." in contrast to
> > the current semantic "Stop toggling. If pwm_config(mypwm, 0, period) was
> > called before, stop the pin at (maybe inverted) low level (for most pwms
> > at least).".
>=20
> I don't see how you could make that work. In practically all cases a
> pwm_disable() would have to be assumed to cause the pin level to become
> undefined. That makes it pretty much useless.

Right, that's what I want. pwm_disable() should make no guarantees about
the pin level. So only call it if you don't care about the pin state. If
you care, only do

	pwm_config(pwm, duty=3D0, period);

and let the backend driver save power if it possible already in the
corresponding callback.

That is actually easier and more expressive! Currently the semantic of
pwm_disable() is ambiguous. The two possible meanings are:

   - save power and keep the pin state
   - save power

and the backend driver cannot know which one the caller actually wants.
So the only way is to assume the stronger one and keep the pin state
which results in more power usage for some hardware.

> > This is in my eyes more clear, removes code duplication and power saving
> > can (and should) be implemented in the pwm backend drivers that have the
> > domain specific knowledge about the effects of pwm_disable and
> > eventually unwanted side effects when duty cycle is 0 and just do the
> > corresponding action if its safe. We could even put something like:
> >=20
> > 	if (pwm->flags & PWM_AUTO_DISABLE && pwm->period =3D=3D 0)
> > 		pwm_disable(pwm);
> >=20
> > in pwm_config to help backend driver authors of "sane" PWMs.
>=20
> I agree that this is simpler and clearer. However it also significantly
> reduces the flexibility of the API, and I'm not sure that it is enough.
> Again, yes, for many cases this is sufficient, but it doesn't fully
> expose the capabilities of hardware.

Can you show me a use case that isn't possible to express with the
suggested change in semantic?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
