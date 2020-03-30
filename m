From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: (EXT) Re: [PATCH 3/4] pwm: pca9685: initialize all LED registers
 during probe
Date: Mon, 30 Mar 2020 15:07:24 +0200
Message-ID: <20200330130724.GA2431644@ulmo>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226135229.24929-3-matthias.schiffer@ew.tq-group.com>
 <20200226150051.sbopz7uzbdhtccba@pengutronix.de>
 <74522773dd3e820ab6f38cd83e52c83f1288c04a.camel@ew.tq-group.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43949 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbgC3NHc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 09:07:32 -0400
Content-Disposition: inline
In-Reply-To: <74522773dd3e820ab6f38cd83e52c83f1288c04a.camel@ew.tq-group.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2020 at 05:13:51PM +0100, Matthias Schiffer wrote:
> On Wed, 2020-02-26 at 16:00 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > On Wed, Feb 26, 2020 at 02:52:28PM +0100, Matthias Schiffer wrote:
> > > Initialize all ON delays to 0 during probe, rather than doing it in
> > > pca9685_pwm_enable.
> > >=20
> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> > > >
> > > ---
> > >  drivers/pwm/pwm-pca9685.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > > index 393ab92aa945..370691b21107 100644
> > > --- a/drivers/pwm/pwm-pca9685.c
> > > +++ b/drivers/pwm/pwm-pca9685.c
> > > @@ -289,13 +289,6 @@ static int pca9685_pwm_enable(struct pwm_chip
> > > *chip, struct pwm_device *pwm)
> > >  {
> > >  	struct pca9685 *pca =3D to_pca(chip);
> > > =20
> > > -	/*
> > > -	 * The PWM subsystem does not support a pre-delay.
> > > -	 * So, set the ON-timeout to 0
> > > -	 */
> > > -	regmap_write(pca->regmap, LED_N_ON_L(pwm->hwpwm), 0);
> > > -	regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), 0);
> > > -
> > >  	/*
> > >  	 * Clear the full-off bit.
> > >  	 * It has precedence over the others and must be off.
> > > @@ -388,6 +381,13 @@ static int pca9685_pwm_probe(struct i2c_client
> > > *client,
> > >  	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
> > >  	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
> > > =20
> > > +	/*
> > > +	 * The PWM subsystem does not support a pre-delay.
> > > +	 * So, set the ON-timeout to 0
> > > +	 */
> > > +	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_H, 0);
> > > +	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
> > > +
> >=20
> > What is a pre-delay: Something like:
> >           _________                   ______
> >     _____/         \_________________/
> >     ^                           ^
> >=20
> > Where ^ marks the period start and then the time between period start
> > and the rising signal is the pre-delay?
> >=20
> > If so, the IMHO more right approach is to keep the pre-delay until a
> > new
> > setting is applied and in .get_state ignore the pre-delay. This way
> > you
> > don't modify the output in .probe() which sounds right.
> >=20
>=20
> My approach was to get the hardware into a known state by resetting
> most registers (which is what the driver attempted to do so far). If
> getting the hardware state via get_state is preferable, I can implement
> that instead.

I think what Uwe was suggesting was to delay setting these registers
until the PWM is actually used. We typically do that in order not to
mess with whatever the bootloader may have set up.

Consider for example the case where the PWM is used to drive a
backlight, which might be showing a splash screen. If you reinitialize
the PWM at probe time, the backlight might go dark some time before the
kernel gets around to initializing the backlight.

For now I think we should just leave this where it is because likely a
change in PWM will be followed by a pwm_enable() call with the legacy
API. Ideally this driver would be converted to the new atomic PWM API,
in which case it'd be best to write the entirety of the hardware
registers during ->apply().

Thierry

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6B7woACgkQ3SOs138+
s6E1pBAAnG+N21eVrYOAi4fg+13x0D6CzUhyDs2ieFfER1TzR1e7GRA7uwtBEd76
kv21RsKUKUcjunPihaAGnHMI1GWF8cm3AXU4ss2ChWZ1re6uCYKdp2RLJHmHDvM3
KKi7Lsmq36XGCpwEzBhHq9qUYVRlimS+Sy9T+XwFxwU+6SMvCpGA2mgQNQTbh/t8
FZwngg0GFFmaULN1lrdSIjcq4uEaSXOpIRiYIBV1bCV97GQLNRGjcbuzzWIiE2l6
qvqYVVW4cJ6e/Kk9qoCHW4toBVGiQXlXzUwUMPJAtSvWvg1t+f9vxl6b7xz6DkdX
8C94dcf8ag612TNoQVaY9MrEpOU53039bgZTugZSqE4i5hM85wEPlhZmFjJbV5V1
Lv04CAnkeGhUSkgolQK2yFfrhS2UJvaYFC9BnOQakSaje/44SI7ywYCNScQ3pMc0
Mp87A1HkM/4h4dbNhp4lmM5ghyTQbIYbz3h+G/nhaBWW2qOOiXne6jgPdniQKdTS
u0R9UEVBhl5me7Fk/9PMWcxxXFjKA+z14INDubRjZmBAjLqWtmBWRb2YfCPq9QAI
9YF68GSoFJp/R83qEv+yOEt1QDvkvzH72MBdHfOaAocu+k+raZl1vEVv+tS3nq+b
ouTb2q8TFZCQdiHqTZ8NGfkgogrCeRyLawRdSkEQbZLZoH8u0Z4=
=fw4R
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
