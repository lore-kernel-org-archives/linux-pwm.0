Return-path: <kernel-bounces@pengutronix.de>
Date: Tue, 9 Oct 2018 09:53:45 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20181009075345.GB5565@ulmo>
References: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
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
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 06, 2018 at 05:51:29PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> (If you have a d=C3=A9j=C3=A0 vu: Yes, I tried to argue this case already=
 in the
> past, it's just that I'm just faced with a new use case that's broken
> with the current state.)
>=20
> Currently the idiom
>=20
> 	pwm_config(mypwm, value, period);
> 	if (!value)
> 		pwm_disable(mypwm);
> 	else
> 		pwm_enable(mypwm);
>=20
> (and it's equivalent:
>=20
> 	state.duty_cycle =3D ...
> 	state.enable =3D state.duty_cycle ? true : false;
> 	pwm_apply_state(...);
>=20
> ) is quite present in the kernel.
>=20
> In my eyes this is bad for two reasons:
>=20
>  a) if the caller is supposed to call pwm_disable() after configuring the
>     duty cycle to zero, then why doesn't pwm_config() contains this to
>     unburden pwm-API users and so reduce open coding this assumption?

Just to reiterate my thoughts on this: while the config/enable/disable
split may seem arbitrary for some use-cases (you may argue most
use-cases, and you'd probably be right), I think there's value in having
the additional flexibility to explicitly turn off the PWM. Also, duty
cycle of zero doesn't always mean "off". If your PWM is inverted, then
the duty cycle of zero actually means "on". And that of course also
still depends on other components on your board. You may have an
inverter somewhere, or you may actually be driving a circuit that
expects an inverted PWM.

So saying that duty-cycle of 0 equals disable is simplifying things too
much, in my opinion.

>  b) it is actually wrong in at least two cases:
>     - On i.MX28 pwm_config(mypwm, 0, period) only programs a register
>       and only after the current period is elapsed this is clocked into
>       the hardware. So it is very likely that when pwm_disable() is
>       called the period is still not over, and then the clk is disabled
>       and the period never ends resulting in the pwm pin being frozen in
>       whatever state it happend to be when the clk was stopped.
>     - on i.MX6 if a pwm is inverted pwm_config(mypwm, 0, period)
>       correctly ensures the PWM pin to stay at 1. But then pwm_disable()
>       puts it to 0. In the current case this implies that the backlight
>       is fully enabled instead of off.

I think I've explained this in the past: these are i.MX specific issues
that you need to work around in the driver. It's also mostly orthogonal
to the API issue because consider the case where you want to unload the
PWM driver on your board. Your remove function would need disable all
PWM channels in order to properly clean up the device, but if you do
that, then your backlight would turn fully on, right?

On that note, I'm not sure I understand how this would even work, since
you should have the very same state on boot. I'm assuming here that the
PWM will be off at boot time by default, in which case, given that it's
disabled, it should cause the backlight to turn on. How do you solve
that problem? Or if it's not a problem at boot, why does it become a
problem on PWM disable or driver removal?

What you're currently proposing is unjustified at this point: you're
trying to work around an issue specific to i.MX by changing an API that
has worked fine for everyone else for a decade.

Thierry

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlu8XoQACgkQ3SOs138+
s6HE9xAAvcPclDblf/8hNP3PdifXMJLsDVeQOU6bdG1H1MeVkNlDkgEH0iIckcy+
KJ/RnPr8YMHUpsj7ONVpAYvK51fEeo4a54FGKi/smvsmaoLDUiziYKYLTWwtLolL
08GjllgbBYH/SfDQsnWfps6J/3Ga+lkZisY7DfvNHalQ7hGWvPq+TH2UkFmxFFVI
PYCFOzJWK4aDdf+v7ilEB6yPMj/s34MIrs+nmNT53Pu9i2qdEOdCDyMqr2aL+/LQ
wmWBUJrEIfkehpjCYWZGEjw3MW0ymSPup69MJIGa7SzQOhAG1h0cYkzFw0uEIZR0
Jgn1rVc4TqAnVWRVCN8y2CnIxvgAFFXrVjTuYuA0iuIIcSIltkZewLaw3gRV8b9f
52ffUfCjLgYP+1TNYFMrNNVJphNhL3DhpNveykSvkUVyK6XN/ibzh0bkGOD8coHY
cORrd6KD9uxwLsJ3l5ebC96qxrokCSnhRuW/axKWPdhCQnZW+IPodyNU0LMSHmKM
yuK/m6gygZWykOfLO4mQ3DKuR3KUDlRGq/n4rtBrfxnzrizSn5d4UpDQNTCGbFbx
YXr7SRhFIp8iEky06FLS4O0qFSxEtwkYDndL3WoMryEBXwbhZnL+/LCv26hfJ6Bi
zTQLbTZSHYWa+SxqL67R6ZHDfYucaUfLCkpaYpJ35HU9/NrJKDU=
=J5Me
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
