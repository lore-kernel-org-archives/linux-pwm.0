From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 01/12] ARM: at91: move SoC specific definitions to SoC
 folder
Date: Wed, 3 Apr 2019 16:36:45 +0200
Message-ID: <20190403143645.GJ5238@ulmo>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
 <20190403141120.32754-2-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4vpci17Ql0Nrbul2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190403141120.32754-2-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexander Dahl <ada@thorsis.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--4vpci17Ql0Nrbul2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2019 at 04:11:09PM +0200, Alexandre Belloni wrote:
> Move linux/atmel_tc.h to the SoC specific folder include/soc/at91.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/clocksource/tcb_clksrc.c                   | 2 +-
>  drivers/misc/atmel_tclib.c                         | 2 +-
>  drivers/pwm/pwm-atmel-tcb.c                        | 2 +-
>  include/{linux/atmel_tc.h =3D> soc/at91/atmel_tcb.h} | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
>  rename include/{linux/atmel_tc.h =3D> soc/at91/atmel_tcb.h} (99%)
>=20
> diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_c=
lksrc.c
> index 43f4d5c4d6fa..138a12090149 100644
> --- a/drivers/clocksource/tcb_clksrc.c
> +++ b/drivers/clocksource/tcb_clksrc.c
> @@ -11,7 +11,7 @@
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
>  #include <linux/syscore_ops.h>
> -#include <linux/atmel_tc.h>
> +#include <soc/at91/atmel_tcb.h>
> =20
> =20
>  /*
> diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
> index ac24a4bd63f7..194f774ab3a1 100644
> --- a/drivers/misc/atmel_tclib.c
> +++ b/drivers/misc/atmel_tclib.c
> @@ -1,4 +1,3 @@
> -#include <linux/atmel_tc.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
> @@ -10,6 +9,7 @@
>  #include <linux/slab.h>
>  #include <linux/export.h>
>  #include <linux/of.h>
> +#include <soc/at91/atmel_tcb.h>
> =20
>  /*
>   * This is a thin library to solve the problem of how to portably alloca=
te
> diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
> index 0d0f8376bc35..d7e92fd552e4 100644
> --- a/drivers/pwm/pwm-atmel-tcb.c
> +++ b/drivers/pwm/pwm-atmel-tcb.c
> @@ -17,7 +17,7 @@
>  #include <linux/ioport.h>
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
> -#include <linux/atmel_tc.h>
> +#include <soc/at91/atmel_tcb.h>

Sort this below the linux/* includes. With that:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--4vpci17Ql0Nrbul2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlykxPoACgkQ3SOs138+
s6EnbQ/2MFXgA2oFM7gYZLm5GaXwaFWSpnwbu8jcyubOcu5sy+IjqVlD+HMaJqoh
jayHE7tjtVfgXd742qIYSMjhb2LTXgGZa7kCP5Li/Ui7jwdnf2B/VhFlY9NrZkgO
4S8Q5WeEEdH5QZ5nNgHgwRVLUC5nF1obrMHM/TfkV3WUeSMwg4V1SzJFF7vE6kuZ
h0BnY6mFyizaiQTaV/CCiwsVIkif0NJO2jsm1OUkpGnJDNbQXIloW6uGAuA3C+DB
0qIJrgUaQFTXrbuj3OMk30ifEOR6bexsW2XyRXeKsjWeQvf1FRIBoH6vPd9q19zX
o7Zp83ye8a0AAg2AHTLidOnKw3FU8Om4cuNt2/aQtQ18ptV4MJL42PHJ6QwDTdyu
7J5FhD0dC8aC9Ad00qXf/+gKg1FJvJ0G4ec2I+5E805fBZewuCOJHk+iRw8tvXb9
ZWjgLejATP3RRT3OggvFeeubK1+yhQ8KTUqw+QyneV/imThalC6mWeJQ1LWjj1gu
DM6eOVa76scfpgio+Kh6trM1J+uRQNhiblbXp9job8Hr+ok3wqPhcSw0+qPzE6zx
fYyQ3BNMyDChnu/+zlra1Hc9bjmvOqZWzWLA43emj0yHT+9xrVUmtZ5qx9NwJTld
ALaeiWXFs7Ae1lCfgKAvlvbKIIXy1yxBYGmXtORdlQZ7zWna/g==
=Yvcc
-----END PGP SIGNATURE-----

--4vpci17Ql0Nrbul2--
