From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 0/6] pwm: mxs: add support for setting polarity via DT
Date: Wed, 8 Jan 2020 13:41:29 +0100
Message-ID: <20200108124129.GC1993114@ulmo>
References: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2019 at 03:32:01PM +0200, Rasmus Villemoes wrote:
> This series adds support for setting the polarity via DT to the
> pwm-mxs driver.
>=20
> The DT binding is updated, but I'm not touching the existing .dts or
> .dtsi files - it seems that the same was done for bcm2835 in commits
> 46421d9d8e802e570dfa4d793a4938d2642ec7a7 and
> 8a88b2a2017d1e7e80db53080baff591fd454722, while
> arch/arm/boot/dts/bcm283x.dtsi still has #pwm-cells =3D <2>.
>=20
> v2:
> - Rebase to v5.4-rc1
> - Address comments from Uwe.
> - Add Rob's ack to patch 4.
> - New patches 5 and 6. The last one is independent of the others, but
>   I stumbled on this when rebasing and found the signature had
>   changed.
>=20
> Rasmus Villemoes (6):
>   pwm: mxs: implement ->apply
>   pwm: mxs: remove legacy methods
>   pwm: mxs: add support for inverse polarity
>   dt-bindings: pwm: mxs-pwm: Increase #pwm-cells
>   pwm: mxs: avoid a division in mxs_pwm_apply()
>   pwm: update comment on struct pwm_ops::apply
>=20
>  .../devicetree/bindings/pwm/mxs-pwm.txt       |   4 +-
>  drivers/pwm/pwm-mxs.c                         | 101 +++++++++---------
>  include/linux/pwm.h                           |   5 +-
>  3 files changed, 53 insertions(+), 57 deletions(-)

Applied, thanks.

Thierry

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4VzfcACgkQ3SOs138+
s6Faow//TMKnlzQDSD5P+wcJ27rYXmJrVrrfo/2vFp2FVtLXqOjDk6c0uR9m8Qiq
oiSIc70R+qNva7QrmlgDZpbIVnSD+ziImsh04Zr9fH8N+pdWda26aqYkGjPUutXU
7Rh02JTyvOqBK7W9qEu2c7xrlUdKzadeeeQSxijqqAyHFSsG5wfNmZK6qeTlB0y/
q0tWwa4YyVfDhjkAWUvKUhw5nPfv/AKO2zStCMv8jIuSJ62w5ahypLBs2A3adZJY
npSKMvPIFzyVOaHdWs3+rmJJzbujKtqMKsQ7RyE6rBRaectlLeHSonDFSjMFtO0t
BKcikgTpmwUEVDzMh0l+uNGm3cAcIjIfRQ7cpigyQEc+dntXNQfRKh8y+x3pWeDc
gssO+6ftEcLgnBSy13djxqNf2xzzqzgv0a/nTzBG2OUfGL85VQTfocP2SN+2yYmV
X4NQckVF2qs8nSQtJCdLhYGUQQMJzJ+KLd0RDRms35E2QiawYii/KvUz+oqN06WP
Wt4h4SWFZ0PVsaq9EeW74DJ1iPvHgDoFWg2y+WGlKO1F3nNQcH15lQdqWuL8i0NP
quf8OKsUUEGTfImySK2ql7pzk2ouy1Sup7wZs8bz7almHoP0KOgFVST9jb1VZRIl
2CQY1FTNqQVTWKcERuxOn6HVMVAnGBLuGWah7wr04iziCVoiY/w=
=4ETa
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
