From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 2/4] pwm-backlight: add support for pwm-delay-us
 property
Date: Thu, 6 Jul 2017 11:12:31 +0200
Message-ID: <20170706091231.GA6741@amd>
References: <20170630112109.13785-1-enric.balletbo@collabora.com>
 <20170630112109.13785-2-enric.balletbo@collabora.com>
 <20170706080132.GL16144@ulmo.fritz.box>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170706080132.GL16144@ulmo.fritz.box>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org, huang lin <hl@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2017-07-06 10:01:32, Thierry Reding wrote:
> On Fri, Jun 30, 2017 at 01:21:07PM +0200, Enric Balletbo i Serra wrote:
> > From: huang lin <hl@rock-chips.com>
> >=20
> > Some panels (i.e. N116BGE-L41), in their power sequence specifications,
> > request a delay between set the PWM signal and enable the backlight and
> > between clear the PWM signal and disable the backlight. Add support for
> > the new pwm-delay-us property to meet the timing.
> >=20
> > Note that this patch inverts current sequence. Before this patch the
> > enable signal was set before the PWM signal and vice-versa on power off.
> >=20
> > I assumed that this sequence was wrong, at least it is on different pan=
el
> > datasheets that I checked, so I inverted the sequence to follow:
> >=20
> >   On power on, set the PWM signal, wait, and set the LED_EN signal.
> >   On power off, clear the LED_EN signal, wait, and stop the PWM signal.
>=20
> I think this should be two separate patches to make it easier to revert
> the inverted sequence should it prove to regress on other panels.

Don't make this overly complex. This is trivial. No need to split it
into more patches.


> Two more comments below.
>=20
> > Signed-off-by: huang lin <hl@rock-chips.com>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> > Changes since v1:
> >  - As suggested by Daniel Thompson
> >    - Do not assume power-on delay and power-off delay will be the same
> >  - Move the check of dt property to the parse dt function.
> >=20
> > v1: https://lkml.org/lkml/2017/6/28/219
> >=20
> >  drivers/video/backlight/pwm_bl.c | 24 ++++++++++++++++++++----
> >  include/linux/pwm_backlight.h    |  1 +
> >  2 files changed, 21 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight=
/pwm_bl.c
> > index 002f1ce..0f5470e 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -10,6 +10,7 @@
> >   * published by the Free Software Foundation.
> >   */
> > =20
> > +#include <linux/delay.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/gpio.h>
> >  #include <linux/module.h>
> > @@ -35,6 +36,7 @@ struct pwm_bl_data {
> >  	struct gpio_desc	*enable_gpio;
> >  	unsigned int		scale;
> >  	bool			legacy;
> > +	unsigned int		pwm_delay[2];
> >  	int			(*notify)(struct device *,
> >  					  int brightness);
> >  	void			(*notify_after)(struct device *,
> > @@ -54,10 +56,14 @@ static void pwm_backlight_power_on(struct pwm_bl_da=
ta *pb, int brightness)
> >  	if (err < 0)
> >  		dev_err(pb->dev, "failed to enable power supply\n");
> > =20
> > +	pwm_enable(pb->pwm);
> > +
> > +	if (pb->pwm_delay[0])
> > +		usleep_range(pb->pwm_delay[0], pb->pwm_delay[0] + 2000);
>=20
> 2000 us is kind of arbitrary. What if pwm_delay[0] is on the order of 20
> us? Making the delay 2 ms longer (in the worst case) seems somewhat
> excessive. Why not something like:
>=20
> 	usleep_range(pb->pwm_delay[0], pb->pwm_delay[0] * 2);
>=20
> ?
>=20
> > +
> >  	if (pb->enable_gpio)
> >  		gpiod_set_value_cansleep(pb->enable_gpio, 1);
> > =20
> > -	pwm_enable(pb->pwm);
> >  	pb->enabled =3D true;
> >  }
> > =20
> > @@ -66,12 +72,15 @@ static void pwm_backlight_power_off(struct pwm_bl_d=
ata *pb)
> >  	if (!pb->enabled)
> >  		return;
> > =20
> > -	pwm_config(pb->pwm, 0, pb->period);
> > -	pwm_disable(pb->pwm);
> > -
> >  	if (pb->enable_gpio)
> >  		gpiod_set_value_cansleep(pb->enable_gpio, 0);
> > =20
> > +	if (pb->pwm_delay[1])
> > +		usleep_range(pb->pwm_delay[1], pb->pwm_delay[1] + 2000);
> > +
> > +	pwm_config(pb->pwm, 0, pb->period);
> > +	pwm_disable(pb->pwm);
> > +
> >  	regulator_disable(pb->power_supply);
> >  	pb->enabled =3D false;
> >  }
> > @@ -174,6 +183,12 @@ static int pwm_backlight_parse_dt(struct device *d=
ev,
> >  		data->max_brightness--;
> >  	}
> > =20
> > +	/* read pwm to enable pre/post delays from DT property */
>=20
> This comment is confusing. This isn't reading anything from the PWM.
>=20
> Thierry



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlld/v8ACgkQMOfwapXb+vIGFwCZAa+++mSKuT2Ho8cB3raXQIEH
tfIAnRbHsibYYGJeGe4hXOfXeGf0O2u6
=2RLI
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
