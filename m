From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: pwm-imx-tpm: Use 'dev' instead of dereferencing it
 repeatedly
Date: Tue, 24 Sep 2019 12:52:59 +0200
Message-ID: <20190924105259.GD14924@ulmo>
References: <1569315667-1525-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1569315667-1525-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Linux-imx@nxp.com
List-Id: linux-pwm@vger.kernel.org


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2019 at 05:01:07PM +0800, Anson Huang wrote:
> Add helper variable dev =3D &pdev->dev to simply the code.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/pwm/pwm-imx-tpm.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Again, positive diffstat and doesn't gain enough for it to be worth the
churn, in my opinion.

Thierry

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2J9YsACgkQ3SOs138+
s6H7EA//c+M1K7oG4eadkixheMYBpEIjyymh8PkLi2meN3+11V9d0zFBvVRjuoUQ
WyoSvQevjdLRO7oiD00k3Eq4oq12pW1nDKkYie2q/KhK/BkHxO9nZppcGmjxp2l5
vf8g076NvJ3Fuwg8e7aWiNPGDHuy+fSrF2wzX174wMZ6z08s3iCFfkfF68PqxYAx
uO6/QC0Ici6CvltPqVrIMYLtn89BbQYVm5GivwAbzkfoukfcvEyMnPRtsMMLPwys
vuHSVpAy6BaQ0q30fqjErVEMDv/nBmBnK+Wk0S4mkt+31rBARoqhoAxPqU2RTsFT
xekt/OoywxVDS4VsFulovvTSC4MRzFFN39z0IiWQq4nlfpVZqYTPm5+Gh0vIRhtl
Yk6ASiRKbLVBfHTMVKoM2ojwHzLoRu7k6P78POdHdiVVdO2LCCdQQZIfW9mOApO3
fEwqdKaRSfQY/MCv+nyoNYB+Slx+2h6qKon6uracPgaYKPasZILcgWQAummpP2OL
yRox2Bk1NDjkXk0Rb/OcQkG5OwoPh/FIbfsoZHwUl2GxO3tJKZcOnCDTcu9B7aEf
txM17yl9fcS166Ir1yhdna/l1mrC+/Rysc7jfYpUC5D26V1K1zwODYlELFGqGY6Q
21LKYO/js44tPqj0CuJz8DHnGS4RLcn7mQr7b1MXN01ue01DwGk=
=AXDg
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
