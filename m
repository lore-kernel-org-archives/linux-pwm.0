Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39651 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCDLO4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Mar 2019 06:14:56 -0500
Date: Mon, 4 Mar 2019 12:14:51 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20190304111451.GC5121@ulmo>
References: <1547021948-7664-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline
In-Reply-To: <1547021948-7664-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v3 0/4] pwm: rcar: Add support "atomic" API and improve
 calculation
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 05:19:04PM +0900, Yoshihiro Shimoda wrote:
> This patch series adds support for PWM "atomic" API and improve
> the clock calculation.
>=20
> Changes from v2 [1]:
>  - Add Acked-by of Uwe in patch [234]/4.
>  - Modify a condition to support normal polarity only.
>  - Fix possible to output wrong a duty cycle when disabling in patch 1/4.
>  - Fix overflow value on 32-bit arch in patch 4/4.
>=20
> Changes from v1 [2]:
>  - Remove workaround code of output pseudo low level for now because it is
>    rejected on the ML.
>  - Add a condition for polarity because the HW doesn't support polarity c=
hange
>    in patch 1/4.
>  - Improve the clock calculation in patch 4/4.
>=20
> [1]
> https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=3D632=
19
>=20
> Remarks:
> On the email thread of patch 2/4, we discuss about suspend/resume
> handling and I suposed to improve it. However, I need more time
> how to improve it. So, for now, I don't improve it on this patch series.
>=20
> [2]
> https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=3D531=
93
>=20
>=20
> Yoshihiro Shimoda (4):
>   pwm: rcar: Add support "atomic" API
>   pwm: rcar: Use "atomic" API on rcar_pwm_resume()
>   pwm: rcar: remove legacy APIs
>   pwm: rcar: improve calculation of divider
>=20
>  drivers/pwm/pwm-rcar.c | 99 ++++++++++++++++++++++++--------------------=
------
>  1 file changed, 48 insertions(+), 51 deletions(-)

Applied, thanks.

Thierry

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9CKsACgkQ3SOs138+
s6GvXBAAtQ63hJn8VU76YX0xf+hldzGWYzwFe2NrcZVW2zsBo7E93/MS2bDgQUXf
X5iFiRgNPWaHTpvxumNBHMo4Xl7ZwyMJHFvzFVuIYLr3DQ9otjJnpUxur6XBlMYl
+ePGcip2cbuEA8lqrhKs1A3H6l8UJ5cJJjy62oWkl0emwe4hVLwI0RwejDIs5pFT
7tYNwR/hLW0ku2iLcfG6jgmPM+hDAwmBexh8XoyQW9DHFG5XaVF/jDlQ8XWkZNME
kZ4C7q7mpt3giD9GUJPdSU1nzjkm8PS1O6IkovjCASLMAxCKzBJVEIPNpro0azWe
v9xvUb8uQxWBu4OxfT4tJSnPoWUkyQMt0V5MMDAoy39gnFCd9mgYTnSlSr3NISvA
0WNW5mUQxXMqnE57wTcj+ikE6MOiflbxpiPKq9zv6Jwk4xfGRHnIrX4CU+UT9Wp0
HuoPcOfrEDUED+Yh7cmXCifurj+7tKETARtJqrpaS/Ho+wK3R1fky6cSnwAzxnBJ
mZ2tcgGl0AGH4afZoOSHkNZPy528Juv6UI7ePq0ERRszPoaHwjBfBdAJ7SgrD3FU
Pv7RiULroMeSgH9DwVeiznmWDujXxOERDPKrBSqQHzPX0mCFVJj8d+/Gvf6+hDoK
lwXSfw8jvCy+Q1bgKrUDxh2CRsqkmC9oTSft1YFJ4wyBHNPgzoQ=
=a31g
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
