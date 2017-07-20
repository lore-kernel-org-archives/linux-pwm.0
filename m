From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 5/5] ARM: dts: rockchip: set PWM delay backlight
 settings for Minnie
Date: Thu, 20 Jul 2017 10:10:38 +0200
Message-ID: <20170720081038.GD13103@amd>
References: <20170717212811.25374-1-enric.balletbo@collabora.com>
 <20170717212811.25374-5-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56046 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933558AbdGTIKk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Jul 2017 04:10:40 -0400
Content-Disposition: inline
In-Reply-To: <20170717212811.25374-5-enric.balletbo@collabora.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2017-07-17 23:28:11, Enric Balletbo i Serra wrote:
> The minnie devices comes with an AUO B101EAN01 panel which is different
> from default veyron devices, thus the power on/off timing sequence is
> slightly different. The datasheet specifies a pwm delay of 200 ms, so
> update the PMW delay proprieties accordingly.

Wait a wait a moment!

> --- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
> +++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
> @@ -123,6 +123,8 @@
>  			240 241 242 243 244 245 246 247
>  			248 249 250 251 252 253 254 255>;
>  	power-supply =3D <&backlight_regulator>;
> +	post-pwm-on-delay-us =3D <20000>;

-us =3D <20 000>;

This is not 200 msec.

Plus, it is quite anti-social to do udelay(200 000).

Plus, it is very anti-socifal to use udelay_range(200msec,
400msec).

Whoever told you udelay_range is good thing to use -- it is not, and
it is certainly not worth making user wait 200msec more!

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllwZX4ACgkQMOfwapXb+vLJ1QCgwpNZaA/L48IiOMzV3VaQpMzw
1vwAn2VqChHxXxuBdBFIyX4uakny7hr2
=Pz6u
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
