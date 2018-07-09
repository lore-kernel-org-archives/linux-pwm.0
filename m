From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 1/4] pwm: fsl-ftm: Added a dedicated IP interface clock
Date: Mon, 9 Jul 2018 19:09:26 +0200
Message-ID: <20180709170926.GF26651@ulmo>
References: <20180608192237.11063-1-shenwei.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180608192237.11063-1-shenwei.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: shenwei.wang@nxp.com
Cc: linux-pwm@vger.kernel.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 02:22:34PM -0500, shenwei.wang@nxp.com wrote:
> The current driver assumes that the ftm_sys clock works as
> one of the clock sources for the IP block as well as the IP
> interface clock. This assumption does not apply any more on
> the latest i.MX8x SoC family. On i.MX8x SoCs, a dedicated IP
> interface clock is introduced and it must be enabled before
> accessing any FTM registers. Moreover, the clock can not be
> used as the source clock for the FTM IP block. This patch
> introduces the ipg_clk as the dedicated IP interface clock
> and by default it is the same as the ftm_sys clock if not
> specified.
>=20
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  drivers/pwm/pwm-fsl-ftm.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)

Applied, thanks.

Thierry

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltDlsYACgkQ3SOs138+
s6H7ug//cl3hko1skwatxl1IG+MUyKAwMQQxnMG/Kok0DrIimWyXFsZpHr0xDsu/
pK7X/IHFkpSMBeyUc54A7iiFF9JZvTIcZLkP/LV01Gz6QfexJTFja/c9WcsmvpMk
QjezjZfIxKIaRl6rtU02pRLz9Vcm5J735h9WWq89sUYBArQtKnh2JjTyQxFd/TJh
Rl5yuizCdJQBk2VmmkOHqSKqr2m5dLTMgtPJXWf7YmOO15sWw0MdzpXZFFZXLBjd
O1ltQD/Jqe9E/NaQDwUxqoOBqvNWNn9+RqzCT1B30zyiMdPMXz2ea0ueeMeekAtF
ia9tf8L0LVOsmxNd6gzQc+dnENFBUK9QVZrCJ3fIsiNv11Zw4YwHuQlszBra5bfb
GeoDbVr2iSkTvn4+DABjozVPA2R/k9eGwPyZFWOEgcrVDTULWBwV3P2/EKr6dynd
1jLpw4yw6PX4t2oA5HFDbV2JuXq2KLHM5nHHH2JbGTKus6IGKqnJJfbOADuDb/LE
8htxlSJrbR2+JXdchnmcLOfOGV4aGEFtuhpFbjoiesdcM7+m3EdjsIhisWNeuDc7
uHJRSd7doJ3dspxlJQKCAzY9dCU+Hwak+FKX2Z/Rereo/osz7KCCVrzIGVGsRy6D
/sFHXxqhf12bE7bBG0np9PQhnIZnv7tdP2GjB8gCLIJehKW/a8Y=
=9/jk
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
