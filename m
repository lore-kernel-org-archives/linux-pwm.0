From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 6/7] pwm: jz4740: Make PWM start with the active part
Date: Sat, 21 Sep 2019 00:52:54 +0200
Message-ID: <20190920225254.GA86019@mithrandir>
References: <20190809123031.24219-1-paul@crapouillou.net>
 <20190809123031.24219-7-paul@crapouillou.net>
 <20190809171058.gothydohec6qx7hu@pengutronix.de>
 <1565372004.2091.3@crapouillou.net>
 <20190812055515.ne7o4ujchfeubjid@pengutronix.de>
 <1565643001.2007.2@crapouillou.net>
 <20190812215853.hbhihhtvdziarj3y@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190812215853.hbhihhtvdziarj3y@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Paul Cercueil <paul@crapouillou.net>, od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 11:58:53PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Aug 12, 2019 at 10:50:01PM +0200, Paul Cercueil wrote:
> >=20
> >=20
> > Le lun. 12 ao=C3=BBt 2019 =C3=A0 7:55, Uwe =3D?iso-8859-1?q?Kleine-K=3D=
F6nig?=3D
> > <u.kleine-koenig@pengutronix.de> a =C3=A9crit :
> > > On Fri, Aug 09, 2019 at 07:33:24PM +0200, Paul Cercueil wrote:
> > > >=20
> > > >=20
> > > >  Le ven. 9 ao=C3=BBt 2019 =C3=A0 19:10, Uwe =3D?iso-8859-1?q?Kleine=
-K=3DF6nig?=3D
> > > >  <u.kleine-koenig@pengutronix.de> a =C3=A9crit :
> > > >  > On Fri, Aug 09, 2019 at 02:30:30PM +0200, Paul Cercueil wrote:
> > > >  > >  The PWM will always start with the inactive part. To counter
> > > > that,
> > > >  > >  when PWM is enabled we switch the configured polarity, and use
> > > >  > >  'period - duty + 1' as the real duty.
> > > >  >
> > > >  > Where does the + 1 come from? This looks wrong. (So if duty=3D0 =
is
> > > >  > requested you use duty =3D period + 1?)
> > > >=20
> > > >  You'd never request duty =3D=3D 0, would you?
> > > >=20
> > > >  Your duty must always be in the inclusive range [1, period]
> > > >  (hardware values, not ns). A duty of 0 is a hardware fault
> > > >  (on the jz4740 it is).
> > >=20
> > > From the PWM framework's POV duty cycle =3D 0 is perfectly valid. Sim=
ilar
> > > to duty =3D=3D period. Not supporting dutz cycle 0 is another limitat=
ion of
> > > your PWM that should be documented.
> > >=20
> > > For actual use cases of duty cycle =3D 0 see drivers/hwmon/pwm-fan.c =
or
> > > drivers/leds/leds-pwm.c.
> >=20
> > Perfectly valid for the PWM framework, maybe; but what is the expected
> > output then? A constant inactive state?
>=20
> Yes, a constant inactive state is expected. This is consistent and in a
> similar way when using duty =3D=3D period an constant active output is
> expected.
>=20
> > Then I guess I can just disable the PWM output in the driver when
> > configured with duty =3D=3D 0.
>=20
> Some time ago I argued with Thierry that we could drop the concept of
> enabled/disabled for a PWM because a disabled PWM is supposed to behave
> identically to duty=3D0. This is however only nearly true because with
> duty=3D0 the time the PWM is inactive still is a multiple of the period.
>=20
> I tend to agree that disabling the PWM when duty=3D0 is requested is
> better than to fail the request (or configure for duty=3D1 $whateverunit).
> I'm looking forward to what Thierry's opinion is here.

Agreed. If in order to meet the expectations of duty =3D=3D 0 you have to
disable the PWM, then that's what you should do.

Thierry

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2FWD4ACgkQ3SOs138+
s6GJ2hAAp+xxW80HyFVnVRXvrUQU5JL2agGhKkjRCBAKysB5F6LiokWLbc8FNh6s
dgb4u/5YsKPrreVuf485w4ZlkKjWhRVN9bAfmrAcmGRZPc1GBnkBtoIEqK0UHcDF
gsijaWp5QWyjHA5pHDaffdSsB6/HQLJtBa3kIEBOyohyANCI0n8Lwdr58L5jZJz+
fcI8Kf9YxvVrdouKiNpj1KEpPzO2+L9otxl6Bnyul85P/GR/LSw1dcQJMkF61xvy
wuTUwaGls7Q1/W6cENWIH8i8HE+xKbvAI+jINVATxHsqvDgo3L0hI/V93xlqE8Ob
oEhJjOq5T7/c+XOjk6KwZzwc3ycZX6z0SC+NmPksSPJKyORCIPoX7P9K1EzetTjp
fUAB/v12TvTcc4Wm5OchRQmwtefGvv5TM/jC4hGCtOwdbLDQ7myVdKp+vRSYkpef
24MwSs23xRa1GN/67NllTwg97WLsA8mfeXyE+89BKsAfhZe+uFCRI84WWoN22dA/
0DYqZxli22Wpyd9w1CUhJCRcBuALBLASAHHbphQK/cxGtxCH3v5Tf59Ntg2pebg5
wsobhpbyyxd4+U+h/Z+cogq0BfMDy6Jvwxza87qvwaOVGF8jttpY8IAnXFAaGQhk
ydHf6uqppyi5uBJ0Yc88IUBYFgXkf2PypVe7VGByk4SQGRMhI24=
=sC9Z
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
