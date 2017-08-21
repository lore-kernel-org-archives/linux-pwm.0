From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 070/102] pwm: tegra: explicitly request exclusive reset
 control
Date: Mon, 21 Aug 2017 08:54:38 +0200
Message-ID: <20170821065438.GH18996@ulmo>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
 <20170719152646.25903-71-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tcC6YSqBgqqkz7Sb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170719152646.25903-71-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--tcC6YSqBgqqkz7Sb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 05:26:14PM +0200, Philipp Zabel wrote:
> Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
> reset lines") started to transition the reset control request API calls
> to explicitly state whether the driver needs exclusive or shared reset
> control behavior. Convert all drivers requesting exclusive resets to the
> explicit API call so the temporary transition helpers can be removed.
>=20
> No functional changes.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-pwm@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/pwm/pwm-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-4.14/drivers, thanks.

Thierry

--tcC6YSqBgqqkz7Sb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmag64ACgkQ3SOs138+
s6Eg/xAAoxPA+C99+p1bsqxnlFjBMV6+PtRuREzqKOvUtMJ560HcDh88+YYX0Ygb
mmm9xw6uOXSC8t58AROyAQtWTDSKm49gPP9vSftWbDRLt7Zw7fUeq1oZ19Fa0wva
ddxRmPe5uMopHqKYMMfM2xo5qozWi0SjhNROlNDd1yqsLORjytIvE68PjOFwiCaT
zaTNJB1vmYkrHqAbQ9VOf0VPnbTi5OgCfeafF3OSgMuAt732dOA9Vzf9GctwcYaw
DirWb+JpS4fGd8eFtY2CO1O68j65x8buWqsj4s/4LwkH84OTMz37eZGaYz0aXQ5w
d3x0QPB9asr++HJYGjV1y13hRITaEOgLGsYvdCFG7JYj9mG2TLa9OgL/mYIqzIfL
k2q+XcKOzKOo5+0WytMPFpxn23iqemXk/v+1I1RsJvJ5W/GMm7A4cWZ2wBKGcjuk
Ap51XtSk5HpCUaM2DP/RtTRfw2FTn7VYRN0Wwm8Sn/G+/Y2qrlAtIpXN2yLKy3P8
ac3+uTR5YodCCjkx944ZAU/b/0tjkxrD8AyvQQHXVpgH39FeDNHYasYJ4yxglqkt
G7BYngboOCZSyYmVwNFzaalQiQPbt1p0SpUmCbrg7Ez38eRrFPwcjwMt+y5tu5Nf
zaqMx3mY2pQfzwBi2++9ShzeZEDf13LDlDYBl9k9yU9BmUvnxOk=
=nimR
-----END PGP SIGNATURE-----

--tcC6YSqBgqqkz7Sb--
