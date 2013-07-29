Return-Path: <thierry.reding@gmail.com>
Date: Mon, 29 Jul 2013 14:24:33 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: pwm-mxs: Check the return value from
 stmp_reset_block()
Message-ID: <20130729122432.GE23152@manwe>
References: <1373423137-31612-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
Content-Disposition: inline
In-Reply-To: <1373423137-31612-1-git-send-email-festevam@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: shawn.guo@linaro.org, linux-pwm@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>


--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2013 at 11:25:37PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> stmp_reset_block() may fail, so let's check its return value and propagat=
e it in
> the case of error.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/pwm/pwm-mxs.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR9l8AAAoJEN0jrNd/PrOh8W4P/1sKRiGoRzLLD/VnP8MOSZaY
Ok2aMLfbhAOMB5eqS0ynqfzvcwEfXlEM46j8O3JWzseoGdH9GphWRTV+Q4Z+8CdL
VrNjIxRFn92OZCiPl2A68LXc/OpwbuR3AdTNgqePTrrDLfKBnZSrzIm5tyFACRoD
NS8tGTnez8KsNYMtZwiU+cLVT3pIomhWlvbwUBSAdzU2Ys0JybOUGvlXdlB1W39C
6/0BxpWlNZbQjxo/b0AcJUSybr0W0pPRGIIXpMd+M7sCIH310uZ9xzUhyGwXrnKD
3iQJ9urkVp5dRJZ5nkIwO/RLjnQc2qzFrN8PG419FdXdHH36e6yc7RLvyuMKloSl
EouQ3/chdkgLsT//8v/n69AF/eV4wmGhaDJPGeUwPY7Z7vbDLYeDqSodSnE75kT0
W/DutgoXcaROmNUY398GAEQ48M21CqMeBhw9tFjMhGY2mgRkMLApXfEjFS8wKUdW
O5yLaiM+9xoCo5rvvsJJV1n5Cv4unQmGlmVsumpl6ADZp2uCx6paB6dQ2Y8nrtep
Jp04MHuvAYFPclTDhXndVKxe4GkBDcggVropXBhSWEDwE+MONlf1YsHG2Ef7B/wk
18BeS/XkuJbnR3KgpDkSeeKl5JOBkZobuyf89PPQC/RLI2SKU5ATRxjAg+W0s07+
8HnArgVHxkCDsSZQupRd
=4JKq
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--
