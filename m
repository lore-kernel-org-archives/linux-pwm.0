Return-path: <kernel-bounces@pengutronix.de>
Date: Thu, 10 Jan 2019 11:07:56 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20190110100756.GG5213@ulmo>
References: <20190107195352.3149-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ulDeV4rPMk/y39in"
Content-Disposition: inline
In-Reply-To: <20190107195352.3149-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/4] pwm: imx: some cleanup patches
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>


--ulDeV4rPMk/y39in
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 08:53:48PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> this are the imx specific patches that are still in my queue. They are
> rebased to apply to v5.0-rc1.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=C3=B6nig (4):
>   pwm: imx: remove if block where the condition is always wrong
>   pwm: imx: set drvdata earlier simplifying the end of .probe
>   pwm: imx: don't print an error on -EPROBE_DEFER
>   pwm: imx: split into two drivers
>=20
>  drivers/pwm/Kconfig                    |  17 +-
>  drivers/pwm/Makefile                   |   3 +-
>  drivers/pwm/pwm-imx1.c                 | 197 +++++++++++++++++++++++
>  drivers/pwm/{pwm-imx.c =3D> pwm-imx27.c} | 210 ++++++-------------------
>  4 files changed, 263 insertions(+), 164 deletions(-)
>  create mode 100644 drivers/pwm/pwm-imx1.c
>  rename drivers/pwm/{pwm-imx.c =3D> pwm-imx27.c} (60%)

Applied, thanks.

Thierry

--ulDeV4rPMk/y39in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw3GXgACgkQ3SOs138+
s6GNTRAAhujUn9nKFpHhJFKsBX5Vpq141aVx3CJcS6/e198iy6pTUb3PxCftZKcR
ps1QH/oua1VJVyPSidLeiPUm3FmrFzIr69cJnQkAFBHv8Cso/bz3pTA7RPee3iyM
8z9rTjR69z4SqfhM8/dNPav2VbHUhMJo4kcUcITeol9kJ7ayYPv+X33KY8zj9aPi
4mgw69Uuk2E2HYMdWh3WmF9PSe1B8aUQvViaNB0kYzr6VMvpNta0P0e/5zVXkkKW
PXrtM8Ga9rD9AaaBzK62h2O+i6WbLE6TUmayiOFkTCiXHPew34yJVYcduFJebcGe
man9ltCOlUfnoZys+a33LBJ9Kvp5rw42BfGuMKyjxglgQsz/f3S51xeaU16HK0WG
N0Qu5Wz7odTkyFzk3rbOrIeDQgJChaOoSwsIY100pzohXEYx4/IPGc6XQNtOsPCZ
OvB+UPk87fE32sTSmH9nNuJELpxJ0voIbyOkFGF4ujnsylzxFA9EsYnvt/SiHvJY
JOhL+Y1MSmuB8WWqSESKXgdW4oebpv+9q+//Jj8NXZzLiIGHdZsIA7Ak85jZiN34
XxKSqETp8+BDsd3PZ/cYcoGgheuAwZLCSO1vtkm0bDCQdMH1oHe65XurF1grsGbI
JJdIu0QJrjGKyWCqEvHTcTne401KtNDNRZ5EdxUK4UP01tifzJY=
=OXqS
-----END PGP SIGNATURE-----

--ulDeV4rPMk/y39in--
