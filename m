From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1] pwm: mediatek: improve precision in rate calculation
Date: Wed, 28 Mar 2018 00:33:15 +0200
Message-ID: <20180327223314.GH28163@mithrandir>
References: <72b74a30ced1c7e7549dcbb56d6123fc27fac405.1519980119.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jRdC2OsRnuV8iIl8"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <72b74a30ced1c7e7549dcbb56d6123fc27fac405.1519980119.git.sean.wang@mediatek.com>
Sender: stable-owner@vger.kernel.org
To: sean.wang@mediatek.com
Cc: matthias.bgg@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--jRdC2OsRnuV8iIl8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 04:49:14PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Add a way that turning resolution from in nanosecond into in picosecond
> to improve noticeably almost 4.5% precision.
>=20
> It's necessary to hold the new resolution with type u64 and thus related
> operations on u64 are applied instead in those rate calculations.
>=20
> And the patch has a dependency on [1].
>=20
> [1] http://lists.infradead.org/pipermail/linux-mediatek/2018-March/012225=
=2Ehtml
>=20
> Cc: stable@vger.kernel.org
> Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Applied, thanks.

Thierry

--jRdC2OsRnuV8iIl8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq6xqoACgkQ3SOs138+
s6GCRRAArW5dSAE+wDWE+7hBfS66wYIK87ZXIPUO69YVGLG5H1GaJ/OGo1JepDJU
ibVXdNZiAcJLiBWBYVuL/8YycVFUCMXZTj5IWaooczKWOj+p2vNIPorzYAkMPgZ8
qLtJxi5fEGO5DqQlAGKBPMhlIIgG/PB1WPxNiaVzngJD81ioAY1H8gTC5+Yxwigp
67wIBtxSHML3lqzpUHBitaIFNHmDQWng3eP8LU5rUqGYYsS3bq08JUQw3uA6/U50
utBcXrzgPQdREhs2j6hyJMDPrdID9DZtcsfm4Z9VIN7cfBtqlNqA9bcrTKHIq6OF
QO8BzGonimfsZk4JqBeVDdCnR3j442SYlrF4Iccat+fqHxGrNKtE8bvaPZqxCQeG
uy3hx14uKOjUkR8vYbC0Oov+cN0WtSkI1VtUxwei/LBDwPWjznLl6W7Nv+NW41k+
funPi3FjiEWC/54dQd0+0iIQZSB+spb06WTKeN3PzO7Qa0Sit3ybJthCSbLKXK+/
A5JCNMlVKRelW0EFQ6eoZyUVeHKWyBGt827ZEDEfPjon5OYbe30zd/1E8owtjSje
nSSJMmLSdinM2npCCmIlCMpYTVZ1tbL2VJ9ZdO7AuVDDHkRiR/3kq1VkphKrwqxi
e4tzFc29xff40FkvhQkU5px1TsRYwv4bQbVTwuAWLH3uy+1k8qY=
=Bg+w
-----END PGP SIGNATURE-----

--jRdC2OsRnuV8iIl8--
