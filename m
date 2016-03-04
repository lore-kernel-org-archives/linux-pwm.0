From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: rcar: Use ARCH_RENESAS
Date: Fri, 4 Mar 2016 16:03:25 +0100
Message-ID: <20160304150325.GC26400@ulmo.nvidia.com>
References: <1456362203-21038-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456362203-21038-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 25, 2016 at 10:03:23AM +0900, Simon Horman wrote:
> Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
>=20
> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> ARCH_RENESAS the motivation for which being that RENESAS seems to be a mo=
re
> appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW2aO8AAoJEN0jrNd/PrOh5zYP/iluqezGIWMxaWXKjMVrpw0D
zlPxpM8fQHm6tSXD8TUX+R5uhHFZushIvYzQdZt5ZqAxkqYyt+bGYJY53r3mHV6g
7eeCcqYHi9dMh2uOKZwicJMTRT2G4/V6HRH29y5kV8IAG1SmYgAieqBHUK2LhnTF
OLW4qLFi1waRTi2BJyDJXv3QQNMXWEwdWqUrUhFsU7Ft3BpKnaOFs7UUZI3MEBRT
Pu+uYdolHjkPcHacRCc/EQ9DGCFcVtVy/bqPTPGmWEnVttZ8p3CNvO7mszF91apu
rUFQCF+ltTlbR8eIvaCvYR9XIzk7zx/q8AYNJJnwytuaQ3i4YF7bARgR6oh0tiuh
tbIgedNqKdiCIXqodbqZl0jB/Zc0MBKKZejcitjjHoW3JuQS2MRhSmvAizlnIuuO
cJlDNlPkfC3xs6GzMU/TXhOgRHo/9YBpiFi8k1csSkHEBFXIm/AsUi7NjeyVsHXm
MuyMwy5Qgulet9kbHVXtJ86rhNfeEQQrUMufaTj2oCqqfJ8F3CUU+YSw+URs/+j9
Ow72sWQKipytkzykF7G2X5xKyW97wi6thkbLUWOFRJS5oNJywdCuJqw3IjzxvQC3
am3qgMyKwcYQCNPLdgv75eqrfizbSRjZNPm9zJxVuYoKimUUIpLGDgK/qY48uC0D
YvIrUhanmzF8L9ribKsX
=WJWG
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
