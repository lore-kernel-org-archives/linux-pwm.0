From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RESEND 0/9] pwm: Remove unnecessary OOM messages
Date: Mon, 28 Apr 2014 13:42:58 +0200
Message-ID: <20140428114257.GJ19455@ulmo>
References: <000a01cf5ed7$bd178ad0$3746a070$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VIOdPewhitSMo36n"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:34444 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115AbaD1Lo3 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Apr 2014 07:44:29 -0400
Received: by mail-ee0-f49.google.com with SMTP id c41so4715308eek.22
        for <linux-pwm@vger.kernel.org>; Mon, 28 Apr 2014 04:44:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <000a01cf5ed7$bd178ad0$3746a070$%han@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pwm@vger.kernel.org


--VIOdPewhitSMo36n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2014 at 06:38:09PM +0900, Jingoo Han wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message. For example,
> k.alloc and v.alloc failures use dump_stack().
>=20
> These patches were expected to be applied to 3.15-rc1. [1]
> However, it is not merged yet, so I resend these patches
> based on 3.15-rc2.
>=20
> [1] http://www.spinics.net/lists/linux-pwm/msg00976.html
>=20
> Jingoo Han (9):
>       pwm: ab8500: Remove unnecessary OOM messages
>       pwm: i.MX: Remove unnecessary OOM messages
>       pwm: pxa: Remove unnecessary OOM messages
>       pwm: renesas-tpu: Remove unnecessary OOM messages
>       pwm: spear: Remove unnecessary OOM messages
>       pwm: tegra: Remove unnecessary OOM messages
>       pwm: pwm-tiecap: Remove unnecessary OOM messages
>       pwm: tiehrpwm: Remove unnecessary OOM messages
>       pwm: vt8500: Remove unnecessary OOM messages
>=20
> ---
>  drivers/pwm/pwm-ab8500.c      |    4 +---
>  drivers/pwm/pwm-imx.c         |    4 +---
>  drivers/pwm/pwm-pxa.c         |    4 +---
>  drivers/pwm/pwm-renesas-tpu.c |    4 +---
>  drivers/pwm/pwm-spear.c       |    4 +---
>  drivers/pwm/pwm-tegra.c       |    4 +---
>  drivers/pwm/pwm-tiecap.c      |    4 +---
>  drivers/pwm/pwm-tiehrpwm.c    |    4 +---
>  drivers/pwm/pwm-vt8500.c      |    4 +---
>  9 files changed, 9 insertions(+), 27 deletions(-)

All 9 patches applied, thanks.

Thierry

--VIOdPewhitSMo36n
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTXj7BAAoJEN0jrNd/PrOhNZYP/iuRH9SgnTxVN5dvZDy4bkiB
fUZ7PogNDFhuYUVXcNp7ARkhQxcj05FMS82YKsAgP7nMMNlmAUZvPPHuN957J/9N
eaTmymcvVuJQZWi/X+FTU1r47zW13DC0yj91QtsZyrBqzL6bvDMoN51dMw/0jhcJ
CMrpMUOU8aZkXBJyxCKLKMYko7Eamx4ahXNG0JbvnMkAtb1xRsc/Ijrs0Es2Djmb
FQVzNim8R59wxMuJbgGlGLMAvsTbqtsVhHq+x/SsbjkAdS37ps/rjknJz+WalJn4
vUIeB6q4Fqn1hhlR2thc8Vd0EyZNaot0ujfZi+mKUtk+0Pd/Oh7UhpORR7adF7X3
c36i6Pti7f9Y+vKHlAlwxp7KBbGNrWeB+2NnO6uiBWNkw6BapwN4/MnJk0bv7VOT
GwBtGogoAATUW0gCGNX74s4steAunSvabHvPDMV/PHma/XIqdENeFof81e66PenU
hPAkbZdSEiZTOkrNrbMtKnZlQ6eM4A40z6rRyYeHOldrKpb+ov/FFSFzbyfBFEq9
3mrOBQo6tIMTRDXoS+Sd+vnFgppw9xTicQzAl6hCorIdTS2VxhUkel6ZRIiIwgmZ
u56WK7KulTga3llJcs081Y8v9qevPTMC70bRk7KGEusahh4BS0Av+glAqGI6Jbzh
hxyexXv7WXO8RXlySd5Q
=rQY+
-----END PGP SIGNATURE-----

--VIOdPewhitSMo36n--
