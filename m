Date: Tue, 24 Sep 2013 11:20:53 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: V2: Agenda for the Edinburgh mini-summit
Message-ID: <20130924092053.GB13971@ulmo>
References: <201309101134.32883.hansverk@cisco.com>
 <52405427.6000002@samsung.com>
 <52406E5C.2020709@schinagl.nl>
 <5240A41A.6050207@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <5240A41A.6050207@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc: Oliver Schinagl <oliver+list@schinagl.nl>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Hans Verkuil <hansverk@cisco.com>, "media-workshop@linuxtv.org" <media-workshop@linuxtv.org>, Sakari Ailus <sakari.ailus@iki.fi>, Bryan Wu <bryan.wu@canonical.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2013 at 10:27:06PM +0200, Sylwester Nawrocki wrote:
> On 09/23/2013 06:37 PM, Oliver Schinagl wrote:
> >On 09/23/13 16:45, Sylwester Nawrocki wrote:
> >>Hi,
> >>
> >>I would like to have a short discussion on LED flash devices support
> >>in the kernel. Currently there are two APIs: the V4L2 and LED class
> >>API exposed by the kernel, which I believe is not good from user space
> >>POV. Generic applications will need to implement both APIs. I think we
> >>should decide whether to extend the led class API to add support for
> >>more advanced LED controllers there or continue to use the both APIs
> >>with overlapping functionality.
> >>There has been some discussion about this on the ML, but without any
> >>consensus reached [1].
> >
> >What about the linux-pwm framework and its support for the backlight via
> >dts?
> >
> >Or am I talking way to uninformed here. Copying backlight to flashlight
> >with some minor modification sounds sensible in a way...
>=20
> I'd assume we don't need yet another user interface for the LEDs ;) AFAICS
> the PWM subsystem exposes pretty much raw interface in sysfs. The PWM LED
> controllers are already handled in the leds-class API, there is the
> leds_pwm
> driver (drivers/leds/leds-pwm.c).
>=20
> I'm adding linux-pwm and linux-leds maintainers at Cc so someone may corr=
ect
> me if I got anything wrong.

The PWM subsystem is most definitely not a good fit for this. The only
thing it provides is a way for other drivers to access a PWM device and
use it for some specific purpose (pwm-backlight, leds-pwm).

The sysfs support is a convenience for people that needs to use a PWM in
a way for which no driver framework exists, or for which it doesn't make
sense to write a driver. Or for testing.

> Presumably, what we need is a few enhancements to support in a standard w=
ay
> devices like MAX77693, LM3560 or MAX8997.  There is already a led
> class driver
> for the MAX8997 LED controller (drivers/leds/leds-max8997.c), but it
> uses some
> device-specific sysfs attributes.
>=20
> Thus similar devices are currently being handled by different subsystems.
> The split between the V4L2 Flash and the leds class API WRT to Flash LED
> controller drivers is included in RFC [1], it seems still up to date.
>=20
>=20
> >>[1] http://www.spinics.net/lists/linux-leds/msg00899.html

Perhaps it would make sense for V4L2 to be able to use a LED as exposed
by the LED subsystem and wrap it so that it can be integrated with V4L2?
If functionality is missing from the LED subsystem I suppose that could
be added.

If I understand correctly, the V4L2 subsystem uses LEDs as flashes for
camera devices. I can easily imagine that there are devices out there
which provide functionality beyond what a regular LED will provide. So
perhaps for things such as mobile phones, which typically use a plain
LED to illuminate the surroundings, an LED wrapped into something that
emulates the flash functionality could work. But I doubt that the LED
subsystem is a good fit for anything beyond that.

Thierry

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSQVl1AAoJEN0jrNd/PrOhY54QAK8p+tv+zHaallHRAqW6c1qs
FRBY7oCORtuCvmVV64oRqsEZMEXOwnSAtxPDxJ/k2hJrVdd1vEa8vF34IwVsfi+s
QVdiZ3JkVOuZ76bwCBLKq6/u/2VKsdJybSn/TVrvePmMG3mg7YtWP67zgPo9nd8d
p+e0bZ2yg4dmh+eGwNAcmXAL9N9r0Qgh+AK3wnG+u1cACpIQMzg3PC341caMyVnp
lA0Z7J7AEWceeoR7DVtuct7ab+VmjwaG0P+nxPTHAF5bp/VjsBhqX6ZahxEkXXC5
rR9XVsy4wdMORsAvcdmyJKN/0ksN8iNIJGnOZ0P8XraN+11lwYUZxcCxRpydN7Z7
BYczpi2/pYV8pJR5Ox7xQN1hgz/E6wAEcrJUyGVQ/l1wXViWdrNP6PpI53+hNHcd
E1PvpDd4/GZJ5FeOntG7EN/fg9EJ4KpiSrh6YkfbeNH04QOgv9c6fF1MVOn0hRbd
2FJbFtnVeh/WbHzSkjrUW7RHR7RvjG/kn2if24draxwXgbMJABMUoPCsvfvK7kV+
b4ThU24Pv6BDahJ7TUZLDHaf9khf3ML+8HE06CW2d2bqXqlHXT9HqlICAJrWAsCm
PoDpWPr5m0CvIxH/8TNEjMGO9pxOnD08Z/OgoagWmBo/c+lXy36IGa74Yc9Kbn4z
glpK7OQwr6oABeqsVuNI
=qUEd
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
