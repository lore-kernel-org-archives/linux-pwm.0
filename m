From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 3/5] pwm-backlight: add support for PWM delays
 proprieties.
Date: Thu, 20 Jul 2017 13:05:26 +0200
Message-ID: <20170720110526.GA22000@amd>
References: <20170717212811.25374-1-enric.balletbo@collabora.com>
 <20170717212811.25374-3-enric.balletbo@collabora.com>
 <d38fa016-ea9c-edf8-9684-5c1235d27c82@linaro.org>
 <20170720080656.GC13103@amd>
 <38adad8d-754b-d1dd-167a-913afd8075d6@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <38adad8d-754b-d1dd-167a-913afd8075d6@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2017-07-20 11:37:17, Daniel Thompson wrote:
> On 20/07/17 09:06, Pavel Machek wrote:
> >Hi!
> >
> >>>--- a/drivers/video/backlight/pwm_bl.c
> >>>+++ b/drivers/video/backlight/pwm_bl.c
> >>>@@ -10,6 +10,7 @@
> >>>   * published by the Free Software Foundation.
> >>>   */
> >>>+#include <linux/delay.h>
> >>>  #include <linux/gpio/consumer.h>
> >>>  #include <linux/gpio.h>
> >>>  #include <linux/module.h>
> >>>@@ -35,6 +36,7 @@ struct pwm_bl_data {
> >>>  	struct gpio_desc	*enable_gpio;
> >>>  	unsigned int		scale;
> >>>  	bool			legacy;
> >>>+	unsigned int		pwm_delay[2];
> >>
> >>Two named members would be better here (eliminating the "magic" 0
> >>and 1).
> >
> >My thought, too.
> >
> >>>@@ -56,6 +58,9 @@ static void pwm_backlight_power_on(struct pwm_bl_dat=
a *pb, int brightness)
> >>>  	pwm_enable(pb->pwm);
> >>>+	if (pb->pwm_delay[0])
> >>>+		usleep_range(pb->pwm_delay[0], pb->pwm_delay[0] * 2);
> >
> >Plus I'd just do the delay unconditionally :-).
>=20
> ... does this still apply if this code is switched to msleep()?
>=20
> msleep() has no wait avoidance[1] and if lots of drivers are reckless abo=
ut
> sleeping for 10ms it soon starts to show up in the boot time (especially
> optimized ones).

No, not for msleep.

Best regards,
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllwjnYACgkQMOfwapXb+vLpMgCgmarGNgd3DbEgXqvRGHS2LSp5
xwAAoL+7wZiNED/sdMLLb4J90eylXU5Z
=43HD
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
