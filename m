From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 1/3] pwm: hibvt: Use individual struct per of-data.
Date: Mon, 4 Mar 2019 11:42:34 +0100
Message-ID: <20190304104234.GA13010@ulmo>
References: <20190219095808.12059-1-m.othacehe@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190219095808.12059-1-m.othacehe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 10:58:06AM +0100, Mathieu Othacehe wrote:
> Split pwm-soc array in one struct per soc and point to the
> corresponding on in of-data.
>=20
> Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
> ---
>  drivers/pwm/pwm-hibvt.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Applied all three patches and, while applying, fixed up the commit
message and comment for patch 3/3 as pointed out by Uwe.

Thanks,
Thierry

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9AQYACgkQ3SOs138+
s6FXTw//XF51RJpnxjSFdJWD79GQqIIDaW0P0HjH0beD50Iy8BJjRwSN3jkV3bRU
knxzHzyiZwxHzqwUcbCZ942hsFOFbt1q88Ho4PA2X0tHhrCjsQtT5RV+wEC1vfl4
lvB7/cuu8b5zd1HleUaymdDd8CNih0AezUPzyucqybW23AlfXwJWt13BJLz4Jhxo
kEze3yV6bAohB+hGWHVabuLjdOD1B/FTnzRl8iQRPejJoMWxjomPoB4k/+9zEqYk
LIFyzO4hPBOEsFd6dbnQ9Ckif1GIz2O657HDpUC+vqcUT3XXfA1C/ieldLRcIonE
SmpMfM5d3/9Jn1uKi1P8gwyJevRqXkSIuFtSsDGGqmCrWUMjCQsf9gGLykAYi3sn
8sO3apKA8xyGoaQPwXXJwPCuewehvEhZWq94DjNd+5Szyc2n7a8Rv06z/IvW+7ol
br7DQoXqAA0klVXBJmWqN5baD/ZWM9fHPqIM7poPnbpqWnrPwyAbkQC+QlVbTbDC
L4yrj7gWQBJPswqPPzXVP5IagKpp+HtZglukz0p5dnIjqOYQvIRE8kDQRtkYVFoi
FrfR/L/BYLZv741OH8ZJDAkA/sQtF3TNC4F3Rubq3nxsIh4JRdl1G6qvGYzXQT4P
fNlCbyZX8olS4A7k6nQWtquHd6O6ov9gpxq/cQ06ZURCXPGD0rw=
=mMfv
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
