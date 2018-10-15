From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: =?utf-8?B?W1JDRsKgUEFUQ0gsdjIsMi8y?= =?utf-8?Q?=5D?= pwm: imx:
 Configure output to GPIO in disabled state
Date: Mon, 15 Oct 2018 10:45:05 +0200
Message-ID: <20181015084505.GA12357@ulmo>
References: <1539163920-9442-3-git-send-email-michal.vokac@ysoft.com>
 <20181012085720.GA9451@taurus.defre.kleine-koenig.org>
 <fa96ae2a-c2cc-b47a-1198-5daffa7c865f@ysoft.com>
 <20181012160854.hmgpokxgsrqdzobx@pengutronix.de>
 <20181014202457.dohwgz3frgcpdpy6@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181014202457.dohwgz3frgcpdpy6@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@karo-electronics.de>
List-Id: linux-pwm@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 14, 2018 at 10:24:57PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Fri, Oct 12, 2018 at 06:08:54PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > >> +	if (PTR_ERR(imx_chip->pwm_gpiod) =3D=3D -EPROBE_DEFER) {
> > > >=20
> > > > You must not use PTR_ERR on a value that might not contain an error
> > > > pointer.
> > >=20
> > > OK, thank you for valuable info.
> > > So it seems like the I2C folks are in troubles as well:
> > >=20
> > > 	https://elixir.bootlin.com/linux/latest/source/drivers/i2c/busses/i2=
c-imx.c#L996
> >=20
> > correct. I cannot find this documented though.
>=20
> I found in LDD3[1], chapter 11 on page 295:
>=20
> 	If you need the actual error code, it can be extracted with:
>=20
> 		long PTR_ERR(const void *ptr);
>=20
> 	You should use PTR_ERR only on a value for which IS_ERR returns a true
> 	value; any other value is a valid pointer.
>=20
> That is probably where I have my claim from. There is no further
> explanation though, so I'll post a patch adding a comment to the
> definition of PTR_ERR to find out if there is a relevant reason.

Michal's code above does an implicit IS_ERR() by comparing to an actual
error code. It's certainly true that PTR_ERR() on any pointer and then
using that value can be risky because it may not actually be an error.
So if you go and unconditionally print that error code even if it isn't
an error but a valid pointer, you've leaked a kernel address.

However, it's perfectly safe to use PTR_ERR(ptr) =3D=3D -EPROBE_DEFER (or
for any other error code for that matter).

Thierry

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvEU48ACgkQ3SOs138+
s6Gzqw//T+d8Wb41k3KDCT7WKo0TzK1p/AyL95o2ZS6lV2/+dd0DemSNRHykSY3s
otrx+vwMpgEhMCA9m9n40Nw0hkmTTDXO3b1ppvLcq0dDArI+wjFbDJfcIsKegx70
90b9ccfTB84TYtcf4bRWtIO7DypS668OQw8VFbbxZ9bBp/+4CNbuhIZyw3brmK/a
YSocK6ZuT3vauWO25LoIawz5WADU7RHl5mSl26ywUxKQ4zKe02RGUIH6qoB3jxmH
heWsXt5C5Yrftn7ns7xvIZT7iufNA2eTW2FsEBQPer7dtflI9RkseTabouJf/VKD
huryBYFmM2NjhcuzohnaPTNCp2txDDc8PFCyra0v4iiwgfwvhnIQYHTjFpiA3q6y
mnhukrI9jX0dw4u3pbz5va8HOnwoWejRJKiWVWMmHsQPXscIC86PYDI90LYPimsk
4l2KpQUwOIrI3m/yC+E7g/AnYSxl3ZSW+0JrOP1NRlgZD9qxODjlwENndxeNdRdi
8OJdrmKLD36rc4TWMNAq3A33S68gKafAz85fh2eraeNvo3EgcN08zezPlAhHhIfb
x2agre7MWxhiXolwD7Rbj6f5DaZAwpYtCXzhCcBAmjo1zoXCAcvb9cfRbiEyhB48
xGHF3lAyUxH+nFJ6unkqubdxMZz17jweaXvZ+6QsrCqnQdcrl4w=
=lOQ2
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
