From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 3/5] pwm-backlight: add support for PWM delays
 proprieties.
Date: Thu, 20 Jul 2017 10:06:56 +0200
Message-ID: <20170720080656.GC13103@amd>
References: <20170717212811.25374-1-enric.balletbo@collabora.com>
 <20170717212811.25374-3-enric.balletbo@collabora.com>
 <d38fa016-ea9c-edf8-9684-5c1235d27c82@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55961 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933632AbdGTIG6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Jul 2017 04:06:58 -0400
Content-Disposition: inline
In-Reply-To: <d38fa016-ea9c-edf8-9684-5c1235d27c82@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >--- a/drivers/video/backlight/pwm_bl.c
> >+++ b/drivers/video/backlight/pwm_bl.c
> >@@ -10,6 +10,7 @@
> >   * published by the Free Software Foundation.
> >   */
> >+#include <linux/delay.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/gpio.h>
> >  #include <linux/module.h>
> >@@ -35,6 +36,7 @@ struct pwm_bl_data {
> >  	struct gpio_desc	*enable_gpio;
> >  	unsigned int		scale;
> >  	bool			legacy;
> >+	unsigned int		pwm_delay[2];
>=20
> Two named members would be better here (eliminating the "magic" 0
>and 1).

My thought, too.

> >@@ -56,6 +58,9 @@ static void pwm_backlight_power_on(struct pwm_bl_data =
*pb, int brightness)
> >  	pwm_enable(pb->pwm);
> >+	if (pb->pwm_delay[0])
> >+		usleep_range(pb->pwm_delay[0], pb->pwm_delay[0] * 2);

Plus I'd just do the delay unconditionally :-).

Best regards,
								Pavel


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllwZKAACgkQMOfwapXb+vJdnQCgp1wZh/1WPaO93To0eEQi7KQ7
mAoAoLKOYXo41aospQxzvc7pbNg5cnX6
=rKLG
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
