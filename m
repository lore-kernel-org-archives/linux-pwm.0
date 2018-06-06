From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 6/8] pwm: cros-ec: Switch to SPDX identifier.
Date: Wed, 6 Jun 2018 11:08:48 +0200
Message-ID: <20180606090848.GF11810@ulmo>
References: <20180605175429.9072-1-enric.balletbo@collabora.com>
 <20180605175429.9072-7-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7mxbaLlpDEyR1+x6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180605175429.9072-7-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 07:54:27PM +0200, Enric Balletbo i Serra wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>=20
> Changes in v2: None
>=20
>  drivers/pwm/pwm-cros-ec.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> index 9c13694eaa24..9bf4cde86765 100644
> --- a/drivers/pwm/pwm-cros-ec.c
> +++ b/drivers/pwm/pwm-cros-ec.c
> @@ -1,12 +1,7 @@
> -/*
> - * Copyright (C) 2016 Google, Inc
> - *
> - * This program is free software; you can redistribute it and/or modify =
it
> - * under the terms of the GNU General Public License version 2, as publi=
shed by
> - * the Free Software Foundation.
> - *
> - * Expose a PWM controlled by the ChromeOS EC to the host processor.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Expose a PWM controlled by the ChromeOS EC to the host processor.
> +//
> +// Copyright (C) 2016 Google, Inc.

This is odd. I understand that for some reason there is an exception for
SPDX license identifies to use C++ style comments, but why would you
make the whole comment C++ style? Why not just something like the below:

+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 Google, Inc
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2, as publish=
ed by
- * the Free Software Foundation.
- *
  * Expose a PWM controlled by the ChromeOS EC to the host processor.
  */

Thierry

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsXpJ4ACgkQ3SOs138+
s6HerhAAwUNTeDQcpNnFb4Q3vWN1ijtYuXHlkaMqSlNZAUVxQ4IM2BVMeWTxTCJa
dq56ik35zor2j4yY1X/mKuYpevEEypl2DKFc3saZraThG0b6fv/+olRAw6Rwb3Lr
Hzy+Q8muy7sg7ISd7Pa74HTzdzwW0XVvvUG0nE4ODo72SzFHV2TiYNdjx0scQmzR
AUoeT/wrD2GFW3ZTLKfMPC/Tb2MdmWIxM9n0tkNsBeZwVL6bNCPuXpk7MhHVhOsN
vknOZYRstIb1N+cDq/te1Wdszu/tjYl3VflRkTa/tX3l3kXNNLxAs4l2owToFDLC
Zqk7kDQlcRs4RxvbW4qsNecMOQKQO4pnR7l8cgtOj/LA1y4W/UlnAeEe6lUCZ4SA
JBlUTCEnYIPrfEAFpd4zRqyQTm2STr7RjwHuIOLQJu9aEUSTFz+vIMt1quFCvZDn
2R8j3l+ar3Dbwb0pNfCdkogDd5JGJ9+4egJYVggKpO1TtzkBzm5Zw9sbITvTUcXF
32fe5k4//3bdtcVwO6tBBnp6CHnfsQdOw1NtGKawawFiIJVS3nFIUXyZzpOV/fJB
9GUdWm8E4id7uYZqYXQZk0mvHOUTgsIwwOELM9e47npEnjz5fJUvz07ZMOYGX2Oc
3v9amaFF625ie21WOZMxDizxZ1RpbQe9aHwHgqTLkRDkfksFYZk=
=2GIJ
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--
