From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: Add CLPS711X PWM support
Date: Wed, 8 Jan 2014 14:34:23 +0100
Message-ID: <20140108133422.GB1592@ulmo.nvidia.com>
References: <1388547821-10029-1-git-send-email-shc_work@mail.ru>
 <20140106161233.GB6721@ulmo.nvidia.com>
 <1389025853.275494031@f414.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:55872 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388AbaAHNgc (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Jan 2014 08:36:32 -0500
Content-Disposition: inline
In-Reply-To: <1389025853.275494031@f414.i.mail.ru>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2014 at 08:30:53PM +0400, Alexander Shiyan wrote:
> Hello.
>=20
> =D0=9F=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D0=BB=D1=8C=D0=BD=D0=B8=D0=BA,  6 =
=D1=8F=D0=BD=D0=B2=D0=B0=D1=80=D1=8F 2014, 17:12 +01:00 =D0=BE=D1=82 Thierr=
y Reding <thierry.reding@gmail.com>:
> > On Wed, Jan 01, 2014 at 07:43:41AM +0400, Alexander Shiyan wrote:
> > > Add a new driver for the PWM controllers on the CLPS711X platform
> > > based on the PWM framework.
> ...
> > 	static inline to_clps711x(struct pwm_chip *chip)
> > 	{
> > 		return container_of(chip, struct clps711x_chip, chip);
> > 	}
> >=20
> > > +	unsigned int period, freq =3D clk_get_rate(priv->clk);
> > > +
> > > +	if (!freq)
> > > +		return -EINVAL;
> > > +
> > > +	/* Calculate and store constant period value */
> > > +	period =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq);
> > > +	pwm_set_period(pwm, period);
> > > +	pwm_set_chip_data(pwm, (void *)(uintptr_t)period);
> >=20
> > Why store this in chip data again if it can be retrieved directly from
> > the PWM device using pwm_get_period()?
>=20
> This is used for compare this value in pwm_config().
> pwm_set_period() potentially can be called from any other place and set
> illegal value for us, but we should calculate duty ratio with our (proper=
) frequency.
> Is not it?

Well, that same argument holds for pwm_set_chip_data(). Nothing should
be calling pwm_set_period() from any other place.

> > > +static int clps711x_pwm_enable(struct pwm_chip *chip, struct pwm_dev=
ice *pwm)
> > > +{
> > > +	/* Do nothing */
> > > +	return 0;
> > > +}
> > > +
> > > +static void clps711x_pwm_disable(struct pwm_chip *chip, struct pwm_d=
evice *pwm)
> > > +{
> > > +	/* Do nothing */
> > > +}
> >=20
> > I think it would be better if this would set the duty field to 0 to stop
> > any potential toggling of the PWM signal. .enable() can later restore
> > the proper value.
> >=20
> > The reason for this is that pwm_disable() is supposed to stop the PWM
> > output from toggling and if you simply ignore it you don't conform to
> > the API specification.
>=20
> I agree for pwm_disable(), but which value should be restored by pwm_enab=
le()?
> I think we should keep pwm_enable() as is, i.e. we enable PWM with existi=
ng value.

Yes, pwm_enable() should restore the previous setting. You should be
able to do that by querying the PWM device using pwm_get_duty_cycle()
and reprogram the channel using that value.

Thierry

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzVPeAAoJEN0jrNd/PrOhE8wP+gIetX/5vGqW2KLCg/znacL0
kc37yU+HOBKbHtK3aTVuCTvNwc1Ava+rv5wy02cwkRNE1fTSFCmcy8g+F4wYSHOS
RJIMuw+p+2Uy5dHD1ftayxzOtGPnm2+PZCW1eoxdkT3w2YlwPJLMDRvC30DkR8tZ
6M4zGsRO5HgHSxZWTh0LqGEUW7VD+S5+ivtqYEExalNUUZ7ax2B+kHxA3ovZzrVV
vBCJGFeJkinMDb13Tj06w/9zGrQVJf6036A7qdYoOwUIOkGyKE+EjYAkYjV+M2Ua
6/qoi3SaMrM/qPQJj1KA7ErPHZTpZiBreWlTeI4T967BlUCtNRiQhTOXR9mogU2h
FkfkVRVKhzQg50aNlaGeObv8WHn/Rdya89GYdXf2nWJfrFlB0NI9h26kAyXjv7Ui
OWYmtAelZ2w2z9c3PAWBYeKYLw3CSOZ/Opk7Pwobvis26ZX/WopPnQ5NtVTSDSK1
Uym8EzjM0xlvhi9WJfQwBFT3obX6TNb8+n8rYEthB7pnLmLPGrT39msWJatygvRy
K94CsMdPLw5zy1uOSqETLYj9h0X1Jna9M/6GESWIWqaCJA9voOCjbaGkZ5ZbjZsH
u1zqOS1hHLDygKOMwP8ni4J4IHPUJyVnpMZUMeHFJljto3qqyuLdJsYUwmK+H2JT
ej8MAwq4hJ/Qzu3ME8PI
=Aqeg
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
