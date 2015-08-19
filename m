From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC PATCH] pwm: TLC591xx PWM driver
Date: Wed, 19 Aug 2015 12:24:25 +0200
Message-ID: <20150819102424.GE26627@ulmo>
References: <1439905927-27861-1-git-send-email-tomi.valkeinen@ti.com>
 <20150818150916.GG4381@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150818150916.GG4381@lunn.ch>
Sender: linux-leds-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-pwm@vger.kernel.org, linux-leds@vger.kernel.org, Jacek Anaszewski <j.anaszewski@samsung.com>, Bryan Wu <cooloney@gmail.com>
List-Id: linux-pwm@vger.kernel.org


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2015 at 05:09:16PM +0200, Andrew Lunn wrote:
> > On the other hand, there's pwm_bl.c which give us backlight device
> > with PWM,
>=20
> Lets look at this. A backlight device seems to do most of its work in
> the update_status callback. It is given a brightness in
> bl->props.brightness, which takes a value between 0 and
> props.max_brightness.
>=20
> What pwm_bl.c does it then turn this brightness value into an
> artificial PWM configuration. Your proposed PWM driver then turns this
> back into a brightness, since you don't actually implement the period
> part of the PWM interface.
>=20
> From an architecture point of view, doesn't an LED class device, which
> takes a brightness value, seem much more naturally?
>=20
> It seems like implementing a generic led_bl.c driver would make sense.
> It would also allow some of the code in drivers/video/backlight/ to be
> eliminated. There seems to be both an LED class driver for lp55xx and
> a blacklight driver lp855x_bl.c. There are duplicate lp8788, 88pm860x,
> adp5520, da903x, da9052, hp6xx, and lm3533 drivers which might all be
> removed if a led_bl.c generic driver existed.
>=20
> > and a GPIO over PWM sounds more sane to me than GPIO over LED.
>=20
> Currently two LED class drivers are calling gpiochip_add:
>=20
> ~/linux/drivers/leds$ grep gpiochip_add *.c
> leds-pca9532.c:	      	   err =3D gpiochip_add(&data->gpio);
> leds-tca6507.c:		   err =3D gpiochip_add(&tca->gpio);
>=20
> The pca9532 has full GPIO capabilities, in as well as out. But it
> seems like tca6507 is output only. The TLC59108/TLC59116 is also
> output only. So a generic GPO driver on top of LED would make sense
> for these two, and save some code/bugs.
>=20
> From a stand back, lets take a look at the architecture point of view,
> generic led_bl and gpio-led drivers seem to make sense.

I agree it's sensible for there to be a driver that can drive a
backlight from an LED. PWM is somewhat of a lower level API than the LED
API, so there are cases where LED fits better than PWM. This particular
case seems to be one of them.

Thierry

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV1FlVAAoJEN0jrNd/PrOhDIoP/1qtFXf94NpapgtqC2Yo4/EJ
ok3OYoEpETw+/Qyl7dyl5ARkCWjFS1w4Opj1RiNTjqS2utHqGs/cUCuno74EzBY2
18qcU5iaUsSQ+O0QFiRraj+MuqapAMVqHnPIrAtt67u+OGhGsgB+r0yGaZeo58c5
zplsHspj6TAFLUCXPWcI/EcHvtm0kZ/klM7I7GPo1Q0yN9Clf6gH/SM57AA3Kntv
L4/ycEFJYGc7L0Ro8eUxLL4JL1DX2d08wyM8Jawkp2FzafBCvQ8TMdvxk8HY4rYa
ICJxf9kupFndqKKMN8NGOHXgg8/ob6dGahvKmH2d0wIR8ngpkkvP680Q9uJJwnKo
rdWQWvyQkqLQIDctOBDkusuGoRH/A3hcdY6oGatZGaxq0E/3pK/BZe7TJMsdWk7E
IUI0A+/3qIJSJBAmrZt8ufQK8OLtXF0JK2E0R+EFBfoiNH/GRZhOpIeagjhufj8i
uyc6ryUdeLkHLEJf90/oO4/xQrpMOS/K1bBLyJYBoWznDqFKHmJ++rlKMWJ538Cb
3AHFZk/c4+FEYjXFmuNj8hWBjHCFgH1v993yBtTUrc2uVi8uG4aMBQ8804bTCPmx
amdMUekEmFnJGx5/X528a4VmDfize6Usb1eyT/ZSHiqMhq3cMBv/R2R61C6XoN6b
SFCHtczZl9vmHxN10V0l
=WWH+
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--
