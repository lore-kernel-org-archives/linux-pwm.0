From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: sun4i: direct clock output support for Allwinner
 A64
Date: Tue, 2 Jun 2020 14:40:04 +0200
Message-ID: <20200602124004.GB3360525@ulmo>
References: <20200428164150.366966-1-peter.vasil@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBMkI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Jun 2020 08:40:08 -0400
Content-Disposition: inline
In-Reply-To: <20200428164150.366966-1-peter.vasil@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Peter Vasil <peter.vasil@gmail.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nightwolf@relghuar.net


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2020 at 06:41:50PM +0200, Peter Vasil wrote:
> Allwinner A64 is capable of a direct clock output on PWM (see A64
> User Manual chapter 3.10). Add support for this in the sun4i PWM
> driver.
>=20
> Signed-off-by: Peter Vasil <peter.vasil@gmail.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied, thanks.

Thierry

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7WSKQACgkQ3SOs138+
s6EaEhAAm/NQGeJ/IOWtqrbF6KZ1hxhFv6kLldfbKchk0A0Rhnebp1FqHYMkQBwu
/KzAQl8/ZLrQMM3oXqYeKEWW+sSowB/KyICk7Ynx/RRJjAQiBsdOjfANNvONeF56
4VOWkiC12fHm7l+vOFWtQttg8ShAIoKQQM/XQ+Gj259BfdAeSs+Gv+7FL9ue8pTI
n6iM9g68mr88CP2XkWMPsMhaSAE21o7UEgMI6y4BpHXETnb2bmbaIHPoWJB2jx/E
rLpCN6iQTkxrgtV/mU8sXggejhRDqTWdq9aueNt3dEDj4o2eAayIJy4Rba4zbyb/
l1C+6qiuT9MQglKbmY4of4FXWt339nfgtgXJL6aHRJob1ROu/OH0hVmW/jDfJV64
C73+XaNUyfNUqgNc2Q+5B/xNCuRa7cENLhA8j3vu+gKFIlSMHVpD35ISBr/DSQwR
qEBPZ2ZDW6TmqUxr2ZLuirW3SXV6jVngsMJhDqAFSWEaLc49MjIi3LG9ItEQdj6h
h2OTJPS+IE3JSTKkX90e9BA/QEsi+f/SP3sQBpxetXYn19eUliLXMzIKv0V/rWUc
L85/oyvgT1n8PVbc7O0hMEgqoRxwth9R/EOtozadIlceBw9zdpRy3lp+aO4DL8NR
5mOiC5GtWuBmP2/l8/edwhneBVDCQQP2AYVZ6vm29XVX5Glklvs=
=FM1x
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
