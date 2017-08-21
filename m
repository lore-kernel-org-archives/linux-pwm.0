From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 1/3] pwm: pwm-samsung: remove redundant checks from
 pwm_samsung_config()
Date: Mon, 21 Aug 2017 10:32:35 +0200
Message-ID: <20170821083235.GS18996@ulmo>
References: <1493028069-32003-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170424100132epcas1p47ad6d41345962cc43d8f34d5920951bd@epcas1p4.samsung.com>
 <1493028069-32003-2-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="daC8KDjlMyCcZyAo"
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493028069-32003-2-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-hwmon-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Kamil Debski <kamil@wypas.org>, Tomasz Figa <tomasz.figa@gmail.com>, linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--daC8KDjlMyCcZyAo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2017 at 12:01:07PM +0200, Bartlomiej Zolnierkiewicz wrote:
> If the requested period_ns and duty_ns values are identical to
> the last programmed ones pwm_samsung_config() returns early and
> skips the hardware configuration. The same checks are now done
> by the PWM core so the driver specific ones can be removed.
>=20
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/pwm/pwm-samsung.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied to for-4.14/drivers, thanks.

Thierry

--daC8KDjlMyCcZyAo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmamqMACgkQ3SOs138+
s6HYbw/7B7RZIzBns6mCTxhwvjC1gMWrMuAANbOTMlE/nfLM5id1NGDbL2vblPhl
sWrkFNlIPD+Xi3+GkyzvzhYOcTKOACyX2w9piCvEBqAIp6rUrzwFCAuVOJ3Go6SS
lnmdxwys2UejbFBu7A5DstrqKJkRwU/WmT5Oykjv8fiTT+/1sn1xRirNcRCRBYQz
Xnht94z7XhBeVluMFv2MeeNu8udLlP+2ZzyxW7civ+UPz0cak6SusyJrwgPHJRe1
QR2kG52ntJWopI6+C9mjscJ/s5/EC9eCUH7uW58WtRxE+6VflT638UhW+k4JvZr2
J8VE7W+75Ph2mz7LgAKDl54Go3lHjVrMOKFA7wkgHJN6xWg3P1uWPsqEjA7hh+rm
Gu5u5IEHxs5s5EdJKxJdQyFDCA1rgFJYATnNoXnKGHnvyDeA69LGymJ9BIcBLZ77
NEZ5mymh5w2zOY8Ilo0jkio5ZEuERRTaGkJ32KrdoHDfJgE0b28CIWTCL8Ml6x7X
CFW9WBtAKU0IiLG5nlRzasorrRg3jr69BUkFzK6GDdy1JqE3Jzk7uE1uf0ETd6ch
wDLNpQBzSy/sH/poYgtW8BGQ4/m6Mvvnjj1TkuOVeCPleM+wETvVTP6/kcK6UvKU
555R/L+bUNfV4635u9nEdZFifW110a67M2+pJ+e13553Yv7wJ7U=
=69Px
-----END PGP SIGNATURE-----

--daC8KDjlMyCcZyAo--
