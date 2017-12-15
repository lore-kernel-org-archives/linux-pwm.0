From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 5/5] ARM: dts: rockchip: set PWM delay backlight
 settings for Minnie
Date: Fri, 15 Dec 2017 11:57:21 +0100
Message-ID: <20171215105721.GB12950@amd>
References: <20171201120651.29633-1-enric.balletbo@collabora.com>
 <20171201120651.29633-5-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171201120651.29633-5-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-12-01 13:06:51, Enric Balletbo i Serra wrote:
> The minnie devices comes with an AUO B101EAN01 panel which is different
> from default veyron devices, thus the power on/off timing sequence is
> slightly different. The datasheet specifies a pwm delay of 200 ms, so
> update the PMW delay proprieties accordingly.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Patches 4,5:

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlozqpEACgkQMOfwapXb+vJy5wCgka6qvAz/LVTaluCFA53oLoGM
T6wAnjaPqYrbPCLVq26+Mw030/oW2klN
=Q6aG
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
