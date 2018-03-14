From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 36/47] pwm: remobe pwm-bfin driver
Date: Wed, 14 Mar 2018 17:38:08 +0100
Message-ID: <20180314163808.GA9201@ulmo>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-37-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-37-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2018 at 04:35:49PM +0100, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so this driver is now
> obsolete as well.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pwm/Kconfig    |   9 ---
>  drivers/pwm/Makefile   |   1 -
>  drivers/pwm/pwm-bfin.c | 157 -------------------------------------------=
------
>  3 files changed, 167 deletions(-)
>  delete mode 100644 drivers/pwm/pwm-bfin.c

Do you want to apply this in a batch or do you want me to pick it up
into the PWM tree?

If you want to go for the former:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

Otherwise, just let me know and I'll pick this up for v4.17.

Thanks,
Thierry

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqpT+0ACgkQ3SOs138+
s6EarRAAoBH+bt5yIhEuCAQW+TacABePYy8Pn4yMZza56aih0v61Jnr6fxkwRaNK
lz5LPOPVcC8S3yWHwWQEw8CFMLwR/jfNvV4cjaiYW5e96KfXHFXTpy7MuzJUMRn8
2qSIoL1Y9ldUpbMeW2yp01zX9QmZEP5kn5dZ9sONR0E32nij3SHlJ7UE5LbRkDHP
ZI+WvI59PE4ZsKHIbF4nnO/PjZlZ59YRHwxJ8RuulVY4ca5S3IOfZneOwCN6iuDg
DFYhYWXdQ+CfcITxWDpWawlR8cyOyhiTEA0nvnDu06q7kXs500Tf+2iWva76guaK
GqX2pepOdwzIt4tC4zcUs/BeKjZG7BiyBo4Nx786B1pPbdLzuKW+tZ81BppsbUiA
hND76qcBMfCe/Bnx0pk2WKTk6lUHdqqJk20xbdIgQtzQrcFJoSpGJ+tAQFg2e2Tv
FtXnmBWxTVprG1lQtf0MI6Wpj77LD7DShD1TFnn5EYrs9JBFosr6EnPtz2gKPWZp
6a38qX4kr/JZc9W2DUTe5sWJXqsoVWD+9wwYGoOdWt8Hp7rhph1Eb/wQW8bMi+4L
/RcaK0XOKWk8XKUDlj5CinUhh0yh/hHRrWaARhzMAeRsfhBzvY7XJsAHAV0OTi6s
mVElonYi4vHjhRxHKzHgmcr+wD3/L85W9lJTrAilN42LCcVcepo=
=52J1
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
