Return-path: <kernel-bounces@pengutronix.de>
Date: Wed, 10 Oct 2018 14:26:07 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20181010122607.GA21134@ulmo>
References: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
 <20181009075345.GB5565@ulmo>
 <20181009093554.ugfxek3n4wacc7px@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20181009093554.ugfxek3n4wacc7px@pengutronix.de>
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


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 09, 2018 at 11:35:54AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Tue, Oct 09, 2018 at 09:53:45AM +0200, Thierry Reding wrote:
> > On Mon, Aug 06, 2018 at 05:51:29PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > Hello Thierry,
> > >=20
> > > (If you have a d=C3=A9j=C3=A0 vu: Yes, I tried to argue this case alr=
eady in the
> > > past, it's just that I'm just faced with a new use case that's broken
> > > with the current state.)
> > >=20
> > > Currently the idiom
> > >=20
> > > 	pwm_config(mypwm, value, period);
> > > 	if (!value)
> > > 		pwm_disable(mypwm);
> > > 	else
> > > 		pwm_enable(mypwm);
> > >=20
> > > (and it's equivalent:
> > >=20
> > > 	state.duty_cycle =3D ...
> > > 	state.enable =3D state.duty_cycle ? true : false;
> > > 	pwm_apply_state(...);
> > >=20
> > > ) is quite present in the kernel.
> > >=20
> > > In my eyes this is bad for two reasons:
> > >=20
> > >  a) if the caller is supposed to call pwm_disable() after configuring=
 the
> > >     duty cycle to zero, then why doesn't pwm_config() contains this to
> > >     unburden pwm-API users and so reduce open coding this assumption?
> >=20
> > Just to reiterate my thoughts on this: while the config/enable/disable
> > split may seem arbitrary for some use-cases (you may argue most
> > use-cases, and you'd probably be right), I think there's value in having
> > the additional flexibility to explicitly turn off the PWM. Also, duty
> > cycle of zero doesn't always mean "off". If your PWM is inverted, then
> > the duty cycle of zero actually means "on". And that of course also
> > still depends on other components on your board.
>=20
> Did you notice you didn't argue against me here? We seem to agree that
> calling disabling a PWM after setting the duty cycle to zero is bad.

I don't see why you think I agree with that. The only thing I'm saying
is that pwm_config() shouldn't assume that a duty-cycle of 0 means the
same as the PWM being disabled.

> > You may have an inverter somewhere, or you may actually be driving a
> > circuit that expects an inverted PWM.
> >=20
> > So saying that duty-cycle of 0 equals disable is simplifying things too
> > much, in my opinion.
>=20
> Full ack. So let's fix the users to not call pwm_disable after setting
> the duty cycle to zero!

I don't understand why you come to that conclusion. It seems like we at
least agree on what the problem is and what potential issues there could
be with different setups.

The point that we don't agree with is how to fix this.

> Really, only the driver knows when it's safe to disable the clock while
> it's expected to keep the pin at a given state. So better don't expect a
> certain state after pwm_disable().

Yes, I agree that only the driver knows when it is safe to do so, but I
still fail to understand why we should change the API in order to
accomodate the specifics of a particular driver.

So we already know that currently all users expect that the pin state
after disable will be low (because they previously set duty cycle to 0,
which is the active equivalent of low). Given that stricter definition,
the i.MX PWM driver becomes buggy because it doesn't guarantee that pin
state. I think the fix for that is for the i.MX PWM driver to make sure
the pin state doesn't actually change on ->disable(). If that means the
clock needs to remain on, then that's exactly what the driver should be
implementing.

> > >  b) it is actually wrong in at least two cases:
> > >     - On i.MX28 pwm_config(mypwm, 0, period) only programs a register
> > >       and only after the current period is elapsed this is clocked in=
to
> > >       the hardware. So it is very likely that when pwm_disable() is
> > >       called the period is still not over, and then the clk is disabl=
ed
> > >       and the period never ends resulting in the pwm pin being frozen=
 in
> > >       whatever state it happend to be when the clk was stopped.
> > >     - on i.MX6 if a pwm is inverted pwm_config(mypwm, 0, period)
> > >       correctly ensures the PWM pin to stay at 1. But then pwm_disabl=
e()
> > >       puts it to 0. In the current case this implies that the backlig=
ht
> > >       is fully enabled instead of off.
> >=20
> > I think I've explained this in the past: these are i.MX specific issues
> > that you need to work around in the driver.
>=20
> I'd say: The i.MX PWM doesn't match the idealised idea of a PWM that can
> (in a sane way) be mapped by the current PWM API. That's because there
> are assumptions in the API that are wrong for i.MX. Still the hardware
> allows to implement all use cases. That's a sign that the API is bad and
> is in need for generalisation.

It's perfectly fine for the driver to make any of the PWM operations a
no-op if that's what it takes to make it conform with the API.

> > It's also mostly orthogonal
> > to the API issue because consider the case where you want to unload the
> > PWM driver on your board. Your remove function would need disable all
> > PWM channels in order to properly clean up the device, but if you do
> > that, then your backlight would turn fully on, right?
>=20
> Right. I cannot fix all hardware problems in software. But with my
> suggested change I can at least make it as good as possible in software
> without having to resort to ugly hacks.
>=20
> > On that note, I'm not sure I understand how this would even work, since
> > you should have the very same state on boot. I'm assuming here that the
> > PWM will be off at boot time by default, in which case, given that it's
> > disabled, it should cause the backlight to turn on. How do you solve
> > that problem? Or if it's not a problem at boot, why does it become a
> > problem on PWM disable or driver removal?
>=20
> Most of the time it's not a problem during boot because the pin is muxed
> as input. But when the clock of the i.MX PWM is disabled it actively
> drives a zero. And I already had cases where there really was a problem
> during boot until the bootloader fixed the stuff in software. For these
> cases I need patches ("hacks") that remove calls to pwm_disable in the
> backlight driver to at least work around the issue during runtime, which
> is the best that can be done in software.

Are you aware of this:

	http://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D69987

This seems to address exactly the problem that you're describing. The
solution matches what I had expected a fix for this problem to look
like. Can you try it and see if that fixes the issue?

It looks as if that also fixes the shutdown problem, so it's better than
what you're proposing here yet it doesn't require any API change at all
to make it work.

Cc'ing Michal for visibility.

> > What you're currently proposing is unjustified at this point: you're
> > trying to work around an issue specific to i.MX by changing an API that
> > has worked fine for everyone else for a decade.
>=20
> I don't agree here. The PWM API as it is now would make it necessary
> that the imx driver becomes ugly.

Beauty is very subjective. This doesn't count as an argument. Michal's
proposed solution looks perfectly fine.

> By changing the semantic of the API
>=20
>  - the i.MX driver can be implemented nicely;
>  - the other drivers for "saner" hardware can stay as they are;
>  - the API users can still express all their needs;
>  - the API stops having two ways to express the same needs;

Again, duty-cycle =3D 0 is not the same as setting the state to disabled.
Practically they usually have the same effect, but that's just because
in the typical use-case we don't care about the subtle differences.

>  - most API users can be simplified because they can drop
>      if (duty =3D=3D 0) pwm_disable()
>  - on i.MX the clock can be disabled when not needed saving some energy;

That's one reason why we have pwm_disable(). It's what you use to save
some energy if you don't need the PWM. Also, you claim that if the clock
is disabled the attached backlight will turn on at full brightness, so I
fail to see how this would work.

Also, you leave out the fact that even after all this work that touches
all users and all PWM drivers you still don't get fully correct
functionality on your devices because when the driver is removed or shut
down you run into the same problem.

> Regarding you claim that the API worked fine for a decade: I tried
> already in 2013 to address this problem. And even independent of that,
> that is not a good reason to not improve stuff.

My claim was that it has worked fine "for everyone else". I know that
this has been an issue on i.MX for a long time and I've done my best to
lay out why I think your proposal is not the right way to fix it. The
proposal from Michal shows that there is another way that properly fixes
the issue, so let's focus on getting that to work for your use-cases.

Thierry

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlu979sACgkQ3SOs138+
s6G8EA//e22ik8MNuBwyglqkesGOiqoQKzS3jOgNz8UNM45YdlzqBtKcojyI4MAY
/hALrCuh5fhmTP01+UxrGMlJtc2STz8DGNaemy6P6Cxd8H0Ruvt4xdduNVw8OEij
ylREphuHaIKFgwNmtMo8AA2F9BOqkmNqhHsLITpn2FOv4kJSRtL+60LiMNcrHIMR
s+C987LJko+bsEBGGhdPRl91LFlJrUtjscAVZ3TXMSu0GaHEfjlaHEFocWVs6NLu
QZN4VmdV5EaJIlBNyH/2pTAj+5UUXulqXBDuMU8fTPNrXEQUDbDUiGGMBvtmbIn/
YMUmh66xghZ/pk5rliYqfICf9Z0OkJV74zQlV+Irni4IY9pe43DNnyE7OtP/kW6Y
CB3+ea/pCrE0JWI8gOAIxB4s3mA/iOzrB4XwDPsi5Tdy5Wzp/OJHJpcCv8+VqRYT
xOozk/AtcTUx4u0BHvdSVT4eZA3nW7ranzHucx5UQmkUsuU6Gmtn9DvNzm+wjQU+
2soC6RXT2NBFTHJWAPJxu8qhFPrw6114P7LJdbfGD84W67Iyojz5tp+StTWSTyxM
T4CD9f8YivK2tKJ/Q7iwJZrCLtf4eGCR1EI9v0C37sEijQRm3TBhUWITLkh9FM1M
wqScCsoni9yA+pkMoFpjC9PAedJywA2r7Uf3F5mQoMosVfqme+c=
=M54W
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
