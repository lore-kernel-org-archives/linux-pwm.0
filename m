From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 5/5] ARM: dts: rockchip: set PWM delay backlight
 settings for Minnie
Date: Thu, 20 Jul 2017 12:13:45 +0200
Message-ID: <20170720101345.GC14149@amd>
References: <20170717212811.25374-1-enric.balletbo@collabora.com>
 <20170717212811.25374-5-enric.balletbo@collabora.com>
 <20170720081038.GD13103@amd>
 <CAFqH_51DezYBsf9Ny1MngOFxZc5HazbH_RHtbwhHodpQmTw0Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFqH_51DezYBsf9Ny1MngOFxZc5HazbH_RHtbwhHodpQmTw0Mg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Linux PWM List <linux-pwm@vger.kernel.org>, linux-fbdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> 2017-07-20 10:10 GMT+02:00 Pavel Machek <pavel@ucw.cz>:
> > On Mon 2017-07-17 23:28:11, Enric Balletbo i Serra wrote:
> >> The minnie devices comes with an AUO B101EAN01 panel which is different
> >> from default veyron devices, thus the power on/off timing sequence is
> >> slightly different. The datasheet specifies a pwm delay of 200 ms, so
> >> update the PMW delay proprieties accordingly.
> >
> > Wait a wait a moment!
> >
> >> --- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
> >> +++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
> >> @@ -123,6 +123,8 @@
> >>                       240 241 242 243 244 245 246 247
> >>                       248 249 250 251 252 253 254 255>;
> >>       power-supply =3D <&backlight_regulator>;
> >> +     post-pwm-on-delay-us =3D <20000>;
> >
> > -us =3D <20 000>;
> >
> > This is not 200 msec.
> >
>=20
> Oops, good catch.
>=20
> > Plus, it is quite anti-social to do udelay(200 000).
> >
> > Plus, it is very anti-socifal to use udelay_range(200msec,
> > 400msec).
> >
> > Whoever told you udelay_range is good thing to use -- it is not, and
> > it is certainly not worth making user wait 200msec more!
> >
>=20
> Checked again some datasheets and seems that or not require a delay or
> the delays are 10ms+, so according to [1] I'll use msleep instead.
>=20
> [1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt

Ok, msleep makes sense.

But in such case, you probably want to specify delays in the
miliseconds in the device tree... or at least carefully round the
values up.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllwglkACgkQMOfwapXb+vJB3gCgm+LZ98Y4kHkMAkfT82xQJRum
LY4AnRqiMcPh4XTm9GZsCvezmoU3VkQO
=xOtT
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
