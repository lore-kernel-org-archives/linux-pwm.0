From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC PATCH] pwm: TLC591xx PWM driver
Date: Wed, 19 Aug 2015 13:52:20 +0300
Message-ID: <55D45FE4.2050805@ti.com>
References: <1439905927-27861-1-git-send-email-tomi.valkeinen@ti.com> <20150818150916.GG4381@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BU0Cmo4Wm0Q5vrUa3Vg4vW1loM9vl6U6C"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58105 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195AbbHSKwe (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Aug 2015 06:52:34 -0400
In-Reply-To: <20150818150916.GG4381@lunn.ch>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-leds@vger.kernel.org, Jacek Anaszewski <j.anaszewski@samsung.com>, Bryan Wu <cooloney@gmail.com>

--BU0Cmo4Wm0Q5vrUa3Vg4vW1loM9vl6U6C
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 18/08/15 18:09, Andrew Lunn wrote:
>> On the other hand, there's pwm_bl.c which give us backlight device
>> with PWM,
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

Hmm, I'm not sure I follow. It's still PWM, even if the period is fixed.
It is programming the PWM of TLC591xx.

> From an architecture point of view, doesn't an LED class device, which
> takes a brightness value, seem much more naturally?

It does the same thing, takes a brightness value, and programs TLC's PWM
for particular PWM duty cycle.

I guess I get your point. You're saying that as TLC has a fixed period,
we can just consider it as a brightness value.

But in the end, it is still PWM in the HW level, and also, the
brightness isn't linear, or even anything like it. At least on my
backlight, the visible values range from ~230 to 255.

So at least in this case I think it makes more sense to consider the
value as PWM duty cycle, which then causes the LED to glow at some
brightness.

If the value would be brightness, I'd presume that more or less the
whole 0-255 range would be usable, and 128 would be somewhere near
mid-brightness.

> It seems like implementing a generic led_bl.c driver would make sense.
> It would also allow some of the code in drivers/video/backlight/ to be
> eliminated. There seems to be both an LED class driver for lp55xx and
> a blacklight driver lp855x_bl.c. There are duplicate lp8788, 88pm860x,
> adp5520, da903x, da9052, hp6xx, and lm3533 drivers which might all be
> removed if a led_bl.c generic driver existed.

Yes, I think this should be looked at. I'll probably have a look at some
point if I find time.

>> and a GPIO over PWM sounds more sane to me than GPIO over LED.
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

Yes, led_bl makes sense. I don't think all LEDs are PWM/GPIO driven, so
in the minimum those LEDs might need a LED class driver.

For this particular chip I still think PWM driver would do just fine.
But as the LED framework offers features like blinking, and it's
possible to implement backlight and gpios on top LED (I hope), I do
agree that we should go with your driver.

That said, I feel that these frameworks, GPIO, PWM and LED are somewhat
overlapping. Not really my area of expertise, but I imagine a single
framework containing all those functionalities could be possible.

 Tomi


--BU0Cmo4Wm0Q5vrUa3Vg4vW1loM9vl6U6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV1F/kAAoJEPo9qoy8lh71eOIQAJyntvQm4MhWIjNWzFGDvQyL
2DAA6ceISHsX09pzIns7bHHi94uyH7+S7Y4zH8yQ3Bdmc+sYRIL3cykBdgj5u1eO
/uXdRTn5otbAa4nV76UdyHocV7uIgSZi7tF41PEp4IEE+Oute4wvaDioqPYYs/Od
UpHH0PF4ogshPw63wsYcUCsKeZlMOVKS/34xWRKHEW2aJlm6axaDdzEkckLoh8Pd
b7d0I4gZm/KzHd+RUnNYt1jcTkuDQlozIO+/oW3HQomgUhga2bmt56k4Y5J7MSyN
MOrDg88N7Hi6YqzMzUTuweV53+yZOQ8nAJC0kiOspZxOXE1ZzLO7OCC0tVgs77ol
T70q4oAnuvNNZkq3DGf5hNPzzzsl2tXz7kr11mtDo1p5r1g18WX1ruN0gwJRSy2E
nYLQ/VzAD+qws7/aZ9p6cls9AdDaV4htNKdrM6LD24OA18ip3OVJrz2GzhAi4Qkg
y68AR+FoaNLEYszeGj0vkAFIHSDdwxmoly46VvGKfC0xzsCUCmDLLfoSJDn2Pg4Z
SDTN0EKZ3YDIC02TZigxO2R0NcISYX4QX5W5ZdZ7mTvv8eTKGtL+1nKmsDf3Lkdx
CmvhsWeCjvl7m4FJgSe61TXTKUuAXgfS4ED/TWanEVWnVgjGhZ1No6aW1wdrVLFM
Y3CgAm9AyCN4FTyI9x+W
=puDj
-----END PGP SIGNATURE-----

--BU0Cmo4Wm0Q5vrUa3Vg4vW1loM9vl6U6C--
