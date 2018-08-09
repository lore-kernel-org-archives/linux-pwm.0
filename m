Return-path: <kernel-bounces@pengutronix.de>
Date: Thu, 9 Aug 2018 13:30:54 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20180809113054.GH21639@ulmo>
References: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="G44BJl3Aq1QbV/QL"
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


--G44BJl3Aq1QbV/QL
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

That's because it's not true in all cases. pwm_disable() is not
equivalent to setting the duty cycle to zero. Many users don't care
about the difference, but that doesn't mean it should be assumed to
be always the case.

>  b) it is actually wrong in at least two cases:
>     - On i.MX28 pwm_config(mypwm, 0, period) only programs a register
>       and only after the current period is elapsed this is clocked into
>       the hardware. So it is very likely that when pwm_disable() is
>       called the period is still not over, and then the clk is disabled
>       and the period never ends resulting in the pwm pin being frozen in
>       whatever state it happend to be when the clk was stopped.

So that's a driver bug then. By definition, after the call to
pwm_config() completes, the hardware should be in the configured state.
If a device doesn't allow the programming to happen immediately, then it
is up to the driver to ensure it waits long enough for the settings to
have been properly applied.

>     - on i.MX6 if a pwm is inverted pwm_config(mypwm, 0, period)
>       correctly ensures the PWM pin to stay at 1. But then pwm_disable()
>       puts it to 0. In the current case this implies that the backlight
>       is fully enabled instead of off.

Again, that's a driver bug. pwm_disable() isn't supposed to change the
pin polarity. It's not supposed to change the pin level.

> Both issues are hard (or at least ugly) to fix. The IMHO most sane
> approach is to not let PWM-API-users care about power saving when they
> still care about the output level and update the samantic of
> pwm_disable() (and struct pwm_state::enabled =3D=3D 0) to mean: "Stop
> toggling, I don't care about the level of the output." in contrast to
> the current semantic "Stop toggling. If pwm_config(mypwm, 0, period) was
> called before, stop the pin at (maybe inverted) low level (for most pwms
> at least).".

I don't see how you could make that work. In practically all cases a
pwm_disable() would have to be assumed to cause the pin level to become
undefined. That makes it pretty much useless.

> This is in my eyes more clear, removes code duplication and power saving
> can (and should) be implemented in the pwm backend drivers that have the
> domain specific knowledge about the effects of pwm_disable and
> eventually unwanted side effects when duty cycle is 0 and just do the
> corresponding action if its safe. We could even put something like:
>=20
> 	if (pwm->flags & PWM_AUTO_DISABLE && pwm->period =3D=3D 0)
> 		pwm_disable(pwm);
>=20
> in pwm_config to help backend driver authors of "sane" PWMs.

I agree that this is simpler and clearer. However it also significantly
reduces the flexibility of the API, and I'm not sure that it is enough.
Again, yes, for many cases this is sufficient, but it doesn't fully
expose the capabilities of hardware.

Thierry

--G44BJl3Aq1QbV/QL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsJewACgkQ3SOs138+
s6FiAQ/+MpTIiXhv0PH83yehPQ8E87S4NEOsrXj8JigpR01rD3Gd+pjDapQI0WTx
51DiMb3QGn8Z23I/DPaDkBUhzOuVdshVMbSXEPNo8TiKd9ywvLKMqO466FX0PyDj
hqadaDJ2hqe44GpITVqp4Uao+PdrpHO8fkSqFrKYrxhssvA6NMFOL1bbM6zat9kY
Yiet0hD+JHi+/H+gKS9TafiVK/ITlneZaHca8LCuURGvW7TSAWHdYxM/rd4eLCOh
VQWsk5jliaCbsDjLAdi3yA97yTElMGZnaU+anif7IBs0Tw3KjVlCI4ELS/D0V5Qt
BZY9Z0LXxu+uZiJGrMK2h4O6vpcNYumzpDA0unJk/eCygWlO79MxVs8McYOmlz9y
Y3ZI7aP5vR9EkHo625bC2uAdUry5CDHmp6X2COF9fH4ZHgxHJo3ehKWsFRzl2aEn
WZhBOOg7HLjjJOBQ7FL7Gjn4mnEnhWWfdXHSPEH1gcN+w84manOGBomf3eS5sl71
feGVLmQztmhSIk1Rwgweg01dX+Aailmn1pNfycV3XJ+clbkg35oslAjb8sdpwjbn
FfkVrqoREaGsVeVDaGqKWk/Heh9/yaAg2vOkTh9zFYxFrCOH7QyTzYzhGFWKlz3m
Cbn6drIarlDA5kGax7X0+Zfr7BTStCn5fwqPzwi0J4vBwHHd6V0=
=Tszm
-----END PGP SIGNATURE-----

--G44BJl3Aq1QbV/QL--
