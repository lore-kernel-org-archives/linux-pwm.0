Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39143 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730172AbeLTRXu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Dec 2018 12:23:50 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so2410383edt.6
        for <linux-pwm@vger.kernel.org>; Thu, 20 Dec 2018 09:23:49 -0800 (PST)
Date: Thu, 20 Dec 2018 18:23:46 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20181220172346.GA9408@ulmo>
References: <20181219103925.28360-1-shc_work@mail.ru>
 <20181219103925.28360-2-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20181219103925.28360-2-shc_work@mail.ru>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 2/2] pwm: clps711x: Switch to SPDX identifier
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-pwm@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 19, 2018 at 01:39:25PM +0300, Alexander Shiyan wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/pwm/pwm-clps711x.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> index 7e16b7def0dc..924d39a797cf 100644
> --- a/drivers/pwm/pwm-clps711x.c
> +++ b/drivers/pwm/pwm-clps711x.c
> @@ -1,12 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Cirrus Logic CLPS711X PWM driver
> - *
> - * Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> + * Author: Alexander Shiyan <shc_work@mail.ru>
>   */
> =20
>  #include <linux/clk.h>
> --=20
> 2.13.0

Applied, thanks.

Thierry

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwb0BgACgkQ3SOs138+
s6FXfRAAtATcgRJu4N30eIRg8KLaYaVsx0AiCheGPrRh04Tbdi9jLcT4KThAmpsp
Vwhj9ciATor5j5ONjN6xVaQG0/sYVryb4AlTtYZyI6MbDyqeJkMDfbJDCUnTqiY4
AfjppLhIsPEuezQsBQiMoMsFfMHEGAs5Q/ve0kpjH+UCSsOlJ2mu003AfL9rfLSN
6Bg96+GyDi8x4WZ7aIKOm7RDxL+02F83xaqVMxN2bfAOGVwW4Je3jDebmVlCS6oB
n8hcO596Jm5eR2waMNbpeNKXvbDwZb4KAuyeucOa4TiOyByHQLrb4utQl1+ydyoB
QfFtl113mkOIq2Gh+u+BrjodfkXV12uMCCKVdA6rdYlLvg55T8z/X25okinlmaDW
ZqGQzyI4Vtx9TPuyCuVssCopayYbPOwsYUCwSd9iv5VQgfL07aEKCUlBgCcb/ydN
M03ItVskatsdFPRHCaHXYGtu6D5aBHnH0/SB4y8Trz3Z34Rg9+K9BfbMnpjXNx1c
EtRE9BUKU35BBWf46T8/duSwzcgUZHaj90CHWzNRoWoViveRlyXvP0W/JX1MUXfG
PqWX1j7QR3KO2fgVTF3HGlISpzC4sDjqN3TBxqKo+136xG3nQAfJCPkN3obmScKN
BUgT3oIuZ6KEt4IsCgVCW8yJeSQYa5LBe7N0aji/m8KwCe4U7e4=
=zsmi
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
