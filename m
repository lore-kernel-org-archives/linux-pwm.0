Date: Tue, 24 Sep 2013 11:32:29 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: V2: Agenda for the Edinburgh mini-summit
Message-ID: <20130924093229.GA19426@ulmo>
References: <201309101134.32883.hansverk@cisco.com>
 <52405427.6000002@samsung.com>
 <52406E5C.2020709@schinagl.nl>
 <5240A41A.6050207@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <5240A41A.6050207@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc: Oliver Schinagl <oliver+list@schinagl.nl>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Hans Verkuil <hansverk@cisco.com>, "media-workshop@linuxtv.org" <media-workshop@linuxtv.org>, Sakari Ailus <sakari.ailus@iki.fi>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Resending using Bryan's correct email address.

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

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSQVwsAAoJEN0jrNd/PrOhRTIQALGU9/sLgFsAwGtbFGuj/IiH
uG2hexdTSP9ITplRppt+34tcVpuD7W5osnVRV49iCw6fOORR644DUszCzaM/k+nb
5qiuLeiKJCJJKdReX3vmbUnDN+scaGz3WQIbsqJngtI+bPm7teIDhRJhlgO++AA/
kMKvYP81KqSTdWd34E7dgYiaso83GR5WovVGAmYaBlm3ApnPCoqVpoD2bJ4PWsEh
rrbIIs+TORdM0eyxRnaWz+aLBm0MQJW2+3mqx5Q0hPUiXmBG7c8rTPC6fwEDOJ7f
SLeM/p/58X8g/+82ByASL7tcBF7DZt25yBX163ItG0eYCbQQBUrLGJG7nMtlfcls
+bNidkjAqL+/rc2cS7d3nKSXr944cQJ0JoQBsENwmO6/wLkxYycqwtXa9E3/kfoC
MJFTeVg1DQqzVykNCyGr/jaaOMztY6NS/rfMYtB2UtrP26+Cd8sXhAOt392Viou6
LXA2jyEtq5ha1UH+TcoDSnM+Rzkv2O2uLryVMDzYWT6RgcVHwGOiePUDnA4d2Z20
q0jVAhVDByNpf2fl+8dJUp6/nWfLQMqcGJJIgafL755r80MmZhLl+rh16tAqKkOj
je53jrXJj8UDL8sEOxOiUSr/6yGSJSshJQ5pgwHCc4BjQyNtboskNZtrKhZWbwCN
UkqWyNProiAlzXyu9daW
=6Cs1
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
