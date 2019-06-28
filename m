From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 4/4] backlight: pwm_bl: Set scale type for brightness
 curves specified in the DT
Date: Fri, 28 Jun 2019 10:18:06 +0200
Message-ID: <20190628081806.GA31375@amd>
References: <20190624203114.93277-1-mka@chromium.org>
 <20190624203114.93277-5-mka@chromium.org>
 <20190626145617.GB22348@xo-6d-61-c0.localdomain>
 <20190628075516.dwev7fxz7kmox2i2@holly.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190628075516.dwev7fxz7kmox2i2@holly.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Matthias Kaehlcke <mka@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>
List-Id: linux-pwm@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-06-28 08:55:16, Daniel Thompson wrote:
> On Wed, Jun 26, 2019 at 04:56:18PM +0200, Pavel Machek wrote:
> > On Mon 2019-06-24 13:31:13, Matthias Kaehlcke wrote:
> > > Check if a brightness curve specified in the device tree is linear or
> > > not and set the corresponding property accordingly. This makes the
> > > scale type available to userspace via the 'scale' sysfs attribute.
> > >=20
> > > To determine if a curve is linear it is compared to a interpolated li=
near
> > > curve between min and max brightness. The curve is considered linear =
if
> > > no value deviates more than +/-5% of ${brightness_range} from their
> > > interpolated value.
> >=20
> > I don't think this works. Some hardware does takes brightness in percep=
tual units,
> > converting it in the LED controller.
>=20
> This check is exclusive to PWM backlights so I'd like to double check
> that you are thinking specifically of hardware that takes it's signal
> from the PWM and works in perceptual units?

I missed that details. Taking PWM input then converting it to
perceptual units would indeed be strange.

Sorry,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0VzT4ACgkQMOfwapXb+vJHvwCfXWJZfJ+NpPdPg9PEDds9PM6A
2PkAoKvMuJ+sLPxMlK+cBeBefsVNKEOi
=vu5D
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
