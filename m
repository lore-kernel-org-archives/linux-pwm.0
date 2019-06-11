From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] backlight: pwm_bl: Get number of brightness levels
 for CIE 1931 from the device tree
Date: Tue, 11 Jun 2019 12:18:43 +0200
Message-ID: <20190611101843.GD7526@amd>
References: <20190610233739.29477-1-mka@chromium.org>
 <20190610233739.29477-2-mka@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1014550703=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190610233739.29477-2-mka@chromium.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Brian Norris <briannorris@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-fbdev@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--===============1014550703==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-06-10 16:37:39, Matthias Kaehlcke wrote:
> Commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
> linearly to human eye") uses pwm_period / hweight32(pwm_period) as
> as heuristic to determine the number of brightness levels when the DT
> doesn't provide a brightness level table. This heuristic is broken
> and can result in excessively large brightness tables.
>=20
> Instead of using the heuristic try to retrieve the number of
> brightness levels from the device tree (property 'max-brightness'
> + 1). If the value is not specified use a default of 256 levels.
>=20
> Fixes: 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linear=
ly to human eye")

I don't think this one is suitable for stable. I'm pretty sure the
heuristics works well for many boards, and you just replaced it with
another heuristics ("256").

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlz/gAMACgkQMOfwapXb+vIo3ACgh5KFLWPPu5aM3ZOFG5tXtj5k
Qc4AoJr268a0RVM8on0+DfnTeYriXWab
=vM3e
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--

--===============1014550703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============1014550703==--
