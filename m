Return-path: <kernel-bounces@pengutronix.de>
Date: Tue, 9 Oct 2018 11:35:54 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: RFC: don't let drivers issue pwm_disable after pwm_config(pwm,
 0, period)
Message-ID: <20181009093554.ugfxek3n4wacc7px@pengutronix.de>
References: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
 <20181009075345.GB5565@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181009075345.GB5565@ulmo>
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

On Tue, Oct 09, 2018 at 09:53:45AM +0200, Thierry Reding wrote:
> On Mon, Aug 06, 2018 at 05:51:29PM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello Thierry,
> >=20
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
> Just to reiterate my thoughts on this: while the config/enable/disable
> split may seem arbitrary for some use-cases (you may argue most
> use-cases, and you'd probably be right), I think there's value in having
> the additional flexibility to explicitly turn off the PWM. Also, duty
> cycle of zero doesn't always mean "off". If your PWM is inverted, then
> the duty cycle of zero actually means "on". And that of course also
> still depends on other components on your board.

Did you notice you didn't argue against me here? We seem to agree that
calling disabling a PWM after setting the duty cycle to zero is bad.

> You may have an inverter somewhere, or you may actually be driving a
> circuit that expects an inverted PWM.
>=20
> So saying that duty-cycle of 0 equals disable is simplifying things too
> much, in my opinion.

Full ack. So let's fix the users to not call pwm_disable after setting
the duty cycle to zero!

Really, only the driver knows when it's safe to disable the clock while
it's expected to keep the pin at a given state. So better don't expect a
certain state after pwm_disable().

> >  b) it is actually wrong in at least two cases:
> >     - On i.MX28 pwm_config(mypwm, 0, period) only programs a register
> >       and only after the current period is elapsed this is clocked into
> >       the hardware. So it is very likely that when pwm_disable() is
> >       called the period is still not over, and then the clk is disabled
> >       and the period never ends resulting in the pwm pin being frozen in
> >       whatever state it happend to be when the clk was stopped.
> >     - on i.MX6 if a pwm is inverted pwm_config(mypwm, 0, period)
> >       correctly ensures the PWM pin to stay at 1. But then pwm_disable()
> >       puts it to 0. In the current case this implies that the backlight
> >       is fully enabled instead of off.
>=20
> I think I've explained this in the past: these are i.MX specific issues
> that you need to work around in the driver.

I'd say: The i.MX PWM doesn't match the idealised idea of a PWM that can
(in a sane way) be mapped by the current PWM API. That's because there
are assumptions in the API that are wrong for i.MX. Still the hardware
allows to implement all use cases. That's a sign that the API is bad and
is in need for generalisation.

> It's also mostly orthogonal
> to the API issue because consider the case where you want to unload the
> PWM driver on your board. Your remove function would need disable all
> PWM channels in order to properly clean up the device, but if you do
> that, then your backlight would turn fully on, right?

Right. I cannot fix all hardware problems in software. But with my
suggested change I can at least make it as good as possible in software
without having to resort to ugly hacks.
=20
> On that note, I'm not sure I understand how this would even work, since
> you should have the very same state on boot. I'm assuming here that the
> PWM will be off at boot time by default, in which case, given that it's
> disabled, it should cause the backlight to turn on. How do you solve
> that problem? Or if it's not a problem at boot, why does it become a
> problem on PWM disable or driver removal?

Most of the time it's not a problem during boot because the pin is muxed
as input. But when the clock of the i.MX PWM is disabled it actively
drives a zero. And I already had cases where there really was a problem
during boot until the bootloader fixed the stuff in software. For these
cases I need patches ("hacks") that remove calls to pwm_disable in the
backlight driver to at least work around the issue during runtime, which
is the best that can be done in software.
=20
> What you're currently proposing is unjustified at this point: you're
> trying to work around an issue specific to i.MX by changing an API that
> has worked fine for everyone else for a decade.

I don't agree here. The PWM API as it is now would make it necessary
that the imx driver becomes ugly. By changing the semantic of the API

 - the i.MX driver can be implemented nicely;
 - the other drivers for "saner" hardware can stay as they are;
 - the API users can still express all their needs;
 - the API stops having two ways to express the same needs;
 - most API users can be simplified because they can drop
     if (duty =3D=3D 0) pwm_disable()
 - on i.MX the clock can be disabled when not needed saving some energy;

Regarding you claim that the API worked fine for a decade: I tried
already in 2013 to address this problem. And even independent of that,
that is not a good reason to not improve stuff.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
