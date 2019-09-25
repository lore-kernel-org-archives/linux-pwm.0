From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v9 03/11] pwm: mediatek: remove a property "has-clks"
Date: Wed, 25 Sep 2019 09:51:35 +0200
Message-ID: <20190925075135.GA29006@ulmo>
References: <1568933351-8584-1-git-send-email-sam.shih@mediatek.com>
 <1568933351-8584-4-git-send-email-sam.shih@mediatek.com>
 <20190925063003.aht4platmfalcqru@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190925063003.aht4platmfalcqru@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sam Shih <sam.shih@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2019 at 08:30:03AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Sep 20, 2019 at 06:49:03AM +0800, Sam Shih wrote:
> > We can use fixed-clock to repair mt7628 pwm during configure from
> > userspace. The SoC is legacy MIPS and has no complex clock tree.
> > Due to we can get clock frequency for period calculation from DT
> > fixed-clock, so we can remove has-clock property, and directly
> > use devm_clk_get and clk_get_rate.
> >=20
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> > Acked-by: Uwe Kleine-K=C3=B6 <u.kleine-koenig@pengutronix.de>
> > ---
> > Changes since v9:
> > Added an Acked-by tag
>=20
> Argh, my name was croped and ended up in this state in
> 5c50982af47ffe36df3e31bc9e11be5a067ddd18. Thierry, any chance to repair
> that? Something
> like
>=20
> 	git filter-branch --msg-filter 'sed "s/Kleine-K=C3=B6 /Kleine-K=C3=B6nig=
 /"' linus/master..

Done, though I ended up doing it manually. I don't trust my git
filter-branch skills. =3D)

Thierry

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2LHIMACgkQ3SOs138+
s6FVWQ//ZCxxPqTJAJi0DQFkIwCq4Zezubiab3AKelA5for80UXfZRc4Mt04Nw6A
Kz9cafImwG+n6i2Lr1bkHmsiPjnweUMMqWHQz42B1veoQXas3iGrDgWjqjq0mCx0
/oELIxnCXP2gnkjkXzSzhtUz3lUWjxsZpVyMw5Lrrwp2zgp+FVGc4qFsCzSpZ1C2
Ns2kDIt6eqgEQnP8HC0JtX7f1BfAqY1iqh5jX/8Ex6yhkskmdhjLriPaFvMzwOE+
wnky4KAn0ehpwpMlTM+X+67QYinD2HF5ACm+KxiKNxDh8YnLzKc3mWlavYUUcgOV
KxZGtJCtcPg2FTz2BsJHIokllFDVYmcSApnkhFxHH7MeANNixbAo9rTe3ZY+eZ/S
bSemBr86T3ypkFKPddRyiVuw2NehYilTML9IjuTha8DzU0YatCm+ZoNrKXUCw21C
ybE2luElYxK8VI6R6M5T7u3eEy98T5gbw49Dtr324cIuF2blJjtqCTnuaNNSvare
TJ4fzjYPfIh0//q4lRWed6QLQkHXpciu+IgSuNtNhbLCPvqI6yju3uIOb/PwGLrH
AJvQgRpRX9ikbZPSD6vCnYad/JZhnGgOJWiKoviSnWbnWWWIvhk5JYMYh/stfTbi
Zk1m7BTKK6vyuyo3Hz9CxnIBpvht0e2ua62KjYCrAUKZaEVuOrI=
=o/DM
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
