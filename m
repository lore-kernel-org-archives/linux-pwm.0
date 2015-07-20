From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 1/2] pwm-pca9685: Fix several driver bugs
Date: Mon, 20 Jul 2015 11:31:41 +0200
Message-ID: <20150720093141.GR29614@ulmo>
References: <1437381369-8502-1-git-send-email-clemens.gruber@pqgruber.com>
 <1437381369-8502-2-git-send-email-clemens.gruber@pqgruber.com>
 <20150720092723.GP29614@ulmo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hw0FrjWlp+qkNlJP"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:36415 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbbGTJbz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2015 05:31:55 -0400
Content-Disposition: inline
In-Reply-To: <20150720092723.GP29614@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>


--Hw0FrjWlp+qkNlJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2015 at 11:27:23AM +0200, Thierry Reding wrote:
> On Mon, Jul 20, 2015 at 10:36:08AM +0200, Clemens Gruber wrote:
> > Problems:
> > - When duty_ns =3D=3D period_ns, the full OFF bit was not cleared and t=
he
> >   PWM output of the PCA9685 stayed off.
> > - When duty_ns =3D=3D period_ns and the catch-all channel was used, the
> >   ALL_LED_OFF_L register was not cleared.
> > - The full ON bit was not cleared when setting the OFF time, therefore
> >   the exact OFF time was ignored when setting a duty_ns < period_ns
> >=20
> > Solution: Clear both OFF registers when setting full ON and clear the
> > full ON bit when changing the OFF registers.
> >=20
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >=20
> > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > index 34b5c27..f4a9c4a 100644
> > --- a/drivers/pwm/pwm-pca9685.c
> > +++ b/drivers/pwm/pwm-pca9685.c
> > @@ -85,6 +85,22 @@ static int pca9685_pwm_config(struct pwm_chip *chip,=
 struct pwm_device *pwm,
> >  	}
> > =20
> >  	if (duty_ns =3D=3D period_ns) {
> > +		/* Clear both OFF registers */
> > +		if (pwm->hwpwm >=3D PCA9685_MAXCHAN)
> > +			reg =3D PCA9685_ALL_LED_OFF_L;
> > +		else
> > +			reg =3D LED_N_OFF_L(pwm->hwpwm);
> > +
> > +		regmap_write(pca->regmap, reg, 0x0);
> > +
> > +		if (pwm->hwpwm >=3D PCA9685_MAXCHAN)
> > +			reg =3D PCA9685_ALL_LED_OFF_H;
> > +		else
> > +			reg =3D LED_N_OFF_H(pwm->hwpwm);
> > +
> > +		regmap_write(pca->regmap, reg, 0x0);
> > +
> > +		/* Set the full ON bit */
> >  		if (pwm->hwpwm >=3D PCA9685_MAXCHAN)
> >  			reg =3D PCA9685_ALL_LED_ON_H;
> >  		else
> > @@ -112,6 +128,14 @@ static int pca9685_pwm_config(struct pwm_chip *chi=
p, struct pwm_device *pwm,
> > =20
> >  	regmap_write(pca->regmap, reg, ((int)duty >> 8) & 0xf);
> > =20
> > +	/* Clear the full ON bit, otherwise the set OFF time has no effect */
> > +	if (pwm->hwpwm >=3D PCA9685_MAXCHAN)
> > +		reg =3D PCA9685_ALL_LED_ON_H;
> > +	else
> > +		reg =3D LED_N_ON_H(pwm->hwpwm);
> > +
> > +	regmap_write(pca->regmap, reg, 0);
>=20
> Doesn't this undo the setting of this register back up in the duty_ns =3D=
=3D
> period_ns conditional block?

Nevermind, looking at the full driver code I see that the branch returns
0.

Thierry

--Hw0FrjWlp+qkNlJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrL/8AAoJEN0jrNd/PrOhus4P/ixKrfg2rS/Fh3mgHieN7hDH
E309C6C0ioHIFsHGUSqEkoRLawHEDZcagKIwH9fSeaKl2uowzadrdFBr3cjtoIjd
n/dqE4v+/RVmyuOz5ZPqWkXxhvg4eZli3XPa/7pFCc/K7UpL6pUV3QoD/TtAMYBc
4EPyLY0rv0ix3Q4mNtFsKpqkZK7zyeMeS6X+z1v/LcsiVn9fEiBbK/jsbpMOPuaM
29ll0iYOxW+C4wJZ2c4/sM1efxaVeDHdiXNZO5wb4DwunGo5Gz6TgyjB6Vm1e0oP
h5z+Z+1TlUT/c8Wy7VxhLyXBejHMnE3V1I5OEYtWqx+nBUM8KPiX8qoVPzpfKppY
fYT71LPEGRRFHTgc9frUWqlK39ZUiTlKOmF67cDlJGh51TzcOhd0R+/aKRIcvRRY
jmLjxUxi/xgVNWzCqhZQqP0O6BOEIxpUYCV0jlByfq/XtymnP6Uj+TDsCc7yAo2k
EMbQxvIFQtEPDJ0PQJVdvILZQsEp0t7s6HCDzr+0ZJrehrK88ngD+WaO0/xiJPoC
eQLK7LaTY2myQulPqEgAfPnIIa9lUAkRQ8hH2FFpKlw/8ROWriga6P1PudxxI3Fz
6bt+1HwrJ5tn0wV++YDv0KbrsTLHEwourhfnP4av907X/BR1jmiSGb0U2UkKjzu1
5TA1GQz4/DZhBWxLBO/O
=BYvP
-----END PGP SIGNATURE-----

--Hw0FrjWlp+qkNlJP--
