Return-Path: <thierry.reding@gmail.com>
Date: Wed, 6 Jun 2018 11:09:46 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: imx: Switch to SPDX identifier
Message-ID: <20180606090946.GG11810@ulmo>
References: <1526830815-15644-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bO4vSxwwZtUjUWHo"
Content-Disposition: inline
In-Reply-To: <1526830815-15644-1-git-send-email-festevam@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-pwm@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>


--bO4vSxwwZtUjUWHo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 20, 2018 at 12:40:15PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>=20
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/pwm/pwm-imx.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index 08cbe81..6ddd6fd 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -1,12 +1,8 @@
> -/*
> - * simple driver for PWM (Pulse Width Modulator) controller
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * Derived from pxa PWM driver by eric miao <eric.miao@marvell.com>
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// simple driver for PWM (Pulse Width Modulator) controller
> +//
> +// Derived from pxa PWM driver by eric miao <eric.miao@marvell.com>

Why do you replace the complete comment by C++ style? I thought only the
SPDX identifier was required to be in that style.

Thierry

--bO4vSxwwZtUjUWHo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsXpNoACgkQ3SOs138+
s6GlnRAArgkCsvyE1rlo+VNOyY6nR0z1xxXQ/BizT/uLfPXJNgYyFMlZahdGG27B
/agq3FBuceRiJ9qSgreGSW+MCS1C+d+JAy7DxMikfGhbFojZnnBsrAmBEeCCZnxv
tgyJ0BmY16VFFhprieUZGQLN2LVZvVKEX0dpVMhd6cSPqBNsEpxjaOOXUrW+Z+ef
Oo7kMwQrkQU9RlMTvKvUS1KP8IsRlGkX9VTWP0PXVi62YbXi4gmzS162GhAv/iKH
tP8JV385fBbOKYIx0JO8FL5LEuNwAThJnEm/apjreZktqMer9EFFBug4RrAhNG0L
pT70WtvP4ZkVcYgJYW0SYHwCoLVzaXpMjN7CWo/rvI+n4xOmnk3wfe1awS704PLq
y6Uv8fcdTX3qq5itIQqKvywpezI5iMQ07YMocNJDjdRJnxuRE+cCpy7FaO9wDU1x
MrH3SLRfmFAJUxcSCXlH7lEYr6vZpvusXs2EWgn77D7DitNXGu6UPUCcr4Sv3xvX
z4oPMcEYXqRCN+aM/ckkeWHxVPSJuYyGQf6e7eCkah3gMa8dR5EhHumMhDnQsMOq
Y39IvQQpRe7t1y+T9lGAUxJkDD7Ii2OvJVgPrsQvgTC6bbjTbwiEHftc8SL+/JJc
QS2fH8D6JFGrHk12kKJ5yo/XiFs3DfwlFUyLSH3RJBjCSrNbr68=
=FfrE
-----END PGP SIGNATURE-----

--bO4vSxwwZtUjUWHo--
